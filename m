Received: from eggs.gnu.org ([2001:4830:134:3::10]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXrrL-00047a-8S
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXrrK-0000NJ-4L
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:34:31 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-4-mreitz@redhat.com>
	<20180222133956.GG4147@localhost.localdomain>
	<a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
	<20180222151210.GK4147@localhost.localdomain>
	<c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
	<20180222162147.GL4147@localhost.localdomain>
	<26a949be-bc67-7fef-3e66-59e9d7268cad@redhat.com>
Message-ID: <e2b18fb9-af9e-c3b7-7def-0c13b3690d00@redhat.com>
Date: Tue, 26 Jun 2018 19:34:20 +0200
MIME-Version: 1.0
In-Reply-To: <26a949be-bc67-7fef-3e66-59e9d7268cad@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ekU32hp2jUIu1SY2UCdSUJbiviV77vLFA"
Subject: Re: [Qemu-devel] [PATCH v8 03/26] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ekU32hp2jUIu1SY2UCdSUJbiviV77vLFA
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Alberto Garcia <berto@igalia.com>
Message-ID: <e2b18fb9-af9e-c3b7-7def-0c13b3690d00@redhat.com>
Subject: Re: [PATCH v8 03/26] block: Add BDS.backing_overridden
References: <20180205151835.20812-1-mreitz@redhat.com>
 <20180205151835.20812-4-mreitz@redhat.com>
 <20180222133956.GG4147@localhost.localdomain>
 <a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
 <20180222151210.GK4147@localhost.localdomain>
 <c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
 <20180222162147.GL4147@localhost.localdomain>
 <26a949be-bc67-7fef-3e66-59e9d7268cad@redhat.com>
In-Reply-To: <26a949be-bc67-7fef-3e66-59e9d7268cad@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

So, while tackling this once more, this is the current state, in short.

I wanted to add a new field BDS.backing_file_canonical which basically
gets set to bs->backing->bs->filename whenever we know that bs->backing
was opened through bs->backing_file.  That is,
bs->backing_file_canonical would be bs->backing_file, but after going
through the whole hoop of bdrv_open() and bdrv_refresh_filename().

With such a field, we could compare bs->backing->bs->filename against
bs->backing_file_canonical, and thus see whether the backing BDS matches
the image header filename.  I hope this would do the right thing
whenever qemu tries to figure out backing filenames on its own; it will
break, though, when the user just uses some filename and that doesn't
happen to coincide with qemu's generated filenames.

(For instance, if you create a new overlay manually, give it some
backing filename, and that backing filename isn't 1:1 what qemu would
reconstruct; and then you open that file with backing=3Dnull, and do a
blockdev-snapshot; then qemu will give you a json:{} filename for the
overlay because due to backing=3Dnull, it didn't open the overlay's
backing_file and thus doesn't know how it would look reconstructed.  But
I think that's something we could live with.)

((The only real way to fix this I can imagine is to clone the whole
bdrv_parse_filename()/bdrv_open()/bdrv_refresh_filename()
infrastructure, but just for filenames instead of real BDSs.  Yeah, no,
I won't do that.))

OK, so that was an idea, but now it turns out that bs->backing_file
actually isn't that image header's idea of the backing file.  It appears
to mostly be a clone of bs->backing->bs->filename, but not really.
Honestly, I have no idea what it is, but as a matter of fact, it is
modified by bdrv_backing_attach(), so it will probably usually match
bs->backing->bs->filename (unless there is no bs->backing, in which case
it just retains its old value?).  So it pretty much is completely
useless for any comparison here.

So I suppose I'll rename my BDS.backing_file_canonical attempt to
BDS.auto_backing_file, and this will be what the image header contains
(unless we have opened a BDS from it, in which case it will be that
BDS's filename, so it is canonicalized).

Well, or I could just go with backing_overridden, because honestly that
didn't seem so bad.

Max


PS: Or, we could argue that nobody needs filenames anyway and that
they're just for show and debugging nowadays, so nobody actually needs
backing chain information in them.  May sound a bit stupid, but then
again nobody has ever complained that that's in fact the current state.


--ekU32hp2jUIu1SY2UCdSUJbiviV77vLFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsyeRwACgkQ9AfbAGHV
z0DkewgAlWCg5mHKj7yqvQHtHdVUFXCd7+APaVUwwF6gh2mGzdfaIAtjKLzJDYed
j0OJWgjhlrO+bLgFD0UcSr4JS3XulZMI8AzSeuvXotT1z3Q/uYEFyzedECf31tA8
RAcnRJMUIRvb6+V1foTBAiW8jh9VSOKsfjsXOm7TlrfhO3/Rj26xbO72VAdCYAE7
/TPHOg+BpTtn43APsKPs0J2ev7jLgWlvgQp73xVvKVPEAjNz7+IcaN6h7OztX5kq
SbDk4+tU9s+83Uyd8KuU6elo1wWClrbjzDx/qucyx//9t0xCAl3+2HJMRQxKjS7g
CE7CRuRjpJ+SsUkD8gustiHfZHbaJQ==
=Cuxo
-----END PGP SIGNATURE-----

--ekU32hp2jUIu1SY2UCdSUJbiviV77vLFA--
