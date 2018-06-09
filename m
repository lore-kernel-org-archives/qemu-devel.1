Received: from eggs.gnu.org ([2001:4830:134:3::10]:49849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1fRZtX-0002mb-CI
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 05:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1fRZtS-0003Si-C8
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 05:10:47 -0400
Received: from [45.249.212.35] (port=36088 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhengui@huawei.com>)
	id 1fRZtR-0003RM-7z
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 05:10:42 -0400
From: l00284672 <lizhengui@huawei.com>
Message-ID: <ed097efe-73a8-5184-e0d6-114374d798f1@huawei.com>
Date: Sat, 9 Jun 2018 17:10:10 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------567547106520A0857E1BF473"
Content-Language: en-US
Subject: [Qemu-devel] question: a dead loop in qemu when do blockJobAbort
 and vm suspend coinstantaneously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, kwolf@redhat.com, famz@redhat.com
Cc: qemu-devel@nongnu.org

--------------567547106520A0857E1BF473
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi, I found a dead loop in qemu when do blockJobAbort and vm suspend=20
coinstantaneously.

The qemu bt is below:

#0=C2=A0 0x00007ff58b53af1f in ppoll () from /lib64/libc.so.6
#1=C2=A0 0x00000000007fdbd9 in ppoll (__ss=3D0x0, __timeout=3D0x7ffcf7055=
390,=20
__nfds=3D<optimized out>, __fds=3D<optimized out>) at=20
/usr/include/bits/poll2.h:77
#2=C2=A0 qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>,=20
timeout=3Dtimeout@entry=3D0) at util/qemu-timer.c:334
#3=C2=A0 0x00000000007ff83a in aio_poll (ctx=3Dctx@entry=3D0x269d800,=20
blocking=3Dblocking@entry=3Dfalse) at util/aio-posix.c:629
#4=C2=A0 0x0000000000776e91 in bdrv_drain_recurse (bs=3Dbs@entry=3D0x26d9=
cb0) at=20
block/io.c:198
#5=C2=A0 0x0000000000776ef2 in bdrv_drain_recurse (bs=3Dbs@entry=3D0x3665=
990) at=20
block/io.c:215
#6=C2=A0 0x00000000007774b8 in bdrv_do_drained_begin (bs=3D0x3665990,=20
recursive=3D<optimized out>, parent=3D0x0) at block/io.c:291
#7=C2=A0 0x000000000076a79e in blk_drain (blk=3D0x2780fc0) at=20
block/block-backend.c:1586
#8=C2=A0 0x000000000072d2a9 in block_job_drain (job=3D0x29df040) at block=
job.c:123
#9=C2=A0 0x000000000072d228 in block_job_detach_aio_context=20
(opaque=3D0x29df040) at blockjob.c:139
#10 0x00000000007298b1 in bdrv_detach_aio_context=20
(bs=3Dbs@entry=3D0x3665990) at block.c:4885
#11 0x0000000000729a46 in bdrv_set_aio_context (bs=3D0x3665990,=20
new_context=3D0x268e140) at block.c:4946
#12 0x0000000000499743 in virtio_blk_data_plane_stop (vdev=3D<optimized=20
out>) at=20
/mnt/sdb/lzg/code/shequ_code/5_29/qemu/hw/block/dataplane/virtio-blk.c:28=
5
#13 0x00000000006bce30 in virtio_bus_stop_ioeventfd (bus=3D0x3de5378) at=20
hw/virtio/virtio-bus.c:246
#14 0x00000000004c654d in virtio_vmstate_change (opaque=3D0x3de53f0,=20
running=3D<optimized out>, state=3D<optimized out>)
 =C2=A0=C2=A0=C2=A0 at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/hw/virtio/v=
