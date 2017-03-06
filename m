Received: from eggs.gnu.org ([2001:4830:134:3::10]:58066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cl034-0007cs-W9
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cl034-00031F-1T
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:20:06 -0500
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-10-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15283523-94bb-7310-6a27-5d50468c7320@redhat.com>
Date: Mon, 6 Mar 2017 15:19:58 -0600
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-10-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TsV4iP3hVsBhtg0IA9xgPcpVukWpUeeLR"
Subject: Re: [Qemu-devel] [PATCH 09/10] block: Handle permission errors in
 change_parent_backing_link()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TsV4iP3hVsBhtg0IA9xgPcpVukWpUeeLR
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <15283523-94bb-7310-6a27-5d50468c7320@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] block: Handle permission errors in
 change_parent_backing_link()
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
 <1488817322-11397-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-10-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:22 AM, Kevin Wolf wrote:
> Instead of just trying to change parents by parent over to reference @t=
o
> instead of @from, and abort()ing whenever the permissions don't allow
> this, do proper permission checking beforehand and pass any error to th=
e
> callers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 6 deletions(-)
>=20

> +    /* Now actually perform the change. We performed the permission ch=
eck for
> +     * all elements of @list at once, so set the permissions all at on=
ce at the
> +     * very end. */
> +    for (p =3D list; p !=3D NULL; p =3D p->next) {
> +        c =3D p->data;
> =20
>          bdrv_ref(to);
> -        /* FIXME Are we sure that bdrv_replace_child() can't run into
> -         * &error_abort because of permissions? */
> -        bdrv_replace_child(c, to, true);
> +        bdrv_replace_child_noperm(c, to);
>          bdrv_unref(from);

Looks awesome to get rid of a FIXME...

> @@ -2995,7 +3032,8 @@ void bdrv_replace_in_backing_chain(BlockDriverSta=
te *old, BlockDriverState *new)
> =20
>      bdrv_ref(old);
> =20
> -    change_parent_backing_link(old, new);
> +    /* FIXME Proper error handling */
> +    change_parent_backing_link(old, new, &error_abort);

=2E..until this shows we are merely trimming it down to one less instance=
,
but are still fighting the overall battle.  But we'll get there in the
end :)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TsV4iP3hVsBhtg0IA9xgPcpVukWpUeeLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvdJ+AAoJEKeha0olJ0NqdOIH/1OdwhITqRhHC0XXf7ZM+901
mT0wrW74Ryx4juJtucJ3QWYYGL3bC8VCRwrPYpFAQBIynOkE+DcxxNYtGdC3UVyE
hj0508l5mNSeR7OncEjFUUOI/u0Pzo0LUIT2Gk1/og6d//fOXCNILSEKcAFYK+sk
Srg1jEdod1bRHASJfXyebabV5lwRpeaQJJ9GfurSd09cM/yoPJ+N0aWhcf+Mic7A
1Us0ak3xfLINBJmijtqTudOkYlY/eKQVl1XVprdJeCaShNRfptjPe5RH0ZmaJ4vs
byWn8YoFDQVnX5jOLAlTVy+9wHa2lL6YdIkITsHoT59s3Yn1h/TFLnddzoe7T7Q=
=7cUk
-----END PGP SIGNATURE-----

--TsV4iP3hVsBhtg0IA9xgPcpVukWpUeeLR--
