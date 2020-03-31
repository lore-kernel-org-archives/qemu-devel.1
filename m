Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECF3C2D0F0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D74520658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nafl0684"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D74520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGUJ-0001CP-J1
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJGTM-0000OU-FM
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJGTK-0001pE-I9
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:58:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27689
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJGTK-0001mu-DS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585659501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNGzjXrj2HApM9rG91lfcNm5wp+BF7zzXZJimh64gN0=;
 b=Nafl0684TWCXfjr5mSm6/KHkLjQtf88LYlJZqWspGuedqTWMNJG9D4abcayPprm76mso0z
 lY9ox4cM8KbjwN2Yue7e/6zQTs04HRLCTTfIFut6EG18Aa3B2AI0nYNvQRNt7vB7PgEBwo
 bJ0wcyoKwLBPaIVQwZj3kvuP3KxkSYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-cIixZX3CNU2NXVTtHN_mnw-1; Tue, 31 Mar 2020 08:58:14 -0400
X-MC-Unique: cIixZX3CNU2NXVTtHN_mnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 557A6800D6C;
 Tue, 31 Mar 2020 12:58:13 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3565C98A3C;
 Tue, 31 Mar 2020 12:58:06 +0000 (UTC)
Date: Tue, 31 Mar 2020 14:58:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200331125804.GE7030@linux.fritz.box>
References: <658260883.24.1585644382441@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <658260883.24.1585644382441@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[ CC qemu-block ]

Am 31.03.2020 um 10:46 hat Dietmar Maurer geschrieben:
> I can see and reproduce this error with latest code from today.=20
> But I also see it on stable 4.1.1 (sometimes).
>=20
> I guess this is a similar problem as reported earlier:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07363.html
>=20
> To reproduce, you need a VM using virtio-scsi-single drive using io-threa=
ds,
> the run "stress -d 5" inside the VM (Debian Buster).
>=20
> Then I start simply drive-backup jobs like:
>=20
> { "execute": "drive-backup", "arguments": { "device": "drive-scsi0", "syn=
c":=20
> "full", "target": "backup-scsi0.raw" } }
>=20
> abort them after a few seconds, then repeat that.
>=20
> After a few iteration the VM freeze inside bdrv_drained_begin():
>=20
> Thread 1 (Thread 0x7fffe9291080 (LWP 30949)):
> #0  0x00007ffff5cb3916 in __GI_ppoll (fds=3D0x7fff63d30c40, nfds=3D2, tim=
eout=3D<optimized out>, timeout@entry=3D0x0, sigmask=3Dsigmask@entry=3D0x0)=
 at ../sysdeps/unix/sysv/linux/ppoll.c:39
> #1  0x0000555555c60419 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<o=
ptimized out>, __fds=3D<optimized out>) at /usr/include/x86_64-linux-gnu/bi=
ts/poll2.h:77
> #2  0x0000555555c60419 in qemu_poll_ns (fds=3D<optimized out>, nfds=3D<op=
timized out>, timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.c:335
> #3  0x0000555555c62c01 in fdmon_poll_wait (ctx=3D0x7fffe8905e80, ready_li=
st=3D0x7fffffffd3a8, timeout=3D-1) at util/fdmon-poll.c:79
> #4  0x0000555555c621e7 in aio_poll (ctx=3D0x7fffe8905e80, blocking=3Dbloc=
king@entry=3Dtrue) at util/aio-posix.c:589
> #5  0x0000555555bc2565 in bdrv_do_drained_begin (poll=3D<optimized out>, =
ignore_bds_parents=3Dfalse, parent=3D0x0, recursive=3Dfalse, bs=3D0x7fff672=
40b80) at block/io.c:430
> #6  0x0000555555bc2565 in bdrv_do_drained_begin (bs=3D0x7fff67240b80, rec=
ursive=3D<optimized out>, parent=3D0x0, ignore_bds_parents=3D<optimized out=
>, poll=3D<optimized out>) at block/io.c:395
> #7  0x0000555555bde252 in bdrv_backup_top_drop (bs=3D0x7fff67240b80) at b=
lock/backup-top.c:273
> #8  0x0000555555bd995c in backup_clean (job=3D0x7fffe5609200) at block/ba=
ckup.c:114
> #9  0x0000555555b6e08d in job_clean (job=3D0x7fffe5609200) at job.c:657
> #10 0x0000555555b6e08d in job_finalize_single (job=3D0x7fffe5609200) at j=
ob.c:673
> #11 0x0000555555b6e08d in job_finalize_single (job=3D0x7fffe5609200) at j=
ob.c:661
> #12 0x0000555555b6ea3a in job_completed_txn_abort (job=3D<optimized out>)=
 at job.c:749
