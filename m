Received: from eggs.gnu.org ([2001:4830:134:3::10]:54710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciJzf-0000TK-PC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciJza-0004XF-Rw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:01:31 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:39458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciJza-0004WR-ML
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:01:26 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id ED3F8B1CAF
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 13:01:24 +0100 (CET)
Date: Mon, 27 Feb 2017 13:01:20 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170227130120.6ec54cc2@bahia.lan>
In-Reply-To: <20170227111726.9237-1-pbonzini@redhat.com>
References: <20170227111726.9237-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/ypDOBS=pfuLUkhC7c.3E8._";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] tests-aio-multithread: use atomic_read
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

--Sig_/ypDOBS=pfuLUkhC7c.3E8._
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2017 12:17:26 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> nodes[id].next is written by other threads.  If atomic_read is not used
> (matching atomic_set in mcs_mutex_lock!) the compiler can optimize the
> whole "if" away!
>=20
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Cool ! I can use travis again :)

Tested-by: Greg Kurz <groug@kaod.org>

>  tests/test-aio-multithread.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
> index f11e990..8b0b40e 100644
> --- a/tests/test-aio-multithread.c
> +++ b/tests/test-aio-multithread.c
> @@ -309,7 +309,7 @@ static void mcs_mutex_lock(void)
>  static void mcs_mutex_unlock(void)
>  {
>      int next;
> -    if (nodes[id].next =3D=3D -1) {
> +    if (atomic_read(&nodes[id].next) =3D=3D -1) {
>          if (atomic_read(&mutex_head) =3D=3D id &&
>              atomic_cmpxchg(&mutex_head, id, -1) =3D=3D id) {
>              /* Last item in the list, exit.  */
> @@ -323,7 +323,7 @@ static void mcs_mutex_unlock(void)
>      }
> =20
>      /* Wake up the next in line.  */
> -    next =3D nodes[id].next;
> +    next =3D atomic_read(&nodes[id].next);
>      nodes[next].locked =3D 0;
>      qemu_futex_wake(&nodes[next].locked, 1);
>  }


--Sig_/ypDOBS=pfuLUkhC7c.3E8._
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli0FRAACgkQAvw66wEB28IksQCfYG5+ippacIDjzbs+FkjNNYN2
LU4AoJLp8iIbK2/lm6yKnCum43LHvMwW
=1LQe
-----END PGP SIGNATURE-----

--Sig_/ypDOBS=pfuLUkhC7c.3E8._--
