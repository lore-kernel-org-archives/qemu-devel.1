Received: from eggs.gnu.org ([2001:4830:134:3::10]:33805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG3Ah-0001hd-Jc
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG3Ag-0000J7-UH
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:56:19 -0400
Date: Wed, 31 May 2017 13:56:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531125611.GC16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-29-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l21Zc9uzwusa2dXo"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-29-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 28/29] qed: Use a coroutine
 for need_check_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--l21Zc9uzwusa2dXo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:09PM +0200, Kevin Wolf wrote:
> This fixes the last place where we degraded from AIO to actual blocking
> synchronous I/O requests. Putting it into a coroutine means that instead
> of blocking, the coroutine simply yields while doing I/O.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/qed.c b/block/qed.c
> index d3f7d0c..20e81a0 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -264,11 +264,23 @@ static void qed_unplug_allocating_write_reqs(BDRVQE=
DState *s)
>      qemu_co_enter_next(&s->allocating_write_reqs);
>  }
> =20
> -static void qed_clear_need_check(void *opaque, int ret)
> +static void qed_need_check_timer_entry(void *opaque)

Missing coroutine_fn.

--l21Zc9uzwusa2dXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLr1rAAoJEJykq7OBq3PIWlsH+waAF3jAzED2oEdBwVsKwZLW
gN/IHqu0g1m4c2GaTxpYdVjOuDQxlecI9jtzOyGq+fGLMp77cbttfWVZ7zAUhnYP
kmlWkY+p0O0YzeSgquYeJbOr6WT64kJiABh/14y4rL1aeQ/hbRQxXtCAVOZxtGm2
8as7BTDHyF5pibqXLfn84eb2S7E6WrjT8f0havQ3xOkj1Pw5c0Bb4dP3TBLX4gb8
0mSK5JjoSyOMBDpSLiEqvH03yiwHnKwcH6vaqRypyYVqDBjsp0iew8VZ85NZEkPa
GZn/T/paJUulOYy4OFca6GOJWn5eapobNf8rh4r6GZ+QFZGwvzuzDuN9tjTOss4=
=fq9j
-----END PGP SIGNATURE-----

--l21Zc9uzwusa2dXo--
