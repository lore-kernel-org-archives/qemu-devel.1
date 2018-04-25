Received: from eggs.gnu.org ([2001:4830:134:3::10]:54990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPfn-0003Fn-Tn
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPfk-0000tW-Ry
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:01:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBPfk-0000tM-LF
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:01:44 -0400
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<20180425124614.17182.22503.stgit@pasha-VirtualBox>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27d6cd78-5a30-eaad-8404-4d2d96db50dd@redhat.com>
Date: Wed, 25 Apr 2018 14:01:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180425124614.17182.22503.stgit@pasha-VirtualBox>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cvSCsiMmUFDcIVgjxYAiBCFBJDbJzGiw2"
Subject: Re: [Qemu-devel] [RFC PATCH 07/17] qcow2: introduce icount field
 for snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cvSCsiMmUFDcIVgjxYAiBCFBJDbJzGiw2
From: Eric Blake <eblake@redhat.com>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com,
 armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org,
 dgilbert@redhat.com, rth@twiddle.net
Message-ID: <27d6cd78-5a30-eaad-8404-4d2d96db50dd@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 07/17] qcow2: introduce icount field for
 snapshots
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
 <20180425124614.17182.22503.stgit@pasha-VirtualBox>
In-Reply-To: <20180425124614.17182.22503.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 07:46 AM, Pavel Dovgalyuk wrote:
> This patch introduces the icount field for saving within the snapshot.
> It is required for navigation between the snapshots in record/replay mo=
de.
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  block/qcow2-snapshot.c |    9 +++++++++
>  block/qcow2.h          |    2 ++
>  2 files changed, 11 insertions(+)

Missing a change to docs/interop/qcow2.txt.  You cannot add new features
into the qcow2 internal snapshot metadata without first documenting them
as part of the qcow2 spec.

>=20
> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index 74293be..4f2357e 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -103,6 +103,12 @@ int qcow2_read_snapshots(BlockDriverState *bs)
>              sn->disk_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
>          }
> =20
> +        if (extra_data_size >=3D 24) {
> +            sn->icount =3D be64_to_cpu(extra.icount);

That's VERY dangerous without a spec change.  If someone else adds extra
data in some other format, then you will misinterpret their extra
information as your icount information.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cvSCsiMmUFDcIVgjxYAiBCFBJDbJzGiw2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg0JUACgkQp6FrSiUn
Q2pUNgf6AlMVGguO81OMzuwhRzA74kbwIGtSvDtY7UeXj5NTsF2dHFDnWpTry+vX
7o45QiZHh6Q3c3/CGGonUjYxAR5O/dIPt3pZjvkFPkrVROerM7Pmht6hhMDM4FBH
58Kd1zs2vPkEMA9syShG9CKlBQUQ+ENE+o9in++geypJPp+rEHutFqHT4L+HLiLx
ePeeL0DWLSQ+7qXgNqs639lGHvZPO7f0FXLNx8KZewSsR1eBhan6bAmDRJgkpJCw
168fut3N6zFZh0v9osCm+ymV0eJ40Anx+7n4Ng6W0OF0YdgSlTcWYy8tT6dsmUFk
Vq3bcX5qmnJw0xjQtwZj62dXf05/fQ==
=qAhy
-----END PGP SIGNATURE-----

--cvSCsiMmUFDcIVgjxYAiBCFBJDbJzGiw2--
