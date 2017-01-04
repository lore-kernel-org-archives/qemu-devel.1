Received: from eggs.gnu.org ([2001:4830:134:3::10]:48798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOtg3-0003B5-7l
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOtg0-0007Kw-2H
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:04:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOtfz-0007K3-PZ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:04:55 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C250F3DFCC
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 22:04:55 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-14-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d424cbc-e81e-c51a-2220-adc9c6deeb73@redhat.com>
Date: Wed, 4 Jan 2017 16:04:53 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-14-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MdUDcChgLJ12B23oiAj1xx2mDCshoRkJi"
Subject: Re: [Qemu-devel] [PATCH 13/54] char: use error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MdUDcChgLJ12B23oiAj1xx2mDCshoRkJi
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <3d424cbc-e81e-c51a-2220-adc9c6deeb73@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/54] char: use error_report()
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-14-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-14-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Prefer error_report() over fprintf(stderr..)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> @@ -4130,17 +4130,20 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,=

>      }
> =20
>      if (is_help_option(qemu_opt_get(opts, "backend"))) {
> -        fprintf(stderr, "Available chardev backend types:\n");
> +        GString *str =3D g_string_new("");
>          for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
>              cd =3D backends[i];
>              if (cd) {
> -                fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->=
kind]);
> +                g_string_append_printf(str, "\n%s", ChardevBackendKind=
_lookup[cd->kind]);
>                  if (cd->alias) {
> -                    fprintf(stderr, "%s\n", cd->alias);
> +                    g_string_append_printf(str, "\n%s", cd->alias);
>                  }
>              }
>          }
> -        exit(!is_help_option(qemu_opt_get(opts, "backend")));
> +
> +        error_report("Available chardev backend types: %s", str->str);=

> +        g_string_free(str, true);
> +        exit(0);

I suppose the g_string_free() could be elided due to the pending exit(),
but it's fine to keep it for lint purposes.  Nice simplification of the
error status.

>      }
> =20
>      if (id =3D=3D NULL) {
> @@ -4255,8 +4258,8 @@ Chardev *qemu_chr_new(const char *label, const ch=
ar *filename)
>              qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
>          }
>          if (qemu_chr_replay(chr) && chr->driver->chr_ioctl) {
> -            fprintf(stderr,
> -                    "Replay: ioctl is not supported for serial devices=
 yet\n");
> +            error_report("Replay: ioctl is not supported "
> +                         "for serial devices yet");
>          }
>          replay_register_char_driver(chr);

Rather gross that we print the message but plow on anyways, but that's
not this patch's problem.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MdUDcChgLJ12B23oiAj1xx2mDCshoRkJi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbXGFAAoJEKeha0olJ0NqRyYIAIfy+c3qolnAMchylgbKUQm9
Eg1SQgrz1flucNoWj/lQP1c6NDKUuR83nQAN27h0kbBRI5k2laUVJof2tsN87kDV
QQu5kpOMDCeQPoLwc02fh9mpPqDRcRHi2loVCNKwpVNX4ao5VVkROe3aaGsxEGIN
5EB1gVM7m6aQ6RV9JnH7C93uNBHP9jfemwUp14bpaDwXYELoG4eOcUGdcjlGwvg9
unBYC/HmXwsYe8BT7bzHlNqgWT27y55QsarWlOH76lNW8M9xg3FNSH/QWZkOEBW9
v45UFbxXAG8AI09g0cyvAFXXxyJfBO4hd74UgVNDCZV7l8AaUfFxjUFvY1+NULQ=
=ePpi
-----END PGP SIGNATURE-----

--MdUDcChgLJ12B23oiAj1xx2mDCshoRkJi--
