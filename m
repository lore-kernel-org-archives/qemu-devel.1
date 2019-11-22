Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9327C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B563120715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG4O+ysO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B563120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBU8-0003or-UI
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iYBR2-0000Ce-Ft
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iYBR0-0002ir-D2
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:05:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iYBR0-0002hL-8t
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574438724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mt0cjYTUj3bhShfV3LT5GsZxmEg1g/0KqM51xEBkRJ8=;
 b=SG4O+ysOtD9t2nM4JoFrNIEp/e5FkHXjATDm98vNUGJDilXM4KAG3VhLRwflRqrsoxf/Mi
 SYexGFvphch/N+5AgaDY0GFtzIAobc34OaQKOma4umLg5LiwjN5DFPyuOXv8ZP+ZX/5M2E
 cotwQcFrWF42lK49Ys9+ZdhO5mgdtg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-2vVknp9qOwmFJ2X-_omAJw-1; Fri, 22 Nov 2019 11:05:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E1C510054E3;
 Fri, 22 Nov 2019 16:05:20 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-252.ams2.redhat.com
 [10.36.117.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6DE8100032E;
 Fri, 22 Nov 2019 16:05:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
Date: Fri, 22 Nov 2019 17:05:03 +0100
Message-Id: <20191122160511.8377-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 2vVknp9qOwmFJ2X-_omAJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

See patch 4 for the description of the bug fixed.

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

Kevin Wolf (8):
  block: bdrv_co_do_pwrite_zeroes: 64 bit 'bytes' parameter
  block: Add no_fallback parameter to bdrv_co_truncate()
  qcow2: Declare BDRV_REQ_NO_FALLBACK supported
  block: truncate: Don't make backing file data visible
  iotests: Add qemu_io_log()
  iotests: Fix timeout in run_job()
  iotests: Support job-complete in run_job()
  iotests: Test committing to short backing file

 include/block/block.h          |   5 +-
 include/sysemu/block-backend.h |   2 +-
 block/block-backend.c          |   4 +-
 block/commit.c                 |   4 +-
 block/crypto.c                 |   4 +-
 block/io.c                     |  55 +++++++--
 block/mirror.c                 |   2 +-
 block/parallels.c              |   6 +-
 block/qcow.c                   |   4 +-
 block/qcow2-refcount.c         |   2 +-
 block/qcow2.c                  |  22 ++--
 block/qed.c                    |   2 +-
 block/raw-format.c             |   2 +-
 block/vdi.c                    |   2 +-
 block/vhdx-log.c               |   2 +-
 block/vhdx.c                   |   6 +-
 block/vmdk.c                   |  10 +-
 block/vpc.c                    |   2 +-
 blockdev.c                     |   2 +-
 qemu-img.c                     |   2 +-
 qemu-io-cmds.c                 |   2 +-
 tests/test-block-iothread.c    |   6 +-
 tests/qemu-iotests/274         | 152 ++++++++++++++++++++++++
 tests/qemu-iotests/274.out     | 203 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group       |   1 +
 tests/qemu-iotests/iotests.py  |  11 +-
 26 files changed, 463 insertions(+), 52 deletions(-)
 create mode 100755 tests/qemu-iotests/274
 create mode 100644 tests/qemu-iotests/274.out

--=20
2.20.1


