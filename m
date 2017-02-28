Received: from eggs.gnu.org ([2001:4830:134:3::10]:47538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cidwr-00082V-DQ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cidwq-0005h6-B3
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:19:57 -0500
Date: Tue, 28 Feb 2017 09:19:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170228091942.GA26496@stefanha-x1.localdomain>
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
	<20170215151419.GD16064@stefanha-x1.localdomain>
	<CAMRbyysZUv1YQa+veW--K9FDDLkXnY5TCSmTS4xPb1sB6kODcw@mail.gmail.com>
	<20170220110732.GE21255@stefanha-x1.localdomain>
	<CAJ1JNOdzD7DHTHGJEO2YQANDPq0kY-PEh6J1jBkP7hUW0Kvy9w@mail.gmail.com>
	<CAMRbyyssi_rspwDJTtWM1Ju5CTZ15z1xBikRDONrS84rx+B8Qg@mail.gmail.com>
	<CAJ1JNOcOKvSBswMQt+2y_jkjHRUeVo33CfJRKhsPfeqfOqMnuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <CAJ1JNOcOKvSBswMQt+2y_jkjHRUeVo33CfJRKhsPfeqfOqMnuA@mail.gmail.com>
Subject: Re: [Qemu-devel] Estimation of qcow2 image size converted from raw
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maor Lipchuk <mlipchuk@redhat.com>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org, Allon Mureinik <amureini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow Huston <jhuston@redhat.com>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 06:15:47PM +0200, Maor Lipchuk wrote:
> Hi all,
>=20
> Thank you very much for your help, it was much helpful
> We adopted John Snow advice and implemented our own calculation so we
> can resolve the issue now,
> We plan to drop this code once we can get this estimation from qemu-img.
>=20
> This is the link to the patch introducing the calculation:
> https://gerrit.ovirt.org/#/c/65039/14/lib/vdsm/storage/qcow2.py
>=20
> And here are link to the tests that we added:
> https://gerrit.ovirt.org/#/c/65039/14/tests/storage_qcow2_test.py
>=20
> Here is how the calculation goes:
>=20
> We first use qemuimg map to get the used clusters and count all the
> clusters for each run returned from qemuimg.map(filename):
>=20
>  def count_clusters(runs):
>     count =3D 0
>      last =3D -1
>      for r in runs:
>          # Find the cluster when start and end are located.
>          start =3D r["start"] // CLUSTER_SIZE
>          end =3D (r["start"] + r["length"]) // CLUSTER_SIZE
>          if r["data"]:
>              if start =3D=3D end:
>                  # This run is smaller then a cluster. If we have several=
 runs
>                  # in the same cluster, we want to count the cluster only=
 once.
>                  if start !=3D last:
>                      count +=3D 1
>              else:
>                  # This run span over multiple clusters - we want to coun=
t all
>                  # the clusters this run touch.
>                  count +=3D end - start
>              last =3D end
>      return count
>=20
>=20
> The following calculation is based on Kevin's comments on the original
> bug, and qcow2 spec:
> https://github.com/qemu/qemu/blob/master/docs/specs/qcow2.txt:
>=20
>      header_size =3D 3 * CLUSTER_SIZE

Are you including the L1 table in these 3 clusters?

>      virtual_size =3D os.stat(filename).st_size

This assumes the input file is in raw format.  If the input file is in
vmdk, vhdx, qcow2, etc then the POSIX file size does not represent the
virtual disk size.

>=20
>      # Each 512MiB has one l2 table (64K)
>      l2_tables =3D (virtual_size + (512 * 1024**2) - 1) // (512 * 1024**2)
>      l2_tables_size =3D l2_tables * CLUSTER_SIZE
>=20
>      # Each cluster have a refcount entry (16 bits) in the refcount table=
s. It
>      # is not clear what is the size of the refcount table, lets assume i=
t is
>      # the same size as the l2 tables.
>      refcounts_tables_size =3D l2_tables_size

There is a formula for calculating refcount blocks in qcow2_create2():

  /* total size of refcount blocks
   *
   * note: every host cluster is reference-counted, including metadata
   * (even refcount blocks are recursively included).
   * Let:
   *   a =3D total_size (this is the guest disk size)
   *   m =3D meta size not including refcount blocks and refcount tables
   *   c =3D cluster size
   *   y1 =3D number of refcount blocks entries
   *   y2 =3D meta size including everything
   *   rces =3D refcount entry size in bytes
   * then,
   *   y1 =3D (y2 + a)/c
   *   y2 =3D y1 * rces + y1 * rces * sizeof(u64) / c + m
   * we can get y1:
   *   y1 =3D (a + m) / (c - rces - rces * sizeof(u64) / c)
   */
  nrefblocke =3D (aligned_total_size + meta_size + cluster_size)
             / (cluster_size - rces - rces * sizeof(uint64_t)
                                           / cluster_size);
  meta_size +=3D DIV_ROUND_UP(nrefblocke, refblock_size) * cluster_size;

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtUCuAAoJEJykq7OBq3PI/T4H/iN00p8I1gN3S7jQg/AzQNGr
ahGJYew945VdPqlllZ5j3WYiSUu1+ACAz7RccgeCMe+Nx/xnl4YYCanuONC/E4lZ
5tbQKlzwpv4vJ9XMarxXyMmTHwMuCVvEFtY50n4LJ2nqkRLSPtcN9zzO8sSkPhWO
fVHXUO9nVcFHXqxvGcKX3XVOQ8nx9We4QJAyN4V2R7G07cg57HFrW3RjwlGtXtBL
tBp3B/vNUF6woKH1roKQJ16g1b4ckYsusizZHqLZbEmPttO05ArWkFd54P8UatYO
Rx6tE9bQR2bYxXTvV5qpPU0hR54iI+NS51Zb/FaS4KK/PZo9JpMrCYlrN6eFiFM=
=UIXK
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
