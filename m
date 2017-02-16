Received: from eggs.gnu.org ([2001:4830:134:3::10]:48806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceOfR-0001Fj-F4
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceOfN-0006Ul-EU
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:12:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ceOfN-0006Ug-5P
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:12:21 -0500
References: <20170215101427.23736-1-eduardo.otubo@profitbricks.com>
	<20170215101427.23736-2-eduardo.otubo@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39c05fd9-af3c-5ef7-72c0-f8d9492fda56@redhat.com>
Date: Thu, 16 Feb 2017 10:12:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170215101427.23736-2-eduardo.otubo@profitbricks.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OgukDecTdUBbMme1soNwXDKWCFx1bQ3O0"
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp/hmp: add writeconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <eduardo.otubo@profitbricks.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OgukDecTdUBbMme1soNwXDKWCFx1bQ3O0
From: Eric Blake <eblake@redhat.com>
To: Eduardo Otubo <eduardo.otubo@profitbricks.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com
Message-ID: <39c05fd9-af3c-5ef7-72c0-f8d9492fda56@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp/hmp: add writeconfig
References: <20170215101427.23736-1-eduardo.otubo@profitbricks.com>
 <20170215101427.23736-2-eduardo.otubo@profitbricks.com>
In-Reply-To: <20170215101427.23736-2-eduardo.otubo@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 04:14 AM, Eduardo Otubo wrote:
> This patch adds support for the command `writeconfig' on the QMP and HM=
P
> consoles. This is a simple way to keep track of current state of VM
> after series of hotplugs and/or hotunplugs of different devices:
>=20
>   (qemu) writeconfig qemu.conf
>=20
> Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> ---

> +++ b/qapi-schema.json
> @@ -4696,6 +4696,26 @@
>    'data': { 'keys': ['KeyValue'], '*hold-time': 'int' } }
> =20
>  ##
> +# @writeconfig:
> +#
> +# Write config to file.
> +#
> +# @filename: the path of a new file to store the current config
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 2.7.0
> +#

You've missed 2.7 by two releases.  This should be 2.9.


> +++ b/ui/console.c

> =20
> +void qmp_writeconfig(const char *filename, Error **errp)
> +{
> +    if (filename =3D=3D NULL) {
> +        error_setg(errp, "You must specify a filename.");
> +        return;
> +    }

Dead code; QAPI ensures that filename is non-NULL.
Even if it weren't dead code, error_setg() messages should not end in '.'=
=2E

> +
> +    FILE *fp;
> +    fp =3D fopen(filename, "w");

Please use qemu_fopen() - that way, the caller can also use qemu's magic
/dev/fdset to write to a pre-opened fd even when qemu itself can't
open() the file.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--OgukDecTdUBbMme1soNwXDKWCFx1bQ3O0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpc9iAAoJEKeha0olJ0NqOY8H/R02/gV6yxEmIg4zJMlR2iPX
8oEab5iaZSY2t4ONK/SdFA+y03KQ/HOcGEYxSNrydtjhV+odaiOQLD44yW0dRDq1
tYzr89u4YJN0uvx+7Ry1KTCPzLV09o/9tO9W+HMXKcsir5+3/ya2RKuY1qZjNOYC
MY3a9YwU4piZP7rh91DA07CxMU6KfzH75qSHlR1qwL2skWwbTjInBrgWNXqK8tCk
+8eNxZZm1VktfXYmPpcdrSrDQMznmBdBiZ6+bwToV6sD1En8jTcL1FmUOZJh41TG
tSECJQUR/2h4YyZvYMlyU3oqvIAkkqPL1gS+WO72Q1CbazPmm+cbs+lxPsqwO0Q=
=Czlt
-----END PGP SIGNATURE-----

--OgukDecTdUBbMme1soNwXDKWCFx1bQ3O0--
