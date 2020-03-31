Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF0DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23F5207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23F5207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCYo-0003dr-Qo
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jJCXh-0003ER-HO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jJCXf-0001jI-2a
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:46:41 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:42309)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>) id 1jJCXe-0001Uk-Mx
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:46:39 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DB5CF42E7D;
 Tue, 31 Mar 2020 10:46:27 +0200 (CEST)
Date: Tue, 31 Mar 2020 10:46:22 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Sergio Lopez <slp@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>
Message-ID: <658260883.24.1585644382441@webmail.proxmox.com>
Subject: bdrv_drained_begin deadlock with io-threads
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I can see and reproduce this error with latest code from today. 
But I also see it on stable 4.1.1 (sometimes).

I guess this is a similar problem as reported earlier:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07363.html

To reproduce, you need a VM using virtio-scsi-single drive using io-threads,
the run "stress -d 5" inside the VM (Debian Buster).

Then I start simply drive-backup jobs like:

{ "execute": "drive-backup", "arguments": { "device": "drive-scsi0", "sync": 
"full", "target": "backup-scsi0.raw" } }

abort them after a few seconds, then repeat that.

After a few iteration the VM freeze inside bdrv_drained_begin():

Thread 1 (Thread 0x7fffe9291080 (LWP 30949)):
#0  0x00007ffff5cb3916 in __GI_ppoll (fds=0x7fff63d30c40, nfds=2, timeout=<optimized out>, timeout@entry=0x0, sigmask=sigmask@entry=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x0000555555c60419 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
#2  0x0000555555c60419 in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=-1) at util/qemu-timer.c:335
#3  0x0000555555c62c01 in fdmon_poll_wait (ctx=0x7fffe8905e80, ready_list=0x7fffffffd3a8, timeout=-1) at util/fdmon-poll.c:79
#4  0x0000555555c621e7 in aio_poll (ctx=0x7fffe8905e80, blocking=blocking@entry=true) at util/aio-posix.c:589
#5  0x0000555555bc2565 in bdrv_do_drained_begin (poll=<optimized out>, ignore_bds_parents=false, parent=0x0, recursive=false, bs=0x7fff67240b80) at block/io.c:430
#6  0x0000555555bc2565 in bdrv_do_drained_begin (bs=0x7fff67240b80, recursive=<optimized out>, parent=0x0, ignore_bds_parents=<optimized out>, poll=<optimized out>) at block/io.c:395
#7  0x0000555555bde252 in bdrv_backup_top_drop (bs=0x7fff67240b80) at block/backup-top.c:273
#8  0x0000555555bd995c in backup_clean (job=0x7fffe5609200) at block/backup.c:114
#9  0x0000555555b6e08d in job_clean (job=0x7fffe5609200) at job.c:657
#10 0x0000555555b6e08d in job_finalize_single (job=0x7fffe5609200) at job.c:673
#11 0x0000555555b6e08d in job_finalize_single (job=0x7fffe5609200) at job.c:661
#12 0x0000555555b6ea3a in job_completed_txn_abort (job=<optimized out>) at job.c:749
#13 0x0000555555b6ec42 in job_completed (job=0x7fffe5609200) at job.c:843
#14 0x0000555555b6ec42 in job_completed (job=0x7fffe5609200) at job.c:836
#15 0x0000555555b6edf0 in job_exit (opaque=0x7fffe5609200) at job.c:864
#16 0x0000555555c5e975 in aio_bh_call (bh=0x7fffe721a2d0) at util/async.c:164
#17 0x0000555555c5e975 in aio_bh_poll (ctx=ctx@entry=0x7fffe8905e80) at util/async.c:164
#18 0x0000555555c6202e in aio_dispatch (ctx=0x7fffe8905e80) at util/aio-posix.c:380
#19 0x0000555555c5e85e in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:298
#20 0x00007ffff7c7ef2e in g_main_context_dispatch () at /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#21 0x0000555555c61298 in glib_pollfds_poll () at util/main-loop.c:219
#22 0x0000555555c61298 in os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:242
#23 0x0000555555c61298 in main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:518
#24 0x00005555558fc5a9 in qemu_main_loop () at /home/dietmar/pve5-devel/mirror_qemu/softmmu/vl.c:1665
#25 0x0000555555800c3e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/softmmu/main.c:49

