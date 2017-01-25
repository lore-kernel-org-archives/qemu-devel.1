Received: from eggs.gnu.org ([2001:4830:134:3::10]:52212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNRV-00009D-Gt
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNRU-0004sj-7C
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:16:53 -0500
Date: Wed, 25 Jan 2017 13:16:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125131644.GC10664@stefanha-x1.localdomain>
References: <20170124095350.16679-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20170124095350.16679-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] aio-posix: honor is_external in AioContext
 polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 09:53:50AM +0000, Stefan Hajnoczi wrote:
> AioHandlers marked ->is_external must be skipped when aio_node_check()
> fails.  bdrv_drained_begin() needs this to prevent dataplane from
> submitting new I/O requests while another thread accesses the device and
> relies on it being quiesced.
>=20
> This patch fixes the following segfault:
>=20
>   Program terminated with signal SIGSEGV, Segmentation fault.
>   #0  0x00005577f6127dad in bdrv_io_plug (bs=3D0x5577f7ae52f0) at qemu/bl=
ock/io.c:2650
>   2650            bdrv_io_plug(child->bs);
>   [Current thread is 1 (Thread 0x7ff5c4bd1c80 (LWP 10917))]
>   (gdb) bt
>   #0  0x00005577f6127dad in bdrv_io_plug (bs=3D0x5577f7ae52f0) at qemu/bl=
ock/io.c:2650
>   #1  0x00005577f6114363 in blk_io_plug (blk=3D0x5577f7b8ba20) at qemu/bl=
ock/block-backend.c:1561
>   #2  0x00005577f5d4091d in virtio_blk_handle_vq (s=3D0x5577f9ada030, vq=
=3D0x5577f9b3d2a0) at qemu/hw/block/virtio-blk.c:589
>   #3  0x00005577f5d4240d in virtio_blk_data_plane_handle_output (vdev=3D0=
x5577f9ada030, vq=3D0x5577f9b3d2a0) at qemu/hw/block/dataplane/virtio-blk.c=
:158
>   #4  0x00005577f5d88acd in virtio_queue_notify_aio_vq (vq=3D0x5577f9b3d2=
a0) at qemu/hw/virtio/virtio.c:1304
>   #5  0x00005577f5d8aaaf in virtio_queue_host_notifier_aio_poll (opaque=
=3D0x5577f9b3d308) at qemu/hw/virtio/virtio.c:2134
>   #6  0x00005577f60ca077 in run_poll_handlers_once (ctx=3D0x5577f79ddbb0)=
 at qemu/aio-posix.c:493
>   #7  0x00005577f60ca268 in try_poll_mode (ctx=3D0x5577f79ddbb0, blocking=
=3Dtrue) at qemu/aio-posix.c:569
>   #8  0x00005577f60ca331 in aio_poll (ctx=3D0x5577f79ddbb0, blocking=3Dtr=
ue) at qemu/aio-posix.c:601
>   #9  0x00005577f612722a in bdrv_flush (bs=3D0x5577f7c20970) at qemu/bloc=
k/io.c:2403
>   #10 0x00005577f60c1b2d in bdrv_close (bs=3D0x5577f7c20970) at qemu/bloc=
k.c:2322
>   #11 0x00005577f60c20e7 in bdrv_delete (bs=3D0x5577f7c20970) at qemu/blo=
ck.c:2465
>   #12 0x00005577f60c3ecf in bdrv_unref (bs=3D0x5577f7c20970) at qemu/bloc=
k.c:3425
>   #13 0x00005577f60bf951 in bdrv_root_unref_child (child=3D0x5577f7a2de70=
) at qemu/block.c:1361
>   #14 0x00005577f6112162 in blk_remove_bs (blk=3D0x5577f7b8ba20) at qemu/=
block/block-backend.c:491
>   #15 0x00005577f6111b1b in blk_remove_all_bs () at qemu/block/block-back=
end.c:245
>   #16 0x00005577f60c1db6 in bdrv_close_all () at qemu/block.c:2382
>   #17 0x00005577f5e60cca in main (argc=3D20, argv=3D0x7ffea6eb8398, envp=
=3D0x7ffea6eb8440) at qemu/vl.c:4684
>=20
> The key thing is that bdrv_close() uses bdrv_drained_begin() and
> virtio_queue_host_notifier_aio_poll() must not be called.
>=20
> Thanks to Fam Zheng <famz@redhat.com> for identifying the root cause of
> this crash.
>=20
> Reported-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  aio-posix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKU8AAoJEJykq7OBq3PIjI0H/03c0AG6YR0LMLM9oVZCHyji
qS8hvyd+5gBxkTxG0zlpp0VRHTuIeuU07mqhzr4aCiiLJPQ2tIgXmBNWDDR2t9Z1
8vGgmX9jSXxhU1yEhvDPqh30TPFHrsDq1rNeq9SXIRm59moABB8c5Y5a9/QxCrLz
wjAamrmu7YE0XGAEF3O3OERpnEoIhYJYz6SgRQQNk13piUIV1on+inGXcGgLjpQt
9muZn0Lq3cGJ18vwAa2hAtcAvhsA2ocaI/x6JFbMkDo2yAAA8QJOk7jb+OKUI4rw
DHCUPPw6WBBvZT+1LlhWR8zu0W2a2HGv5jBehQH+60XvXe4X6027iGvyIC3/0qU=
=6twe
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
