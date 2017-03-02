Received: from eggs.gnu.org ([2001:4830:134:3::10]:58492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjaCz-000085-2e
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjaCy-0001pc-7B
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:32:29 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d4d7ef14-2b0b-e8f3-69f3-9a2b9e81bd39@redhat.com>
Date: Thu, 2 Mar 2017 17:32:20 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nNhooLQRitRlB0MXmRgk78qiwsJ91Jird"
Subject: Re: [Qemu-devel] [PATCH 06/15] sheepdog: Don't truncate long VDI
 name in _open(), _create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nNhooLQRitRlB0MXmRgk78qiwsJ91Jird
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <d4d7ef14-2b0b-e8f3-69f3-9a2b9e81bd39@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/15] sheepdog: Don't truncate long VDI name
 in _open(), _create()
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:43 PM, Markus Armbruster wrote:
> sd_parse_uri() truncates long VDI names silently.  Reject them
> instead.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index deb110e..72a52a6 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -985,7 +985,9 @@ static int sd_parse_uri(BDRVSheepdogState *s, const=
 char *filename,
>          ret =3D -EINVAL;
>          goto out;
>      }
> -    pstrcpy(vdi, SD_MAX_VDI_LEN, uri->path + 1);
> +    if (g_strlcpy(vdi, uri->path + 1, SD_MAX_VDI_LEN) >=3D SD_MAX_VDI_=
LEN) {
> +        goto out;
> +    }

Does this need to set ret? Maybe to -EINVAL?

> =20
>      qp =3D query_params_parse(uri->query);
>      if (qp->n > 1 || (s->is_unix && !qp->n) || (!s->is_unix && qp->n))=
 {
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nNhooLQRitRlB0MXmRgk78qiwsJ91Jird
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuKuEAAoJEKeha0olJ0NqW5YH/i/Da/gF9qGcWSmB0GkhRh93
rKxTaeZjEhmTWMT8AE55pA7Rs2x7pDa6MtSMY1Ut++HCVl7bC1EuZg04kCsC2PuR
VEX7WM06v8Wgfbisig8dUbMsDiYI5QnzCrwKuDxyMaBXiJ/PVBATaqxsiC8QWOB3
cwho6LGHR9PjxrT6jVJQF1tH5B7SUoN9gm1lKEXG6kxwiDHbelsb7vkEH247DdOE
cW4yep+PK5EMnmRSgVcYtBw8kdSbTusshXZs2iufGhmj+/EZnl8pMcQ5S+/srlC2
AddOhYRxd4IVmTiuql4krkPF5XBOUyKmxdceNvhM7jiHOTOa3EBZ50J6HLZdMZw=
=iVc1
-----END PGP SIGNATURE-----

--nNhooLQRitRlB0MXmRgk78qiwsJ91Jird--
