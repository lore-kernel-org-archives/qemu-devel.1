Received: from eggs.gnu.org ([2001:4830:134:3::10]:56618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f44QF-0007LJ-M0
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f44QE-0006UO-49
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:55:23 -0400
Date: Thu, 5 Apr 2018 13:55:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180405125509.GJ32222@stefanha-x1.localdomain>
References: <20180329110914.20888-1-famz@redhat.com>
	<20180404132332.GR4467@stefanha-x1.localdomain>
	<20180404134923.GL12052@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pMCBjikF2xGw87uL"
Content-Disposition: inline
In-Reply-To: <20180404134923.GL12052@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/8] qemu-img convert with
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com


--pMCBjikF2xGw87uL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 09:49:23PM +0800, Fam Zheng wrote:
> On Wed, 04/04 14:23, Stefan Hajnoczi wrote:
> > On Thu, Mar 29, 2018 at 07:09:06PM +0800, Fam Zheng wrote:
> > > [Posting a preview RFC for the general idea discussion and internal A=
PI review.
> > > Libiscsi support is being worked on in the meantime.]
> > >=20
> > > This series introduces block layer API for copy offloading and makes =
use of it
> > > in qemu-img convert.
> > >=20
> > > For now we implemented the operation in local file protocol with
> > > copy_file_range(2).  Besides that it's possible to add similar to isc=
si, nfs
> > > and potentially more.
> > >=20
> > > As far as its usage goes, in addition to qemu-img convert, we can emu=
late
> > > offloading in scsi-disk (EXTENDED COPY), and do similar to drive-mirr=
or.
> > >=20
> > > The new bdrv_co_map_range can also be an alternative way to implement=
 format
> > > drivers in the future, once we make block/io.c use it in preadv/pwrit=
ev paths.
> >=20
> > I posted concerns about the bdrv_co_map_range() interface.  It would be
> > safer to only have a copy_range() interface without exposing how data is
> > mapped outside the driver where race conditions can occur and the format
> > driver no longer has full control over file layout.
>=20
> It's a good point, but I couldn't think of a way to implement copy_range =
between
> two format drivers: both of them need to recurse down to their bs->file a=
nd what
> we eventually want is a copy_file_range() on two fds (or an iscsi equival=
ent):
>=20
>     src[qcow2]           ->              dst[raw]
>         |                                   |
>         v                                   v
>     src[file]            ->              dst[file]
>         |                                   |
>         v                                   v
>        fd1               ->                 fd2
>                     copy_file_range
>=20
> Maybe we should add BlockDriver.bdrv_co_map_range_{prepare,commit,abort} =
and
> call them from bdrv_co_copy_range(). This way the code path works pretty =
much
> the same way to .bdrv_co_preadv/pwritev.

Regarding the recursion, there are two phases:
1. Finding the leaf BDS of the source (the left side of your diagram)
2. finding the leaf BDS of the destination (the right side)

Here is one way to represent this in BlockDriver:

  /* Map [offset, offset + nbytes) range onto a child of src_bs and
   * invoke bdrv_co_copy_file_range_src(child, ...), or invoke
   * bdrv_co_copy_file_range_dst() if the leaf child has been found.
   */
  .bdrv_co_copy_file_range_src(src_bs, dst_bs, offset, nbytes)

  /* Map [offset, offset + nbytes) range onto a child of dst_bs and
   * invoke bdrv_co_copy_file_range_src(src_bs, child, ...), or perform
   * the copy operation if the leaf child has been found.  Return
   * -ENOTSUP if src_bs and the leaf child have different BlockDrivers.
   */
  .bdrv_co_copy_file_range_dst(src_bs, dst_bs, offset, nbytes)

bdrv_copy_file_range() will invoke bdrv_co_copy_file_range_src() on
src[qcow2].  The qcow2 block driver will invoke
bdrv_co_copy_file_range_src() on src[file].  The file-posix driver will
invoke bdrv_co_copy_file_range_dst() on dst[raw].  The raw driver will
invoke bdrv_co_copy_file_range_dst() on dst[file], which sees that
src_bds (src[file]) is also file-posix and then goes ahead with
copy_file_range(2).

In the case where src[qcow2] is on file-posix but dst[raw] is on iSCSI,
the iSCSI .bdrv_co_copy_file_range_dst() call fails with -ENOTSUP and
the block layer can fall back to a traditional copy operation.

With this approach src[qcow2] could take a lock or keep track of a
serializing request struct so that other requests cannot interfere with
the operation, and it's done in a natural way since we remain in the
qcow2 function until the entire operation completes.  There's no need
for bookkeeping structs or callbacks.

Stefan

--pMCBjikF2xGw87uL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxhysAAoJEJykq7OBq3PIrL0H/iy8MIhAZUmWj4Lfuf4FPV+M
nVl/DTt3tRg3lRO13Er+UKML9hgLYim/ZcchuyL+Aev8y3J5bcF41ts69HrpWgYv
1M7XviawiIJ3nP3kv3zEDFG/boPd3HF5H2HhnxTCiBPmtVFFfMQvXUe4SPO+DQlj
0KVIUWWbrGnHr7n+TmBCXqdjeC63+HgJG750DHwFTeo1BqS6aT0vgUfdM+FRNHwf
I0W6MiBXd24Yd5RQ5cN3ueULLTGDiee/puaveagL6PFqhkBLmOXZzmoCQ+qnImm0
SZjkAerzpa4ygTsfZnk2STpjzB1+zn86DazmKTvzPP+UXpSeZSVdms8QJHdW/lQ=
=Jb5B
-----END PGP SIGNATURE-----

--pMCBjikF2xGw87uL--
