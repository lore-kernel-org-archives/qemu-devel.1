Received: from eggs.gnu.org ([2001:4830:134:3::10]:53776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlWU-00029q-Gp
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlWR-0007Wk-D2
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dQlWR-0007WH-4K
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:19:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 378D178EB1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 02:19:02 +0000 (UTC)
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-5-git-send-email-peterx@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
Date: Fri, 30 Jun 2017 04:18:56 +0200
MIME-Version: 1.0
In-Reply-To: <1498536619-14548-5-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SupiKOqQQlxGjIOBSPMq4J3IwlJ33CiEU"
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be
 a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SupiKOqQQlxGjIOBSPMq4J3IwlJ33CiEU
From: Max Reitz <mreitz@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be a
 qdev
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
 <1498536619-14548-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1498536619-14548-5-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-27 06:10, Peter Xu wrote:
> Let the old man "MigrationState" join the object family. Direct benefit=

> is that we can start to use all the property features derived from
> current QDev, like: HW_COMPAT_* bits, command line setup for migration
> parameters (so will never need to set them up each time using HMP/QMP,
> this is really, really attractive for test writters), etc.
>=20
> I see no reason to disallow this happen yet. So let's start from this
> one, to see whether it would be anything good.
>=20
> Now we init the MigrationState struct statically in main() to make sure=

> it's initialized after global properties are applied, since we'll use
> them during creation of the object.
>=20
> No functional change at all.

Evidently not quite right because this breaks iotest 055.

Condensed test case:

$ ./qemu-img create -f vmdk -o subformat=3DstreamOptimized foo.vmdk 64M
Formatting 'foo.vmdk', fmt=3Dvmdk size=3D67108864 compat6=3Doff
hwversion=3Dundefined subformat=3DstreamOptimized
$ x86_64-softmmu/qemu-system-x86_64 -drive if=3Dnone,file=3Dfoo.vmdk
qemu-system-x86_64: ./migration/migration.c:114: migrate_get_current:
Assertion `current_migration' failed.
[1]    15453 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64
-drive if=3Dnone,file=3Dfoo.vmdk

(It just worked before this patch.)

Max

> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/misc.h |  1 +
>  migration/migration.c    | 78 ++++++++++++++++++++++++++++++++++------=
--------
>  migration/migration.h    | 19 ++++++++++++
>  vl.c                     |  6 ++++
>  4 files changed, 81 insertions(+), 23 deletions(-)


--SupiKOqQQlxGjIOBSPMq4J3IwlJ33CiEU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVbUQEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQLn7
B/9lwWyiYj19JOXupXHhDb0l9Ys5J16e0HxFM/yakbieD0oGz+EjmjEE76n1SbsK
fh2ccpQzzctySmQKS2oHCgyBfNO8ysmqr2UnPR77L7ff1jPfDW4GWY+9QQhEhkpZ
ggeIt/KjGicopgpmrZxMAQcr+T9PMvQSxrfFeY6oXnLgb+75kbFNCLKB0yfyUvu6
N13GDyoQ7m7UOuB6deqwd309KXSHcnAWxSpDQya6gCB3gt6ibRmRJLZ519WqLR4J
eaWoUI/IbfbHx7QiPC+b34qIBqkvrC5o7kqiorIRbgNLhCtXVrSOmSS2Wzim7Z8g
v+3KTpm3i+5nfkT1RgBz9oAl
=namo
-----END PGP SIGNATURE-----

--SupiKOqQQlxGjIOBSPMq4J3IwlJ33CiEU--
