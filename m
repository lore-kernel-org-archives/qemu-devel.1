Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07904C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CF320775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CF320775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGmkZ-00044j-Ry
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 12:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jGmjz-0003fc-97
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jGmjx-00008w-5n
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:49:23 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:28142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>) id 1jGmjw-00008T-RE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:49:21 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5471B40B89;
 Tue, 24 Mar 2020 17:49:18 +0100 (CET)
Date: Tue, 24 Mar 2020 17:49:15 +0100 (CET)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Max Reitz <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1187924316.77.1585068555273@webmail.proxmox.com>
In-Reply-To: <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
References: <2007060575.48.1585048408879@webmail.proxmox.com>
 <1512602350.59.1585056617632@webmail.proxmox.com>
 <1806708761.60.1585056799652@webmail.proxmox.com>
 <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
Subject: Re: backup transaction with io-thread core dumps
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A more serious issue is that I also get a hang inside the poll loop
when the VM is under load. For example, running "stress -d 5" inside
the VM (Debian Buster).

Then running a simply drive-backup like:

{ "execute": "drive-backup", "arguments": { "device": "drive-scsi0", "sync"=
: "full", "target": "backup-scsi0.raw" } }

At the end of the backup, VM hangs, gdb says:

(gdb) bt
#0  0x00007ffff5cb3916 in __GI_ppoll (fds=3D0x7fff63d35c40, nfds=3D2, timeo=
ut=3D<optimized out>,=20
    timeout@entry=3D0x0, sigmask=3Dsigmask@entry=3D0x0) at ../sysdeps/unix/=
sysv/linux/ppoll.c:39
#1  0x0000555555c5f2c9 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<opt=
imized out>, __fds=3D<optimized out>)
    at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
#2  0x0000555555c5f2c9 in qemu_poll_ns (fds=3D<optimized out>, nfds=3D<opti=
mized out>, timeout=3Dtimeout@entry=3D-1)
    at util/qemu-timer.c:335
#3  0x0000555555c61ab1 in fdmon_poll_wait (ctx=3D0x7fffe8905e80, ready_list=
=3D0x7fffffffdc68, timeout=3D-1)
    at util/fdmon-poll.c:79
#4  0x0000555555c61097 in aio_poll (ctx=3D0x7fffe8905e80, blocking=3Dblocki=
ng@entry=3Dtrue) at util/aio-posix.c:589
#5  0x0000555555bc2243 in bdrv_do_drained_begin
    (poll=3D<optimized out>, ignore_bds_parents=3Dfalse, parent=3D0x0, recu=
rsive=3Dfalse, bs=3D0x7fff671c11c0) at block/io.c:429
#6  0x0000555555bc2243 in bdrv_do_drained_begin
    (bs=3D0x7fff671c11c0, recursive=3D<optimized out>, parent=3D0x0, ignore=
_bds_parents=3D<optimized out>, poll=3D<optimized out>)
    at block/io.c:395
#7  0x0000555555bdd132 in bdrv_backup_top_drop (bs=3D0x7fff671c11c0) at blo=
ck/backup-top.c:273
#8  0x0000555555bd883c in backup_clean (job=3D0x7fffe5609a00) at block/back=
up.c:114
#9  0x0000555555b6d46d in job_clean (job=3D0x7fffe5609a00) at job.c:657
#10 0x0000555555b6d46d in job_finalize_single (job=3D0x7fffe5609a00) at job=
.c:673
#11 0x0000555555b6d46d in job_finalize_single (job=3D0x7fffe5609a00) at job=
.c:661
#12 0x0000555555b6dedc in job_txn_apply (txn=3D<optimized out>, fn=3D0x5555=
55b6d420 <job_finalize_single>) at job.c:145
#13 0x0000555555b6dedc in job_do_finalize (job=3D0x7fffe5609a00) at job.c:7=
82
#14 0x0000555555b6e131 in job_completed_txn_success (job=3D0x7fffe5609a00) =
at job.c:832
#15 0x0000555555b6e131 in job_completed (job=3D0x7fffe5609a00) at job.c:845
#16 0x0000555555b6e131 in job_completed (job=3D0x7fffe5609a00) at job.c:836
#17 0x0000555555b6e190 in job_exit (opaque=3D0x7fffe5609a00) at job.c:864
#18 0x0000555555c5d855 in aio_bh_call (bh=3D0x7fffe721a3c0) at util/async.c=
:164
#19 0x0000555555c5d855 in aio_bh_poll (ctx=3Dctx@entry=3D0x7fffe8905e80) at=
 util/async.c:164
#20 0x0000555555c60ede in aio_dispatch (ctx=3D0x7fffe8905e80) at util/aio-p=
osix.c:380
#21 0x0000555555c5d73e in aio_ctx_dispatch (source=3D<optimized out>, callb=
ack=3D<optimized out>, user_data=3D<optimized out>)
    at util/async.c:298
