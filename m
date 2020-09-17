Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34309C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9683B2087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="Pjd7vzJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9683B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqwZ-0005fa-L0
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kIqtK-0002E2-TZ; Thu, 17 Sep 2020 06:11:50 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kIqtC-0003fI-1L; Thu, 17 Sep 2020 06:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600337464; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=ZTVg+pZchzG2dpDtKpGSp+4Ci2k0klPs/82ZFusj7DIZe75vg1frGx2H4WleElqUI8GXOnpKf9lJPQW593a4nAVXrDOolJAdkR87EldsUfNfbf2iWi/si7+LMwYGsa/D2QZXMsfWqByCWNG/C3ZJHBaoZ9PhThwfKVAA9U4NXvo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1600337464;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=UTuYMQajCsak4+oaDskYrKE0CPaiR73H5gTzfyCrnMk=; 
 b=J8Mm3dR/Y5smMBbDezwxtU9+CqqVizbpEzSzdSgoB5muUUQJ8192n3j7DeoWkhCAKsrVd4UmWzKKwb3QRrzHaz5QDv3A3GLye4L6ms7UUX/NlN0RRe0eQuVGMCHQ34tuaKOPVd9Ufl2rmCzBjNpHEgiK8HfymLnmRt/A9UsjW2E=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1600337464; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 bh=UTuYMQajCsak4+oaDskYrKE0CPaiR73H5gTzfyCrnMk=;
 b=Pjd7vzJhiab9PzOZ9xN8VSZcyR7km4i2FNSKMeoIAGuJUnAcitGbnB0/s7EIHSEW
 25D4tVhN6VyN9zj5QRN9U9NAyRIFDki9Ncqu2zf/YQVg7GbdQ8q+10LCjOWFF2Qrhyl
 gcL+v0QidnNhwRvUl9wu77qDMQidVdqCWX0Qj3yU=
Received: from localhost (ec2-52-56-101-76.eu-west-2.compute.amazonaws.com
 [52.56.101.76]) by mx.zoho.com.cn
 with SMTPS id 1600337462854190.47417162686747;
 Thu, 17 Sep 2020 18:11:02 +0800 (CST)
