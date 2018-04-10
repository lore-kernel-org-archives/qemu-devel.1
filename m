Received: from eggs.gnu.org ([2001:4830:134:3::10]:37345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5ida-0007Xq-51
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5idX-000392-2P
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:03:58 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:45992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f5idW-00038a-Rl
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:03:55 -0400
Received: by mail-pl0-x244.google.com with SMTP id e22-v6so4612731plj.12
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 19:03:54 -0700 (PDT)
Date: Tue, 10 Apr 2018 10:03:49 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180410020349.GA11203@stefanha-x1.localdomain>
References: <20180409083956.1780-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20180409083956.1780-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] iothread: workaround glib bug
 which hangs qmp-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 04:39:56PM +0800, Peter Xu wrote:
> Free the AIO context earlier than the GMainContext (if we have) to
> workaround a glib2 bug that GSource context pointer is not cleared even
> if the context has already been destroyed (while it should).
>=20
> The patch itself only changed the order to destroy the objects, no
> functional change at all. Without this workaround, we can encounter
> qmp-test hang with oob (and possibly any other use case when iothread is
> used with GMainContexts):
>=20
>   #0  0x00007f35ffe45334 in __lll_lock_wait () from /lib64/libpthread.so.0
>   #1  0x00007f35ffe405d8 in _L_lock_854 () from /lib64/libpthread.so.0
>   #2  0x00007f35ffe404a7 in pthread_mutex_lock () from /lib64/libpthread.=
so.0
>   #3  0x00007f35fc5b9c9d in g_source_unref_internal (source=3D0x24f0600, =
context=3D0x7f35f0000960, have_lock=3D0) at gmain.c:1685
>   #4  0x0000000000aa6672 in aio_context_unref (ctx=3D0x24f0600) at /root/=
qemu/util/async.c:497
>   #5  0x000000000065851c in iothread_instance_finalize (obj=3D0x24f0380) =
at /root/qemu/iothread.c:129
>   #6  0x0000000000962d79 in object_deinit (obj=3D0x24f0380, type=3D0x242e=
960) at /root/qemu/qom/object.c:462
>   #7  0x0000000000962e0d in object_finalize (data=3D0x24f0380) at /root/q=
emu/qom/object.c:476
>   #8  0x0000000000964146 in object_unref (obj=3D0x24f0380) at /root/qemu/=
qom/object.c:924
>   #9  0x0000000000965880 in object_finalize_child_property (obj=3D0x24ec6=
40, name=3D0x24efca0 "mon_iothread", opaque=3D0x24f0380) at /root/qemu/qom/=
object.c:1436
>   #10 0x0000000000962c33 in object_property_del_child (obj=3D0x24ec640, c=
hild=3D0x24f0380, errp=3D0x0) at /root/qemu/qom/object.c:436
>   #11 0x0000000000962d26 in object_unparent (obj=3D0x24f0380) at /root/qe=
mu/qom/object.c:455
>   #12 0x0000000000658f00 in iothread_destroy (iothread=3D0x24f0380) at /r=
oot/qemu/iothread.c:365
>   #13 0x00000000004c67a8 in monitor_cleanup () at /root/qemu/monitor.c:46=
63
>   #14 0x0000000000669e27 in main (argc=3D16, argv=3D0x7ffc8b1ae2f8, envp=
=3D0x7ffc8b1ae380) at /root/qemu/vl.c:4749
>=20
> The glib2 bug is fixed in commit 26056558b ("gmain: allow
> g_source_get_context() on destroyed sources", 2012-07-30), the first
> good version is glib2 2.33.10. So this error will be encountered before
> any glib version older than 2.33.10 (not including). Since we are still
> supporting even older glib versions, we may want this workaround.
>=20
> Let's make sure we destroy the GSources first before its owner context
> until we drop support for glibs older than 2.33.10.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - verified the root cause of the bug, and enhance commit message and
>   comments correspondingly
> ---
>  iothread.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazBuFAAoJEJykq7OBq3PIMEQH/iwoGJgW27eTL8TYxswdy9Pp
2qC6noQ1E0APikqiG67qCNZ4tjjqKfFLkiI4+hoDGLiDE7UKKyWKg2NQTqAtPuop
BUi+r+OMO7594wCqXv9DcmWA3ASNF5j8WOeE/69hPW8o2m56pzj13oUmE708uLcD
9IZxyMM/NX5x+Zf9RaOwglc/BF8MXuD/wAZX3DrHKXJx5r5moPEQl2kh5YGQL+RJ
TetQnMgQ4ohBmOdTp7W/Q4zTZ6OqryMakCJriizIA+LEkDmGJiQeRm8D7WoKoY5G
6MadAhRCO0Yf+1lRueJ3peLckjOTcvroX4gfUIoXJeITDQVG8PY4GoSZOvPeqbw=
=0Ppc
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
