Received: from eggs.gnu.org ([2001:4830:134:3::10]:48113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGkUI-0007tz-RI
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 06:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGkUD-0007bV-Tj
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 06:43:42 -0500
Date: Mon, 20 Nov 2017 11:43:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120114334.GD4516@stefanha-x1.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<0c039d00e03331d863ee249810d9778313670803.1511145863.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <0c039d00e03331d863ee249810d9778313670803.1511145863.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/5] coroutines: abort if we
 try to enter a still-sleeping coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:46:44PM -0500, Jeff Cody wrote:
> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> index 931cdc9..b071217 100644
> --- a/include/qemu/coroutine_int.h
> +++ b/include/qemu/coroutine_int.h
> @@ -56,6 +56,8 @@ struct Coroutine {
> =20
>      int scheduled;
> =20
> +    int sleeping;

s/int/bool/

BTW an alternative to adding individual bools is to implement a finite
state machine for the entire coroutine lifecycle.  A single function can
validate all state transitions:

  void check_state_transition(CoState old, CoState new,
                              const char *action)
  {
      const char *errmsg =3D fsm[old][new];
      if (!errmsg) {
          return; /* valid transition! */
      }

      fprintf(stderr, "Cannot %s coroutine from %s state\n",
              action, state_name[old]);
      abort();
  }

Specifying fsm[][] forces us to think through all possible state
transitions.  This approach is proactive whereas adding bool flags is
reactive since it only covers a subset of states that were encountered
after crashes.  I'm not sure if it's worth it though :).

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaEr/mAAoJEJykq7OBq3PIxR8H/1nIsOsTCcDfmkWE4miQuknn
kAPjOZZsWyT/oBAjs1GG1Yoo6jN+DD3YYT15plmFPjRjcB0QNm71g/YRD2F/BuI8
BEVIHdDl3elWVXORfCbEOdU4Bq3OkQ7X3c5gJlWRS6+Xa89ojOEsrLnSRgpaue5b
Ua+9OTwE9tpSpjQKK4b0cNNdW0UXove7I41mPh778HFmKJ5UJjoE5d8580+RcVoS
pbcdy/Q/0mKovupFOeJ+8dKbwncI6uOKhRxhT3UqBIbJIMksoF1se1j0efFsCVFy
JJ31Dwh2IuMbDmnP/huye4NEh43TbuHc86ZE6g2ciq/cI6jZLwszU9QrDcmZxMA=
=yQQ1
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
