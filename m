Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3421FC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA562076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA562076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH4PV-0007j6-Vt
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <s.reiter@proxmox.com>) id 1jH4OW-0007F7-J9
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <s.reiter@proxmox.com>) id 1jH4OU-0005hP-4j
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:40:24 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:56845)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <s.reiter@proxmox.com>)
 id 1jH4OT-0005dS-P5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:40:22 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CF83A42E64;
 Wed, 25 Mar 2020 12:40:16 +0100 (CET)
Subject: Re: backup transaction with io-thread core dumps
References: <2007060575.48.1585048408879@webmail.proxmox.com>
 <1512602350.59.1585056617632@webmail.proxmox.com>
 <1806708761.60.1585056799652@webmail.proxmox.com>
 <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
 <1187924316.77.1585068555273@webmail.proxmox.com>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <e1a10c51-cf7f-0724-f61a-f6a82ebd9da2@proxmox.com>
Date: Wed, 25 Mar 2020 12:40:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1187924316.77.1585068555273@webmail.proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: vsementsov@virtuozzo.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/03/2020 17:49, Dietmar Maurer wrote:
> A more serious issue is that I also get a hang inside the poll loop
> when the VM is under load. For example, running "stress -d 5" inside
> the VM (Debian Buster).
>=20
> Then running a simply drive-backup like:
>=20
> { "execute": "drive-backup", "arguments": { "device": "drive-scsi0", "s=
ync": "full", "target": "backup-scsi0.raw" } }
>=20
> At the end of the backup, VM hangs, gdb says:
>=20
> (gdb) bt
> #0  0x00007ffff5cb3916 in __GI_ppoll (fds=3D0x7fff63d35c40, nfds=3D2, t=
imeout=3D<optimized out>,
>      timeout@entry=3D0x0, sigmask=3Dsigmask@entry=3D0x0) at ../sysdeps/=
unix/sysv/linux/ppoll.c:39
> #1  0x0000555555c5f2c9 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D=
<optimized out>, __fds=3D<optimized out>)
>      at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
> #2  0x0000555555c5f2c9 in qemu_poll_ns (fds=3D<optimized out>, nfds=3D<=
optimized out>, timeout=3Dtimeout@entry=3D-1)
>      at util/qemu-timer.c:335
> #3  0x0000555555c61ab1 in fdmon_poll_wait (ctx=3D0x7fffe8905e80, ready_=
list=3D0x7fffffffdc68, timeout=3D-1)
>      at util/fdmon-poll.c:79
> #4  0x0000555555c61097 in aio_poll (ctx=3D0x7fffe8905e80, blocking=3Dbl=
ocking@entry=3Dtrue) at util/aio-posix.c:589
> #5  0x0000555555bc2243 in bdrv_do_drained_begin
>      (poll=3D<optimized out>, ignore_bds_parents=3Dfalse, parent=3D0x0,=
 recursive=3Dfalse, bs=3D0x7fff671c11c0) at block/io.c:429
> #6  0x0000555555bc2243 in bdrv_do_drained_begin
>      (bs=3D0x7fff671c11c0, recursive=3D<optimized out>, parent=3D0x0, i=
gnore_bds_parents=3D<optimized out>, poll=3D<optimized out>)
>      at block/io.c:395
> #7  0x0000555555bdd132 in bdrv_backup_top_drop (bs=3D0x7fff671c11c0) at=
 block/backup-top.c:273
> #8  0x0000555555bd883c in backup_clean (job=3D0x7fffe5609a00) at block/=
backup.c:114
> #9  0x0000555555b6d46d in job_clean (job=3D0x7fffe5609a00) at job.c:657
> #10 0x0000555555b6d46d in job_finalize_single (job=3D0x7fffe5609a00) at=
 job.c:673
> #11 0x0000555555b6d46d in job_finalize_single (job=3D0x7fffe5609a00) at=
 job.c:661
