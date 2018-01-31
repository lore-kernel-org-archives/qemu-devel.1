Received: from eggs.gnu.org ([2001:4830:134:3::10]:38746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxaV-0002c6-BE
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxaU-0003S1-Iq
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:58:27 -0500
References: <20180130062503.32596-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7d94ad09-9c3e-da10-3f15-2c15147fb837@redhat.com>
Date: Wed, 31 Jan 2018 19:58:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180130062503.32596-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eikoRdCrBIFiK8TBG9H5jonEGmphxv3VE"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eikoRdCrBIFiK8TBG9H5jonEGmphxv3VE
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <7d94ad09-9c3e-da10-3f15-2c15147fb837@redhat.com>
Subject: Re: [PATCH] iotests: Fix CID for VMDK afl image
References: <20180130062503.32596-1-famz@redhat.com>
In-Reply-To: <20180130062503.32596-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-30 07:25, Fam Zheng wrote:
> This reverts commit 76bf133c4 which updated the reference output, and
> fixed the reference image, because the code path we want to exercise is=

> actually the invalid image size.
>=20
> The descriptor block in the image, which includes the CID to verify, ha=
s been
> invalid since the reference image was added. Since commit 9877860e7bd w=
e report
> this error earlier than the "file too large", so 059.out mismatches.
>=20
> The binary change is generated along the operations of:
>=20
>   $ bunzip2 afl9.vmdk.bz2
>   $ qemu-img create -f vmdk fix.vmdk 1G
>   $ dd if=3Dafl9.vmdk.bz2 of=3Dfix.vmdk bs=3D512 count=3D1 conv=3Dnotru=
nc
>   $ mv fix.vmdk afl9.vmdk
>   $ bzip2 afl9.vmdk
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v2: Fix commit message "qcow2 -> vmdk". [Kevin]
>     Revert 76bf133c4.

Hmmmm, now this fails again on my 32 bit build. :-(

The issue there is that you get a "Cannot allocate memory" when trying
to open the file.  My current fix was 2291712c39111a732 which simply
converted that to "Invalid argument", but now it's getting a bit more
complicated...  Should I just continue to play the game and check the
output for "Cannot allocate memory" and print exactly what the reference
output is expecting...?

Max


--eikoRdCrBIFiK8TBG9H5jonEGmphxv3VE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyEcsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AA+0H/RPMKCCVwIa/4l8gE2Vlwp5v/ivV3ZOd
JhjaHeCeoGO1pqR8So3thG3zPm+TGrR8CfVCvKpisIj7bpkYF5gJHwjLb4kRNMKw
ffZDnELOWfIuufOjDMy5Kxh5pTdQ2VUUU4OlwG2EdDtsN43fWC0G67+28JRnlvm/
JyS3x/uxp30MkcPtmEH0h2OlhJbwmRjxcgInhPERhl8Vq3c1+fM+hbLyudnv5mAi
cGuZYlB+x6yRYPDyEU4LIaMziFzgr1FKFvhN4f6M3rLw/6S8pFmExiXYZaMiu6GD
WQwlwOcZmhjw/0JuO13oEgHGmVoufaUfM/aHWPysLogf+++YzSOdjRo=
=zi9u
-----END PGP SIGNATURE-----

--eikoRdCrBIFiK8TBG9H5jonEGmphxv3VE--
