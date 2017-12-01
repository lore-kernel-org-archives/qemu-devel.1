Received: from eggs.gnu.org ([2001:4830:134:3::10]:46767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKujX-0001dk-K3
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKujW-0008OY-Mi
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:28:39 -0500
References: <20171201224909.9373-1-klim.kireev@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c18c4367-e605-9deb-cbf9-d3fea4b631f5@redhat.com>
Date: Fri, 1 Dec 2017 17:28:29 -0600
MIME-Version: 1.0
In-Reply-To: <20171201224909.9373-1-klim.kireev@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NEinXnB4jcvA6d3DhaAdx0jRAxBhoTVS0"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: add the simplest format
 recognition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NEinXnB4jcvA6d3DhaAdx0jRAxBhoTVS0
From: Eric Blake <eblake@redhat.com>
To: Klim Kireev <klim.kireev@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <c18c4367-e605-9deb-cbf9-d3fea4b631f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: add the simplest format
 recognition
References: <20171201224909.9373-1-klim.kireev@virtuozzo.com>
In-Reply-To: <20171201224909.9373-1-klim.kireev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/01/2017 04:49 PM, Klim Kireev wrote:
> Now, if you type something like
>=20
> qemu-img create disk.qcow2 1G
> or
> qemu-img dd if=3D/dev/sda of=3Ddisk.qcow2
>=20
> it creates a raw image and if you need you should
> manually specify an image format with -f qcow2. It would
> be more convenient if it could be detected from an extension.
>=20
> This patch adds a simple heuristic to recognize the image format
> for qcow, qcow2, vmdk, vhdx, vdi
>=20
> It warns users about guessed format and informs them about '-f' option.=

>=20
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> ---
>  qemu-img.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 02a6e27beb..ac1adf1582 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -421,11 +421,22 @@ static int64_t cvtnum(const char *s)
>      return value;
>  }
> =20
> +static const char *get_format(const char *filename)
> +{
> +    const char *fmt =3D strrchr(filename, '.');
> +    if (fmt =3D=3D NULL || bdrv_find_format(++fmt) =3D=3D NULL) {
> +        fmt =3D "raw";
> +    }
> +    printf("!!! %s format was detected.\n"

Assumed, not detected.  (We didn't read the file, because we're creating
it; we're assuming a format based on the file name, not its contents,
and detection tends to imply a contents-based check).

> +           "!!! If you meant another format, specify it with -f.\n", f=
mt);

Not our usual error reporting style; the !!! is yelling at the user, and
we tend to avoid trailing '.'.  printf() goes to stdout, but the message
should go to stderr(); you really want to use warn_report().

I suggest:

warn_report("No format specified with -f, assuming %s.", fmt);

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NEinXnB4jcvA6d3DhaAdx0jRAxBhoTVS0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloh5Z0ACgkQp6FrSiUn
Q2oSMgf+Lh3x+Q4JDHfIgP9kLRxd+xTZl5B5dy4zc8ECEd2WdJsNcuPeyUBcbAHE
LRRZjgTMKZ8VcutsSGBJ9mpAR+fKqPUzV0DGMyXtciDzW74JwMbI+wHWOpEQSjqj
FTGClHo+QtuRBjMPIJxcYxtMXHhvvZ2QEUbSyC+RBdw0NMFOZWekegyL3EP+t8NJ
pnqeu0Kwtcgu1oSiBuhY187AvCk+Ty52GoBNv8/UlgIopfABbyIOO23WnXiM2Zmi
+iz69XCqPFec28OYkf96x2ERbS/p9CMmgC9B00Um69wDkJ19pCpLEytt0A21yPUC
F7S2mnE9ZkRuPVHhJJg2AiG250ZzNw==
=1syM
-----END PGP SIGNATURE-----

--NEinXnB4jcvA6d3DhaAdx0jRAxBhoTVS0--
