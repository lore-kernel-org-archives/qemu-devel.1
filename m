Received: from eggs.gnu.org ([2001:4830:134:3::10]:50514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Zg1-00028R-Ks
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Zg0-0001Gx-Ds
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:18:25 -0400
References: <20180419075232.31407-1-stefanha@redhat.com>
	<6d37b435-bc05-a776-3e7f-c73adec4ee74@redhat.com>
	<20180420030542.GD10319@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd343653-f9d0-48fa-b71f-27c845551130@redhat.com>
Date: Fri, 20 Apr 2018 08:53:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180420030542.GD10319@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ljzsIceivc4FZINqmaD3l6dwK6e9THaSg"
Subject: Re: [Qemu-devel] [RFC 0/2] block/file-posix: allow -drive
 cache.direct=off live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ljzsIceivc4FZINqmaD3l6dwK6e9THaSg
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dd343653-f9d0-48fa-b71f-27c845551130@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/2] block/file-posix: allow -drive
 cache.direct=off live migration
References: <20180419075232.31407-1-stefanha@redhat.com>
 <6d37b435-bc05-a776-3e7f-c73adec4ee74@redhat.com>
 <20180420030542.GD10319@stefanha-x1.localdomain>
In-Reply-To: <20180420030542.GD10319@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 10:05 PM, Stefan Hajnoczi wrote:

>>> This patch series implements .bdrv_co_invalidate_cache() for block/fi=
le-posix.c
>>> on Linux so that shared storage live migration works.  I have sent it=
 as an RFC
>>> because cache consistency is not binary, there are corner cases which=
 I've
>>> described in the actual patch, and this may require more discussion.
>>
>> Interesting, in that the NBD list is also discussing the possible
>> standardization of a NBD_CMD_CACHE command (based on existing practice=

>> in the xNBD implementation), and covering whether that MIGHT be worth
>> doing as a thin wrapper that corresponds to posix_fadvise() semantics.=

>> Thus, if NBD_CMD_CACHE learns flags, we could support
>> .bdrv_co_invalidate_cache() through the NBD protocol driver, in additi=
on
>> to the POSIX file driver.  Obviously, your usage invalidates the cache=

>> of the entire file; but does it also make sense to expose a start/leng=
th
>> subset invalidation, for better exposure to posix_fadvise() semantics?=

>=20
> bdrv_co_invalidate_cache() is currently only used by migration before
> using a file that may have been touched by the other host.  I don't
> think start/length will be needed for that use case.
>=20
> Can you describe how will NBD use cache invalidation?  Maybe this will
> help me understand other use cases.

That's where things are still under discussion - no one has yet provided
a case that would benefit from a POSIX_FADV_DONTNEED over just a range
of the file [1]; on the other hand, it might make sense that if you know
an implementation has a limited cache, then having control over the
various posix_fadvise() flags over various ranges of the files may lead
to more optimum behavior.  And posix_fadvise() does have the ability to
work over the entire file (offset 0 length 0) or a subrange (any offset
and nonzero length).  So I'm also fine if .bdrv_co_invalidate_cache()
doesn't expose offset/length parameters, particularly if NBD can't come
up with an actual use case that would benefit.

[1] https://lists.debian.org/nbd/2018/04/msg00020.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ljzsIceivc4FZINqmaD3l6dwK6e9THaSg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrZ8N0ACgkQp6FrSiUn
Q2qTQAf+KEkgY07RTa4iUdOoXS9yGYJnXR5y/NQvGzNj5Dz7wviqP2GRtMnsIOvA
ESBteuKnNX/qZ0g/QKH5Qe6WZM8ucezJJwtCAj4DVLHveTsJfzrgQffwsl3alnck
l+ME0eDSKw1v0f80MT0vBjzdz+53ztJEbfMHH7xBCLuY402ZqChQ/VjSA7FyS3i1
1NfnpKklFmIkE3rDl3eV492jb4e6aXuHvU9dTxtIyWt3/yoTjBarisoPs7GwGbBB
RQYQkdfzxYD/qTJQ0KZ2wbykGzgEwKrnKLYa5Ndusu+swjm8dyT0mdRQ7MLSu48D
xFkwMJH8IIVqw2DF2xjIEKYjux2lbw==
=3cOI
-----END PGP SIGNATURE-----

--ljzsIceivc4FZINqmaD3l6dwK6e9THaSg--
