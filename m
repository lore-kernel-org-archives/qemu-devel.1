Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1FCC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614CF22210
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="AMRxCB5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614CF22210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwWI-0002SE-7f
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kIwNH-0007vR-8f; Thu, 17 Sep 2020 12:03:07 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kIwN5-000496-LK; Thu, 17 Sep 2020 12:03:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600358476; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=VJG+wmXShuy7YFvBKjxaENeYeLKhDo5rVMmcjueYZcHQu7LQZ3dbcJjrcskOup8fM5xHwdmjc/CqIDwFFQtZaTfYKbIa8fI2TxcZQdT4hoBMO6c0T6JL1X8CbumLtkYzVn6HtcdFYCo5hytLiXY3FrV0QryN//pAuXxzV+hCGpU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1600358476;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=KLPw0xg5wW2NuCB7I6yMoI/ufMVfvSXKW6X0IBEVc+U=; 
 b=TItZdnkludFeZPOrLevaYSHQC068XFEWQgmShzpPBhF1MpPHfXlbIxq1utqe9BXEyBzRXkxPmezI8MkRtijgKCklYQ2entwvGJFU/rVrdXdObrGDnH48vaJbPlzfFOam3qi3cWoPR91xTbeLD8Llmre94jfvYS8k1IePZPZ4T1Q=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1600358476; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 bh=KLPw0xg5wW2NuCB7I6yMoI/ufMVfvSXKW6X0IBEVc+U=;
 b=AMRxCB5WIBqazo0VIPdJsbkX/NRqjJ3mHe8ek/Iguqct5gu9M+O6jfOAQQs9x5Yg
 e8NYUifVCmw+uGxDVcY8h7xcgwD6T96zA5JgxUaqo0MgtWDo0woY37ivAnWKgtILh+C
 L3xB2Mic9qkJVSCHciVgx/BXBF1wEDL4X8aq/xeo=
Received: from localhost (ec2-52-56-101-76.eu-west-2.compute.amazonaws.com
 [52.56.101.76]) by mx.zoho.com.cn
 with SMTPS id 1600358473568625.6813746852993;
 Fri, 18 Sep 2020 00:01:13 +0800 (CST)
Date: Thu, 17 Sep 2020 16:01:06 +0000
From: Fam Zheng <fam@euphon.net>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20200917160054.GA2453251@dev>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
 <20200917154415.GB839531@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917154415.GB839531@stefanha-x1.localdomain>
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 12:01:57
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Zhenyu Ye <yezhenyu2@huawei.com>, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, armbru@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-09-17 16:44, Stefan Hajnoczi wrote:
> On Thu, Sep 17, 2020 at 03:36:57PM +0800, Zhenyu Ye wrote:
> > When the hang occurs, the QEMU is blocked at:
> > 
> > 	#0  0x0000ffff95762b64 in ?? () from target:/usr/lib64/libpthread.so.0
> > 	#1  0x0000ffff9575bd88 in pthread_mutex_lock () from target:/usr/lib64/libpthread.so.0
> > 	#2  0x0000aaaabb1f5948 in qemu_mutex_lock_impl (mutex=0xaaaacc8e1860,
> > 	    file=0xaaaabb4e1bd0 "/Images/eillon/CODE/5-opensource/qemu/util/async.c", line=605)
> > 	#3  0x0000aaaabb20acd4 in aio_context_acquire (ctx=0xaaaacc8e1800)
> > 	#4  0x0000aaaabb105e90 in bdrv_query_image_info (bs=0xaaaacc934620,
> > 	    p_info=0xaaaaccc41e18, errp=0xffffca669118)
> > 	#5  0x0000aaaabb105968 in bdrv_block_device_info (blk=0xaaaacdca19f0, bs=0xaaaacc934620,
> > 	    flat=false, errp=0xffffca6692b8)
> > 	#6  0x0000aaaabb1063dc in bdrv_query_info (blk=0xaaaacdca19f0, p_info=0xaaaacd29c9a8,
> > 	    errp=0xffffca6692b8)
> > 	#7  0x0000aaaabb106c14 in qmp_query_block (errp=0x0)
> > 	#8  0x0000aaaabacb8e6c in hmp_info_block (mon=0xffffca6693d0, qdict=0xaaaacd089790)
> 
> Great, this shows that the main loop thread is stuck waiting for the
> AioContext lock.
> 
> Please post backtraces from all QEMU threads ((gdb) thread apply all bt)
> so we can figure out which thread is holding up the main loop.

I think that is reflected in the perf backtrace posted by Zheny already:

And in the host, the information of sys_enter_io_submit() is:

Samples: 3K of event 'syscalls:sys_enter_io_submit', Event count
(approx.): 3150
   Children      Self  Trace output
   -   66.70%    66.70%  ctx_id: 0xffff9c044000,
   nr: 0x00000001, iocbpp: 0xffff9f7fad28
   0xffffae7f871c
   0xffffae8a27c4
   qemu_thread_start
   iothread_run
   aio_poll
   aio_dispatch_ready_handlers
   aio_dispatch_handler
   virtio_queue_host_notifier_aio_read
   virtio_queue_notify_aio_vq
   virtio_blk_data_plane_handle_output
   virtio_blk_handle_vq
   blk_io_unplug
   bdrv_io_unplug
   bdrv_io_unplug
   raw_aio_unplug
   laio_io_unplug
   syscall

So the iothread is blocked by a slow io_submit holding the AioContext
lock.

It would be interesting to know what in kernel is blocking io_submit
from returning.

Fam

