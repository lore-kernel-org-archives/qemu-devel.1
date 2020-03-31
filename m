Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F24C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE952073B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE952073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJbk-000248-FD
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jJJau-000173-3H
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jJJas-00082A-9t
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:18:28 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:19822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>)
 id 1jJJap-00080R-4Z; Tue, 31 Mar 2020 12:18:23 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 40AF042F8F;
 Tue, 31 Mar 2020 18:18:20 +0200 (CEST)
Date: Tue, 31 Mar 2020 18:18:18 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <518198448.62.1585671498399@webmail.proxmox.com>
In-Reply-To: <20200331153719.GI7030@linux.fritz.box>
References: <658260883.24.1585644382441@webmail.proxmox.com>
 <20200331125804.GE7030@linux.fritz.box>
 <303038276.59.1585665152860@webmail.proxmox.com>
 <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
 <713436887.61.1585668262838@webmail.proxmox.com>
 <20200331153719.GI7030@linux.fritz.box>
Subject: Re: bdrv_drained_begin deadlock with io-threads
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev23
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On March 31, 2020 5:37 PM Kevin Wolf <kwolf@redhat.com> wrote:
> 
>  
> Am 31.03.2020 um 17:24 hat Dietmar Maurer geschrieben:
> > 
> > > > How can I see/debug those waiting request?
> > > 
> > > Examine bs->tracked_requests list.
> > > 
> > > BdrvTrackedRequest has "Coroutine *co" field. It's a pointer of coroutine of this request. You may use qemu-gdb script to print request's coroutine back-trace:
> > 
> > I would, but there are no tracked request at all.
> > 
> > print bs->tracked_requests
> > $2 = {lh_first = 0x0}
> 
> Then it's one of the recursively checked parents, as you already figured
> out.
> 
> > Looks bdrv_parent_drained_poll_single() calls
> > blk_root_drained_poll(), which return true in my case (in_flight > 5).
> 
> Can you identify which BlockBackend is this? Specifically if it's the
> one attached to a guest device or whether it belongs to the block job.

This can trigger from various different places, but the simplest case is when
its called from drive_backup_prepare 

>   bdrv_drained_begin(bs);

which is the backup source drive.

Note: I have added printf debug statement to the source, so the line numbers may not exactly match

#0  0x00007ffff5cb3916 in __GI_ppoll (fds=0x7fff63d30c40, nfds=2, timeout=<optimized out>, timeout@entry=0x0, sigmask=sigmask@entry=0x0)
    at ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x0000555555c60479 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
#2  0x0000555555c60479 in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=-1) at util/qemu-timer.c:335
#3  0x0000555555c62c61 in fdmon_poll_wait (ctx=0x7fffe8905e80, ready_list=0x7fffffffda68, timeout=-1) at util/fdmon-poll.c:79
#4  0x0000555555c62247 in aio_poll (ctx=0x7fffe8905e80, blocking=blocking@entry=true) at util/aio-posix.c:589
#5  0x0000555555bc25d5 in bdrv_do_drained_begin (poll=<optimized out>, ignore_bds_parents=false, parent=0x0, recursive=false, bs=0x7fffe8954bc0)
    at block/io.c:430
#6  0x0000555555bc25d5 in bdrv_do_drained_begin
    (bs=0x7fffe8954bc0, recursive=<optimized out>, parent=0x0, ignore_bds_parents=<optimized out>, poll=<optimized out>) at block/io.c:395
#7  0x000055555595f753 in drive_backup_prepare (common=0x7fffe560c200, errp=0x7fffffffdba8) at blockdev.c:1759
#8  0x0000555555961f0a in qmp_transaction (dev_list=dev_list@entry=0x7fffffffdc20, has_props=has_props@entry=false, props=0x7fffe560e0e0, 
    props@entry=0x0, errp=errp@entry=0x7fffffffdc58) at blockdev.c:2406
#9  0x00005555559633c2 in blockdev_do_action (errp=0x7fffffffdc58, action=0x7fffffffdc10) at blockdev.c:1054
#10 0x00005555559633c2 in qmp_drive_backup (backup=backup@entry=0x7fffffffdc60, errp=errp@entry=0x7fffffffdc58) at blockdev.c:3134
#11 0x0000555555b1e1d1 in qmp_marshal_drive_backup (args=<optimized out>, ret=<optimized out>, errp=0x7fffffffdd38) at qapi/qapi-commands-block-core.c:555
#12 0x0000555555c15b08 in qmp_dispatch (cmds=0x555556162000 <qmp_commands>, request=<optimized out>, allow_oob=<optimized out>) at qapi/qmp-dispatch.c:155
#13 0x0000555555affca1 in monitor_qmp_dispatch (mon=0x7fffe8915d80, req=<optimized out>) at monitor/qmp.c:145
#14 0x0000555555b0048a in monitor_qmp_bh_dispatcher (data=<optimized out>) at monitor/qmp.c:234
#15 0x0000555555c5e9d5 in aio_bh_call (bh=0x7fffe8e8f960) at util/async.c:164
#16 0x0000555555c5e9d5 in aio_bh_poll (ctx=ctx@entry=0x7fffe8f3ef80) at util/async.c:164
#17 0x0000555555c6208e in aio_dispatch (ctx=0x7fffe8f3ef80) at util/aio-posix.c:380
#18 0x0000555555c5e8be in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:298
#19 0x00007ffff7c7ef2e in g_main_context_dispatch () at /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#20 0x0000555555c612f8 in glib_pollfds_poll () at util/main-loop.c:219
#21 0x0000555555c612f8 in os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:242
#22 0x0000555555c612f8 in main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:518
#23 0x00005555558fc5a9 in qemu_main_loop () at /home/dietmar/pve5-devel/mirror_qemu/softmmu/vl.c:1665
#24 0x0000555555800c3e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/softmmu/main.c:49

> 
> Maybe have a look at the job coroutine, too. You can probably easiest
> find it in the 'jobs' list, and then print the coroutine backtrace for
> job->co.

There is in drive_backup_prepare(), before the job gets created.

> > Looks like I am loosing poll events somewhere?
> 
> I don't think we've lost any event if in_flight > 0. It means that
> something is still supposedly active. Maybe the job deadlocked.

This is a simple call to bdrv_drained_begin(bs) (before we setup the job).

I really nobody else able to reproduce this (somebody already tried to reproduce)?