irtio.c:2222
#15 0x0000000000561b52 in vm_state_notify (running=3Drunning@entry=3D0,=20
state=3Dstate@entry=3DRUN_STATE_PAUSED) at vl.c:1514
#16 0x000000000045d67a in do_vm_stop=20
(state=3Dstate@entry=3DRUN_STATE_PAUSED, send_stop=3Dsend_stop@entry=3Dtr=
ue)
 =C2=A0=C2=A0=C2=A0 at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/cpus.c:1012
#17 0x000000000045dafd in vm_stop (state=3Dstate@entry=3DRUN_STATE_PAUSED=
)=20
at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/cpus.c:2035
#18 0x000000000057301b in qmp_stop (errp=3Derrp@entry=3D0x7ffcf70556f0) a=
t=20
qmp.c:106
#19 0x000000000056bf7a in qmp_marshal_stop (args=3D<optimized out>,=20
ret=3D<optimized out>, errp=3D0x7ffcf7055738) at qapi/qapi-commands-misc.=
c:784
#20 0x00000000007f2d27 in do_qmp_dispatch (errp=3D0x7ffcf7055730,=20
request=3D0x3e121e0, cmds=3D<optimized out>) at qapi/qmp-dispatch.c:119
#21 qmp_dispatch (cmds=3D<optimized out>, request=3Drequest@entry=3D0x26f=
2800)=20
at qapi/qmp-dispatch.c:168
#22 0x00000000004655be in monitor_qmp_dispatch_one=20
(req_obj=3Dreq_obj@entry=3D0x39abff0) at=20
/mnt/sdb/lzg/code/shequ_code/5_29/qemu/monitor.c:4088
#23 0x0000000000465894 in monitor_qmp_bh_dispatcher (data=3D<optimized=20
out>) at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/monitor.c:4146
#24 0x00000000007fc571 in aio_bh_call (bh=3D0x26de7e0) at util/async.c:90
#25 aio_bh_poll (ctx=3Dctx@entry=3D0x268dd50) at util/async.c:118
#26 0x00000000007ff6f0 in aio_dispatch (ctx=3D0x268dd50) at=20
util/aio-posix.c:436
#27 0x00000000007fc44e in aio_ctx_dispatch (source=3D<optimized out>,=20
callback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:=
261
#28 0x00007ff58bc7c99a in g_main_context_dispatch () from=20
/lib64/libglib-2.0.so.0
#29 0x00000000007fea3a in glib_pollfds_poll () at util/main-loop.c:215
#30 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-loop.=
c:238
#31 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at util/main-loo=
p.c:497
#32 0x0000000000561cad in main_loop () at vl.c:1848
#33 0x000000000041995c in main (argc=3D<optimized out>, argv=3D<optimized=
=20
out>, envp=3D<optimized out>) at vl.c:4605

The disk is a virtio-blk dataplane disk with a mirror job running.=C2=A0 =
The=20
dead loop is here:

static void block_job_detach_aio_context(void *opaque)
{
 =C2=A0=C2=A0=C2=A0 BlockJob *job =3D opaque;

 =C2=A0=C2=A0=C2=A0 /* In case the job terminates during aio_poll()... */
 =C2=A0=C2=A0=C2=A0 job_ref(&job->job);

 =C2=A0=C2=A0=C2=A0 job_pause(&job->job);

 =C2=A0 while (!job->job.paused && !job_is_completed(&job->job)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_drain(&job->job);
 =C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0 job->job.aio_context =3D NULL;
 =C2=A0=C2=A0=C2=A0 job_unref(&job->job);
}

The job is deferred to main loop now,=C2=A0 but the=C2=A0 job_drain only =
processes=20
the AIO context of bs which has no more work to do,

while the main loop BH is scheduled for setting the job->completed flag=20
is never processed.

I=C2=A0 have tried many ways and want to slove it,=C2=A0 but they all can=
 not=20
slove it completely.=C2=A0 Do you have any good ideas for it? Thanks for =
your=20
reply!

--------------567547106520A0857E1BF473
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------567547106520A0857E1BF473--
