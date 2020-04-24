Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D0C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DCF20706
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoHmJzji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DCF20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxsb-0000Xt-9J
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRxrC-0006b4-2N
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRxr7-0002sr-LH
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:54:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRxr7-0002rF-72
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587732896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CorRfj9qYM+ce8ful77Cs2bqHn6eSvaWap6xNys4V4A=;
 b=hoHmJzjiE2jP8pUlI9M7EP655ZtgNSSDsMs87u/nfFVG6UcHpJoySrm8ZpzBJy80hZXgur
 wUK1PwLX3y5Zb3VqsnYg2gXA2FUatPZS3qEdHPNlgXR9BED+h/5dQBk4spmwMaDh3/HQB7
 Jl6lSjhQL/AEXWFClFmO94PWwvIeOXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-C5nXdEfUPMG2z5kd5j1ODA-1; Fri, 24 Apr 2020 08:54:54 -0400
X-MC-Unique: C5nXdEfUPMG2z5kd5j1ODA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71E3800D24;
 Fri, 24 Apr 2020 12:54:53 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-114.ams2.redhat.com
 [10.36.114.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 149FC6084A;
 Fri, 24 Apr 2020 12:54:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 00/10] block: Fix resize (extending) of short overlays
Date: Fri, 24 Apr 2020 14:54:38 +0200
Message-Id: <20200424125448.63318-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
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

v7:
- Allocate smaller zero buffer [Vladimir]
- Added missing error_setg_errno() [Max]
- Code cleanup in the iotest, enabled mapping for 'metadata' [Vladimir]
- Don't assign to errp twice [Eric]

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
 block/io.c                     |  43 +++++-
 block/iscsi.c                  |   2 +-
 block/mirror.c                 |   2 +-
 block/nfs.c                    |   3 +-
 block/parallels.c              |   6 +-
 block/qcow.c                   |   4 +-
 block/qcow2-cluster.c          |   2 +-
 block/qcow2-refcount.c         |   2 +-
 block/qcow2.c                  |  73 +++++++--
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
 tests/qemu-iotests/274         | 155 +++++++++++++++++++
 tests/qemu-iotests/274.out     | 268 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group       |   1 +
 37 files changed, 597 insertions(+), 64 deletions(-)
 create mode 100755 tests/qemu-iotests/274
 create mode 100644 tests/qemu-iotests/274.out

--=20
2.25.3


