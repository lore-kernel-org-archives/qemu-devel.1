Received: from eggs.gnu.org ([2001:4830:134:3::10]:55478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f9MN7-0002tt-83
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f9MN6-0007Wz-B4
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:06:01 -0400
Date: Fri, 20 Apr 2018 11:05:42 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180420030542.GD10319@stefanha-x1.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<6d37b435-bc05-a776-3e7f-c73adec4ee74@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <6d37b435-bc05-a776-3e7f-c73adec4ee74@redhat.com>
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


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 11:09:53AM -0500, Eric Blake wrote:
> On 04/19/2018 02:52 AM, Stefan Hajnoczi wrote:
> > file-posix.c only supports shared storage live migration with -drive
> > cache.direct=3Doff due to cache consistency issues.  There are two main=
 shared
> > storage configurations: files on NFS and host block devices on SAN LUNs.
> >=20
> > The problem is that QEMU starts on the destination host before the sour=
ce host
> > has written everything out to the disk.  The page cache on the destinat=
ion host
> > may contain stale data read when QEMU opened the image file (before mig=
ration
> > handover).  Using O_DIRECT avoids this problem but prevents users from =
taking
> > advantage of the host page cache.
> >=20
> > Although cache=3Dnone is the recommended setting for virtualization use=
 cases,
> > there are scenarios where cache=3Dwriteback makes sense.  If the guest =
has much
> > less RAM than the host or many guests share the same backing file, then=
 the
> > host page cache can significantly improve disk I/O performance.
> >=20
> > This patch series implements .bdrv_co_invalidate_cache() for block/file=
-posix.c
> > on Linux so that shared storage live migration works.  I have sent it a=
s an RFC
> > because cache consistency is not binary, there are corner cases which I=
've
> > described in the actual patch, and this may require more discussion.
>=20
> Interesting, in that the NBD list is also discussing the possible
> standardization of a NBD_CMD_CACHE command (based on existing practice
> in the xNBD implementation), and covering whether that MIGHT be worth
> doing as a thin wrapper that corresponds to posix_fadvise() semantics.
> Thus, if NBD_CMD_CACHE learns flags, we could support
> .bdrv_co_invalidate_cache() through the NBD protocol driver, in addition
> to the POSIX file driver.  Obviously, your usage invalidates the cache
> of the entire file; but does it also make sense to expose a start/length
> subset invalidation, for better exposure to posix_fadvise() semantics?

bdrv_co_invalidate_cache() is currently only used by migration before
using a file that may have been touched by the other host.  I don't
think start/length will be needed for that use case.

Can you describe how will NBD use cache invalidation?  Maybe this will
help me understand other use cases.

Stefan

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2VkGAAoJEJykq7OBq3PIMbkIAKHkCUZRCUeycdP92FcQ8jLl
6JuF4XLKHyZ6bb7jvIH8HuuyQhlIePHghcOUV/KSv/S7/IMwE+n1+D5t2J8xeF8+
9tAsEl5EgqV/1b0C1l8hOYqnj+t0YJyVaBYeH65ustoiFQ0ntymlkOz/WZVStRMg
xuCApKKsT3HCOobfu6hvitq4oxuV1COmu0is5K9XeU1Bsl3d0oZU4rlcWqgd4m0b
kOdjOrEmNvKPEWCxVQzNGfKDFOpWJIDfciQlt7wlTA0KDU56Sv4De8+765++Q6F2
xjZbhCx1VSwzqgMC/zrsohcf+egKcFN9qve91KZkvytDHk5TO6dzHnbzBbd7zYk=
=3mIv
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
