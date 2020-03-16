Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47764C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 06:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5F520575
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 06:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5F520575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDj6G-0002xG-U4
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 02:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jDitm-0007h2-GB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jDitl-00006p-8p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:06:50 -0400
Received: from relay.sw.ru ([185.231.240.75]:49920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jDiti-0007MK-6w; Mon, 16 Mar 2020 02:06:46 -0400
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1jDitY-0004fQ-7t; Mon, 16 Mar 2020 09:06:36 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] block: bdrv_set_backing_bs: fix use-after-free
Date: Mon, 16 Mar 2020 09:06:30 +0300
Message-Id: <20200316060631.30052-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200316060631.30052-1-vsementsov@virtuozzo.com>
References: <20200316060631.30052-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a use-after-free possible: bdrv_unref_child() leaves
bs->backing freed but not NULL. bdrv_attach_child may produce nested
polling loop due to drain, than access of freed pointer is possible.

I've produced the following crash on 30 iotest with modified code. It
does not reproduce on master, but still seems possible:

    #0  __strcmp_avx2 () at /lib64/libc.so.6
    #1  bdrv_backing_overridden (bs=0x55c9d3cc2060) at block.c:6350
    #2  bdrv_refresh_filename (bs=0x55c9d3cc2060) at block.c:6404
    #3  bdrv_backing_attach (c=0x55c9d48e5520) at block.c:1063
    #4  bdrv_replace_child_noperm
        (child=child@entry=0x55c9d48e5520,
        new_bs=new_bs@entry=0x55c9d3cc2060) at block.c:2290
    #5  bdrv_replace_child
        (child=child@entry=0x55c9d48e5520,
        new_bs=new_bs@entry=0x55c9d3cc2060) at block.c:2320
    #6  bdrv_root_attach_child
        (child_bs=child_bs@entry=0x55c9d3cc2060,
        child_name=child_name@entry=0x55c9d241d478 "backing",
        child_role=child_role@entry=0x55c9d26ecee0 <child_backing>,
        ctx=<optimized out>, perm=<optimized out>, shared_perm=21,
        opaque=0x55c9d3c5a3d0, errp=0x7ffd117108e0) at block.c:2424
    #7  bdrv_attach_child
        (parent_bs=parent_bs@entry=0x55c9d3c5a3d0,
        child_bs=child_bs@entry=0x55c9d3cc2060,
        child_name=child_name@entry=0x55c9d241d478 "backing",
        child_role=child_role@entry=0x55c9d26ecee0 <child_backing>,
        errp=errp@entry=0x7ffd117108e0) at block.c:5876
    #8  in bdrv_set_backing_hd
        (bs=bs@entry=0x55c9d3c5a3d0,
        backing_hd=backing_hd@entry=0x55c9d3cc2060,
        errp=errp@entry=0x7ffd117108e0)
        at block.c:2576
    #9  stream_prepare (job=0x55c9d49d84a0) at block/stream.c:150
    #10 job_prepare (job=0x55c9d49d84a0) at job.c:761
    #11 job_txn_apply (txn=<optimized out>, fn=<optimized out>) at
        job.c:145
    #12 job_do_finalize (job=0x55c9d49d84a0) at job.c:778
    #13 job_completed_txn_success (job=0x55c9d49d84a0) at job.c:832
    #14 job_completed (job=0x55c9d49d84a0) at job.c:845
    #15 job_completed (job=0x55c9d49d84a0) at job.c:836
    #16 job_exit (opaque=0x55c9d49d84a0) at job.c:864
    #17 aio_bh_call (bh=0x55c9d471a160) at util/async.c:117
    #18 aio_bh_poll (ctx=ctx@entry=0x55c9d3c46720) at util/async.c:117
    #19 aio_poll (ctx=ctx@entry=0x55c9d3c46720,
        blocking=blocking@entry=true)
        at util/aio-posix.c:728
    #20 bdrv_parent_drained_begin_single (poll=true, c=0x55c9d3d558f0)
        at block/io.c:121
    #21 bdrv_parent_drained_begin_single (c=c@entry=0x55c9d3d558f0,
        poll=poll@entry=true)
        at block/io.c:114
    #22 bdrv_replace_child_noperm
        (child=child@entry=0x55c9d3d558f0,
        new_bs=new_bs@entry=0x55c9d3d27300) at block.c:2258
    #23 bdrv_replace_child
        (child=child@entry=0x55c9d3d558f0,
        new_bs=new_bs@entry=0x55c9d3d27300) at block.c:2320
    #24 bdrv_root_attach_child
        (child_bs=child_bs@entry=0x55c9d3d27300,
        child_name=child_name@entry=0x55c9d241d478 "backing",
        child_role=child_role@entry=0x55c9d26ecee0 <child_backing>,
        ctx=<optimized out>, perm=<optimized out>, shared_perm=21,
        opaque=0x55c9d3cc2060, errp=0x7ffd11710c60) at block.c:2424
    #25 bdrv_attach_child
        (parent_bs=parent_bs@entry=0x55c9d3cc2060,
        child_bs=child_bs@entry=0x55c9d3d27300,
        child_name=child_name@entry=0x55c9d241d478 "backing",
        child_role=child_role@entry=0x55c9d26ecee0 <child_backing>,
        errp=errp@entry=0x7ffd11710c60) at block.c:5876
    #26 bdrv_set_backing_hd
        (bs=bs@entry=0x55c9d3cc2060,
        backing_hd=backing_hd@entry=0x55c9d3d27300,
        errp=errp@entry=0x7ffd11710c60)
        at block.c:2576
    #27 stream_prepare (job=0x55c9d495ead0) at block/stream.c:150
    ...

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 957630b1c5..a862ce4df9 100644
--- a/block.c
+++ b/block.c
@@ -2735,10 +2735,10 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
 
     if (bs->backing) {
         bdrv_unref_child(bs, bs->backing);
+        bs->backing = NULL;
     }
 
     if (!backing_hd) {
-        bs->backing = NULL;
         goto out;
     }
 
-- 
2.21.0


