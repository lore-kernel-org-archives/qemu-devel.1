Received: from eggs.gnu.org ([2001:4830:134:3::10]:40504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGoIo-0002l0-Vi
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGoIl-0001kj-08
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGoIk-0001kW-Ng
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:15:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE1CDC04B948
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 15:15:44 +0000 (UTC)
References: <20170601220813.30535-1-quintela@redhat.com>
	<20170601220813.30535-4-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d275b7f-5f31-0f41-21e4-4d1abe96d7f7@redhat.com>
Date: Fri, 2 Jun 2017 10:15:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170601220813.30535-4-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CWfXwcR8D3eXSHRfFcuRCnmL9sUavepj7"
Subject: Re: [Qemu-devel] [PATCH 3/5] migration: Print statistics about the
 number of remaining target pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CWfXwcR8D3eXSHRfFcuRCnmL9sUavepj7
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <6d275b7f-5f31-0f41-21e4-4d1abe96d7f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] migration: Print statistics about the
 number of remaining target pages
References: <20170601220813.30535-1-quintela@redhat.com>
 <20170601220813.30535-4-quintela@redhat.com>
In-Reply-To: <20170601220813.30535-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 05:08 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 4 +++-
>  migration/ram.c       | 4 ++--
>  migration/ram.h       | 2 +-
>  qapi-schema.json      | 6 +++++-
>  4 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index ea3d41c..2c13217 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -518,7 +518,9 @@ static void populate_ram_info(MigrationInfo *info, =
MigrationState *s)
>      }
> =20
>      if (s->state !=3D MIGRATION_STATUS_COMPLETED) {
> -        info->ram->remaining =3D ram_bytes_remaining();
> +        info->ram->remaining_pages =3D ram_pages_remaining();
> +        info->ram->remaining =3D ram_pages_remaining() *
> +            qemu_target_page_size();

Why not the opposite direction, of:

info->ram->remaining_pages =3D ram_bytes_remaining() /
qemu_target_page_size();
info->ram->remaining =3D ram_bytes_remaining();

?

> +++ b/migration/ram.h
> @@ -41,7 +41,7 @@ uint64_t xbzrle_mig_pages_cache_miss(void);
>  double xbzrle_mig_cache_miss_rate(void);
>  uint64_t xbzrle_mig_pages_overflow(void);
>  uint64_t ram_bytes_transferred(void);
> -uint64_t ram_bytes_remaining(void);
> +uint64_t ram_pages_remaining(void);
>  uint64_t ram_dirty_sync_count(void);
>  uint64_t ram_dirty_pages_rate(void);
>  uint64_t ram_postcopy_requests(void);

I know we already have a mishmash of which interfaces are byte-based vs.
page-based, but using byte-based everywhere seems like a better goal,
and this feels like we are going backwards from that goal.

> diff --git a/qapi-schema.json b/qapi-schema.json
> index 4b50b65..ff1c048 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -601,6 +601,9 @@
>  # @page-size: The number of bytes per page for the various page-based
>  #        statistics (since 2.10)
>  #
> +# @remaining-pages: amount of pages remaining to be transferred to the=
 target VM
> +#        (since 2.10)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationStats',
> @@ -608,7 +611,8 @@
>             'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
>             'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
>             'mbps' : 'number', 'dirty-sync-count' : 'int',
> -           'postcopy-requests' : 'int', 'page-size' : 'int' } }
> +           'postcopy-requests' : 'int', 'page-size' : 'int',
> +           'remaining-pages' : 'int' } }

We already have 'remaining'; why do we need a redundant stat
'remaining-pages'?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CWfXwcR8D3eXSHRfFcuRCnmL9sUavepj7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMYEdAAoJEKeha0olJ0NqvhEIAJJFtxQlvqZgRbXWxuRDodqt
vpZjG7NbvwRw03fDsniHBX2SLD9AemAD5P9w0lcEClIwDI1wcBcDLigax6UyJ9ZH
bD4QOzJcpLc1tdKCxnqXG0YNru4RNYPBTOXlDbYuAuyg9MKI0ffSOO/bwraTxcrZ
6Wpyu2LJe6VvblV7mfigRwZv+RsCHTwcLnnpJlgAS0xTSk+kB+XWtzEQF4D1X7lL
MPTrlC8gRBkH2qK40o252CjpMD0ZZ5TTnE5zvY74foTckLfobZhGKjfwwI5xPXQs
6LqRcSYwh8JWY93t9ImG3kxwzccYEPgoLYm6DL8aNzuUAiImmbHpvzd8OcMNOLg=
=Q/kA
-----END PGP SIGNATURE-----

--CWfXwcR8D3eXSHRfFcuRCnmL9sUavepj7--
