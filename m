Received: from eggs.gnu.org ([2001:4830:134:3::10]:50218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXny-0000Vp-Lr
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnx-0001Ys-QF
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:45:02 -0500
Date: Tue, 31 Jan 2017 11:29:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131112926.GG18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-6-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-6-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 05/21] hbitmap: improve dirty iter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:48PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Make dirty iter resistant to resetting bits in corresponding HBitmap.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qemu/hbitmap.h | 24 ++----------------------
>  util/hbitmap.c         | 23 ++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
> index eb46475..2873a46 100644
> --- a/include/qemu/hbitmap.h
> +++ b/include/qemu/hbitmap.h
> @@ -243,10 +243,7 @@ void hbitmap_free(HBitmap *hb);
>   * the lowest-numbered bit that is set in @hb, starting at @first.
>   *
>   * Concurrent setting of bits is acceptable, and will at worst cause the
> - * iteration to miss some of those bits.  Resetting bits before the curr=
ent
> - * position of the iterator is also okay.  However, concurrent resetting=
 of
> - * bits can lead to unexpected behavior if the iterator has not yet reac=
hed
> - * those bits.
> + * iteration to miss some of those bits.  Resetting bits is also okay.
>   */
>  void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t fir=
st);

Do you need to modify hbitmap_iter_next_word() as well?  Otherwise it
uses the hbi->cur[] cached information and does not handle clearing bits
ahead of the iterator.

Stefan

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkHUWAAoJEJykq7OBq3PIU/IH/jz0Dac1oJ2e+fKSsksBE4ET
QKA6EB7ASZX06lcvl2gc1BWZ/mw6nc/WKnGcVuVwDo1GmLPxihue1UoIc98DuHRX
aTh7fyy/n97LG6eRz/Day6Z4+4nPXcGGSdLVMaV95a6awGCbREeI5Exyca1uXii5
ZH1BKjqVgG3C61TAig/IVWvh+fqzwk0HvDmLLTBAGzAXmdc7SPWZQMs08R2QM2Bm
jlQWKqKXxeNmBgh+tUEaEsjeKsmw3p2JMtrdCHkWyl9EcS4DYyKRStezAmiBWwWi
KieEzuoGTgdUxkJtWAmihXbGUHnBuQ4fXIeSPqOmBeVEyBaUMU+sFfvYcyjUIjI=
=kAsE
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
