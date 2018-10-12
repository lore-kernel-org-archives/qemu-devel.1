Received: from eggs.gnu.org ([2001:4830:134:3::10]:56884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAyk1-0004CB-1u
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAyjw-0004UY-2f
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:48:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gAyjr-0004N8-9j
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:48:29 -0400
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-4-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ed7db5e9-142d-7ab9-0b3a-969490b0099a@redhat.com>
Date: Fri, 12 Oct 2018 16:48:23 +0200
MIME-Version: 1.0
In-Reply-To: <1535739372-24454-4-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9fWasUs7O3jpi0wAX0bdrRNariRfpLVTI"
Subject: Re: [Qemu-devel] [PATCH v3 3/8] block: Null pointer dereference in
 blk_root_get_parent_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9fWasUs7O3jpi0wAX0bdrRNariRfpLVTI
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Message-ID: <ed7db5e9-142d-7ab9-0b3a-969490b0099a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/8] block: Null pointer dereference in
 blk_root_get_parent_desc()
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
 <1535739372-24454-4-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-4-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 31.08.18 20:16, Liam Merwick wrote:
> The dev_id returned by the call to blk_get_attached_dev_id() in
> blk_root_get_parent_desc() can be NULL (an internal call to
> object_get_canonical_path may have returned NULL) so it should
> be checked before dereferencing.
>=20
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
> ---
>  block/block-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index fa120630be83..210eee75006a 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -136,7 +136,7 @@ static char *blk_root_get_parent_desc(BdrvChild *ch=
ild)
>      }
> =20
>      dev_id =3D blk_get_attached_dev_id(blk);
> -    if (*dev_id) {
> +    if (dev_id && *dev_id) {
>          return dev_id;

I rather think that blk_get_attached_dev_id() needs attention first.  It
returns an explicitly empty string if blk->dev is NULL.  If NULL was a
valid return value, it should just return NULL there.

Besides this caller, there are two callers that pass the dev_id to
qapi_event_send_device_tray_moved().  Now in practice that allows the
string to be NULL, but there is a comment in visit_type_str() that says
one should not pass NULL.

So it's either changing blk_get_attached_dev_id() to return NULL when
there is no valid ID (instead of the empty string, and then we could
save ourselves the check "*dev_id" here and elsewhere), but then we have
to fix all callers.

Or we make it return an empty string if object_get_canonical_path()
returned NULL.

Max

>      } else {
>          /* TODO Callback into the BB owner for something more detailed=
 */
>=20



--9fWasUs7O3jpi0wAX0bdrRNariRfpLVTI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvAtDcACgkQ9AfbAGHV
z0D/SggAvUQJXh0GlT1OyK1NphKEvpA9F6258ghD75lg3fiRG4pCuWfT8ynzNN8E
bmikhK0axy4FhXheDhagLAN9pYbEmKHwGSh3dxRwHYntfJDVF6lFT44THZObiNVJ
26OYwj+A4AOL/D9eMuo3/aAYxOSRA/UCnRYN1EASOfpCg9LZG7SKVqfiOTt4hbkH
q418VihH1OX9Ot9JDM4ukgpz2XFcLSlad8SweontPJnTSUbg8BGj21TjD/fTU7tb
LOeQH+YLM8lgpaQRq6bZaZtgElHxvYo/NPtihMK798JMRMpd2eMOd4Pzjtlv773v
cQlzCTv1hRtsjf+9O9zExKZHgFZ9IQ==
=fFr4
-----END PGP SIGNATURE-----

--9fWasUs7O3jpi0wAX0bdrRNariRfpLVTI--
