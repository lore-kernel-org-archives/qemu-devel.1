Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9D3C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF33206F8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF33206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlod-00017o-Ok
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jHlne-0000fU-CU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jHlnZ-00073S-8r
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:01:14 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:13097)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>)
 id 1jHlnS-0006fZ-Dy; Fri, 27 Mar 2020 06:01:02 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3001C428FF;
 Fri, 27 Mar 2020 11:00:50 +0100 (CET)
Date: Fri, 27 Mar 2020 11:00:48 +0100 (CET)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <626397594.17.1585303248535@webmail.proxmox.com>
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

After more test, I am 100% sure the bug (or another one) is still there. 
Here is how to trigger:

1. use latest qemu sources from githup
2. apply those 3 patches from Stefan
2. create a VM with virtio-scsis-single drive using io-thread
3. inside VM install Debian buster
4. inside VM, run "stress -d 5"

Then run a series of backups, aborting them after a few seconds:

# start loop 

qmp: { "execute": "drive-backup", "arguments": { "device": "drive-scsi0", "sync": "full", "target": "backup-scsi0.raw" } }

sleep 3 second

qmp: { "execute": "'block-job-cancel", "arguments": { "device": "drive-scsi0" } }

# end loop

After several iterations (mostly < 50) the VM freezes (this time somewhere 
inside drive_backup_prepare):


(gdb) bt
#0  0x00007f61ea09e916 in __GI_ppoll (fds=0x7f6158130c40, nfds=2, timeout=<optimized out>, timeout@entry=0x0, sigmask=sigmask@entry=0x0)
    at ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x000055f708401c79 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>)
    at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
#2  0x000055f708401c79 in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=-1) at util/qemu-timer.c:335
#3  0x000055f708404461 in fdmon_poll_wait (ctx=0x7f61dcd05e80, ready_list=0x7ffc4e7fbde8, timeout=-1) at util/fdmon-poll.c:79
#4  0x000055f708403a47 in aio_poll (ctx=0x7f61dcd05e80, blocking=blocking@entry=true) at util/aio-posix.c:589
#5  0x000055f708364c03 in bdrv_do_drained_begin (poll=<optimized out>, ignore_bds_parents=false, parent=0x0, recursive=false, bs=0x7f61dcd4c500)
    at block/io.c:429
#6  0x000055f708364c03 in bdrv_do_drained_begin
    (bs=0x7f61dcd4c500, recursive=<optimized out>, parent=0x0, ignore_bds_parents=<optimized out>, poll=<optimized out>) at block/io.c:395
#7  0x000055f7081016f9 in drive_backup_prepare (common=0x7f61d9a0c280, errp=0x7ffc4e7fbf28) at blockdev.c:1755
#8  0x000055f708103e6a in qmp_transaction (dev_list=dev_list@entry=0x7ffc4e7fbfa0, has_props=has_props@entry=false, props=0x7f61d9a304e8, 
    props@entry=0x0, errp=errp@entry=0x7ffc4e7fbfd8) at blockdev.c:2401
#9  0x000055f708105322 in blockdev_do_action (errp=0x7ffc4e7fbfd8, action=0x7ffc4e7fbf90) at blockdev.c:1054
#10 0x000055f708105322 in qmp_drive_backup (backup=backup@entry=0x7ffc4e7fbfe0, errp=errp@entry=0x7ffc4e7fbfd8) at blockdev.c:3129
#11 0x000055f7082c0101 in qmp_marshal_drive_backup (args=<optimized out>, ret=<optimized out>, errp=0x7ffc4e7fc0b8)
    at qapi/qapi-commands-block-core.c:555
#12 0x000055f7083b7338 in qmp_dispatch (cmds=0x55f708904000 <qmp_commands>, request=<optimized out>, allow_oob=<optimized out>)
    at qapi/qmp-dispatch.c:155
#13 0x000055f7082a1bd1 in monitor_qmp_dispatch (mon=0x7f61dcd15d80, req=<optimized out>) at monitor/qmp.c:145
#14 0x000055f7082a23ba in monitor_qmp_bh_dispatcher (data=<optimized out>) at monitor/qmp.c:234
#15 0x000055f708400205 in aio_bh_call (bh=0x7f61dd28f960) at util/async.c:164
#16 0x000055f708400205 in aio_bh_poll (ctx=ctx@entry=0x7f61dd33ef80) at util/async.c:164
#17 0x000055f70840388e in aio_dispatch (ctx=0x7f61dd33ef80) at util/aio-posix.c:380
#18 0x000055f7084000ee in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:298
#19 0x00007f61ec069f2e in g_main_context_dispatch () at /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#20 0x000055f708402af8 in glib_pollfds_poll () at util/main-loop.c:219
#21 0x000055f708402af8 in os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:242
#22 0x000055f708402af8 in main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:518
#23 0x000055f70809e589 in qemu_main_loop () at /home/dietmar/pve5-devel/mirror_qemu/softmmu/vl.c:1665
#24 0x000055f707fa2c3e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at /home/dietmar/pve5-devel/mirror_qemu/softmmu/main.c:49


