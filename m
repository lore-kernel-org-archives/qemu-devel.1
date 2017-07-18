Received: from eggs.gnu.org ([2001:4830:134:3::10]:47493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWWe-0002qW-1y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWWd-0005Iz-1J
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:43:12 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-10-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <52d3cf1a-1a1c-1f6f-f7e1-c794f5367097@redhat.com>
Date: Tue, 18 Jul 2017 12:42:46 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pssXxLNwbLQdQdepx6jIRn6FfhAac9J8A"
Subject: Re: [Qemu-devel] [PATCH for-2.10 09/10] migration: Unshare
 MigrationParameters struct for now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pssXxLNwbLQdQdepx6jIRn6FfhAac9J8A
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <52d3cf1a-1a1c-1f6f-f7e1-c794f5367097@redhat.com>
Subject: Re: [PATCH for-2.10 09/10] migration: Unshare MigrationParameters
 struct for now
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> Commit de63ab6 "migrate: Share common MigrationParameters struct"
> reused MigrationParameters for the arguments of
> migrate-set-parameters, with the following rationale:
>=20
>     It is rather verbose, and slightly error-prone, to repeat
>     the same set of parameters for input (migrate-set-parameters)
>     as for output (query-migrate-parameters), where the only
>     difference is whether the members are optional.  We can just
>     document that the optional members will always be present
>     on output, and then share a common struct between both
>     commands.  The next patch can then reduce the amount of
>     code needed on input.
>=20
> I need to unshare them to correct a design flaw in a stupid, but
> minimally invasive way, in the next commit.  We can restore the
> sharing when we redo that patch in a less stupid way.  Add a suitable
> TODO comment.
>=20
> Note that I revert only the sharing part of commit de63ab6, not the
> part that made the members of query-migrate-parameters' result
> optional.  The schema (and thus introspection) remains inaccurate for
> query-migrate-parameters.  If we decide not to restore the sharing, we
> should revert that part, too.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c                 |  4 +--
>  migration/migration.c | 12 +++++---
>  qapi-schema.json      | 85 +++++++++++++++++++++++++++++++++++++++++++=
+++-----
>  3 files changed, 87 insertions(+), 14 deletions(-)

No fun, but when you're up against a release deadline, it beats the
alternative of baking in a design flaw longer than we want.

Reviewed-by: Eric Blake <eblake@redhat.com>

A possible alternative: make a common base class with most of the
members (those that aren't related to tls), then two subclasses, one
with output semantics, one with input semantics, for the tls members.
You share a bit more code that way (and could still QAPI_CLONE the
common base-class members).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pssXxLNwbLQdQdepx6jIRn6FfhAac9J8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluSJYACgkQp6FrSiUn
Q2puXwf8Cdxmekdhdicp2WPhzsS3Xb5tfevX7nWUvaw+cxndv15nDZ1Czi/Kuewz
6QCn9amtE1d8CF1k1+2KjwB2/9FtTdOw2PnRpYZVtBg8psjNkXwXhriStPVU9RwI
Y806WmZG4sOU/wUt1gWTCSL4dHQxXmgiPrrf0iQx/sHdi97ArBO1wRfirwhrHbwi
Pk0FdLFFT4dRmXHn3geR6tt0MCHlyuqJaXdUIkCrUz4XJeIll37uMW35BJs8FvK/
dRFE0qpwXa7Z2f3qcuRfusYXTnfdxag5ixLc7WVbYOosXM/1qnYs4WxstUoyLaDl
4LWONbXZaWq+hoBd1LG5JWOSG3qTqA==
=KF3F
-----END PGP SIGNATURE-----

--pssXxLNwbLQdQdepx6jIRn6FfhAac9J8A--
