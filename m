Received: from eggs.gnu.org ([2001:4830:134:3::10]:36828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAHU3-0007da-Qz
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAHTz-00045D-7B
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:00:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAHTy-00044j-Te
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:00:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74BFAC05973C
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 15:00:21 +0000 (UTC)
References: <20170515140529.23264-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <52e7394a-627f-539c-9c13-8385cfceaf00@redhat.com>
Date: Mon, 15 May 2017 09:59:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170515140529.23264-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HXv2w8AbrqODjwjsnag8wXemPg5TTQDcc"
Subject: Re: [Qemu-devel] [PATCH v2] block migration: Allow compile time
 disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, kashyap@redhat.com, jcody@redhat.com, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HXv2w8AbrqODjwjsnag8wXemPg5TTQDcc
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, kashyap@redhat.com,
 jcody@redhat.com, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <52e7394a-627f-539c-9c13-8385cfceaf00@redhat.com>
Subject: Re: [PATCH v2] block migration: Allow compile time disable
References: <20170515140529.23264-1-dgilbert@redhat.com>
In-Reply-To: <20170515140529.23264-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 09:05 AM, Dr. David Alan Gilbert (git) wrote:
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
> ---
>  configure                 | 11 +++++++++++
>  include/migration/block.h | 23 +++++++++++++++++++++++
>  migration/Makefile.objs   |  2 +-
>  migration/migration.c     |  9 +++++++++
>  4 files changed, 44 insertions(+), 1 deletion(-)
>=20

> @@ -1400,6 +1405,7 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
>    libnfs          nfs support
>    smartcard       smartcard support (libcacard)
>    libusb          libusb (for usb passthrough)
> +  live-block-migration   Block migration in the main migration stream

Bummer that the long name breaks alignment. But I don't have any
bikeshed paint handy to suggest a shorter name.

> +++ b/migration/migration.c
> @@ -1213,6 +1213,15 @@ void qmp_migrate(const char *uri, bool has_blk, =
bool blk,
>      params.blk =3D has_blk && blk;
>      params.shared =3D has_inc && inc;
> =20
> +#ifndef CONFIG_LIVE_BLOCK_MIGRATION
> +    if (params.blk || params.shared) {
> +        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc=
/-i) "
> +                         "block migration");
> +        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
> +        return;
> +    }
> +#endif

Juan's pending series to simplify the representation of -b/-i may also
play a role here, particularly if we want to bite the bullet and change
the QMP command to drop the optional parameters altogether.

It may be worth documenting in the .json file (independently of whether
the configure option is used) that blk/inc are deprecated, and may be
removed in a future release, if we want to start the clock on removing th=
em.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HXv2w8AbrqODjwjsnag8wXemPg5TTQDcc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGcJcAAoJEKeha0olJ0Nq1vMIAK8R3yqZFdutP8N/eSEjr5hG
K0EwIIn/JqkbkXQVAsm2+Z8SLM7AOrP4M8tQ2uTKtsLVoxdVXD9UeXs7iUhn3bb1
RI5WtphnxR2Ng05jZiTyE4ResrReES6al14ErKO6Sfy4efZrGwOZEZV12shFN9xO
PUjBe2tP33zJW3CcPkBCffeg/VqcdpYLtffjYUUTYwfqdYpMfTxcn446OjJK3r8h
IX8IHWQ2d5cawjYsKwIdabs7fOudtATYkgt43s87UQefDrMUGsW1od/AuMdUANVD
6lt9AvtcxooGNxw4HasK5/e1WpMGPDHQdT5TEIaf6IkxsNslQDHhd3DSRItb390=
=bbGt
-----END PGP SIGNATURE-----

--HXv2w8AbrqODjwjsnag8wXemPg5TTQDcc--
