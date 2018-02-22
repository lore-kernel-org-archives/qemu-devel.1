Received: from eggs.gnu.org ([2001:4830:134:3::10]:59463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eosHW-0002kj-Sa
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eosHV-0006Id-Pt
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:55:34 -0500
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-4-mreitz@redhat.com>
	<20180222133956.GG4147@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
Date: Thu, 22 Feb 2018 15:55:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180222133956.GG4147@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TjwWXgXCZV0xNl8x96ZCPyhhaTvzmvaif"
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
--TjwWXgXCZV0xNl8x96ZCPyhhaTvzmvaif
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Alberto Garcia <berto@igalia.com>
Message-ID: <a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
Subject: Re: [PATCH v8 03/26] block: Add BDS.backing_overridden
References: <20180205151835.20812-1-mreitz@redhat.com>
 <20180205151835.20812-4-mreitz@redhat.com>
 <20180222133956.GG4147@localhost.localdomain>
In-Reply-To: <20180222133956.GG4147@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-22 14:39, Kevin Wolf wrote:
> Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
>> If the backing file is overridden, this most probably does change the
>> guest-visible data of a BDS. Therefore, we will need to consider this =
in
>> bdrv_refresh_filename().
>>
>> Adding a new field to the BDS is not nice, but it is very simple and
>> exactly keeps track of whether the backing file has been overridden.
>=20
> ...as long as we manage to actually keep it up to date all the time.
>=20
> First of all, what I'm missing here (or in fact in the comment in the
> code) is a definition what "overridden" really means. "specified by the=

> user" is kind of vague: You consider the backing file relationship for
> snapshot=3Don as user specified, even though the user wasn't explicit
> about this. On the other hand, creating a live snapshot results in a
> node that isn't user specified.
>=20
> Isn't the real question to ask whether the default backing file (taken
> from the image header) would result in the same tree? The answer to thi=
s
> changes after more operations, like qmp_change_backing_file().

With you so far.

> Considering that there are so many ways to change the answer, I think
> the simplest reliable option isn't a new BDS field that needs to update=
d
> everywhere, but looking at the current value of bs->options and
> bs->backing_file and see if they match.

I don't see how that is simple.  First, bs->options does not necessarily
reflect the "current options", those would be bs->full_open_options.
And for generating that, we need a way to determine whether the backing
file has been overridden or not, so whether we need to put the backing
options into it or whether we do not.

(I am right that bs->backing_file is what the image header says, right?
So we need to compare it against something that reflects the runtime stat=
e.)

What I could see would be comparing bs->backing_file to
bs->backing->bs->filename.  But this sounds very hacky to me.

One thing the comes to mind is that it can break whenever
bdrv_refresh_filename() is clever.  So you specify
'json:{"driver":"null-co"}' in the image header, and
bdrv_refresh_filename() optimizes that to "null-co://".  Now the
filenames differ even though it's still the original filename.  So this
wouldn't work very well either.

Max

>> This commit adds a FIXME which will be remedied by a follow-up commit.=

>> Until then, the respective piece of code will not result in any behavi=
or
>> that is worse than what we currently have.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> Kevin
>=20



--TjwWXgXCZV0xNl8x96ZCPyhhaTvzmvaif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqO2csSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoykH/3X/Qew5Q+vBC1Q0o+4LNZ5XYhrCJuDj
ZNXoQNwGkSHeK0f9PbyNsW9DOzLu25Zgctfja2G9qhhUKb5aBFECJ1apExMCsV7g
qITYJwmgUuzK5sz5w4NhkaPXV5FwqO6KavUZf2r4xCLrjgFp0s6rEO+6rsS3JD0c
JsRjKjJf9QiWv4E4LQMprZM5NJPiG7VCC+naLMznxLyNW1L+kxXclO95xVzxILig
CBLgKxVFYLidQem6S2sZf91EOt0rqr9Bee/TbD9MyCtxJP0IzLZAlg7AoCGHZwM4
2Ggiy0aC/3gJbo6JDIjjIoF/kA7zorhaaJQJ1mZCWhvY0cb2LPCgNqU=
=Bgs2
-----END PGP SIGNATURE-----

--TjwWXgXCZV0xNl8x96ZCPyhhaTvzmvaif--
