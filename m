Received: from eggs.gnu.org ([2001:4830:134:3::10]:49341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7M1-0002T9-FY
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7M0-0003Ja-AY
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:26:57 -0400
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-4-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a8e53307-8465-0471-2c50-cdab30bd5375@redhat.com>
Date: Tue, 25 Jul 2017 16:26:45 -0500
MIME-Version: 1.0
In-Reply-To: <1500993699-19299-4-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TXgLpQ13EDjCAgfcNgiGaR7drvd6A11jm"
Subject: Re: [Qemu-devel] [PATCH V5 03/10] block/qcow2: parse compress
 create options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TXgLpQ13EDjCAgfcNgiGaR7drvd6A11jm
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <a8e53307-8465-0471-2c50-cdab30bd5375@redhat.com>
Subject: Re: [PATCH V5 03/10] block/qcow2: parse compress create options
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
 <1500993699-19299-4-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-4-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 09:41 AM, Peter Lieven wrote:
> this adds parsing and validation for the compress create
> options. They are only validated but not yet used.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2.c             | 86 +++++++++++++++++++++++++++++++++++++++=
++++++--
>  include/block/block_int.h | 39 +++++++++++----------
>  2 files changed, 105 insertions(+), 20 deletions(-)
>=20

> +static void
> +qcow2_check_compress_settings(Qcow2Compress *compress, Error **errp)
> +{
> +    if (compress->format =3D=3D QCOW2_COMPRESS_FORMAT_DEFLATE) {
> +        if (!compress->u.deflate.has_level) {
> +            compress->u.deflate.has_level =3D true;
> +            compress->u.deflate.level =3D 0;
> +        }
> +        if (compress->u.deflate.level > 9) {
> +            error_setg(errp, "Compress level %" PRIu8 " is not support=
ed for"
> +                       " format '%s'", compress->u.deflate.level,
> +                       Qcow2CompressFormat_lookup[compress->format]);
> +            return;
> +        }
> +        if (!compress->u.deflate.has_window_size) {
> +            compress->u.deflate.has_window_size =3D true;
> +            compress->u.deflate.window_size =3D 15;

Maybe for 2.11 we should finally get around to adding parameter defaults
directly in QMP (you would then not need a has_FOO for any parameter FOO
that can specify its own default).  Not your problem to solve, though.

> +        }
> +        if (compress->u.deflate.window_size < 8 ||
> +            compress->u.deflate.window_size > 15) {
> +            error_setg(errp, "Compress window size %" PRIu8 " is not s=
upported"
> +                       " for format '%s'", compress->u.deflate.window_=
size,
> +                       Qcow2CompressFormat_lookup[compress->format]);

Should we allow a window_size of 0 in the UI (meaning pick a sane
non-zero default)?  It's odd that you allow 0 for level but not for
window-size.

> +            return;
> +        }
> +    }
> +}

Dead return statement, since the end of the function occurs anyways.
But arguably it helps future maintenance if more tests were to be added
later?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TXgLpQ13EDjCAgfcNgiGaR7drvd6A11jm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3t5UACgkQp6FrSiUn
Q2r6jQf+OGvj9Fksd7UeuN4JzNHA6HsitIZYnBJ90kHhQVLqlSBjjLYzg2r6USvW
G5YoEsjIs7chidP2+imp0s0/wU753xXpAumJJucOAKtxyvivm8oa61LYETLZzXov
Win6cjPCODUj7cdwDY9LgGDkNHxz44uHxkuToqoWLjhjwTnOuo6QJdgxOK2jcjgA
aIAnJeitU6VeOlw/Pp6DJlk5nQKrsP4WiDOX7z+9CfkknV+GiFhmujyiUBDm81CQ
JdKNNznbX8Uz4MCnXpsxyLzOyFvbaGpm8RWcPzSP5j3lPeB1KGSl/bkhD5GRggEF
rmDXG9QXrBLDPW0SyVul4XQNRIp5WA==
=Tzsr
-----END PGP SIGNATURE-----

--TXgLpQ13EDjCAgfcNgiGaR7drvd6A11jm--
