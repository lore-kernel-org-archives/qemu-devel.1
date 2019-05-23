Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047B9C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF08D21773
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF08D21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40067 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqJc-0004oG-TL
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:11:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAK-0004Tj-HN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAI-00027U-T8
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hTqAC-0001bP-D0; Thu, 23 May 2019 12:01:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3603A4D29;
	Thu, 23 May 2019 16:01:14 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-143.ams2.redhat.com
	[10.36.116.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE9B710027C6;
	Thu, 23 May 2019 16:01:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 23 May 2019 18:00:49 +0200
Message-Id: <20190523160104.21258-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 23 May 2019 16:01:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/15] block: AioContext management, part 2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recently, a few bugs were reported that resulted from an inconsistent
state regarding AioContexts. Block nodes can end up in different
contexts than their users expect - the AioContext of a node can even
change under the feet of a device with no way for the device to forbid
this. We recently added a few basic checks to scsi-disk and virtio-blk,
but they are by far not enough.

Part 1 solved the first half of the problem and made sure that
AioContext changes are propagated through the graph as necessary, so
that a bdrv_set_aio_context() correctly pulls everything that uses the
node into the right context.

This is part 2 that fixes the second half: Attaching new child nodes
where the parent and child are already in different AioContexts. This
operation may only succeed if we can move one of the node into the
context of the other node.

After applying this series, unchecked bdrv_set_aio_context() doesn't
exist any more and all users call functions that make sure that the
AioContext assignments across the graph stays consistent.

Kevin Wolf (15):
  test-block-iothread: Check filter node in test_propagate_mirror
  block: Add Error to blk_set_aio_context()
  block: Add BlockBackend.ctx
  block: Add qdev_prop_drive_iothread property type
  scsi-disk: Use qdev_prop_drive_iothread
  block: Adjust AioContexts when attaching nodes
  test-block-iothread: Test adding parent to iothread node
  test-block-iothread: BlockBackend AioContext across root node change
  block: Move node without parents to main AioContext
  blockdev: Use bdrv_try_set_aio_context() for monitor commands
  block: Remove wrong bdrv_set_aio_context() calls
  virtio-scsi-test: Test attaching new overlay with iothreads
  iotests: Attach new devices to node in non-default iothread
  test-bdrv-drain: Use bdrv_try_set_aio_context()
  block: Remove bdrv_set_aio_context()

 docs/devel/multiple-iothreads.txt |   4 +-
 include/block/block.h             |   9 ---
 include/block/block_int.h         |   1 +
 include/hw/block/block.h          |   7 +-
 include/hw/qdev-properties.h      |   3 +
 include/hw/scsi/scsi.h            |   1 +
 include/sysemu/block-backend.h    |   5 +-
 tests/libqtest.h                  |  11 ++++
 block.c                           |  70 ++++++++++++++------
 block/backup.c                    |   3 +-
 block/block-backend.c             |  47 +++++++++-----
 block/commit.c                    |  13 ++--
 block/crypto.c                    |   3 +-
 block/mirror.c                    |   4 +-
 block/parallels.c                 |   3 +-
 block/qcow.c                      |   3 +-
 block/qcow2.c                     |   6 +-
 block/qed.c                       |   3 +-
 block/sheepdog.c                  |   3 +-
 block/vdi.c                       |   3 +-
 block/vhdx.c                      |   3 +-
 block/vmdk.c                      |   3 +-
 block/vpc.c                       |   3 +-
 blockdev.c                        |  48 ++++++++------
 blockjob.c                        |  12 +++-
 hmp.c                             |   3 +-
 hw/block/dataplane/virtio-blk.c   |  12 +++-
 hw/block/dataplane/xen-block.c    |   6 +-
 hw/block/fdc.c                    |   2 +-
 hw/block/xen-block.c              |   2 +-
 hw/core/qdev-properties-system.c  |  41 +++++++++++-
 hw/ide/qdev.c                     |   2 +-
 hw/scsi/scsi-disk.c               |  24 ++++---
 hw/scsi/virtio-scsi.c             |  25 ++++---
 migration/block.c                 |   3 +-
 nbd/server.c                      |   5 +-
 tests/libqtest.c                  |  19 ++++++
 tests/test-bdrv-drain.c           |  50 +++++++-------
 tests/test-bdrv-graph-mod.c       |   5 +-
 tests/test-block-backend.c        |   4 +-
 tests/test-block-iothread.c       | 104 +++++++++++++++++++++++++-----
 tests/test-blockjob.c             |   2 +-
 tests/test-throttle.c             |   6 +-
 tests/virtio-scsi-test.c          |  62 ++++++++++++++++++
 tests/qemu-iotests/051            |  24 +++++++
 tests/qemu-iotests/051.out        |   3 +
 tests/qemu-iotests/051.pc.out     |  27 ++++++++
 tests/qemu-iotests/240.out        |   2 +-
 48 files changed, 531 insertions(+), 173 deletions(-)

--=20
2.20.1


