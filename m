Received: from eggs.gnu.org ([2001:4830:134:3::10]:38157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWPy6-0002OC-DA
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 10:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWPy5-0006Lv-ML
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 10:58:42 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e10208d6-ade6-f31d-83b1-12a12cff6e7f@redhat.com>
Date: Wed, 25 Jan 2017 16:58:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mhfuTNBB1iwBdGnR733lNppe5eUQwJEwU"
Subject: Re: [Qemu-devel] [PATCH v1 00/15] Convert QCow[2] to QCryptoBlock &
 add LUKS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mhfuTNBB1iwBdGnR733lNppe5eUQwJEwU
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <e10208d6-ade6-f31d-83b1-12a12cff6e7f@redhat.com>
Subject: Re: [PATCH v1 00/15] Convert QCow[2] to QCryptoBlock & add LUKS
 support
References: <20170103182801.9638-1-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-1-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> This series is a continuation of previous work to support LUKS in
> QEMU. The existing merged code supports LUKS as a standalone
> driver which can be layered over/under any other QEMU block device
> driver. This works well when using LUKS over protocol drivers (file,
> rbd, iscsi, etc, etc), but has some downsides when combined with
> format drivers like qcow2.

When trying out whether compressed images are actually encrypted (which
they are not, as I wrote in my last reply to patch 12), I noticed that
the user interface still has some flaws:

One is that you actually can't convert to encrypted images any more, or
if you can, it doesn't seem obvious to me:

$ ./qemu-img convert -O qcow2 --object secret,id=3Dsec0,data=3D12345 \
    -o encryption-format=3Dluks,luks-key-secret=3Dsec0 \
    foo.qcow2 bar.qcow2
qemu-img: Could not open 'bar.qcow2': Parameter 'key-secret' is required
for cipher

The issue is that you have to specify the key secret as a runtime
parameter in addition to the creation option. Not only is that a bit
cumbersome, but it's also impossible because --image-opts doesn't work
for the output image.

The second flaw is also visible above: The parameter is called
"luks-key-secret" here, not just "key-secret". The error message should
reflect that.

Max


--mhfuTNBB1iwBdGnR733lNppe5eUQwJEwU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliIyygSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3d8IAMLZgAJ6uvLGHW2j3GUhqISySpaGCiB7
ymsWIh30ATwkG22133sVFL7eh7RL4GZi00slcTc2FSgNxP+366dEo8loAN1B0Ut2
SrK9bFTr3Mwi36AeOJPswcxTYVOSfDDlYy99MKgBYN3dNu9vZMSI+IgsErRyK8j6
MeXws4Sjx8H4unpA3+rOjQzNkLEnQUniqULB5lKK0Tmi5wS7286bQRg3jHTO4isa
RN7W109NMrnC6BQSbIlcyTb2NUSz9FfPiHoLqKgVmGHSp/8IBqHr9DizSYly8Msl
ySZF8z+eODLUa4CMa4nWKbaioG1ieMLoIDfkw+10FR7MMo0tJwOVN18=
=Rb7N
-----END PGP SIGNATURE-----

--mhfuTNBB1iwBdGnR733lNppe5eUQwJEwU--