> #13 0x0000555555b6ec42 in job_completed (job=3D0x7fffe5609200) at job.c:8=
43
> #14 0x0000555555b6ec42 in job_completed (job=3D0x7fffe5609200) at job.c:8=
36
> #15 0x0000555555b6edf0 in job_exit (opaque=3D0x7fffe5609200) at job.c:864
> #16 0x0000555555c5e975 in aio_bh_call (bh=3D0x7fffe721a2d0) at util/async=
.c:164
> #17 0x0000555555c5e975 in aio_bh_poll (ctx=3Dctx@entry=3D0x7fffe8905e80) =
at util/async.c:164
> #18 0x0000555555c6202e in aio_dispatch (ctx=3D0x7fffe8905e80) at util/aio=
-posix.c:380
> #19 0x0000555555c5e85e in aio_ctx_dispatch (source=3D<optimized out>, cal=
lback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:298
> #20 0x00007ffff7c7ef2e in g_main_context_dispatch () at /usr/lib/x86_64-l=
inux-gnu/libglib-2.0.so.0
> #21 0x0000555555c61298 in glib_pollfds_poll () at util/main-loop.c:219
> #22 0x0000555555c61298 in os_host_main_loop_wait (timeout=3D<optimized ou=
t>) at util/main-loop.c:242
> #23 0x0000555555c61298 in main_loop_wait (nonblocking=3Dnonblocking@entry=
=3D0) at util/main-loop.c:518
> #24 0x00005555558fc5a9 in qemu_main_loop () at /home/dietmar/pve5-devel/m=
irror_qemu/softmmu/vl.c:1665
> #25 0x0000555555800c3e in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/soft=
mmu/main.c:49

The thing that we need to figure out is probably what operation we are
(or were) waiting for and why it doesn't complete.

A typical cause of a hang like this is that the operation we're waiting
for actually did already complete in a different thread, but forgot to
call aio_wait_kick().

To confirm, if you have gdb attached to a hanging process, you could
manually call bdrv_drain_poll_top_level(bs, 0, 0) and check its result.
If it returns false, then a kick is missing somewhere. If it returns
true, some request is still waiting for completion somewhere and can be
inspected in gdb.

