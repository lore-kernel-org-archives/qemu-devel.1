Received: from eggs.gnu.org ([2001:4830:134:3::10]:41418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRv0n-0006Ma-Pl
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 03:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRv0k-000134-Lt
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 03:43:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fRv0k-00012N-FL
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 03:43:38 -0400
Date: Sun, 10 Jun 2018 15:43:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180610074333.GA16232@lemon.usersys.redhat.com>
References: <ed097efe-73a8-5184-e0d6-114374d798f1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ed097efe-73a8-5184-e0d6-114374d798f1@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] question: a dead loop in qemu when do
 blockJobAbort and vm suspend coinstantaneously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: l00284672 <lizhengui@huawei.com>
Cc: stefanha@gmail.com, kwolf@redhat.com, qemu-devel@nongnu.org

On Sat, 06/09 17:10, l00284672 wrote:
> Hi, I found a dead loop in qemu when do blockJobAbort and vm suspend
> coinstantaneously.
>=20
> The qemu bt is below:
>=20
> #0=A0 0x00007ff58b53af1f in ppoll () from /lib64/libc.so.6
> #1=A0 0x00000000007fdbd9 in ppoll (__ss=3D0x0, __timeout=3D0x7ffcf70553=
90,
> __nfds=3D<optimized out>, __fds=3D<optimized out>) at
> /usr/include/bits/poll2.h:77
> #2=A0 qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>,
> timeout=3Dtimeout@entry=3D0) at util/qemu-timer.c:334
> #3=A0 0x00000000007ff83a in aio_poll (ctx=3Dctx@entry=3D0x269d800,
> blocking=3Dblocking@entry=3Dfalse) at util/aio-posix.c:629
> #4=A0 0x0000000000776e91 in bdrv_drain_recurse (bs=3Dbs@entry=3D0x26d9c=
b0) at
> block/io.c:198
> #5=A0 0x0000000000776ef2 in bdrv_drain_recurse (bs=3Dbs@entry=3D0x36659=
90) at
> block/io.c:215
> #6=A0 0x00000000007774b8 in bdrv_do_drained_begin (bs=3D0x3665990,
> recursive=3D<optimized out>, parent=3D0x0) at block/io.c:291
> #7=A0 0x000000000076a79e in blk_drain (blk=3D0x2780fc0) at
> block/block-backend.c:1586
> #8=A0 0x000000000072d2a9 in block_job_drain (job=3D0x29df040) at blockj=
ob.c:123
> #9=A0 0x000000000072d228 in block_job_detach_aio_context (opaque=3D0x29=
df040) at
> blockjob.c:139
> #10 0x00000000007298b1 in bdrv_detach_aio_context (bs=3Dbs@entry=3D0x36=
65990) at
> block.c:4885
> #11 0x0000000000729a46 in bdrv_set_aio_context (bs=3D0x3665990,
> new_context=3D0x268e140) at block.c:4946
> #12 0x0000000000499743 in virtio_blk_data_plane_stop (vdev=3D<optimized=
 out>)
> at
> /mnt/sdb/lzg/code/shequ_code/5_29/qemu/hw/block/dataplane/virtio-blk.c:=
285
> #13 0x00000000006bce30 in virtio_bus_stop_ioeventfd (bus=3D0x3de5378) a=
t
> hw/virtio/virtio-bus.c:246
> #14 0x00000000004c654d in virtio_vmstate_change (opaque=3D0x3de53f0,
> running=3D<optimized out>, state=3D<optimized out>)
> =A0=A0=A0 at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/hw/virtio/virtio.c:=
2222
> #15 0x0000000000561b52 in vm_state_notify (running=3Drunning@entry=3D0,
> state=3Dstate@entry=3DRUN_STATE_PAUSED) at vl.c:1514
> #16 0x000000000045d67a in do_vm_stop (state=3Dstate@entry=3DRUN_STATE_P=
AUSED,
> send_stop=3Dsend_stop@entry=3Dtrue)
> =A0=A0=A0 at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/cpus.c:1012
> #17 0x000000000045dafd in vm_stop (state=3Dstate@entry=3DRUN_STATE_PAUS=
ED) at
> /mnt/sdb/lzg/code/shequ_code/5_29/qemu/cpus.c:2035
> #18 0x000000000057301b in qmp_stop (errp=3Derrp@entry=3D0x7ffcf70556f0)=
 at
