Received: from eggs.gnu.org ([2001:4830:134:3::10]:47257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEpC-0000v0-10
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEp8-00067D-R0
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:06:30 -0400
Date: Wed, 11 Jul 2018 14:06:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711130617.GH31228@stefanha-x1.localdomain>
References: <20180709154549.7df475b9.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline
In-Reply-To: <20180709154549.7df475b9.cohuck@redhat.com>
Subject: Re: [Qemu-devel] qemu-nbd vs 'simple' trace backend vs iotest 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 03:45:49PM +0200, Cornelia Huck wrote:
> Hi,
>=20
> I recently noticed that iotest 147 was hanging on my laptop, but worked
> fine on my s390x LPAR. Turned out that the architecture was a red
> herring; on both platforms, things fail with the 'simple' trace backend
> and work with e.g. the 'log' trace backend. Some details on the
> failures with the 'simple' backend:
>=20
> - The first run of 147 passes. However, there are two processes hanging
>   around, one using a unix socket and one using an inet socket:
>=20
> cohuck   22912  0.0  0.0 156580  3836 ?        Ss   14:32   0:00 /home/co=
huck/git/qemu/build/tests/qemu-iotests/../../qemu-nbd --fork -f qcow2 /home=
/cohuck/git/qemu/build/tests/qemu-iotests/scratch/test.img -p 10811
> cohuck   22925  0.0  0.0 156580  3840 ?        Ss   14:32   0:00 /home/co=
huck/git/qemu/build/tests/qemu-iotests/../../qemu-nbd --fork -f qcow2 /home=
/cohuck/git/qemu/build/tests/qemu-iotests/scratch/test.img -k /home/cohuck/=
git/qemu/build/tests/qemu-iotests/scratch/nbd.socket
>=20
> Attaching a gdb shows that we seem to be waiting on flushing:
>=20
> (gdb) bt
> #0  0x00007f461c078b99 in syscall () from /lib64/libc.so.6
> #1  0x00007f461d13650f in g_cond_wait () from /lib64/libglib-2.0.so.0
> #2  0x0000560cf3a1caf2 in flush_trace_file (wait=3D255)
>     at /home/cohuck/git/qemu/trace/simple.c:139
> #3  st_flush_trace_buffer () at /home/cohuck/git/qemu/trace/simple.c:374
> #4  0x00007f461bfc01d8 in __run_exit_handlers () from /lib64/libc.so.6
> #5  0x00007f461bfc022a in exit () from /lib64/libc.so.6
> #6  0x0000560cf392eb7e in main (argc=3D<optimized out>, argv=3D<optimized=
 out>)
>     at /home/cohuck/git/qemu/qemu-nbd.c:1076
>=20
> (for both processes)

Please also print backtraces for the other threads:

  (gdb) thread apply all bt

There should be another thread in writeout_thread() so I'm surprised
that flush_trace_file() is getting stuck in g_cond_wait().

Stefan

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRgDJAAoJEJykq7OBq3PIHGcH/0HI1x1eWxgiYf/c0wZianOG
BTJLCQS8VcL9G71esLjKKNVwjYnvPDC9tJtJMel2Irqmjvhu9Fps2ID7g+Ww/J0A
noylksAzmubSN5R7vifmBE5sJO19eTdVuQ6XFlNFBTsOnr0Lw1w1gZy964Bt8Kd0
TaJ6NOseDV0lFnjKsiGsl6E52+oNhNNqtdgXizXFp3G6hyXqoscU3eZ4ZbuX5BAY
FQamFmtBVlJSmt19fNX9b8Jm14NJSh4sWoGNhopNoN5+eoBdPgNEyWJNnU1PJpSV
Fvm5y2XDgu4blAitkApc+3NEAqPYRh3euUnClyqKPLJ0QB1cHm2sar/RPEA1N1o=
=hkOp
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
