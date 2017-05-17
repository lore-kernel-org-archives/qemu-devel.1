Received: from eggs.gnu.org ([2001:4830:134:3::10]:47422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB1Ob-0001dy-KQ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB1OY-0005gE-IV
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dB1OY-0005fa-AH
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:01:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F4C27F4A0
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:01:48 +0000 (UTC)
References: <20170517153812.21993-1-quintela@redhat.com>
	<20170517153812.21993-6-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d6af160-aba9-c73d-90fb-5e0433638244@redhat.com>
Date: Wed, 17 May 2017 11:01:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170517153812.21993-6-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JneLDmacX9c6GA8isPAkXxo1B9FHPgvxO"
Subject: Re: [Qemu-devel] [PATCH 5/5] block migration: Allow compile time
 disable
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
--JneLDmacX9c6GA8isPAkXxo1B9FHPgvxO
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com,
 armbru@redhat.com
Message-ID: <8d6af160-aba9-c73d-90fb-5e0433638244@redhat.com>
Subject: Re: [PATCH 5/5] block migration: Allow compile time disable
References: <20170517153812.21993-1-quintela@redhat.com>
 <20170517153812.21993-6-quintela@redhat.com>
In-Reply-To: <20170517153812.21993-6-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 10:38 AM, Juan Quintela wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Many users now prefer to use drive_mirror over NBD as an
> alternative to the older migrate -b option; drive_mirror is
> more complex to setup but gives you more options (e.g. only
> migrating some of the disks if some of them are shared).
>=20
> Allow the large chunk of block migration code to be compiled
> out for those who don't use it.
>=20
> Based on a downstream-patch we've had for a while by Jeff Cody.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  configure                 | 11 +++++++++++
>  include/migration/block.h | 24 +++++++++++++++++++++++-
>  migration/Makefile.objs   |  2 +-
>  migration/migration.c     | 13 +++++++++++++
>  4 files changed, 48 insertions(+), 2 deletions(-)

> @@ -763,6 +768,14 @@ void qmp_migrate_set_capabilities(MigrationCapabil=
ityStatusList *params,
>      }
> =20
>      for (cap =3D params; cap; cap =3D cap->next) {
> +#ifndef CONFIG_LIVE_BLOCK_MIGRATION
> +        if (cap->value->capability =3D=3D MIGRATION_CAPABILITY_BLOCK) =
{
> +            error_setg(errp, "QEMU compiled without old-style (blk/-b,=
 inc/-i) "
> +                       "block migration");
> +            error_append_hint(errp, "Use drive_mirror+NBD instead.\n")=
;
> +            continue;
> +        }
> +#endif

If I'm not mistaken, this will cause an unconditional error even if I do
the QMP { "command":"migrate", "arguments":{"uri":"...", "blk":false} }

Wouldn't it be better to make the conditional:

if (cap->value->capability =3D=3D MIGRATION_CAPABILITY_BLOCK &&
cap->value->state) {

so that I can pass an explicit false, and the error only happens when
trying to set the optional parameter to true?  I ask, because libvirt
(currently) ALWAYS passes the "inc" and "blk" QMP parameters, but
generally to an explicit false when it uses NBD+mirror.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JneLDmacX9c6GA8isPAkXxo1B9FHPgvxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHHPjAAoJEKeha0olJ0NqSooH/3m/L6epVCBgtZUVXXQXf74v
OTl16EWEd1dRPty6JVguJYIMwUE2h81N6DmBKledG228wA9yr9NieGoS3Am0P/Xq
1cHDLiiH1o3dlQtH+mYZPz86wUCnPeu9KoV48B1HKLDwCSaz4eeWICaajVC21AJT
rIeEymQ3reKw2I28OnG5P7kJ2hfAmXm0xeLIrD80Zl4SaeDaJ6jzLSrFNjxU0i1y
tr+eRXN4H7dD9Xhr8vPgnNVrE0ElVDyguNOqGnQYa6ZrroW/4SEoyz0+Pv2q8ndA
xIw/AY8y7/Xv2/mHMtb3QJxVDKsacYYMBun6gz6+xwkcyzzgS2x5wmQfF2SfVBU=
=9D7+
-----END PGP SIGNATURE-----

--JneLDmacX9c6GA8isPAkXxo1B9FHPgvxO--