> qmp.c:106
> #19 0x000000000056bf7a in qmp_marshal_stop (args=3D<optimized out>,
> ret=3D<optimized out>, errp=3D0x7ffcf7055738) at qapi/qapi-commands-mis=
c.c:784
> #20 0x00000000007f2d27 in do_qmp_dispatch (errp=3D0x7ffcf7055730,
> request=3D0x3e121e0, cmds=3D<optimized out>) at qapi/qmp-dispatch.c:119
> #21 qmp_dispatch (cmds=3D<optimized out>, request=3Drequest@entry=3D0x2=
6f2800) at
> qapi/qmp-dispatch.c:168
> #22 0x00000000004655be in monitor_qmp_dispatch_one
> (req_obj=3Dreq_obj@entry=3D0x39abff0) at
> /mnt/sdb/lzg/code/shequ_code/5_29/qemu/monitor.c:4088
> #23 0x0000000000465894 in monitor_qmp_bh_dispatcher (data=3D<optimized =
out>)
> at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/monitor.c:4146
> #24 0x00000000007fc571 in aio_bh_call (bh=3D0x26de7e0) at util/async.c:=
90
> #25 aio_bh_poll (ctx=3Dctx@entry=3D0x268dd50) at util/async.c:118
> #26 0x00000000007ff6f0 in aio_dispatch (ctx=3D0x268dd50) at
> util/aio-posix.c:436
> #27 0x00000000007fc44e in aio_ctx_dispatch (source=3D<optimized out>,
> callback=3D<optimized out>, user_data=3D<optimized out>) at util/async.=
c:261
> #28 0x00007ff58bc7c99a in g_main_context_dispatch () from
> /lib64/libglib-2.0.so.0
> #29 0x00000000007fea3a in glib_pollfds_poll () at util/main-loop.c:215
> #30 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-loo=
p.c:238
> #31 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at util/main-l=
oop.c:497
> #32 0x0000000000561cad in main_loop () at vl.c:1848
> #33 0x000000000041995c in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>,
> envp=3D<optimized out>) at vl.c:4605
>=20
> The disk is a virtio-blk dataplane disk with a mirror job running.=A0 T=
he dead
> loop is here:
>=20
> static void block_job_detach_aio_context(void *opaque)
> {
> =A0=A0=A0 BlockJob *job =3D opaque;
>=20
> =A0=A0=A0 /* In case the job terminates during aio_poll()... */
> =A0=A0=A0 job_ref(&job->job);
>=20
> =A0=A0=A0 job_pause(&job->job);
>=20
> =A0 while (!job->job.paused && !job_is_completed(&job->job)) {
> =A0=A0=A0=A0=A0=A0=A0 job_drain(&job->job);
> =A0=A0=A0 }
>=20
> =A0=A0=A0 job->job.aio_context =3D NULL;
> =A0=A0=A0 job_unref(&job->job);
> }
>=20
> The job is deferred to main loop now,=A0 but the=A0 job_drain only proc=
esses the
> AIO context of bs which has no more work to do,
>=20
> while the main loop BH is scheduled for setting the job->completed flag=
 is
> never processed.

In that case, main loop's AioContext should be driven like in job_finish_=
sync().
Could you try this patch?

diff --git a/blockjob.c b/blockjob.c
index 0306533a2e..72aa82ac2d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -135,7 +135,15 @@ static void block_job_detach_aio_context(void *opaqu=
e)

     job_pause(&job->job);

-    while (!job->job.paused && !job_is_completed(&job->job)) {
+
+    while (true) {
+        if (job->job.paused || job_is_completed(&job->job)) {
+            break;
+        }
+        if (job->deferred_to_main_loop) {
+            aio_poll(qemu_get_aio_context(), true);
+            continue;
+        }
         job_drain(&job->job);
     }