> Thread 1 locks the BQL, while thread7 wants to aquire it to complete the =
read in prepare_mmio_access():
>=20
> (gdb) source ./scripts/qemu-gdb.py=20
> (gdb) qemu tcg-lock-status=20
> Thread, BQL (iothread_mutex), Replay, Blocked?
> 10/31149, false, false, not blocked
> 8/30998, false, false, __lll_lock_wait waiting on 0x555556142e60 <qemu_gl=
obal_mutex> from 30949
> 7/30997, false, false, __lll_lock_wait waiting on 0x555556142e60 <qemu_gl=
obal_mutex> from 30949
> 6/30996, false, false, not blocked
> 4/30955, false, false, not blocked
> 3/30954, false, false, __lll_lock_wait waiting on 0x7fffe89151e0 from 309=
49
> 2/30953, false, false, not blocked
> 1/30949, true, false, not blocked
>=20
>=20
> (gdb) thread apply 7 bt
> Thread 7 (Thread 0x7fff669ff700 (LWP 30997)):
> #0  0x00007ffff5d9729c in __lll_lock_wait () at ../sysdeps/unix/sysv/linu=
x/x86_64/lowlevellock.S:103
> #1  0x00007ffff5d90714 in __GI___pthread_mutex_lock (mutex=3Dmutex@entry=
=3D0x555556142e60 <qemu_global_mutex>) at ../nptl/pthread_mutex_lock.c:80
> #2  0x0000555555c65013 in qemu_mutex_lock_impl (mutex=3D0x555556142e60 <q=
emu_global_mutex>, file=3D0x555555c94008 "/home/dietmar/pve5-devel/mirror_q=
emu/exec.c", line=3D3089) at util/qemu-thread-posix.c:78
> #3  0x00005555558480ee in qemu_mutex_lock_iothread_impl (file=3Dfile@entr=
y=3D0x555555c94008 "/home/dietmar/pve5-devel/mirror_qemu/exec.c", line=3Dli=
ne@entry=3D3089)
>     at /home/dietmar/pve5-devel/mirror_qemu/cpus.c:1831
> #4  0x0000555555802425 in prepare_mmio_access (mr=3D<optimized out>, mr=
=3D<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3089
> #5  0x000055555580759f in flatview_read_continue
>     (fv=3Dfv@entry=3D0x7fff5f9baf00, addr=3Daddr@entry=3D375, attrs=3D...=
, ptr=3Dptr@entry=3D0x7ffff7fbe000, len=3Dlen@entry=3D1, addr1=3D<optimized=
 out>, l=3D<optimized out>, mr=3D0x7fffe8e66e80)
>     at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3188
> #6  0x0000555555807803 in flatview_read (fv=3D0x7fff5f9baf00, addr=3D375,=
 attrs=3D..., buf=3D0x7ffff7fbe000, len=3D1) at /home/dietmar/pve5-devel/mi=
rror_qemu/exec.c:3229
> #7  0x000055555580791b in address_space_read_full (as=3D<optimized out>, =
addr=3D<optimized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimize=
d out>) at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3242
> #8  0x0000555555807a25 in address_space_rw (as=3D<optimized out>, addr=3D=
addr@entry=3D375, attrs=3D..., attrs@entry=3D..., buf=3D<optimized out>, le=
n=3Dlen@entry=3D1, is_write=3Dis_write@entry=3Dfalse)
>     at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3270
> #9  0x0000555555865024 in kvm_handle_io (count=3D1, size=3D1, direction=
=3D<optimized out>, data=3D<optimized out>, attrs=3D..., port=3D375) at /ho=
me/dietmar/pve5-devel/mirror_qemu/accel/kvm/kvm-all.c:2140
> #10 0x0000555555865024 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x7fffe89efb00)=
 at /home/dietmar/pve5-devel/mirror_qemu/accel/kvm/kvm-all.c:2386
> #11 0x000055555584835e in qemu_kvm_cpu_thread_fn (arg=3D0x7fffe89efb00) a=
t /home/dietmar/pve5-devel/mirror_qemu/cpus.c:1246
> #12 0x000055555584835e in qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0x7ff=
fe89efb00) at /home/dietmar/pve5-devel/mirror_qemu/cpus.c:1218
> #13 0x0000555555c64e1a in qemu_thread_start (args=3D<optimized out>) at u=
til/qemu-thread-posix.c:519
> #14 0x00007ffff5d8dfa3 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:486
> #15 0x00007ffff5cbe4cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95
> [...]

> So the pattern is:
>=20
> 1.) Main thread has the BQL
> 2.) Main thread calls bdrv_drained_begin(bs);
> 3.) CPU thread want to complete read prepare_mmio_access(), but needs BQL
> 4.) deadlock
>=20
> Any ideas how to prevent that?

What's going on in the vcpu thread (thread 7) is probably not part of
the problem. It does have to wait for the main thread, but it would only
really be part of the deadlock if the main thread would also wait for
the vcpu thread, which I don't think it does.

Kevin


