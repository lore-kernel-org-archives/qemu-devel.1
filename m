Received: from eggs.gnu.org ([2001:4830:134:3::10]:57964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbanq-0005Y3-6V
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbank-0004Xr-Bi
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:33:28 -0500
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
	<ebca91ef-52f0-2f2c-d52f-d95569ec73e2@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7c45fcaf-56dc-097b-14b0-ac497fd1ab6b@redhat.com>
Date: Wed, 8 Feb 2017 23:33:14 +0100
MIME-Version: 1.0
In-Reply-To: <ebca91ef-52f0-2f2c-d52f-d95569ec73e2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hOPGFaNW61GePkdicFwv3NWOoXApU7vrS"
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
--hOPGFaNW61GePkdicFwv3NWOoXApU7vrS
From: Max Reitz <mreitz@redhat.com>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <7c45fcaf-56dc-097b-14b0-ac497fd1ab6b@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 0/3] scsi-generic and BLKSECTGET
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
 <ebca91ef-52f0-2f2c-d52f-d95569ec73e2@redhat.com>
In-Reply-To: <ebca91ef-52f0-2f2c-d52f-d95569ec73e2@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 20:55, Max Reitz wrote:
> On 20.01.2017 17:25, Eric Farman wrote:
>> In the Linux kernel, I see two (three) places where the BLKSECTGET ioc=
tl is
>> handled:
>>
>> (1) block/(compat_)ioctl.c -- (compat_)blkdev_ioctl
>> (2) drivers/scsi/sg.c -- sg_ioctl
>>
>> The former has been around forever[1], and returns a short value measu=
red in
>> sectors.  A sector is generally assumed to be 512 bytes.
>>
>> The latter has been around for slightly less than forever[2], and retu=
rns an
>> int that measures the value in bytes.  A change to return the block co=
unt
>> was brought up a few years ago[3] and nacked.
>>
>> As a convenient example, if I use the blockdev tool to drive the ioctl=
 to a
>> SCSI disk and its scsi-generic equivalent, I get different results:
>>
>>   # lsscsi -g
>>   [0:0:8:1077166114]disk    IBM      2107900          .217  /dev/sda /=
dev/sg0
>>   # blockdev --getmaxsect /dev/sda
>>   2560
>>   # blockdev --getmaxsect /dev/sg0
>>   20
>>
>> Now, the value for /dev/sda looks "correct" to me.
>>
>>   # cd /sys/devices/css0/0.0.0125/0.0.1f69/host0/rport-0\:0-8/
>>   # cd target0\:0\:8/0\:0\:8\:1077166114/
>>   # cat block/sda/queue/max_sectors_kb
>>   1280
>>   # cat block/sda/queue/hw_sector_size
>>   512
>>
>> And the math checks out:
>>
>>   max_sectors_kb * 1024 / hw_sector_size =3D=3D getmaxsect
>>   -OR-
>>   1280 * 1024 / 512 =3D 2560
>>
>> For /dev/sg0, it appears the answer is coming from the sg_ioctl result=

>> which is already multiplied by the block size, and then looking at onl=
y the
>> upper half (short) of the returned big-endian fullword:
>>
>>   (1280 * 1024 / 512) * 512 =3D 1310720 =3D x00140000 =3D> x0014 =3D 2=
0
>>
>> The reason for all this?  Well, QEMU recently added a BLKSECTGET ioctl=

>> call[4] which we see during guest boot.  This code presumes the value =
is in
>> blocks/sectors, and converts it to bytes[5].  Not that this matters, b=
ecause
>> the short/int discrepancy gives us "zero" on s390x.
>>
>> Also, that code doesn't execute for scsi-generic devices, so the conve=
rsion
>> to bytes is correct, but I'd like to extend this code to interrogate
>> scsi-generic devices as well.  This is important because libvirt conve=
rts
>> a specified virtio-scsi device to its /dev/sgX address for the QEMU
>> commandline.
>>
>> Changes:
>>  v2->v3:
>>   - Move byte/sector conversions to patch 2 [Fam Zheng]
>>   - Rename "max_sectors" when holding a byte value [Fam Zheng]
>>  v1->v2:
>>   - Patch 3, make hdev_get_max_transfer_length return bytes [Fam Zheng=
]
>>
>> [1] The initial kernel git commit
>> [2] kernel commit 44ec95425c1d9dce6e4638c29e4362cfb44814e7
>> [3] https://lkml.org/lkml/2012/6/27/78
>> [4] qemu commit 6f6071745bd0366221f5a0160ed7d18d0e38b9f7
>> [5] qemu commit 5def6b80e1eca696c1fc6099e7f4d36729686402=20
>>
>> Eric Farman (3):
>>   hw/scsi: Fix debug message of cdb structure in scsi-generic
>>   block: Fix target variable of BLKSECTGET ioctl
>>   block: get max_transfer limit for char (scsi-generic) devices
>>
>>  block/file-posix.c     | 19 +++++++++++--------
>>  hw/scsi/scsi-generic.c |  5 +++--
>>  include/block/block.h  |  1 +
>>  3 files changed, 15 insertions(+), 10 deletions(-)
>=20
> Thank you, I've applied the series to my block tree (with the macro
> definitions in patch 2 switched as proposed):
>=20
> https://github.com/XanClic/qemu/commits/block

Noticed now that Paolo has already merged this. Well, then out it goes.
Too bad the swap of BDRV_REQUEST_MAX_BYTES and BDRV_REQUEST_MAX_SECTORS
is not in his tree.

Well, I'll make it an own patch then.

Max


--hOPGFaNW61GePkdicFwv3NWOoXApU7vrS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibnKoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AFQsIAKT81GNoJFiiB1Sy3+9joR7wC1La2q1L
1C7f6Pp0ftpQ2OBTMNA3ENlEIdOYRaRosQqaHWqEyl4U7tcicOyyOpauZBCRI8bE
86qIwBPRQvVdQJ7NvFqwjqOGM6LDNjWK2/XJ0VjHao+hfNv7t+ibVBlESqzGdLFg
fAAhd0MLapIwPD7mXq0YKpZm8jfg6dZoF0QGpg+u5HehVHwBhXXOc+ZS/lPuRFkd
zRqWKBHMQkmQVMc1Vr0c6zqYpookFQ3dIBKujJTEHyTTtH837OtUGpXa8XwPEArs
t+aHkz1RwvcFRSt/xk4YGRHcuxxLr5rYdOba3iPnVsvXkoKcGiXSUYA=
=c1Ta
-----END PGP SIGNATURE-----

--hOPGFaNW61GePkdicFwv3NWOoXApU7vrS--
