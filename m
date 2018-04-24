Received: from eggs.gnu.org ([2001:4830:134:3::10]:46734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fAyE6-0005en-QE
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fAyE5-0007oB-Lq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:43:22 -0400
Date: Tue, 24 Apr 2018 14:43:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180424134307.GA5120@stefanha-x1.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<6d37b435-bc05-a776-3e7f-c73adec4ee74@redhat.com>
	<20180420030542.GD10319@stefanha-x1.localdomain>
	<dd343653-f9d0-48fa-b71f-27c845551130@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <dd343653-f9d0-48fa-b71f-27c845551130@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 08:53:33AM -0500, Eric Blake wrote:
> On 04/19/2018 10:05 PM, Stefan Hajnoczi wrote:
>=20
> >>> This patch series implements .bdrv_co_invalidate_cache() for block/fi=
le-posix.c
> >>> on Linux so that shared storage live migration works.  I have sent it=
 as an RFC
> >>> because cache consistency is not binary, there are corner cases which=
 I've
> >>> described in the actual patch, and this may require more discussion.
> >>
> >> Interesting, in that the NBD list is also discussing the possible
> >> standardization of a NBD_CMD_CACHE command (based on existing practice
> >> in the xNBD implementation), and covering whether that MIGHT be worth
> >> doing as a thin wrapper that corresponds to posix_fadvise() semantics.
> >> Thus, if NBD_CMD_CACHE learns flags, we could support
> >> .bdrv_co_invalidate_cache() through the NBD protocol driver, in additi=
on
> >> to the POSIX file driver.  Obviously, your usage invalidates the cache
> >> of the entire file; but does it also make sense to expose a start/leng=
th
> >> subset invalidation, for better exposure to posix_fadvise() semantics?
> >=20
> > bdrv_co_invalidate_cache() is currently only used by migration before
> > using a file that may have been touched by the other host.  I don't
> > think start/length will be needed for that use case.
> >=20
> > Can you describe how will NBD use cache invalidation?  Maybe this will
> > help me understand other use cases.
>=20
> That's where things are still under discussion - no one has yet provided
> a case that would benefit from a POSIX_FADV_DONTNEED over just a range
> of the file [1]; on the other hand, it might make sense that if you know
> an implementation has a limited cache, then having control over the
> various posix_fadvise() flags over various ranges of the files may lead
> to more optimum behavior.  And posix_fadvise() does have the ability to
> work over the entire file (offset 0 length 0) or a subrange (any offset
> and nonzero length).  So I'm also fine if .bdrv_co_invalidate_cache()
> doesn't expose offset/length parameters, particularly if NBD can't come
> up with an actual use case that would benefit.
>=20
> [1] https://lists.debian.org/nbd/2018/04/msg00020.html

Okay.  .bdrv_co_invalidate_cache() is an internal interface.  We can
change it later to support NBD functionality, if necessary.  Let's keep
it without start/length for now.

Stefan

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa3zRrAAoJEJykq7OBq3PIOokH/2EYSmBesTa71q1TNb23cidW
08vj/ttGrHv3C93GjQgnRFtqqu0AtvMoJIcvqqcAqaXC7nSVmwttBJsKB72ehm5W
St36NL8Al49HRg/s1Xh2tXe2Zc23cPwdnJ3wyF4heaThlAOAv86YbHMMuEx9yOg7
JN0wzS6Y1cRlVTP8kfVYwJFZZq5Z1FZNAF09DUItcRvX+QsAL3md2mj94/2ivPDT
9WuuNwRZz+gcw19VhsddwkOC6OKntDxZhztIfcJi7UgnL/MsZt+WBITQsFa6OHpy
axPiY5+BVPBACuYVIum/oBpoUlibYt1HEJPdw6cmB/qTBZ0eOXXQk1AtaewwcWI=
=KNJr
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
