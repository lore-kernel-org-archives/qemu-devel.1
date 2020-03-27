Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835EC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 06:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9582920714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 06:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9582920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHi9s-00050L-Pu
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 02:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jHi9J-0004WQ-4g
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 02:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jHi9I-0001aK-1t
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 02:07:21 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:50725)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>)
 id 1jHi9F-0000yO-Ds; Fri, 27 Mar 2020 02:07:17 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2A72B41C87;
 Fri, 27 Mar 2020 07:07:14 +0100 (CET)
Date: Fri, 27 Mar 2020 07:07:12 +0100 (CET)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <1614642655.1.1585289232685@webmail.proxmox.com>
In-Reply-To: <20200326155628.859862-1-s.reiter@proxmox.com>
References: <20200326155628.859862-1-s.reiter@proxmox.com>
Subject: Re: [PATCH v2 0/3] Fix some AIO context locking in jobs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev22
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, slp@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> I *think* the second patch also fixes the hangs on backup abort that I and
> Dietmar noticed in v1, but I'm not sure, they we're somewhat intermittent
> before too.

No, I still get this freeze:

0  0x00007f0aa4866916 in __GI_ppoll (fds=0x7f0a12935c40, nfds=2, timeout=<optimized out>, timeout@entry=0x0, sigmask=sigmask@entry=0x0)
    at ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x000055d3a6c91d29 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>)
    at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
#2  0x000055d3a6c91d29 in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=-1) at util/qemu-timer.c:335
#3  0x000055d3a6c94511 in fdmon_poll_wait (ctx=0x7f0a97505e80, ready_list=0x7fff67e5c358, timeout=-1) at util/fdmon-poll.c:79
#4  0x000055d3a6c93af7 in aio_poll (ctx=0x7f0a97505e80, blocking=blocking@entry=true) at util/aio-posix.c:589
#5  0x000055d3a6bf4cd3 in bdrv_do_drained_begin
    (poll=<optimized out>, ignore_bds_parents=false, parent=0x0, recursive=false, bs=0x7f0a9754c280) at block/io.c:429
#6  0x000055d3a6bf4cd3 in bdrv_do_drained_begin
    (bs=0x7f0a9754c280, recursive=<optimized out>, parent=0x0, ignore_bds_parents=<optimized out>, poll=<optimized out>) at block/io.c:395
#7  0x000055d3a6be5c87 in blk_drain (blk=0x7f0a97abcc00) at block/block-backend.c:1617
#8  0x000055d3a6be686d in blk_unref (blk=0x7f0a97abcc00) at block/block-backend.c:473
#9  0x000055d3a6b9e835 in block_job_free (job=0x7f0a15f44e00) at blockjob.c:89
#10 0x000055d3a6b9fe29 in job_unref (job=0x7f0a15f44e00) at job.c:376
#11 0x000055d3a6b9fe29 in job_unref (job=0x7f0a15f44e00) at job.c:368
#12 0x000055d3a6ba07aa in job_finish_sync (job=job@entry=0x7f0a15f44e00, finish=finish@entry=
    0x55d3a6ba0cd0 <job_cancel_err>, errp=errp@entry=0x0) at job.c:1004
#13 0x000055d3a6ba0cee in job_cancel_sync (job=job@entry=0x7f0a15f44e00) at job.c:947


