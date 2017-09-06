Received: from eggs.gnu.org ([2001:4830:134:3::10]:45704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpczZ-0008N6-N9
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpczT-0003y6-W1
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:15:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpczT-0003xc-Mo
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:15:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A901D81E18
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 16:15:46 +0000 (UTC)
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-8-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <265f10bb-5718-aaac-d0fe-595a78acdf46@redhat.com>
Date: Wed, 6 Sep 2017 11:15:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170906115143.27451-8-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P6pWfS71U3gIs8g9ITrqOOgPm7FHln6M7"
Subject: Re: [Qemu-devel] [PATCH v7 07/22] migration: Make
 migrate_fd_error() the owner of the Error
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
--P6pWfS71U3gIs8g9ITrqOOgPm7FHln6M7
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <265f10bb-5718-aaac-d0fe-595a78acdf46@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 07/22] migration: Make migrate_fd_error()
 the owner of the Error
References: <20170906115143.27451-1-quintela@redhat.com>
 <20170906115143.27451-8-quintela@redhat.com>
In-Reply-To: <20170906115143.27451-8-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 06:51 AM, Juan Quintela wrote:
> So far, we had to free the error after each caller, so just do it
> here.  Once there, tls.c was leaking the error.

You mention tls.c,

>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/channel.c   |  1 -
>  migration/migration.c | 10 ++++------
>  migration/migration.h |  4 ++--
>  migration/socket.c    |  1 -
>  4 files changed, 6 insertions(+), 10 deletions(-)

but don't touch it.  Am I missing something?

> =20
> -void migrate_fd_error(MigrationState *s, const Error *error)
> +void migrate_fd_error(MigrationState *s, Error *error)
>  {

No comments at definition,

> +++ b/migration/migration.h
> @@ -163,8 +163,8 @@ bool  migration_has_all_channels(void);
> =20
>  uint64_t migrate_max_downtime(void);
> =20
> -void migrate_set_error(MigrationState *s, const Error *error);
> -void migrate_fd_error(MigrationState *s, const Error *error);
> +void migrate_set_error(MigrationState *s, Error *error);
> +void migrate_fd_error(MigrationState *s, Error *error);

or at declaration. That would be worth adding at some point, but this
patch isn't making it worse.

The code looks okay in isolation, so if it is only the commit message
that needs fixing,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--P6pWfS71U3gIs8g9ITrqOOgPm7FHln6M7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwHxsACgkQp6FrSiUn
Q2os5Qf+M4sxox+kj9NDfDOd92KEFza5MflFsP3u3yvhRR8HA4NnqBwphJYR03vs
HUCtkEGaMtgknDdHEOQ1BmFydw4A6+b//7uoMH/jUVTp6zKZukHCwNxsx092dAYk
8LES8Ujxhu4Qdw809h64O9qezF0uzZNV6f+cyTTvnOobtSoAOO4csp/0lgmU0UTx
eMGlRHsnlSxBYyFBbGyf3lkUKpAeFSUpVMyUNhD0hzM4CCY8Yufx94dMJrcXfDNY
gUkrdciX+1kq0mJ0v0PVOBHWFP8pTyTpuF7BZha+KO8+kAwkWi5tc1uSSvZBp1Im
1o41+IwVgXU2T7cTAAQug/C2fIKLVg==
=qiWJ
-----END PGP SIGNATURE-----

--P6pWfS71U3gIs8g9ITrqOOgPm7FHln6M7--
