Received: from eggs.gnu.org ([2001:4830:134:3::10]:47185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eC60k-0005gK-VH
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eC60g-0004Er-8O
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:41:58 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:49990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eC60g-0004EV-0p
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:41:54 -0500
Received: by mail-wr0-x231.google.com with SMTP id o88so1411095wrb.6
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:41:53 -0800 (PST)
Date: Tue, 7 Nov 2017 15:41:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171107154144.GA23535@stefanha-x1.localdomain>
References: <20171106190233.1175-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20171106190233.1175-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] tests-aio-multithread: fix
 /aio/multi/schedule race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 07:02:33PM +0000, Stefan Hajnoczi wrote:
> test_multi_co_schedule_entry() set to_schedule[id] in the final loop
> iteration before terminating the coroutine.  There is a race condition
> where the main thread attempts to enter the terminating or terminated
> coroutine when signalling coroutines to stop:
>=20
>   atomic_mb_set(&now_stopping, true);
>   for (i =3D 0; i < NUM_CONTEXTS; i++) {
>       ctx_run(i, finish_cb, NULL);  <--- enters dead coroutine!
>       to_schedule[i] =3D NULL;
>   }
>=20
> Make sure only to set to_schedule[id] if this coroutine really needs to
> be scheduled!
>=20
> Reported-by: "R.Nageswara Sastry" <nasastry@in.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> This patch is appropriate for the QEMU 2.11 release to eliminate
> spurious test failures.
>=20
>  tests/test-aio-multithread.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAdQ4AAoJEJykq7OBq3PIuEUH/j7D3Cp6O5aNi30+Vt7BS9fH
fwwO4eIQSXO3t180Iem4GFdSHHZ/Q5UZlf13sc+Aunq7et+anPV/QYHGWM13r8Px
CKdNPUTKIkrXhZ9OMR94JlZog25Np5c3MvMrsTtjxIavzYTF9q8rk0P97VgvghSI
UcB6WyElnUfzz+LsLe4Ax/friQ8B+egcp5gziHNhSqRCtG1JfCN7eIUXXMyvpsAq
mrkPUHzrnbn4XZJlwGDcZhD7UVlY1TUEtJhjElFwMSw0thvw85WJ9k05quI0xACv
V+/UK8u0PyQ9Ziw1s1r0N/1sSqyGbRCGx2TJE3+H7/yU8B/JK4Bfcw+qsRV/jEE=
=Sdzk
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
