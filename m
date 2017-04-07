Received: from eggs.gnu.org ([2001:4830:134:3::10]:47025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwSsQ-0006SY-L9
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwSsP-0002il-LC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:20:30 -0400
Date: Fri, 7 Apr 2017 13:20:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407122021.GP13602@stefanha-x1.localdomain>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N5iGxCIPT7YMRg16"
Content-Disposition: inline
In-Reply-To: <20170406150148.zwjpozqtale44jfh@perseus.local>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--N5iGxCIPT7YMRg16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 06:01:48PM +0300, Alberto Garcia wrote:
> Here are the results (subcluster size in brackets):
>=20
> |-----------------+----------------+-----------------+-------------------|
> |  cluster size   | subclusters=3Don | subclusters=3Doff | Max L2 cache s=
ize |
> |-----------------+----------------+-----------------+-------------------|
> |   2 MB (256 KB) |   440 IOPS     |  100 IOPS       | 160 KB (*)        |
> | 512 KB  (64 KB) |  1000 IOPS     |  300 IOPS       | 640 KB            |
> |  64 KB   (8 KB) |  3000 IOPS     | 1000 IOPS       |   5 MB            |
> |  32 KB   (4 KB) | 12000 IOPS     | 1300 IOPS       |  10 MB            |
> |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB            |
> |-----------------+----------------+-----------------+-------------------|
>=20
>                 (*) The L2 cache must be a multiple of the cluster
>                     size, so in this case it must be 2MB. On the table
>                     I chose to show how much of those 2MB are actually
>                     used so you can compare it with the other cases.
>=20
> Some comments about the results:
>=20
> - For the 64KB, 512KB and 2MB cases, having subclusters increases
>   write performance roughly by three. This happens because for each
>   cluster allocation there's less data to copy from the backing
>   image. For the same reason, the smaller the cluster, the better the
>   performance. As expected, 64KB clusters with no subclusters perform
>   roughly the same as 512KB clusters with 64KB subclusters.
>=20
> - The 32KB case is the most interesting one. Without subclusters it's
>   not very different from the 64KB case, but having a subcluster with
>   the same size of the I/O block eliminates the need for COW entirely
>   and the performance skyrockets (10 times faster!).
>=20
> - 4KB is however very slow. I attribute this to the fact that the
>   cluster size is so small that a new cluster needs to be allocated
>   for every single write and its refcount updated accordingly. The L2
>   and refcount tables are also so small that they are too inefficient
>   and need to grow all the time.
>=20
> Here are the results when writing to an empty 40GB qcow2 image with no
> backing file. The numbers are of course different but as you can see
> the patterns are similar:
>=20
> |-----------------+----------------+-----------------+-------------------|
> |  cluster size   | subclusters=3Don | subclusters=3Doff | Max L2 cache s=
ize |
> |-----------------+----------------+-----------------+-------------------|
> |   2 MB (256 KB) |  1200 IOPS     |  255 IOPS       | 160 KB            |
> | 512 KB  (64 KB) |  3000 IOPS     |  700 IOPS       | 640 KB            |
> |  64 KB   (8 KB) |  7200 IOPS     | 3300 IOPS       |   5 MB            |
> |  32 KB   (4 KB) | 12300 IOPS     | 4200 IOPS       |  10 MB            |
> |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB            |
> |-----------------+----------------+-----------------+-------------------|

I don't understand why subclusters=3Don performs so much better when
there's no backing file.  Is qcow2 zeroing out the 64 KB cluster with
subclusters=3Doff?

It ought to just write the 4 KB data when a new cluster is touched.
Therefore the performance should be very similar to subclusters=3Don.

Stefan

--N5iGxCIPT7YMRg16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY54QFAAoJEJykq7OBq3PIDQYH/j8dPXgUJp5F79paUxrPpjSI
mhiTl+oLa7gvj5nUFd58c9OYHfqKcgzoehofdGaUh3ZkOOm1v8d6NSf81joKhfRg
Zf/vT/7hFoElZ9BYavvU5u3QsNwXzGmp/+t0blVUZBWTVTds3SmBlxKIb3Qwhf8e
ZvEGmxqBHWCc2qMDqQF/pD7nePpEASyQ0SNCoYW4hO1lAwTt32d7qdaTR3pjtCbc
2VjTacgOvFDuEgkjH6pm9Bnd7rqJrSG2/wSTiDPkq3y2vRfjsPOcngryPK7r+S7S
AOJtG8sLWySTG+UiX2pVzxTakGY0Gwsi3Rb1n7Z9GXvcFWkgiweoYH8B94oQYDw=
=oqVs
-----END PGP SIGNATURE-----

--N5iGxCIPT7YMRg16--
