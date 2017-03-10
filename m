Received: from eggs.gnu.org ([2001:4830:134:3::10]:56264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmC0G-0006B1-Er
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmC0F-0007lc-3c
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:18:08 -0500
Date: Fri, 10 Mar 2017 12:17:53 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170310041753.GA4589@stefanha-x1.localdomain>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484884080-28836-6-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170227173720.GJ10201@stefanha-x1.localdomain>
	<58BEC406.1050903@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <58BEC406.1050903@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 5/6] replication: Implement
 block replication for shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kwolf@redhat.com, xuquan8@huawei.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, qemu-block@nongnu.org, wencongyang2@huawei.com, qemu-devel@nongnu.org, mreitz@redhat.com


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2017 at 10:30:30PM +0800, Hailiang Zhang wrote:
> Hi Stefan,
>=20
> Sorry for the delayed reply.
>=20
> On 2017/2/28 1:37, Stefan Hajnoczi wrote:
> > On Fri, Jan 20, 2017 at 11:47:59AM +0800, zhanghailiang wrote:
> > > Just as the scenario of non-shared disk block replication,
> > > we are going to implement block replication from many basic
> > > blocks that are already in QEMU.
> > > The architecture is:
> > >=20
> > >           virtio-blk                     ||                          =
     .----------
> > >               /                          ||                          =
     | Secondary
> > >              /                           ||                          =
     '----------
> > >             /                            ||                          =
       virtio-blk
> > >            /                             ||                          =
            |
> > >            |                             ||                          =
     replication(5)
> > >            |                    NBD  -------->   NBD   (2)           =
            |
> > >            |                  client     ||    server ---> hidden dis=
k <-- active disk(4)
> > >            |                     ^       ||                      |
> > >            |              replication(1) ||                      |
> > >            |                     |       ||                      |
> > >            |   +-----------------'       ||                      |
> > >           (3)  |drive-backup sync=3Dnone   ||                      |
> > > --------. |   +-----------------+       ||                      |
> > > Primary | |                     |       ||           backing    |
> > > --------' |                     |       ||                      |
> > >            V                     |                               |
> > >         +-------------------------------------------+            |
> > >         |               shared disk                 | <----------+
> > >         +-------------------------------------------+
> > >=20
> > >      1) Primary writes will read original data and forward it to Seco=
ndary
> > >         QEMU.
> > >      2) The hidden-disk is created automatically. It buffers the orig=
inal content
> > >         that is modified by the primary VM. It should also be an empt=
y disk, and
> > >         the driver supports bdrv_make_empty() and backing file.
> > >      3) Primary write requests will be written to Shared disk.
> > >      4) Secondary write requests will be buffered in the active disk =
and it
> > >         will overwrite the existing sector content in the buffer.
> > >=20
> > > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > > Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> > > Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> >=20
> > Are there any restrictions on the shared disk?  For example the -drive
> > cache=3D mode must be 'none'.  If the cache mode isn't 'none' the
> > secondary host might have old data in the host page cache.  The
>=20
> While do checkpoint, we will call vm_stop(), in which, the bdrv_flush_all=
()
> will be called, is it enough ?
>=20
> > Secondary QEMU would have an inconsistent view of the shared disk.
> >=20
> > Are image file formats like qcow2 supported for the shared disk?  Extra
>=20
> In the above scenario, it has no limitation of formats for the shared dis=
k.
>=20
> > steps are required to achieve consistency, see bdrv_invalidate_cache().
> >=20
>=20
> Hmm, in that case, we should call bdrv_invalidate_cache_all() while check=
point.

Yes, it's not enough to just call bdrv_drain_all()/bdrv_flush_all().
The Secondary may need to reread metadata that is loaded in memory (e.g.
qcow2's L2 table cache) so bdrv_invalidate_cache() is needed.

Stefan

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYwijxAAoJEJykq7OBq3PIybMH/1OOQZxRHg3745vPjLnQDgHF
gACnCNPlD3WyxlmmTBlVJw328l18FO85GHFBiIHS1aoOZgA/V/g4cagQE1HNSVzr
tVcWPmTcBBEhtcxz8U/sci3KNeNHurKO76kqU3a9K6I/pLZfSsTE1AZa46SWcZVY
vAhfOLgd6bQhIhWUTpgHaBdV4EpxEqOX0HEyXPBmd7QqNXwnCGxeBR4yRpMfx7f2
OoFNs1SU1ecCar8lO6LleL0dxsEzwsxS/226W3t1WHCzzwo408UaHCaifHXEmOi2
QxiTHehinyDqgEIwFPi4f8S2uop7mwDDB1YclA53Iynv+3g63BJgIY2UqTxyX0U=
=dL0A
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
