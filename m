Received: from eggs.gnu.org ([2001:4830:134:3::10]:44266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB1FT-0003HB-0B
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB1FP-0002KL-Rm
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:52:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dB1FP-0002K9-Ii
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:52:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5413B6556
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 15:52:22 +0000 (UTC)
References: <20170517153812.21993-1-quintela@redhat.com>
	<20170517153812.21993-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2c957f44-3318-0f99-6f6e-936df2bce154@redhat.com>
Date: Wed, 17 May 2017 10:52:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170517153812.21993-3-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CiwkIB1Q6uLWBRbMdsaXLkuPmebDjr6Xc"
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CiwkIB1Q6uLWBRbMdsaXLkuPmebDjr6Xc
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com,
 armbru@redhat.com
Message-ID: <2c957f44-3318-0f99-6f6e-936df2bce154@redhat.com>
Subject: Re: [PATCH 2/5] migration: Create block capability
References: <20170517153812.21993-1-quintela@redhat.com>
 <20170517153812.21993-3-quintela@redhat.com>
In-Reply-To: <20170517153812.21993-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 10:38 AM, Juan Quintela wrote:
> Create one capability for block migration and one parameter for
> incremental block migration.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> ---
>=20
> @@ -1207,6 +1242,26 @@ void qmp_migrate(const char *uri, bool has_blk, =
bool blk,
>          return;
>      }
> =20
> +    if (((has_blk && blk) || (has_inc && inc))
> +        && (migrate_use_block() || migrate_use_block_incremental())) {=

> +        error_setg(errp, "Command options are incompatible with curren=
t "
> +                   "migration capabilities");
> +        return;
> +    }
> +
> +    if ((has_blk && blk) || (has_inc & inc)) {
> +        migrate_set_block_enabled(true, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +        s->must_remove_block_options =3D true;
> +    }

You wrote:
if (A && B) {
  error;
}
if (A) {
  stuff;
}

I might have done:

if (A) {
  if (B) {
    error;
  }
  stuff;
}

but it's the same either way.


> +++ b/qapi-schema.json
> @@ -894,11 +894,18 @@
>  # @release-ram: if enabled, qemu will free the migrated ram pages on t=
he source
>  #        during postcopy-ram migration. (since 2.9)
>  #
> +# @block: If enabled, QEMU will also migrate the contents of all block=

> +#          devices.  Default is disabled.  A possible alternative are

s/are/uses/

> +#          mirror jobs to a builtin NBD server on the destination, whi=
ch
> +#          are more flexible.

s/are more flexible/offers more flexibility/

> +#          (Since 2.10)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m'] }
> +           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m',
> +           'block' ] }
> =20

The grammar touchups can be done in preparing the pull request, if there
is no other reason for a respin.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CiwkIB1Q6uLWBRbMdsaXLkuPmebDjr6Xc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHHGrAAoJEKeha0olJ0NqdFUIAIWF8/+IJA1DY9bwRDxV+PJL
1BrCp6xJAYNnzv1oCFXCdXUD9dEA7qn+gajbIIHjvMP1YVMkKG8hUeZX2h7yKDFQ
Qw2zyG+p+Igw/PJ4XSSSOknljbsz+01Y04chMx7T8yag2vtjv9aeJPsl8Z8xKMUi
0dCFsTV59db39087X8VLo4+AxO6xxXHpkmHo655whnaHLTt/qsFe3PRwUxuroyTP
Ih01xPUsAiDycd8pAgtAxCmNz5tpB9nHYQtw7lsLyjV+4yLonPHKM0jKqcF/xBMP
gj5JGq2dChie4HjIUDaYPcSg1E4WMNQ0ytdwOoVy1LTriLRecZ5KlDTKm4t9e0s=
=HOaz
-----END PGP SIGNATURE-----

--CiwkIB1Q6uLWBRbMdsaXLkuPmebDjr6Xc--