#22 0x00007ffff7c7ef2e in g_main_context_dispatch () at /usr/lib/x86_64-lin=
ux-gnu/libglib-2.0.so.0
#23 0x0000555555c60148 in glib_pollfds_poll () at util/main-loop.c:219
#24 0x0000555555c60148 in os_host_main_loop_wait (timeout=3D<optimized out>=
) at util/main-loop.c:242
#25 0x0000555555c60148 in main_loop_wait (nonblocking=3Dnonblocking@entry=
=3D0) at util/main-loop.c:518
#26 0x00005555558fc579 in qemu_main_loop () at /home/dietmar/pve5-devel/mir=
ror_qemu/softmmu/vl.c:1665
#27 0x0000555555800c2e in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>)
    at /home/dietmar/pve5-devel/mirror_qemu/softmmu/main.c:49

The VM uses a similar hardware setup with io-threads as the previous=20
example.

Is somebody able to reproduce that? And ideas whats wrong here?

> On March 24, 2020 2:47 PM Max Reitz <mreitz@redhat.com> wrote:
>=20
> =20
> Hi Dietmar,
>=20
> I assume this is with master and has popped up only recently?
>=20
> Maybe it has something to do with the recent mutex patches by Stefan, so
> I=E2=80=99m Cc-ing him.
>=20
> Max
>=20
> On 24.03.20 14:33, Dietmar Maurer wrote:
> > spoke too soon - the error is still there, sigh
> > =20
> >> This is fixed with this patch:
> >>
> >> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07249.html
> >>
> >> thanks!
> >>
> >>> On March 24, 2020 12:13 PM Dietmar Maurer <dietmar@proxmox.com> wrote=
:
> >>>
> >>> =20
> >>> I get a core dump with backup transactions when using io-threads.
> >>>
> >>> To reproduce, create and start a VM with:
> >>>
> >>> # qemu-img create disk1.raw 100M
> >>> # qemu-img create disk2.raw 100M
> >>> #./x86_64-softmmu/qemu-system-x86_64 -chardev 'socket,id=3Dqmp,path=
=3D/var/run/qemu-test.qmp,server,nowait' -mon 'chardev=3Dqmp,mode=3Dcontrol=
' -pidfile /var/run/qemu-server/108.pid  -m 512 -object 'iothread,id=3Dioth=
read-virtioscsi0' -object 'iothread,id=3Diothread-virtioscsi1'  -device 'vi=
rtio-scsi-pci,id=3Dvirtioscsi0,iothread=3Diothread-virtioscsi0' -drive 'fil=
e=3Ddisk1.raw,if=3Dnone,id=3Ddrive-scsi0,format=3Draw,cache=3Dnone,aio=3Dna=
tive,detect-zeroes=3Don' -device 'scsi-hd,bus=3Dvirtioscsi0.0,channel=3D0,s=
csi-id=3D0,lun=3D0,drive=3Ddrive-scsi0,id=3Dscsi0' -device 'virtio-scsi-pci=
,id=3Dvirtioscsi1,iothread=3Diothread-virtioscsi1' -drive 'file=3Ddisk2.raw=
,if=3Dnone,id=3Ddrive-scsi1,format=3Draw,cache=3Dnone,aio=3Dnative,detect-z=
eroes=3Don' -device 'scsi-hd,bus=3Dvirtioscsi1.0,channel=3D0,scsi-id=3D0,lu=
n=3D1,drive=3Ddrive-scsi1,id=3Dscsi1'
> >>>
> >>> Then open socat to the qmp socket
> >>> # socat /var/run/qemu-test.qmp -
> >>>
> >>> And run the following qmp command:
> >>>
> >>> { "execute": "qmp_capabilities", "arguments": {} }
> >>> { "execute": "transaction", "arguments":  { "actions": [{ "type": "dr=
ive-backup", "data": { "device": "drive-scsi0", "sync": "full", "target": "=
backup-sysi0.raw" }}, { "type": "drive-backup", "data": { "device": "drive-=
scsi1", "sync": "full", "target": "backup-scsi1.raw" }}], "properties": { "=
completion-mode": "grouped" } } }
> >>>
> >>> The VM will core dump:
> >>>
> >>> qemu: qemu_mutex_unlock_impl: Operation not permitted
> >>> Aborted (core dumped)
> >>> (gdb) bt
> >>> #0  0x00007f099d5037bb in __GI_raise (sig=3Dsig@entry=3D6) at ../sysd=
eps/unix/sysv/linux/raise.c:50
> >>> #1  0x00007f099d4ee535 in __GI_abort () at abort.c:79
> >>> #2  0x000055c04e39525e in error_exit (err=3D<optimized out>, msg=3Dms=
g@entry=3D0x55c04e5122e0 <__func__.16544> "qemu_mutex_unlock_impl") at util=
/qemu-thread-posix.c:36
> >>> #3  0x000055c04e395813 in qemu_mutex_unlock_impl (mutex=3Dmutex@entry=
=3D0x7f09903154e0, file=3Dfile@entry=3D0x55c04e51129f "util/async.c", line=
=3Dline@entry=3D601)
> >>>     at util/qemu-thread-posix.c:108
> >>> #4  0x000055c04e38f8e5 in aio_context_release (ctx=3Dctx@entry=3D0x7f=
0990315480) at util/async.c:601
> >>> #5  0x000055c04e299073 in bdrv_set_aio_context_ignore (bs=3D0x7f0929a=
76500, new_context=3Dnew_context@entry=3D0x7f0990315000, ignore=3Dignore@en=
try=3D0x7ffe08fa7400)
> >>>     at block.c:6238
> >>> #6  0x000055c04e2990cc in bdrv_set_aio_context_ignore (bs=3Dbs@entry=
=3D0x7f092af47900, new_context=3Dnew_context@entry=3D0x7f0990315000, ignore=
=3Dignore@entry=3D0x7ffe08fa7400)
> >>>     at block.c:6211
> >>> #7  0x000055c04e299443 in bdrv_child_try_set_aio_context (bs=3Dbs@ent=
ry=3D0x7f092af47900, ctx=3D0x7f0990315000, ignore_child=3Dignore_child@entr=
y=3D0x0, errp=3Derrp@entry=3D0x0)
> >>>     at block.c:6324
> >>> #8  0x000055c04e299576 in bdrv_try_set_aio_context (errp=3D0x0, ctx=
=3D<optimized out>, bs=3D0x7f092af47900) at block.c:6333
> >>> #9  0x000055c04e299576 in bdrv_replace_child (child=3Dchild@entry=3D0=
x7f09902ef5e0, new_bs=3Dnew_bs@entry=3D0x0) at block.c:2551
> >>> #10 0x000055c04e2995ff in bdrv_detach_child (child=3D0x7f09902ef5e0) =
at block.c:2666
> >>> #11 0x000055c04e299ec9 in bdrv_root_unref_child (child=3D<optimized o=
ut>) at block.c:2677
> >>> #12 0x000055c04e29f3fe in block_job_remove_all_bdrv (job=3Djob@entry=
=3D0x7f0927c18800) at blockjob.c:191
> >>> #13 0x000055c04e29f429 in block_job_free (job=3D0x7f0927c18800) at bl=
ockjob.c:88
> >>> #14 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c:3=
59
> >>> #15 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c:3=
51
> >>> #16 0x000055c04e2a0b68 in job_conclude (job=3D0x7f0927c18800) at job.=
c:620
> >>> #17 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800) =
at job.c:688
> >>> #18 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800) =
at job.c:660
> >>> #19 0x000055c04e2a14fc in job_txn_apply (txn=3D<optimized out>, fn=3D=
0x55c04e2a0a50 <job_finalize_single>) at job.c:145
> >>> #20 0x000055c04e2a14fc in job_do_finalize (job=3D0x7f0927c1c200) at j=
ob.c:781
> >>> #21 0x000055c04e2a1751 in job_completed_txn_success (job=3D0x7f0927c1=
c200) at job.c:831
> >>> #22 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at job=
.c:844
> >>> #23 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at job=
.c:835
> >>> #24 0x000055c04e2a17b0 in job_exit (opaque=3D0x7f0927c1c200) at job.c=
:863
> >>> #25 0x000055c04e38ee75 in aio_bh_call (bh=3D0x7f098ec52000) at util/a=
sync.c:164
> >>> #26 0x000055c04e38ee75 in aio_bh_poll (ctx=3Dctx@entry=3D0x7f09903150=
00) at util/async.c:164
> >>> #27 0x000055c04e3924fe in aio_dispatch (ctx=3D0x7f0990315000) at util=
/aio-posix.c:380
> >>> #28 0x000055c04e38ed5e in aio_ctx_dispatch (source=3D<optimized out>,=
 callback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:2=
98
> >>> #29 0x00007f099f020f2e in g_main_context_dispatch () at /usr/lib/x86_=
64-linux-gnu/libglib-2.0.so.0
> >>> #30 0x000055c04e391768 in glib_pollfds_poll () at util/main-loop.c:21=
9
> >>> #31 0x000055c04e391768 in os_host_main_loop_wait (timeout=3D<optimize=
d out>) at util/main-loop.c:242
> >>> #32 0x000055c04e391768 in main_loop_wait (nonblocking=3Dnonblocking@e=
ntry=3D0) at util/main-loop.c:518
> >>> #33 0x000055c04e032329 in qemu_main_loop () at /home/dietmar/pve5-dev=
el/mirror_qemu/softmmu/vl.c:1665
> >>> #34 0x000055c04df36a8e in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/=
softmmu/main.c:49
> >