> #12 0x0000555555b6dedc in job_txn_apply (txn=3D<optimized out>, fn=3D0x=
555555b6d420 <job_finalize_single>) at job.c:145
> #13 0x0000555555b6dedc in job_do_finalize (job=3D0x7fffe5609a00) at job=
.c:782
> #14 0x0000555555b6e131 in job_completed_txn_success (job=3D0x7fffe5609a=
00) at job.c:832
> #15 0x0000555555b6e131 in job_completed (job=3D0x7fffe5609a00) at job.c=
:845
> #16 0x0000555555b6e131 in job_completed (job=3D0x7fffe5609a00) at job.c=
:836
> #17 0x0000555555b6e190 in job_exit (opaque=3D0x7fffe5609a00) at job.c:8=
64
> #18 0x0000555555c5d855 in aio_bh_call (bh=3D0x7fffe721a3c0) at util/asy=
nc.c:164
> #19 0x0000555555c5d855 in aio_bh_poll (ctx=3Dctx@entry=3D0x7fffe8905e80=
) at util/async.c:164
> #20 0x0000555555c60ede in aio_dispatch (ctx=3D0x7fffe8905e80) at util/a=
io-posix.c:380
> #21 0x0000555555c5d73e in aio_ctx_dispatch (source=3D<optimized out>, c=
allback=3D<optimized out>, user_data=3D<optimized out>)
>      at util/async.c:298
> #22 0x00007ffff7c7ef2e in g_main_context_dispatch () at /usr/lib/x86_64=
-linux-gnu/libglib-2.0.so.0
> #23 0x0000555555c60148 in glib_pollfds_poll () at util/main-loop.c:219
> #24 0x0000555555c60148 in os_host_main_loop_wait (timeout=3D<optimized =
out>) at util/main-loop.c:242
> #25 0x0000555555c60148 in main_loop_wait (nonblocking=3Dnonblocking@ent=
ry=3D0) at util/main-loop.c:518
> #26 0x00005555558fc579 in qemu_main_loop () at /home/dietmar/pve5-devel=
/mirror_qemu/softmmu/vl.c:1665
> #27 0x0000555555800c2e in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>)
>      at /home/dietmar/pve5-devel/mirror_qemu/softmmu/main.c:49
>=20
> The VM uses a similar hardware setup with io-threads as the previous
> example.
>=20
> Is somebody able to reproduce that? And ideas whats wrong here?
>=20

Can't speak for the original issue, but this one I can reproduce exactly=20
as you say: main thread hangs at the end of a backup job of a drive that=20
uses IO threads, when said drive is under load. Single disk, raw-file=20
backed.

I've bisected the issue to commit 00e30f05de1d ("block/backup: use=20
backup-top instead of write notifiers") - CC'ing Vladimir, since he=20
wrote that one. Before that patch, backup works fine.


For completeness, here's the trace I get on my machine (latest master)=20
when everything's stuck, Thread 1 is the main thread, 3 the IO thread=20
for the drive:

