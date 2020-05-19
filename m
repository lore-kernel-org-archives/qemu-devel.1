Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D5FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC2F206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBxce2wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC2F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jazsP-0006eD-5f
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 06:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jazrr-00069E-RZ
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:53:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jazrq-00089V-3W
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589885580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QnrzlGSK8fafG65CSerirzjRhrHsI+mOn9EVB1BmxJY=;
 b=WBxce2wxMBx58xjtCpsoXaHRB1m1hqSTLmnEPRkGQpiCl/e0gE8JxFo23QuxDJwiZQxfxh
 3ggPAVCMCtoRKgvATAYrcbxFYVrCji/z2nDGryCvVuRFSxgTELll5ijhPEsPQYeRuMvOvK
 5IuRiIRqRfvaW2n+ShmE2cuzehG95H0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-i-VNCyZTMtCr9rId2w2BTg-1; Tue, 19 May 2020 06:52:58 -0400
X-MC-Unique: i-VNCyZTMtCr9rId2w2BTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D1180B738;
 Tue, 19 May 2020 10:52:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-199.ams2.redhat.com [10.36.113.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66E072CE39;
 Tue, 19 May 2020 10:52:43 +0000 (UTC)
Date: Tue, 19 May 2020 12:52:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 5/9] block/io: expand in_flight inc/dec section:
 simple cases
Message-ID: <20200519105241.GH7652@linux.fritz.box>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
 <20200427143907.5710-6-vsementsov@virtuozzo.com>
 <efc8e783-0541-6b95-1356-71ccc823cad2@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <efc8e783-0541-6b95-1356-71ccc823cad2@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.05.2020 um 09:02 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 27.04.2020 17:39, Vladimir Sementsov-Ogievskiy wrote:
> > It's safer to expand in_flight request to start before enter to
> > coroutine in synchronous wrappers, due to the following (theoretical)
> > problem:
> > 
> > Consider write.
> > It's possible, that qemu_coroutine_enter only schedules execution,
> > assume such case.
> > 
> > Then we may possibly have the following:
> > 
> > 1. Somehow check that we are not in drained section in outer code.
> > 
> > 2. Call bdrv_pwritev(), assuming that it will increase in_flight, which
> > will protect us from starting drained section.
> > 
> > 3. It calls bdrv_prwv_co() -> bdrv_coroutine_enter() (not yet increased
> > in_flight).
> > 
> > 4. Assume coroutine not yet actually entered, only scheduled, and we go
> > to some code, which starts drained section (as in_flight is zero).
> > 
> > 5. Scheduled coroutine starts, and blindly increases in_flight, and we
> > are in drained section with in_flight request.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Very interesting: this patch breaks test-replication. It hangs:
> 
> (gdb) thr a a bt
> 
> Thread 2 (Thread 0x7eff256cd700 (LWP 2843)):
> #0  0x00007eff2f5fd1fd in syscall () from /lib64/libc.so.6
> #1  0x000055af9a9a4f11 in qemu_futex_wait (f=0x55af9aa6f758 <rcu_call_ready_event>, val=4294967295) at /work/src/qemu/up-expand-bdrv-in_flight-bounds/include/qemu/futex.h:29
> #2  0x000055af9a9a50d5 in qemu_event_wait (ev=0x55af9aa6f758 <rcu_call_ready_event>) at util/qemu-thread-posix.c:459
> #3  0x000055af9a9bd20d in call_rcu_thread (opaque=0x0) at util/rcu.c:260
> #4  0x000055af9a9a5288 in qemu_thread_start (args=0x55af9c4f1b80) at util/qemu-thread-posix.c:519
> #5  0x00007eff2f6d44c0 in start_thread () from /lib64/libpthread.so.0
> #6  0x00007eff2f602553 in clone () from /lib64/libc.so.6
> 
> Thread 1 (Thread 0x7eff25820a80 (LWP 2842)):
> #0  0x00007eff2f5f7bd6 in ppoll () from /lib64/libc.so.6
> #1  0x000055af9a99e405 in qemu_poll_ns (fds=0x55af9c52a830, nfds=1, timeout=-1) at util/qemu-timer.c:335
> #2  0x000055af9a9a1cab in fdmon_poll_wait (ctx=0x55af9c526890, ready_list=0x7ffc73e8c5d0, timeout=-1) at util/fdmon-poll.c:79
> #3  0x000055af9a9a160c in aio_poll (ctx=0x55af9c526890, blocking=true) at util/aio-posix.c:600
> #4  0x000055af9a8f0bb0 in bdrv_do_drained_begin (bs=0x55af9c52a8d0, recursive=false, parent=0x0, ignore_bds_parents=false, poll=true) at block/io.c:429
> #5  0x000055af9a8f0c95 in bdrv_drained_begin (bs=0x55af9c52a8d0) at block/io.c:435
> #6  0x000055af9a8dc6a8 in blk_drain (blk=0x55af9c542c10) at block/block-backend.c:1681
> #7  0x000055af9a8da0b6 in blk_unref (blk=0x55af9c542c10) at block/block-backend.c:473
> #8  0x000055af9a8eb5e7 in mirror_exit_common (job=0x55af9c6c45c0) at block/mirror.c:667
> #9  0x000055af9a8eb9c1 in mirror_prepare (job=0x55af9c6c45c0) at block/mirror.c:765
> #10 0x000055af9a87cd65 in job_prepare (job=0x55af9c6c45c0) at job.c:781
> #11 0x000055af9a87b62a in job_txn_apply (job=0x55af9c6c45c0, fn=0x55af9a87cd28 <job_prepare>) at job.c:158
> #12 0x000055af9a87cdee in job_do_finalize (job=0x55af9c6c45c0) at job.c:798
> #13 0x000055af9a87cfb5 in job_completed_txn_success (job=0x55af9c6c45c0) at job.c:852
> #14 0x000055af9a87d055 in job_completed (job=0x55af9c6c45c0) at job.c:865
> #15 0x000055af9a87d0a8 in job_exit (opaque=0x55af9c6c45c0) at job.c:885
> #16 0x000055af9a99b981 in aio_bh_call (bh=0x55af9c547440) at util/async.c:136
> #17 0x000055af9a99ba8b in aio_bh_poll (ctx=0x55af9c526890) at util/async.c:164
> #18 0x000055af9a9a17ff in aio_poll (ctx=0x55af9c526890, blocking=true) at util/aio-posix.c:650
> #19 0x000055af9a8f7011 in bdrv_flush (bs=0x55af9c53b900) at block/io.c:3019
> #20 0x000055af9a874351 in bdrv_close (bs=0x55af9c53b900) at block.c:4252
> #21 0x000055af9a874ca3 in bdrv_delete (bs=0x55af9c53b900) at block.c:4498
> #22 0x000055af9a877862 in bdrv_unref (bs=0x55af9c53b900) at block.c:5866
> #23 0x000055af9a870837 in bdrv_root_unref_child (child=0x55af9c6c4430) at block.c:2684
> #24 0x000055af9a8da9a2 in blk_remove_bs (blk=0x55af9c547bd0) at block/block-backend.c:803
> #25 0x000055af9a8d9e54 in blk_delete (blk=0x55af9c547bd0) at block/block-backend.c:422
> #26 0x000055af9a8da0f8 in blk_unref (blk=0x55af9c547bd0) at block/block-backend.c:477
> #27 0x000055af9a86a6f1 in teardown_secondary () at tests/test-replication.c:392
> #28 0x000055af9a86aac1 in test_secondary_stop () at tests/test-replication.c:490
> #29 0x00007eff2fd7df7e in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
> #30 0x00007eff2fd7dd24 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
> #31 0x00007eff2fd7dd24 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
> #32 0x00007eff2fd7e46a in g_test_run_suite () from /lib64/libglib-2.0.so.0
> #33 0x00007eff2fd7e485 in g_test_run () from /lib64/libglib-2.0.so.0
> #34 0x000055af9a86b19c in main (argc=1, argv=0x7ffc73e8d088) at tests/test-replication.c:645
> 
> 
> (gdb) p ((BlockBackend *)0x55af9c547bd0)->in_flight
> $5 = 0
> (gdb) p ((BlockBackend *)0x55af9c542c10)->in_flight
> $6 = 0
> (gdb) p ((BlockDriverState *)0x55af9c53b900)->in_flight
> $7 = 1
> (gdb) p ((BlockDriverState *)0x55af9c52a8d0)->in_flight
> $8 = 0
> (gdb) fr 20
> #20 0x000055af9a874351 in bdrv_close (bs=0x55af9c53b900) at block.c:4252
> 4252        bdrv_flush(bs);
> (gdb) p bs->node_name
> $9 = "#block5317", '\000' <repeats 21 times>
> (gdb) p bs->drv
> $10 = (BlockDriver *) 0x55af9aa63c40 <bdrv_replication>
> (gdb) p bs->in_flight
> $11 = 1
> (gdb) p bs->tracked_requests
> $12 = {lh_first = 0x0}
> 
> 
> So, we entered bdrv_flush at frame 19, and increased in_flight. Then
> we go to aio_poll and to nested event loop, and we never return to
> decrease in_flight field.
> 
> Hmm. I'm afraid, I don't know what to do with that. Kevin, could you
> take a look? And could similar thing happen with blk layer, because of
> you recent similar patch?

Hmm... You mean blk_prw(), right? Looks like it could have the same
problem, indeed.

Maybe we need to move the blk/bdrv_dec_in_flight to inside the coroutine
(probably to the place where we currently have aio_wait_kick(), which
would already be built in for bdrv_dec_in_flight). This is the last
thing the coroutine does, so presumably it will still be late enough.

Kevin


