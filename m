Received: from eggs.gnu.org ([2001:4830:134:3::10]:54164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0qug-0002AK-2b
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0quf-0000sG-1h
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:25:46 -0400
Date: Fri, 14 Sep 2018 18:25:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180914162526.GC4991@localhost.localdomain>
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-13-kwolf@redhat.com>
	<9f51d49d-0159-3382-b561-1f33335a2dfd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <9f51d49d-0159-3382-b561-1f33335a2dfd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/17] mirror: Fix potential
 use-after-free in active commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.09.2018 um 22:55 hat Max Reitz geschrieben:
> On 13.09.18 14:52, Kevin Wolf wrote:
> > When starting an active commit job, other callbacks can run before
> > mirror_start_job() calls bdrv_ref() where needed and cause the nodes to
> > go away. Add another pair of bdrv_ref/unref() around it to protect
> > against this case.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/mirror.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> But...  How?

Tried to reproduce the other bug Paolo was concerned about (good there
is something like 'git reflog'!) and dug up this one instead.

So the scenario seems to be test_stream_commit_1 in qemu-iotests 030.

The backtrace when the BDS is deleted is the following:

(rr) bt
#0  0x00007faeaf6145ec in __memset_sse2_unaligned_erms () at /lib64/libc.so=
=2E6
#1  0x00007faeaf60414e in _int_free () at /lib64/libc.so.6
#2  0x00007faeaf6093be in free () at /lib64/libc.so.6
#3  0x00007faecaea6b4e in g_free () at /lib64/libglib-2.0.so.0
#4  0x000055c0c94f9d6c in bdrv_delete (bs=3D0x55c0cbe69240) at block.c:3590
#5  0x000055c0c94fbe82 in bdrv_unref (bs=3D0x55c0cbe69240) at block.c:4638
#6  0x000055c0c94f6761 in bdrv_root_unref_child (child=3D0x55c0cbe57af0) at=
 block.c:2188
#7  0x000055c0c94fe239 in block_job_remove_all_bdrv (job=3D0x55c0ccf9e220) =
at blockjob.c:200
#8  0x000055c0c94fdf1f in block_job_free (job=3D0x55c0ccf9e220) at blockjob=
=2Ec:94
#9  0x000055c0c94ffe0d in job_unref (job=3D0x55c0ccf9e220) at job.c:368
#10 0x000055c0c95007cd in job_do_dismiss (job=3D0x55c0ccf9e220) at job.c:641
#11 0x000055c0c95008d9 in job_conclude (job=3D0x55c0ccf9e220) at job.c:667
#12 0x000055c0c9500b66 in job_finalize_single (job=3D0x55c0ccf9e220) at job=
=2Ec:735
#13 0x000055c0c94ff4fa in job_txn_apply (txn=3D0x55c0cbe19eb0, fn=3D0x55c0c=
9500a62 <job_finalize_single>, lock=3Dtrue) at job.c:151
#14 0x000055c0c9500e92 in job_do_finalize (job=3D0x55c0ccf9e220) at job.c:8=
22
#15 0x000055c0c9501040 in job_completed_txn_success (job=3D0x55c0ccf9e220) =
at job.c:872
#16 0x000055c0c950115c in job_completed (job=3D0x55c0ccf9e220, ret=3D0, err=
or=3D0x0) at job.c:892
#17 0x000055c0c92b572c in stream_complete (job=3D0x55c0ccf9e220, opaque=3D0=
x55c0cc050bc0) at block/stream.c:96
#18 0x000055c0c950142b in job_defer_to_main_loop_bh (opaque=3D0x55c0cbe38a5=
0) at job.c:981
#19 0x000055c0c96171fc in aio_bh_call (bh=3D0x55c0cbe19f20) at util/async.c=
:90
#20 0x000055c0c9617294 in aio_bh_poll (ctx=3D0x55c0cbd7b8d0) at util/async.=
c:118
#21 0x000055c0c961c150 in aio_poll (ctx=3D0x55c0cbd7b8d0, blocking=3Dtrue) =
at util/aio-posix.c:690
#22 0x000055c0c957246c in bdrv_flush (bs=3D0x55c0cbe4b250) at block/io.c:26=
93
#23 0x000055c0c94f8e46 in bdrv_reopen_prepare (reopen_state=3D0x55c0cbef4d6=
8, queue=3D0x55c0cbeab9f0, errp=3D0x7ffd65617050) at block.c:3206
#24 0x000055c0c94f883a in bdrv_reopen_multiple (ctx=3D0x55c0cbd7b8d0, bs_qu=
eue=3D0x55c0cbeab9f0, errp=3D0x7ffd656170c8) at block.c:3032
#25 0x000055c0c94f8a00 in bdrv_reopen (bs=3D0x55c0cbe2c250, bdrv_flags=3D81=
94, errp=3D0x7ffd65617220) at block.c:3075
#26 0x000055c0c956a23f in commit_active_start (job_id=3D0x0, bs=3D0x55c0cbd=
905b0, base=3D0x55c0cbe2c250, creation_flags=3D0, speed=3D0, on_error=3DBLO=
CKDEV_ON_ERROR_REPORT, filter_node_name=3D0x0, cb=3D0x0, opaque=3D0x0, auto=
_complete=3Dfalse, errp=3D0x7ffd65617220) at block/mirror.c:1687
#27 0x000055c0c927437c in qmp_block_commit (has_job_id=3Dfalse, job_id=3D0x=
0, device=3D0x55c0cbef4d20 "drive0", has_base_node=3Dfalse, base_node=3D0x0=
, has_base=3Dtrue, base=3D0x55c0cbe38a00 "/home/kwolf/source/qemu/tests/qem=
u-iotests/scratch/img-3.img", has_top_node=3Dfalse, top_node=3D0x0, has_top=
=3Dfalse, top=3D0x0, has_backing_file=3Dfalse, backing_file=3D0x0, has_spee=
d=3Dfalse, speed=3D0, has_filter_node_name=3Dfalse, filter_node_name=3D0x0,=
 errp=3D0x7ffd656172d8) at blockdev.c:3325