Thread 1 (Thread 0x7ffff5d20680 (LWP 958009)):
#0    0x00007ffff6cf2916 in __GI_ppoll (fds=3D0x7ffff4a0c2c0, nfds=3D0x2,=
=20
timeout=3D<optimized out>, sigmask=3D0x0) at=20
../sysdeps/unix/sysv/linux/ppoll.c:39
#1    0x0000555555dba2dd in qemu_poll_ns (fds=3D0x7ffff4a0c2c0, nfds=3D0x=
2,=20
timeout=3D0xffffffffffffffff) at util/qemu-timer.c:335
#2    0x0000555555dbdb1d in fdmon_poll_wait (ctx=3D0x7ffff49e3380,=20
ready_list=3D0x7fffffffdab0, timeout=3D0xffffffffffffffff) at=20
util/fdmon-poll.c:79
#3    0x0000555555dbd48d in aio_poll (ctx=3D0x7ffff49e3380, blocking=3D0x=
1)=20
at util/aio-posix.c:589
#4    0x0000555555cf5a83 in bdrv_do_drained_begin (bs=3D0x7fffd1577180,=20
recursive=3D0x0, parent=3D0x0, ignore_bds_parents=3D0x0, poll=3D0x1) at=20
block/io.c:429
#5    0x0000555555cf5aef in bdrv_drained_begin (bs=3D0x7fffd1577180) at=20
block/io.c:435
#6    0x0000555555d1b135 in bdrv_backup_top_drop (bs=3D0x7fffd1577180) at=
=20
block/backup-top.c:273
#7    0x0000555555d14734 in backup_clean (job=3D0x7ffff49fba00) at=20
block/backup.c:132
#8    0x0000555555c81be5 in job_clean (job=3D0x7ffff49fba00) at job.c:656
#9    0x0000555555c81c60 in job_finalize_single (job=3D0x7ffff49fba00) at=
=20
job.c:672
#10   0x0000555555c80830 in job_txn_apply (txn=3D0x7fffd1576a80,=20
fn=3D0x555555c81be8 <job_finalize_single>) at job.c:145
#11   0x0000555555c82017 in job_do_finalize (job=3D0x7ffff49fba00) at=20
job.c:781
#12   0x0000555555c821b4 in job_completed_txn_success=20
(job=3D0x7ffff49fba00) at job.c:831
#13   0x0000555555c82254 in job_completed (job=3D0x7ffff49fba00) at job.c=
:844
#14   0x0000555555c822a3 in job_exit (opaque=3D0x7ffff49fba00) at job.c:8=
63
#15   0x0000555555db78a0 in aio_bh_call (bh=3D0x7ffff3c0d240) at=20
util/async.c:136
#16   0x0000555555db79aa in aio_bh_poll (ctx=3D0x7ffff49e3380) at=20
util/async.c:164
#17   0x0000555555dbcdae in aio_dispatch (ctx=3D0x7ffff49e3380) at=20
util/aio-posix.c:380
#18   0x0000555555db7dbc in aio_ctx_dispatch (source=3D0x7ffff49e3380,=20
callback=3D0x0, user_data=3D0x0) at util/async.c:298
#19   0x00007ffff7c8ff2e in g_main_context_dispatch + 0x2ae () at=20
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#20   0x0000555555dbb360 in glib_pollfds_poll () at util/main-loop.c:219
#21   0x0000555555dbb3da in os_host_main_loop_wait (timeout=3D0x3b9aca00)=
=20
at util/main-loop.c:242
#22   0x0000555555dbb4df in main_loop_wait (nonblocking=3D0x0) at=20
util/main-loop.c:518
#23   0x0000555555947478 in qemu_main_loop () at=20
/root/qemu/softmmu/vl.c:1665
#24   0x0000555555d58ddf in main (argc=3D0x15, argv=3D0x7fffffffe058,=20
envp=3D0x7fffffffe108) at /root/qemu/softmmu/main.c:49

Thread 3 (Thread 0x7ffff497e700 (LWP 958039)):
#0    0x00007ffff6dd629c in __lll_lock_wait + 0x1c () at=20
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1    0x00007ffff6dcf7d1 in __GI___pthread_mutex_lock=20
(mutex=3D0x7ffff49e36e0) at ../nptl/pthread_mutex_lock.c:115
#2    0x0000555555dc0ad7 in qemu_mutex_lock_impl (mutex=3D0x7ffff49e36e0,=
=20
file=3D0x555555f66501 "util/async.c", line=3D0x254) at=20
util/qemu-thread-posix.c:78
#3    0x0000555555db872e in aio_context_acquire (ctx=3D0x7ffff49e3680) at=
=20
util/async.c:596
#4    0x0000555555db905e in thread_pool_completion_bh=20
(opaque=3D0x7ffff3c0c000) at util/thread-pool.c:167
#5    0x0000555555db78a0 in aio_bh_call (bh=3D0x7ffff49d7f20) at=20
util/async.c:136
#6    0x0000555555db79aa in aio_bh_poll (ctx=3D0x7ffff49e3680) at=20
util/async.c:164
#7    0x0000555555dbd673 in aio_poll (ctx=3D0x7ffff49e3680, blocking=3D0x=
1)=20
at util/aio-posix.c:638
#8    0x00005555559d7611 in iothread_run (opaque=3D0x7ffff49b1c80) at=20
iothread.c:75
#9    0x0000555555dc1650 in qemu_thread_start (args=3D0x7ffff58ea480) at=20
util/qemu-thread-posix.c:519
#10   0x00007ffff6dccfa3 in start_thread (arg=3D<optimized out>) at=20
pthread_create.c:486
#11   0x00007ffff6cfd4cf in clone + 0x3f () at=20
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