Thread 1 locks the BQL, while thread7 wants to aquire it to complete the read in prepare_mmio_access():

(gdb) source ./scripts/qemu-gdb.py 
(gdb) qemu tcg-lock-status 
Thread, BQL (iothread_mutex), Replay, Blocked?
10/31149, false, false, not blocked
8/30998, false, false, __lll_lock_wait waiting on 0x555556142e60 <qemu_global_mutex> from 30949
7/30997, false, false, __lll_lock_wait waiting on 0x555556142e60 <qemu_global_mutex> from 30949
6/30996, false, false, not blocked
4/30955, false, false, not blocked
3/30954, false, false, __lll_lock_wait waiting on 0x7fffe89151e0 from 30949
2/30953, false, false, not blocked
1/30949, true, false, not blocked


(gdb) thread apply 7 bt
Thread 7 (Thread 0x7fff669ff700 (LWP 30997)):
#0  0x00007ffff5d9729c in __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1  0x00007ffff5d90714 in __GI___pthread_mutex_lock (mutex=mutex@entry=0x555556142e60 <qemu_global_mutex>) at ../nptl/pthread_mutex_lock.c:80
#2  0x0000555555c65013 in qemu_mutex_lock_impl (mutex=0x555556142e60 <qemu_global_mutex>, file=0x555555c94008 "/home/dietmar/pve5-devel/mirror_qemu/exec.c", line=3089) at util/qemu-thread-posix.c:78
#3  0x00005555558480ee in qemu_mutex_lock_iothread_impl (file=file@entry=0x555555c94008 "/home/dietmar/pve5-devel/mirror_qemu/exec.c", line=line@entry=3089)
    at /home/dietmar/pve5-devel/mirror_qemu/cpus.c:1831
#4  0x0000555555802425 in prepare_mmio_access (mr=<optimized out>, mr=<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3089
#5  0x000055555580759f in flatview_read_continue
    (fv=fv@entry=0x7fff5f9baf00, addr=addr@entry=375, attrs=..., ptr=ptr@entry=0x7ffff7fbe000, len=len@entry=1, addr1=<optimized out>, l=<optimized out>, mr=0x7fffe8e66e80)
    at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3188
#6  0x0000555555807803 in flatview_read (fv=0x7fff5f9baf00, addr=375, attrs=..., buf=0x7ffff7fbe000, len=1) at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3229
#7  0x000055555580791b in address_space_read_full (as=<optimized out>, addr=<optimized out>, attrs=..., buf=<optimized out>, len=<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3242
#8  0x0000555555807a25 in address_space_rw (as=<optimized out>, addr=addr@entry=375, attrs=..., attrs@entry=..., buf=<optimized out>, len=len@entry=1, is_write=is_write@entry=false)
    at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3270
#9  0x0000555555865024 in kvm_handle_io (count=1, size=1, direction=<optimized out>, data=<optimized out>, attrs=..., port=375) at /home/dietmar/pve5-devel/mirror_qemu/accel/kvm/kvm-all.c:2140
#10 0x0000555555865024 in kvm_cpu_exec (cpu=cpu@entry=0x7fffe89efb00) at /home/dietmar/pve5-devel/mirror_qemu/accel/kvm/kvm-all.c:2386
#11 0x000055555584835e in qemu_kvm_cpu_thread_fn (arg=0x7fffe89efb00) at /home/dietmar/pve5-devel/mirror_qemu/cpus.c:1246
#12 0x000055555584835e in qemu_kvm_cpu_thread_fn (arg=arg@entry=0x7fffe89efb00) at /home/dietmar/pve5-devel/mirror_qemu/cpus.c:1218
#13 0x0000555555c64e1a in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:519
#14 0x00007ffff5d8dfa3 in start_thread (arg=<optimized out>) at pthread_create.c:486
#15 0x00007ffff5cbe4cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Above code is triggered by a cancelled backup, but it sometimes triggers from drive_backup_prepare(),
for example:

