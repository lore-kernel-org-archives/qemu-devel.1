Received: from eggs.gnu.org ([2001:4830:134:3::10]:57078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwTWI-0005Z3-Kn
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwTWH-00007B-E4
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:01:42 -0400
Date: Fri, 7 Apr 2017 15:01:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170407130129.GE4716@noname.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<20170407122021.GP13602@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20170407122021.GP13602@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.04.2017 um 14:20 hat Stefan Hajnoczi geschrieben:
> On Thu, Apr 06, 2017 at 06:01:48PM +0300, Alberto Garcia wrote:
> > Here are the results (subcluster size in brackets):
> >=20
> > |-----------------+----------------+-----------------+-----------------=
--|
> > |  cluster size   | subclusters=3Don | subclusters=3Doff | Max L2 cache=
 size |
> > |-----------------+----------------+-----------------+-----------------=
--|
> > |   2 MB (256 KB) |   440 IOPS     |  100 IOPS       | 160 KB (*)      =
  |
> > | 512 KB  (64 KB) |  1000 IOPS     |  300 IOPS       | 640 KB          =
  |
> > |  64 KB   (8 KB) |  3000 IOPS     | 1000 IOPS       |   5 MB          =
  |
> > |  32 KB   (4 KB) | 12000 IOPS     | 1300 IOPS       |  10 MB          =
  |
> > |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB          =
  |
> > |-----------------+----------------+-----------------+-----------------=
--|
> >=20
> >                 (*) The L2 cache must be a multiple of the cluster
> >                     size, so in this case it must be 2MB. On the table
> >                     I chose to show how much of those 2MB are actually
> >                     used so you can compare it with the other cases.
> >=20
> > Some comments about the results:
> >=20
> > - For the 64KB, 512KB and 2MB cases, having subclusters increases
> >   write performance roughly by three. This happens because for each
> >   cluster allocation there's less data to copy from the backing
> >   image. For the same reason, the smaller the cluster, the better the
> >   performance. As expected, 64KB clusters with no subclusters perform
> >   roughly the same as 512KB clusters with 64KB subclusters.
> >=20
> > - The 32KB case is the most interesting one. Without subclusters it's
> >   not very different from the 64KB case, but having a subcluster with
> >   the same size of the I/O block eliminates the need for COW entirely
> >   and the performance skyrockets (10 times faster!).
> >=20
> > - 4KB is however very slow. I attribute this to the fact that the
> >   cluster size is so small that a new cluster needs to be allocated
> >   for every single write and its refcount updated accordingly. The L2
> >   and refcount tables are also so small that they are too inefficient
> >   and need to grow all the time.
> >=20
> > Here are the results when writing to an empty 40GB qcow2 image with no
> > backing file. The numbers are of course different but as you can see
> > the patterns are similar:
> >=20
> > |-----------------+----------------+-----------------+-----------------=
--|
> > |  cluster size   | subclusters=3Don | subclusters=3Doff | Max L2 cache=
 size |
> > |-----------------+----------------+-----------------+-----------------=
--|
> > |   2 MB (256 KB) |  1200 IOPS     |  255 IOPS       | 160 KB          =
  |
> > | 512 KB  (64 KB) |  3000 IOPS     |  700 IOPS       | 640 KB          =
  |
> > |  64 KB   (8 KB) |  7200 IOPS     | 3300 IOPS       |   5 MB          =
  |
> > |  32 KB   (4 KB) | 12300 IOPS     | 4200 IOPS       |  10 MB          =
  |
> > |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB          =
  |
> > |-----------------+----------------+-----------------+-----------------=
--|
>=20
> I don't understand why subclusters=3Don performs so much better when
> there's no backing file.  Is qcow2 zeroing out the 64 KB cluster with
> subclusters=3Doff?
>=20
> It ought to just write the 4 KB data when a new cluster is touched.
> Therefore the performance should be very similar to subclusters=3Don.

No, it can't do that. Nobody guarantees that the cluster contains only
zeros when we don't write them. It could have been used before and then
either freed on a qcow2 level or we could be sitting on a block device
rather than a file.

One optimisation that would be possible even without subclusters is
making only a single I/O request to write the whole cluster instead of
three of them (COW head, guest write, COW tail). Without a backing file,
this improved performance almost to the level of rewrites, but it
couldn't solve the problem when a backing file was used (which is the
main use case for qcow2), so I never got to submitting a patch for it.

Kevin

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY542oAAoJEH8JsnLIjy/WhuAP/1BfOaGs3jMMJgjtMpcenrb7
0vF6BtLDz11EB8P7iIhKmEGpIzyNX1bgo1X/x5JEow41qwCBlZA9l3t81bZvmm8v
fAJ1PxyunSWiF3yQF2pO6k2bAHmZMVNPUlZdFrYEqPxKQJ16LR6b96nBzO/TwbMP
hrx3LtH5uvFkgYrCRjzz4GpFXchD3dh1XhN5Ou7uLCz0tO8Kj1esSIRHjPfP412I
SwYIeH+FBmSVDNWLQR20FSXhg3QH4XguyOlBMBUuaJ2utFfo0OyLJfOv4wmtS0WB
GNQ8K+GxoxSz+nsV1lcrK+dMilObMBjEJ+rLJ2uUKyakRz0QYiYXTxDlnV9ttrSF
++3hFZom1TWgvkvqv499HkAcmSs7TnmL6lNmM8SMfeqwrvvZhT4eEPJjQDXmv85j
hLPZxNNkbM1dRaJ1kU9RAalTDyk/Kwj0pl4E/blqYtD79u+bcThde2s26PMr3nhn
J07PGSABm68QS6VPuNAK6vyUl7G3QBpFLnet5kqJCU61LgCKwE5MiSfa69JvIca9
+vIS87qtXhML2f5iFVWP//OPysoyE1WRU6+LidGLn5mljaeDYpd1Zb+utPKXLTtu
/jvDzqXH7dM7+RD8rr2N1yzLzr3q59ROzIWXGJ5k6JRxM11axLhuGFNQOU+tzUqV
DtzJA2r6Rz7ZsfnvviaW
=4K4M
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
