Received: from eggs.gnu.org ([2001:4830:134:3::10]:42769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxbJ1-0006wJ-L1
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxbJ0-0003rw-Kx
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:32:39 -0400
Date: Mon, 10 Apr 2017 16:32:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170410153223.GD3214@stefanha-x1.localdomain>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<20170407122021.GP13602@stefanha-x1.localdomain>
	<20170407130129.GE4716@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <20170407130129.GE4716@noname.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 03:01:29PM +0200, Kevin Wolf wrote:
> Am 07.04.2017 um 14:20 hat Stefan Hajnoczi geschrieben:
> > On Thu, Apr 06, 2017 at 06:01:48PM +0300, Alberto Garcia wrote:
> > > Here are the results (subcluster size in brackets):
> > >=20
> > > |-----------------+----------------+-----------------+---------------=
----|
> > > |  cluster size   | subclusters=3Don | subclusters=3Doff | Max L2 cac=
he size |
> > > |-----------------+----------------+-----------------+---------------=
----|
> > > |   2 MB (256 KB) |   440 IOPS     |  100 IOPS       | 160 KB (*)    =
    |
> > > | 512 KB  (64 KB) |  1000 IOPS     |  300 IOPS       | 640 KB        =
    |
> > > |  64 KB   (8 KB) |  3000 IOPS     | 1000 IOPS       |   5 MB        =
    |
> > > |  32 KB   (4 KB) | 12000 IOPS     | 1300 IOPS       |  10 MB        =
    |
> > > |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB        =
    |
> > > |-----------------+----------------+-----------------+---------------=
----|
> > >=20
> > >                 (*) The L2 cache must be a multiple of the cluster
> > >                     size, so in this case it must be 2MB. On the table
> > >                     I chose to show how much of those 2MB are actually
> > >                     used so you can compare it with the other cases.
> > >=20
> > > Some comments about the results:
> > >=20
> > > - For the 64KB, 512KB and 2MB cases, having subclusters increases
> > >   write performance roughly by three. This happens because for each
> > >   cluster allocation there's less data to copy from the backing
> > >   image. For the same reason, the smaller the cluster, the better the
> > >   performance. As expected, 64KB clusters with no subclusters perform
> > >   roughly the same as 512KB clusters with 64KB subclusters.
> > >=20
> > > - The 32KB case is the most interesting one. Without subclusters it's
> > >   not very different from the 64KB case, but having a subcluster with
> > >   the same size of the I/O block eliminates the need for COW entirely
> > >   and the performance skyrockets (10 times faster!).
> > >=20
> > > - 4KB is however very slow. I attribute this to the fact that the
> > >   cluster size is so small that a new cluster needs to be allocated
> > >   for every single write and its refcount updated accordingly. The L2
> > >   and refcount tables are also so small that they are too inefficient
> > >   and need to grow all the time.
> > >=20
> > > Here are the results when writing to an empty 40GB qcow2 image with no
> > > backing file. The numbers are of course different but as you can see
> > > the patterns are similar:
> > >=20
> > > |-----------------+----------------+-----------------+---------------=
----|
> > > |  cluster size   | subclusters=3Don | subclusters=3Doff | Max L2 cac=
he size |
> > > |-----------------+----------------+-----------------+---------------=
----|
> > > |   2 MB (256 KB) |  1200 IOPS     |  255 IOPS       | 160 KB        =
    |
> > > | 512 KB  (64 KB) |  3000 IOPS     |  700 IOPS       | 640 KB        =
    |
> > > |  64 KB   (8 KB) |  7200 IOPS     | 3300 IOPS       |   5 MB        =
    |
> > > |  32 KB   (4 KB) | 12300 IOPS     | 4200 IOPS       |  10 MB        =
    |
> > > |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB        =
    |
> > > |-----------------+----------------+-----------------+---------------=
----|
> >=20
> > I don't understand why subclusters=3Don performs so much better when
> > there's no backing file.  Is qcow2 zeroing out the 64 KB cluster with
> > subclusters=3Doff?
> >=20
> > It ought to just write the 4 KB data when a new cluster is touched.
> > Therefore the performance should be very similar to subclusters=3Don.
>=20
> No, it can't do that. Nobody guarantees that the cluster contains only
> zeros when we don't write them. It could have been used before and then
> either freed on a qcow2 level or we could be sitting on a block device
> rather than a file.

I thought we had the no-op optimization for clusters allocated at the
end of a POSIX file.  All the more reason to add sub-clusters!

Stefan

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY66WHAAoJEJykq7OBq3PIQpYIAJjj7rtFveCLCd2TIxuIYKHF
zsoxQDZLVbnrKwu8ThVGX3TO3IF/42y3Jh/cZgbMfRT3HImNRXEV/pL0QaQRbGd4
3Dqg2BKO9OHvqhb+jPRIXQUnobMQS3okzUKbIbs53G2L+dzMRW9FXF2J+dP9QBt/
1kn6FgUrx6MrYqMYwyREGFaPJ6ngHWH/a8tAx9+HkNDJMkdr4/yJ/6jYntIwXq/y
VjYhHuO5zTuAuRUIOhoWF3IWipQ+90wBef7yw05o9bkQi3IsHngQv/pi9MBqcSh1
4sDj+mDBAq2IcM+3W3UI+JK8+IpHtCyT8FO+K0eJ809TVOOfFoBn1wA727J9HYs=
=C0C4
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