(gdb) bt
#0  0x00007ffff5cb3916 in __GI_ppoll (fds=0x7fff63d30c40, nfds=2, timeout=<optimized out>, timeout@entry=0x0, sigmask=sigmask@entry=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x0000555555c60419 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
#2  0x0000555555c60419 in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=-1) at util/qemu-timer.c:335
#3  0x0000555555c62c01 in fdmon_poll_wait (ctx=0x7fffe8905e80, ready_list=0x7fffffffd188, timeout=-1) at util/fdmon-poll.c:79
#4  0x0000555555c621e7 in aio_poll (ctx=0x7fffe8905e80, blocking=blocking@entry=true) at util/aio-posix.c:589
#5  0x0000555555bc2565 in bdrv_do_drained_begin (poll=<optimized out>, ignore_bds_parents=false, parent=0x0, recursive=false, bs=0x7fffe8954bc0) at block/io.c:430
#6  0x0000555555bc2565 in bdrv_do_drained_begin (bs=0x7fffe8954bc0, recursive=<optimized out>, parent=0x0, ignore_bds_parents=<optimized out>, poll=<optimized out>) at block/io.c:395
#7  0x000055555595f753 in drive_backup_prepare (common=0x7fffe8910780, errp=0x7fffffffd2c8) at blockdev.c:1759
#8  0x0000555555961f0a in qmp_transaction (dev_list=dev_list@entry=0x7fffffffd340, has_props=has_props@entry=false, props=0x7fffe560e200, props@entry=0x0, errp=errp@entry=0x7fffffffd378) at blockdev.c:2406
#9  0x00005555559633c2 in blockdev_do_action (errp=0x7fffffffd378, action=0x7fffffffd330) at blockdev.c:1054
#10 0x00005555559633c2 in qmp_drive_backup (backup=backup@entry=0x7fffffffd380, errp=errp@entry=0x7fffffffd378) at blockdev.c:3134
#11 0x0000555555b1e1d1 in qmp_marshal_drive_backup (args=<optimized out>, ret=<optimized out>, errp=0x7fffffffd458) at qapi/qapi-commands-block-core.c:555
#12 0x0000555555c15aa8 in qmp_dispatch (cmds=0x555556162000 <qmp_commands>, request=<optimized out>, allow_oob=<optimized out>) at qapi/qmp-dispatch.c:155
#13 0x0000555555affca1 in monitor_qmp_dispatch (mon=0x7fffe8915d80, req=<optimized out>) at monitor/qmp.c:145
#14 0x0000555555b0048a in monitor_qmp_bh_dispatcher (data=<optimized out>) at monitor/qmp.c:234
#15 0x0000555555c5e975 in aio_bh_call (bh=0x7fffe8e8f960) at util/async.c:164
#16 0x0000555555c5e975 in aio_bh_poll (ctx=ctx@entry=0x7fffe8f3ef80) at util/async.c:164
#17 0x0000555555c6202e in aio_dispatch (ctx=0x7fffe8f3ef80) at util/aio-posix.c:380
#18 0x0000555555c5e85e in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:298
#19 0x00007ffff7c7ef2e in g_main_context_dispatch () at /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#20 0x0000555555c61298 in glib_pollfds_poll () at util/main-loop.c:219
#21 0x0000555555c61298 in os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:242
#22 0x0000555555c61298 in main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:518
#23 0x00005555558fc5a9 in qemu_main_loop () at /home/dietmar/pve5-devel/mirror_qemu/softmmu/vl.c:1665
#24 0x0000555555800c3e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/softmmu/main.c:49