>> On March 24, 2020 2:47 PM Max Reitz <mreitz@redhat.com> wrote:
>>
>>  =20
>> Hi Dietmar,
>>
>> I assume this is with master and has popped up only recently?
>>
>> Maybe it has something to do with the recent mutex patches by Stefan, =
so
>> I=E2=80=99m Cc-ing him.
>>
>> Max
>>
>> On 24.03.20 14:33, Dietmar Maurer wrote:
>>> spoke too soon - the error is still there, sigh
>>>  =20
>>>> This is fixed with this patch:
>>>>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07249.html
>>>>
>>>> thanks!
>>>>
>>>>> On March 24, 2020 12:13 PM Dietmar Maurer <dietmar@proxmox.com> wro=
te:
>>>>>
>>>>>  =20
>>>>> I get a core dump with backup transactions when using io-threads.
>>>>>
>>>>> To reproduce, create and start a VM with:
>>>>>
>>>>> # qemu-img create disk1.raw 100M
>>>>> # qemu-img create disk2.raw 100M
>>>>> #./x86_64-softmmu/qemu-system-x86_64 -chardev 'socket,id=3Dqmp,path=
=3D/var/run/qemu-test.qmp,server,nowait' -mon 'chardev=3Dqmp,mode=3Dcontr=
ol' -pidfile /var/run/qemu-server/108.pid  -m 512 -object 'iothread,id=3D=
iothread-virtioscsi0' -object 'iothread,id=3Diothread-virtioscsi1'  -devi=
ce 'virtio-scsi-pci,id=3Dvirtioscsi0,iothread=3Diothread-virtioscsi0' -dr=
ive 'file=3Ddisk1.raw,if=3Dnone,id=3Ddrive-scsi0,format=3Draw,cache=3Dnon=
e,aio=3Dnative,detect-zeroes=3Don' -device 'scsi-hd,bus=3Dvirtioscsi0.0,c=
hannel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0,id=3Dscsi0' -device 'v=
irtio-scsi-pci,id=3Dvirtioscsi1,iothread=3Diothread-virtioscsi1' -drive '=
file=3Ddisk2.raw,if=3Dnone,id=3Ddrive-scsi1,format=3Draw,cache=3Dnone,aio=
=3Dnative,detect-zeroes=3Don' -device 'scsi-hd,bus=3Dvirtioscsi1.0,channe=
l=3D0,scsi-id=3D0,lun=3D1,drive=3Ddrive-scsi1,id=3Dscsi1'
>>>>>
>>>>> Then open socat to the qmp socket
>>>>> # socat /var/run/qemu-test.qmp -
>>>>>
>>>>> And run the following qmp command:
>>>>>
>>>>> { "execute": "qmp_capabilities", "arguments": {} }
>>>>> { "execute": "transaction", "arguments":  { "actions": [{ "type": "=
drive-backup", "data": { "device": "drive-scsi0", "sync": "full", "target=
": "backup-sysi0.raw" }}, { "type": "drive-backup", "data": { "device": "=
drive-scsi1", "sync": "full", "target": "backup-scsi1.raw" }}], "properti=
es": { "completion-mode": "grouped" } } }
>>>>>
>>>>> The VM will core dump:
>>>>>
>>>>> qemu: qemu_mutex_unlock_impl: Operation not permitted
>>>>> Aborted (core dumped)
>>>>> (gdb) bt
>>>>> #0  0x00007f099d5037bb in __GI_raise (sig=3Dsig@entry=3D6) at ../sy=
sdeps/unix/sysv/linux/raise.c:50
>>>>> #1  0x00007f099d4ee535 in __GI_abort () at abort.c:79
>>>>> #2  0x000055c04e39525e in error_exit (err=3D<optimized out>, msg=3D=
msg@entry=3D0x55c04e5122e0 <__func__.16544> "qemu_mutex_unlock_impl") at =
util/qemu-thread-posix.c:36
>>>>> #3  0x000055c04e395813 in qemu_mutex_unlock_impl (mutex=3Dmutex@ent=
ry=3D0x7f09903154e0, file=3Dfile@entry=3D0x55c04e51129f "util/async.c", l=
ine=3Dline@entry=3D601)
>>>>>      at util/qemu-thread-posix.c:108
>>>>> #4  0x000055c04e38f8e5 in aio_context_release (ctx=3Dctx@entry=3D0x=
7f0990315480) at util/async.c:601
>>>>> #5  0x000055c04e299073 in bdrv_set_aio_context_ignore (bs=3D0x7f092=
9a76500, new_context=3Dnew_context@entry=3D0x7f0990315000, ignore=3Dignor=
e@entry=3D0x7ffe08fa7400)
>>>>>      at block.c:6238
>>>>> #6  0x000055c04e2990cc in bdrv_set_aio_context_ignore (bs=3Dbs@entr=
y=3D0x7f092af47900, new_context=3Dnew_context@entry=3D0x7f0990315000, ign=
ore=3Dignore@entry=3D0x7ffe08fa7400)
>>>>>      at block.c:6211
>>>>> #7  0x000055c04e299443 in bdrv_child_try_set_aio_context (bs=3Dbs@e=
ntry=3D0x7f092af47900, ctx=3D0x7f0990315000, ignore_child=3Dignore_child@=
entry=3D0x0, errp=3Derrp@entry=3D0x0)
>>>>>      at block.c:6324
>>>>> #8  0x000055c04e299576 in bdrv_try_set_aio_context (errp=3D0x0, ctx=
=3D<optimized out>, bs=3D0x7f092af47900) at block.c:6333
>>>>> #9  0x000055c04e299576 in bdrv_replace_child (child=3Dchild@entry=3D=
0x7f09902ef5e0, new_bs=3Dnew_bs@entry=3D0x0) at block.c:2551
>>>>> #10 0x000055c04e2995ff in bdrv_detach_child (child=3D0x7f09902ef5e0=
) at block.c:2666
>>>>> #11 0x000055c04e299ec9 in bdrv_root_unref_child (child=3D<optimized=
 out>) at block.c:2677