#28 0x000055c0c928bb08 in qmp_marshal_block_commit (args=3D<optimized out>,=
 ret=3D<optimized out>, errp=3D0x7ffd656173b8) at qapi/qapi-commands-block-=
core.c:409
#29 0x000055c0c960beef in do_qmp_dispatch (errp=3D0x7ffd656173b0, allow_oob=
=3Dfalse, request=3D<optimized out>, cmds=3D0x55c0c9f56f80 <qmp_commands>) =
at qapi/qmp-dispatch.c:129
#30 0x000055c0c960beef in qmp_dispatch (cmds=3D0x55c0c9f56f80 <qmp_commands=
>, request=3D<optimized out>, allow_oob=3D<optimized out>) at qapi/qmp-disp=
atch.c:171
#31 0x000055c0c9111623 in monitor_qmp_dispatch (mon=3D0x55c0cbdbb930, req=
=3D0x55c0ccf90e00, id=3D0x0) at /home/kwolf/source/qemu/monitor.c:4168
#32 0x000055c0c911191f in monitor_qmp_bh_dispatcher (data=3D0x0) at /home/k=
wolf/source/qemu/monitor.c:4237
#33 0x000055c0c96171fc in aio_bh_call (bh=3D0x55c0cbccc840) at util/async.c=
:90
#34 0x000055c0c9617294 in aio_bh_poll (ctx=3D0x55c0cbccc550) at util/async.=
c:118
#35 0x000055c0c961b723 in aio_dispatch (ctx=3D0x55c0cbccc550) at util/aio-p=
osix.c:436
#36 0x000055c0c961762f in aio_ctx_dispatch (source=3D0x55c0cbccc550, callba=
ck=3D0x0, user_data=3D0x0) at util/async.c:261
#37 0x00007faecaea1257 in g_main_context_dispatch () at /lib64/libglib-2.0.=
so.0
#38 0x000055c0c961a2aa in glib_pollfds_poll () at util/main-loop.c:215
#39 0x000055c0c961a2aa in os_host_main_loop_wait (timeout=3D0) at util/main=
-loop.c:238
#40 0x000055c0c961a2aa in main_loop_wait (nonblocking=3D<optimized out>) at=
 util/main-loop.c:497
#41 0x000055c0c92805e1 in main_loop () at vl.c:1866
#42 0x000055c0c9287eca in main (argc=3D18, argv=3D0x7ffd65617958, envp=3D0x=
7ffd656179f0) at vl.c:4647
(rr) p bs.node_name=20
$17 =3D "node1", '\000' <repeats 26 times>

Obviously, this exact backtrace shouldn't even be possible like this
because job_defer_to_main_loop_bh() shouldn't be called inside
bdrv_flush(), but when draining the subtree in bdrv_reopen(). This is
only fixed in "blockjob: Lie better in child_job_drained_poll()".

It probably doesn't make a difference, though, where exactly during
bdrv_reopen() the node is deleted. We'll crash anyway if we don't hold
the extra reference.

Kevin

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbm+D1AAoJEH8JsnLIjy/WG74P/A/9odOCXegeSaeBjwLXOzTi
GMVE+lZsjIDU0V58u4oeFpaC3tIpXwYl02V9XTcMQRC0n0VOF2JJka0fzcmTAt27
HgKuKomhwPXu5HDvx6U3StoSLABkhJTd4w31l2Ejvdw5ODM1iSb6sTCRHLVCUeEb
TygZeXJYrNEvQAyMfC8yYkx4fS0ixkbT9726FUscFPMlseNdOUbETKfTPxXw1Gtt
4Z7vWVAQOdd1iCV2NkAAltjpa6vCIO7VijwOJFss5djxJ8DlsR1WRp5RIYxMP2Uz
d0rTpTbloEzVePI6Il4UzomWzd519qA3S2n1x+FWaVe9ycLmk1ioJCh9bRQLczxP
dXu/7/vQt1jCAzkqXEJrDrbf/HK4g4bIoCElC/vmzlvbGiPc/I/bUqVlojFE5N66
Vyf6RXXsejBlTDZnV/5v0U3btvHBsWRqtaMHH61t9DMclfIxdUo5vL4rYW7O708t
Ca/RVX3YDX6YURLoTojqKAaKX+1zIxxHU1srqg31PIp8ajNAUkktethYvfvFzbD8
KQW8yWpJmeBkqxokcT0KLwivUHpUHJShSUFfw4/qbxVeiALRBwfoL99BXp4J+u8J
efdlxrrsbKEPIaRq2XfZlbKQvDU/p4FCvj3AC7WRfZ/c0oVJwDDFt7cIhxgbdqOC
5LB/YOCZ7WhBR2lNIkJV
=7085
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