(gdb) source ./scripts/qemu-gdb.py 
(gdb) qemu tcg-lock-status 
Thread, BQL (iothread_mutex), Replay, Blocked?
10/7233, false, false, not blocked
8/7082, false, false, __lll_lock_wait waiting on 0x555556142e60 <qemu_global_mutex> from 7037
7/7081, false, false, __lll_lock_wait waiting on 0x555556142e60 <qemu_global_mutex> from 7037
6/7080, false, false, not blocked
4/7043, false, false, not blocked
3/7042, false, false, not blocked
2/7041, false, false, not blocked
1/7037, true, false, not blocked

(gdb) thread apply 7 bt

Thread 7 (Thread 0x7fff669ff700 (LWP 7081)):
#0  0x00007ffff5d9729c in __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1  0x00007ffff5d90714 in __GI___pthread_mutex_lock (mutex=mutex@entry=0x555556142e60 <qemu_global_mutex>) at ../nptl/pthread_mutex_lock.c:80
#2  0x0000555555c65013 in qemu_mutex_lock_impl (mutex=0x555556142e60 <qemu_global_mutex>, file=0x555555c94008 "/home/dietmar/pve5-devel/mirror_qemu/exec.c", line=3089) at util/qemu-thread-posix.c:78
#3  0x00005555558480ee in qemu_mutex_lock_iothread_impl (file=file@entry=0x555555c94008 "/home/dietmar/pve5-devel/mirror_qemu/exec.c", line=line@entry=3089)
    at /home/dietmar/pve5-devel/mirror_qemu/cpus.c:1831
#4  0x0000555555802425 in prepare_mmio_access (mr=<optimized out>, mr=<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3089
#5  0x000055555580759f in flatview_read_continue
    (fv=fv@entry=0x7fff5f635f00, addr=addr@entry=375, attrs=..., ptr=ptr@entry=0x7ffff7fbe000, len=len@entry=1, addr1=<optimized out>, l=<optimized out>, mr=0x7fffe8e66e80)
    at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3188
#6  0x0000555555807803 in flatview_read (fv=0x7fff5f635f00, addr=375, attrs=..., buf=0x7ffff7fbe000, len=1) at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3229
#7  0x000055555580791b in address_space_read_full (as=<optimized out>, addr=<optimized out>, attrs=..., buf=<optimized out>, len=<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3242
#8  0x0000555555807a25 in address_space_rw (as=<optimized out>, addr=addr@entry=375, attrs=..., attrs@entry=..., buf=<optimized out>, len=len@entry=1, is_write=is_write@entry=false)
    at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3270
#9  0x0000555555865024 in kvm_handle_io (count=1, size=1, direction=<optimized out>, data=<optimized out>, attrs=..., port=375) at /home/dietmar/pve5-devel/mirror_qemu/accel/kvm/kvm-all.c:2140
#10 0x0000555555865024 in kvm_cpu_exec (cpu=cpu@entry=0x7fffe89efb00) at /home/dietmar/pve5-devel/mirror_qemu/accel/kvm/kvm-all.c:2386
#11 0x000055555584835e in qemu_kvm_cpu_thread_fn (arg=0x7fffe89efb00) at /home/dietmar/pve5-devel/mirror_qemu/cpus.c:1246
#12 0x000055555584835e in qemu_kvm_cpu_thread_fn (arg=arg@entry=0x7fffe89efb00) at /home/dietmar/pve5-devel/mirror_qemu/cpus.c:1218
#13 0x0000555555c64e1a in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:519
#14 0x00007ffff5d8dfa3 in start_thread (arg=<optimized out>) at pthread_create.c:486
#15 0x00007ffff5cbe4cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

So the pattern is:

1.) Main thread has the BQL
2.) Main thread calls bdrv_drained_begin(bs);
3.) CPU thread want to complete read prepare_mmio_access(), but needs BQL
4.) deadlock

Any ideas how to prevent that?