>>>>> #12 0x000055c04e29f3fe in block_job_remove_all_bdrv (job=3Djob@entr=
y=3D0x7f0927c18800) at blockjob.c:191
>>>>> #13 0x000055c04e29f429 in block_job_free (job=3D0x7f0927c18800) at =
blockjob.c:88
>>>>> #14 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c=
:359
>>>>> #15 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c=
:351
>>>>> #16 0x000055c04e2a0b68 in job_conclude (job=3D0x7f0927c18800) at jo=
b.c:620
>>>>> #17 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800=
) at job.c:688
>>>>> #18 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800=
) at job.c:660
>>>>> #19 0x000055c04e2a14fc in job_txn_apply (txn=3D<optimized out>, fn=3D=
0x55c04e2a0a50 <job_finalize_single>) at job.c:145
>>>>> #20 0x000055c04e2a14fc in job_do_finalize (job=3D0x7f0927c1c200) at=
 job.c:781
>>>>> #21 0x000055c04e2a1751 in job_completed_txn_success (job=3D0x7f0927=
c1c200) at job.c:831
>>>>> #22 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at j=
ob.c:844
>>>>> #23 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at j=
ob.c:835
>>>>> #24 0x000055c04e2a17b0 in job_exit (opaque=3D0x7f0927c1c200) at job=
.c:863
>>>>> #25 0x000055c04e38ee75 in aio_bh_call (bh=3D0x7f098ec52000) at util=
/async.c:164
>>>>> #26 0x000055c04e38ee75 in aio_bh_poll (ctx=3Dctx@entry=3D0x7f099031=
5000) at util/async.c:164
>>>>> #27 0x000055c04e3924fe in aio_dispatch (ctx=3D0x7f0990315000) at ut=
il/aio-posix.c:380
>>>>> #28 0x000055c04e38ed5e in aio_ctx_dispatch (source=3D<optimized out=
>, callback=3D<optimized out>, user_data=3D<optimized out>) at util/async=
.c:298
>>>>> #29 0x00007f099f020f2e in g_main_context_dispatch () at /usr/lib/x8=
6_64-linux-gnu/libglib-2.0.so.0
>>>>> #30 0x000055c04e391768 in glib_pollfds_poll () at util/main-loop.c:=
219
>>>>> #31 0x000055c04e391768 in os_host_main_loop_wait (timeout=3D<optimi=
zed out>) at util/main-loop.c:242
>>>>> #32 0x000055c04e391768 in main_loop_wait (nonblocking=3Dnonblocking=
@entry=3D0) at util/main-loop.c:518
>>>>> #33 0x000055c04e032329 in qemu_main_loop () at /home/dietmar/pve5-d=
evel/mirror_qemu/softmmu/vl.c:1665
>>>>> #34 0x000055c04df36a8e in main (argc=3D<optimized out>, argv=3D<opt=
imized out>, envp=3D<optimized out>) at /home/dietmar/pve5-devel/mirror_q=
emu/softmmu/main.c:49


