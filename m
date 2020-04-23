Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0617C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7863B20857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xaf8voay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7863B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdP6-0000LT-GS
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMN-00050h-NS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMI-0005bT-Co
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:01:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47345
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRdMH-0005a0-Rn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587654104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H3+wNyWOSH6j8FrHMR9tlc7HrSv0Q/nGxI8BHHbr4cI=;
 b=Xaf8voayG0pWpcFNQ1coPLqaSP0GxPS5Q3EQz+VNShIOZAIrlRUfddUHOKayGO+eupLKMf
 nJ7MAvaUvUYzJTN5+UtcxNwOceqYgQF5d6+nHkOf1mI50vicmpMhrX5jMwOuxagp7ApsDJ
 omGlWZHCc0V9rukywn5tlEzNlNREX+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-h50f5R9QOQGaZbUW1p8Tzw-1; Thu, 23 Apr 2020 11:01:38 -0400
X-MC-Unique: h50f5R9QOQGaZbUW1p8Tzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3530E463;
 Thu, 23 Apr 2020 15:01:37 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60F4860C81;
 Thu, 23 Apr 2020 15:01:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 00/10] block: Fix resize (extending) of short overlays
Date: Thu, 23 Apr 2020 17:01:17 +0200
Message-Id: <20200423150127.142609-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v6:
- qcow2: Don't round up end offset [Eric]
- qcow2: Use different error messages for different error paths
- Request BDRV_REQ_ZERO_WRITE only if the backing file actually covers
  (part of) the new area (fix regression from v3) [Max]
- New patch: Forward ZERO_WRITE flag for full preallocation [Max]

v5:
- Fixed file-win32 [Patchew]
- Fixed zeroing in qcow2 for unaligned requests + tests [Vladimir]
- Made raw-format code more consistent [Eric]
- Leave output for existing iotests cases unchanged [Vladimir]

v4:
- Rewrote the series to move the actual zeroing to the block drivers so
  that error paths can work correctly and potentially long-running
  fallback to writing explicit zeroes is avoided.
- Fixed output filtering order in the test case [Max]

v3:
- Don't allow blocking the monitor for a zero write in block_resize
  (even though we can already blockfor other reasons there). This is
  mainly responsible for the increased complexity compared to v2.
  Personally, I think this is not an improvement over v2, but if this is
  what it takes to fix a corruption issue in 4.2... [Max]
- Don't use huge image files in the test case [Vladimir]

v2:
- Switched order of bs->total_sectors update and zero write [Vladimir]
- Fixed coding style [Vladimir]
- Changed the commit message to contain what was in the cover letter
- Test all preallocation modes
- Test allocation status with qemu-io 'map' [Vladimir]

*** BLURB HERE ***

Kevin Wolf (10):
  block: Add flags to BlockDriver.bdrv_co_truncate()
  block: Add flags to bdrv(_co)_truncate()
  block-backend: Add flags to blk_truncate()
  qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
  raw-format: Support BDRV_REQ_ZERO_WRITE for truncate
  file-posix: Support BDRV_REQ_ZERO_WRITE for truncate
  block: truncate: Don't make backing file data visible
  iotests: Filter testfiles out in filter_img_info()
  iotests: Test committing to short backing file
  qcow2: Forward ZERO_WRITE flag for full preallocation

 include/block/block.h          |   5 +-
 include/block/block_int.h      |  10 +-
 include/sysemu/block-backend.h |   2 +-
 block.c                        |   3 +-
 block/block-backend.c          |   4 +-
 block/commit.c                 |   4 +-
 block/crypto.c                 |   7 +-
 block/file-posix.c             |   6 +-
 block/file-win32.c             |   2 +-
 block/gluster.c                |   1 +
 block/io.c                     |  42 +++++-
 block/iscsi.c                  |   2 +-
 block/mirror.c                 |   2 +-
 block/nfs.c                    |   3 +-
 block/parallels.c              |   6 +-
 block/qcow.c                   |   4 +-
 block/qcow2-cluster.c          |   2 +-
 block/qcow2-refcount.c         |   2 +-
 block/qcow2.c                  |  72 +++++++--
 block/qed.c                    |   3 +-
 block/raw-format.c             |   6 +-
 block/rbd.c                    |   1 +
 block/sheepdog.c               |   4 +-
 block/ssh.c                    |   2 +-
 block/vdi.c                    |   2 +-
 block/vhdx-log.c               |   2 +-
 block/vhdx.c                   |   6 +-
 block/vmdk.c                   |   8 +-
 block/vpc.c                    |   2 +-
 blockdev.c                     |   2 +-
 qemu-img.c                     |   2 +-
 qemu-io-cmds.c                 |   2 +-
 tests/test-block-iothread.c    |   9 +-
 tests/qemu-iotests/iotests.py  |   5 +-
 tests/qemu-iotests/274         | 157 ++++++++++++++++++++
 tests/qemu-iotests/274.out     | 260 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group       |   1 +
 37 files changed, 589 insertions(+), 64 deletions(-)
 create mode 100755 tests/qemu-iotests/274
 create mode 100644 tests/qemu-iotests/274.out

--=20
2.25.3


