Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3F7C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714F620830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714F620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhJc-0008U7-HR
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:22:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFm-0005SB-Ow
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFl-0004no-Ik
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNhFj-0004lI-F3; Mon, 06 May 2019 13:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB174309B15E;
	Mon,  6 May 2019 17:18:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-82.ams2.redhat.com
	[10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8FD6F1001DC1;
	Mon,  6 May 2019 17:18:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 19:17:55 +0200
Message-Id: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 06 May 2019 17:18:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/10] block: AioContext management, part 1
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

This is the first part of my work to actually properly manage
AioContexts in the block layer rather than just doing some ad-hoc calls
to bdrv_set_aio_context() and hoping that everything will work out.

The goal of this first part is that bdrv_set_aio_context() propagates
the AioContext change not only to the children of the node like we
already do, but also to any other affected nodes, such as additional
parents or nodes connected to the requested one only through a block job
that operates on both nodes.

Keep in mind that a second part will follow and that this is visible in
some functions that may not seem that useful in this series. In
particular, bdrv_try_set_aio_context() isn't used much outside of test
cases in this series. This will change in the second part.

Kevin Wolf (10):
  block: Add bdrv_try_set_aio_context()
  block: Make bdrv_attach/detach_aio_context() static
  block: Move recursion to bdrv_set_aio_context()
  block: Propagate AioContext change to parents
  test-block-iothread: Test AioContext propagation through the tree
  block: Implement .(can_)set_aio_ctx for BlockBackend
  block: Add blk_set_allow_aio_context_change()
  blockjob: Propagate AioContext change to all job nodes
  blockjob: Remove AioContext notifiers
  test-block-iothread: Test AioContext propagation for block jobs

 include/block/block.h          |  10 ++
 include/block/block_int.h      |  25 +---
 include/sysemu/block-backend.h |   1 +
 block.c                        | 157 ++++++++++++++++++++++---
 block/backup.c                 |   8 --
 block/block-backend.c          |  55 ++++++++-
 block/mirror.c                 |  10 +-
 blockjob.c                     |  77 ++++++-------
 tests/test-block-iothread.c    | 202 +++++++++++++++++++++++++++++++++
 9 files changed, 449 insertions(+), 96 deletions(-)

--=20
2.20.1


