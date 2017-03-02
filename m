Received: from eggs.gnu.org ([2001:4830:134:3::10]:49688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjZUJ-000628-Ay
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjZUI-0005ay-CM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:46:19 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be25a2d0-a351-e2a9-a753-5c73b44b3eaf@redhat.com>
Date: Thu, 2 Mar 2017 16:46:08 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GVEKhc9ApGi2WJv2VQQ2Dr6XkAMxNPhlw"
Subject: Re: [Qemu-devel] [PATCH 01/15] sheepdog: Defuse time bomb in
 sd_open() error handling
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
--GVEKhc9ApGi2WJv2VQQ2Dr6XkAMxNPhlw
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <be25a2d0-a351-e2a9-a753-5c73b44b3eaf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/15] sheepdog: Defuse time bomb in
 sd_open() error handling
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:43 PM, Markus Armbruster wrote:
> When qemu_opts_absorb_qdict() fails, sd_open() closes stdin, because
> sd->fd is still zero.  Fortunately, qemu_opts_absorb_qdict() can't
> fail, because:
>=20
> 1. it only fails when qemu_opt_parse() fails, and
> 2. the only member of runtime_opts.desc[] is a QEMU_OPT_STRING, and
> 3. qemu_opt_parse() can't fail for QEMU_OPT_STRING.
>=20
> Defuse this ticking time bomb by jumping behind the file descriptor
> cleanup on error.
>=20
> Also do that for the error paths where sd->fd is still -1.  The file
> descriptor cleanup happens to do nothing then, but let's not rely on
> that here.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20

>      s->fd =3D get_sheep_fd(s, errp);
>      if (s->fd < 0) {
>          ret =3D s->fd;
> -        goto out;
> +        goto out_no_fd;
>      }

Thanks to this change...

> =20
>      ret =3D find_vdi_name(s, vdi, snapid, tag, &vid, true, errp);
> @@ -1472,6 +1472,7 @@ out:
>      if (s->fd >=3D 0) {

=2E..this 'if' is now always true, and you can unconditionally call
closesocket().

For that matter, the 'out:' label is a bit of a misnomer, since it is
only reached on errors.

>          closesocket(s->fd);
>      }
> +out_no_fd:
>      qemu_opts_del(opts);
>      g_free(buf);
>      return ret;
>=20

The cleanup is correct, but looks like it can be more extensive.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GVEKhc9ApGi2WJv2VQQ2Dr6XkAMxNPhlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuKCwAAoJEKeha0olJ0NqFYwH/1riyBLxjaUMWE0clVcZ+Btf
38gBowu56lm6CxI/Qd9WmlsVaXZhCFV48sOSkk3hm1f250aw7+1jnLkkhEk/WWqp
fNFJmpwbfWbJ1dkaehEc0Urqe7yR/RaQ7L+1X6NgbcckRYQXdhkomksxlNrUG/FT
d8X1VvCD4kkQBWw1NmseMLSQGAZMK4FIAxt/Wc9PeDopJWfULXuKIkY2rEqgVWOH
boVePTfKrThFCrU/H7KfjREDLQ3dJUz4yQbOOqMm76vj093MioMDL+HYjfGZlY/c
52/Lee318CnGph2qliLD+nDpkNl8yZJ7Wt0QXT/hMlZa8tPK8I31B5WUiNE18j4=
=LNBy
-----END PGP SIGNATURE-----

--GVEKhc9ApGi2WJv2VQQ2Dr6XkAMxNPhlw--
