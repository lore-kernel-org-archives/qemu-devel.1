Received: from eggs.gnu.org ([2001:4830:134:3::10]:45925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ10K-00078A-5w
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 14:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ10J-0007j3-3H
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 14:55:44 -0500
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ebca91ef-52f0-2f2c-d52f-d95569ec73e2@redhat.com>
Date: Wed, 1 Feb 2017 20:55:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6KD9E9q0uXx4m7ScSRsnAaVt3qPPULj1c"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/3] scsi-generic and
 BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6KD9E9q0uXx4m7ScSRsnAaVt3qPPULj1c
From: Max Reitz <mreitz@redhat.com>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <ebca91ef-52f0-2f2c-d52f-d95569ec73e2@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 0/3] scsi-generic and BLKSECTGET
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
In-Reply-To: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 20.01.2017 17:25, Eric Farman wrote:
> In the Linux kernel, I see two (three) places where the BLKSECTGET ioct=
l is
> handled:
>
> (1) block/(compat_)ioctl.c -- (compat_)blkdev_ioctl
> (2) drivers/scsi/sg.c -- sg_ioctl
>
> The former has been around forever[1], and returns a short value measur=
ed in
> sectors.  A sector is generally assumed to be 512 bytes.
>
> The latter has been around for slightly less than forever[2], and retur=
ns an
> int that measures the value in bytes.  A change to return the block cou=
nt
> was brought up a few years ago[3] and nacked.
>
> As a convenient example, if I use the blockdev tool to drive the ioctl =
to a
> SCSI disk and its scsi-generic equivalent, I get different results:
>
>   # lsscsi -g
>   [0:0:8:1077166114]disk    IBM      2107900          .217  /dev/sda /d=
ev/sg0
>   # blockdev --getmaxsect /dev/sda
>   2560
>   # blockdev --getmaxsect /dev/sg0
>   20
>
> Now, the value for /dev/sda looks "correct" to me.
>
>   # cd /sys/devices/css0/0.0.0125/0.0.1f69/host0/rport-0\:0-8/
>   # cd target0\:0\:8/0\:0\:8\:1077166114/
>   # cat block/sda/queue/max_sectors_kb
>   1280
>   # cat block/sda/queue/hw_sector_size
>   512
>
> And the math checks out:
>
>   max_sectors_kb * 1024 / hw_sector_size =3D=3D getmaxsect
>   -OR-
>   1280 * 1024 / 512 =3D 2560
>
> For /dev/sg0, it appears the answer is coming from the sg_ioctl result
> which is already multiplied by the block size, and then looking at only=
 the
> upper half (short) of the returned big-endian fullword:
>
>   (1280 * 1024 / 512) * 512 =3D 1310720 =3D x00140000 =3D> x0014 =3D 20=

>
> The reason for all this?  Well, QEMU recently added a BLKSECTGET ioctl
> call[4] which we see during guest boot.  This code presumes the value i=
s in
> blocks/sectors, and converts it to bytes[5].  Not that this matters, be=
cause
> the short/int discrepancy gives us "zero" on s390x.
>
> Also, that code doesn't execute for scsi-generic devices, so the conver=
sion
> to bytes is correct, but I'd like to extend this code to interrogate
> scsi-generic devices as well.  This is important because libvirt conver=
ts
> a specified virtio-scsi device to its /dev/sgX address for the QEMU
> commandline.
>
> Changes:
>  v2->v3:
>   - Move byte/sector conversions to patch 2 [Fam Zheng]
>   - Rename "max_sectors" when holding a byte value [Fam Zheng]
>  v1->v2:
>   - Patch 3, make hdev_get_max_transfer_length return bytes [Fam Zheng]=

>
> [1] The initial kernel git commit
> [2] kernel commit 44ec95425c1d9dce6e4638c29e4362cfb44814e7
> [3] https://lkml.org/lkml/2012/6/27/78
> [4] qemu commit 6f6071745bd0366221f5a0160ed7d18d0e38b9f7
> [5] qemu commit 5def6b80e1eca696c1fc6099e7f4d36729686402=20
>
> Eric Farman (3):
>   hw/scsi: Fix debug message of cdb structure in scsi-generic
>   block: Fix target variable of BLKSECTGET ioctl
>   block: get max_transfer limit for char (scsi-generic) devices
>
>  block/file-posix.c     | 19 +++++++++++--------
>  hw/scsi/scsi-generic.c |  5 +++--
>  include/block/block.h  |  1 +
>  3 files changed, 15 insertions(+), 10 deletions(-)

Thank you, I've applied the series to my block tree (with the macro
definitions in patch 2 switched as proposed):

https://github.com/XanClic/qemu/commits/block

Max


--6KD9E9q0uXx4m7ScSRsnAaVt3qPPULj1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSPTUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzFEH/iId8fl/e8L7s7GJxKDN6M709Ghn5Siu
51MzOhS74fxLzEzgnY55heeAd1xJMsOv1BQWMPRdpN/apAk+c86DjK7F3U5GCEPl
eN/bRokWVecA6D/5z0JbiHQYDtiFwy7FAuLIxUpMnLNhwwG3jpKb/QTh6qHH6ewz
ZwvkM//AgfRo1MZ77QzivkEYI3t4/TjHDJUpCskZgrHjtM8AobniOQo4oAl+yA5s
WkrVNVYjTxGd7DBXzyBAcweeJIdvqQGlZChD7O+pvd0PTn82naZOUn5qBi2dgiiQ
WqBSdfH9JS33Chq/tKjymUXXrG9BdSfj5zN5NnHqt+/3HbZ6jIm0V7c=
=UhcN
-----END PGP SIGNATURE-----

--6KD9E9q0uXx4m7ScSRsnAaVt3qPPULj1c--