Date: Thu, 17 Sep 2020 10:10:56 +0000
From: Fam Zheng <fam@euphon.net>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20200917101056.GA2423524@dev>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 06:11:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, armbru@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-09-17 15:36, Zhenyu Ye wrote:
> Hi Stefan,
> 
> On 2020/9/14 21:27, Stefan Hajnoczi wrote:
> >>
> >> Theoretically, everything running in an iothread is asynchronous. However,
> >> some 'asynchronous' actions are not non-blocking entirely, such as
> >> io_submit().  This will block while the iodepth is too big and I/O pressure
> >> is too high.  If we do some qmp actions, such as 'info block', at this time,
> >> may cause vm soft lockup.  This series can make these qmp actions safer.
> >>
> >> I constructed the scene as follow:
> >> 1. create a vm with 4 disks, using iothread.
> >> 2. add press to the CPU on the host.  In my scene, the CPU usage exceeds 95%.
> >> 3. add press to the 4 disks in the vm at the same time.  I used the fio and
> >> some parameters are:
> >>
> >> 	 fio -rw=randrw -bs=1M -size=1G -iodepth=512 -ioengine=libaio -numjobs=4
> >>
> >> 4. do block query actions, for example, by virsh:
> >>
> >> 	virsh qemu-monitor-command [vm name] --hmp info block
> >>
> >> Then the vm will soft lockup, the calltrace is:
> >>
> >> [  192.311393] watchdog: BUG: soft lockup - CPU#1 stuck for 42s! [kworker/1:1:33]
> > 
> > Hi,
> > Sorry I haven't had time to investigate this myself yet.
> > 
> > Do you also have a QEMU backtrace when the hang occurs?
> > 
> > Let's find out if QEMU is stuck in the io_submit(2) syscall or whether
> > there's an issue in QEMU itself that causes the softlockup (for example,
> > aio_poll() with the global mutex held).
> 
> Sorry for the delay.
> 
> I traced the io_submit() within the guest. The maximum execution time exceeds 16s:
> 
> 	guest# perf trace -p `pidof -s fio` --duration 1
> 	    14.808 (3843.082 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	  3861.336 (11470.608 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 15341.998 (479.283 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 15831.380 (3704.997 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 19547.869 (3412.839 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 22966.953 (1080.854 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 24062.689 (6939.813 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 31019.219 (532.147 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 31556.610 (3469.920 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 35038.885 (9007.175 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 44053.578 (16006.405 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 60068.944 (3068.748 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	 63138.474 (13012.499 ms): io_getevents(ctx_id: 281472924459008, min_nr: 511, nr: 511, events: 0x19a83150) = 511
> 	 76191.073 (2872.657 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
> 	...
> 
> And in the host, the information of sys_enter_io_submit() is:
> 
> 	Samples: 3K of event 'syscalls:sys_enter_io_submit', Event count (approx.): 3150
> 	Children      Self  Trace output
> 	-   66.70%    66.70%  ctx_id: 0xffff9c044000, nr: 0x00000001, iocbpp: 0xffff9f7fad28
> 	0xffffae7f871c
> 	0xffffae8a27c4
> 	qemu_thread_start
> 	iothread_run
> 	aio_poll
> 	aio_dispatch_ready_handlers
> 	aio_dispatch_handler
> 	virtio_queue_host_notifier_aio_read
> 	virtio_queue_notify_aio_vq
> 	virtio_blk_data_plane_handle_output
> 	virtio_blk_handle_vq
> 	blk_io_unplug
> 	bdrv_io_unplug
> 	bdrv_io_unplug
> 	raw_aio_unplug
> 	laio_io_unplug
> 	syscall
> 
> 
> When the hang occurs, the QEMU is blocked at:
> 
> 	#0  0x0000ffff95762b64 in ?? () from target:/usr/lib64/libpthread.so.0
> 	#1  0x0000ffff9575bd88 in pthread_mutex_lock () from target:/usr/lib64/libpthread.so.0
> 	#2  0x0000aaaabb1f5948 in qemu_mutex_lock_impl (mutex=0xaaaacc8e1860,
> 	    file=0xaaaabb4e1bd0 "/Images/eillon/CODE/5-opensource/qemu/util/async.c", line=605)
> 	#3  0x0000aaaabb20acd4 in aio_context_acquire (ctx=0xaaaacc8e1800)
> 	#4  0x0000aaaabb105e90 in bdrv_query_image_info (bs=0xaaaacc934620,
> 	    p_info=0xaaaaccc41e18, errp=0xffffca669118)
> 	#5  0x0000aaaabb105968 in bdrv_block_device_info (blk=0xaaaacdca19f0, bs=0xaaaacc934620,
> 	    flat=false, errp=0xffffca6692b8)
> 	#6  0x0000aaaabb1063dc in bdrv_query_info (blk=0xaaaacdca19f0, p_info=0xaaaacd29c9a8,
> 	    errp=0xffffca6692b8)
> 	#7  0x0000aaaabb106c14 in qmp_query_block (errp=0x0)
> 	#8  0x0000aaaabacb8e6c in hmp_info_block (mon=0xffffca6693d0, qdict=0xaaaacd089790)
> 	#9  0x0000aaaabb0068f0 in handle_hmp_command (mon=0xffffca6693d0,
> 	    cmdline=0xaaaacc9013ca "")
> 	#10 0x0000aaaabaab5034 in qmp_human_monitor_command (
> 	    command_line=0xaaaacc9013c0 "info block", has_cpu_index=false, cpu_index=0,
> 	    errp=0xffffca6694d8)
> 	#11 0x0000aaaabb03c720 in qmp_marshal_human_monitor_command (args=0xffff70008070,
> 	    ret=0xffffca669570, errp=0xffffca669568) at qapi/qapi-commands-misc.c:653
> 	#12 0x0000aaaabb18fdbc in qmp_dispatch (cmds=0xaaaabbb197c0 <qmp_commands>,
> 	    request=0xffff70005cc0, allow_oob=false)
> 	#13 0x0000aaaabb003074 in monitor_qmp_dispatch (mon=0xaaaacc962320, req=0xffff70005cc0)
> 	#14 0x0000aaaabb003488 in monitor_qmp_bh_dispatcher (data=0x0)
> 	#15 0x0000aaaabb209d44 in aio_bh_call (bh=0xaaaacc5f0810)
> 	#16 0x0000aaaabb209e50 in aio_bh_poll (ctx=0xaaaacc5ef320)
> 	#17 0x0000aaaabb1f1494 in aio_dispatch (ctx=0xaaaacc5ef320)
> 	#18 0x0000aaaabb20a330 in aio_ctx_dispatch (source=0xaaaacc5ef320, callback=0x0,
> 	    user_data=0x0)
> 	#19 0x0000ffff95f00a7c in g_main_context_dispatch ()
> 	   from target:/usr/lib64/libglib-2.0.so.0
> 	#20 0x0000aaaabb2128e8 in glib_pollfds_poll ()
> 	#21 0x0000aaaabb212970 in os_host_main_loop_wait (timeout=64805420)
> 	#22 0x0000aaaabb212a90 in main_loop_wait (nonblocking=0)
> 	#23 0x0000aaaabaad63d0 in qemu_main_loop ()
> 	#24 0x0000aaaabb188b54 in main (argc=117, argv=0xffffca669a68, envp=0xffffca669e18)
> 
> And the QEMU process backtrace in kernel is:
> 	[<0>] __switch_to+0xdc/0x140
> 	[<0>] futex_wait_queue_me+0xd4/0x158
> 	[<0>] futex_wait+0xf4/0x230
> 	[<0>] do_futex+0x46c/0x608
> 	[<0>] __arm64_sys_futex+0x13c/0x188
> 	[<0>] el0_svc_common+0x80/0x1b8
> 	[<0>] el0_svc_handler+0x38/0x78
> 	[<0>] el0_svc+0x10/0x14
> 	[<0>] 0xffffffffffffffff

Hi Zhenyu,

Did you by any chance capture the kernel stack where io_submit is stuck?

Thanks,
Fam

