Received: from eggs.gnu.org ([2001:4830:134:3::10]:56604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSjcI-0005xz-Ik
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSjcH-0005ZJ-Dv
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:41:14 -0400
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
	<20170704084059.6278-2-el13635@mail.ntua.gr>
	<20170704094417.GA4253@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0b3851d-c9b8-81fb-75c5-ceb6392f8c24@redhat.com>
Date: Wed, 5 Jul 2017 07:40:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170704094417.GA4253@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pN2IQl6Qoj6p1LLCv4TSKQNKvN52aLg2B"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] block: Pass bdrv_* methods to
 bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, "libvir-list@redhat.com" <libvir-list@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pN2IQl6Qoj6p1LLCv4TSKQNKvN52aLg2B
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>
Message-ID: <b0b3851d-c9b8-81fb-75c5-ceb6392f8c24@redhat.com>
Subject: Re: [PATCH v3 1/4] block: Pass bdrv_* methods to bs->file by default
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
 <20170704084059.6278-2-el13635@mail.ntua.gr>
 <20170704094417.GA4253@noname.str.redhat.com>
In-Reply-To: <20170704094417.GA4253@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding libvirt for block size discussion]

On 07/04/2017 04:44 AM, Kevin Wolf wrote:
> Am 04.07.2017 um 10:40 hat Manos Pitsidianakis geschrieben:
>> The following functions fail if bs->drv does not implement them:
>>
>> bdrv_probe_blocksizes
>> bdrv_probe_geometry
>> bdrv_truncate
>> bdrv_has_zero_init
>> bdrv_get_info
>> bdrv_media_changed
>> bdrv_eject
>> bdrv_lock_medium
>> bdrv_co_ioctl
>>
>> Instead, the call should be passed to bs->file if it exists, to allow
>> filter drivers to support those methods without implementing them.
>>

>=20
>> +        return bdrv_probe_blocksizes(bs->file->bs, bsz);
>>      }
>> =20
>>      return -ENOTSUP;
>=20
> This change actually changes existing behaviour. Basically, all of your=

> additions also apply for qcow2 images or other image formats, and we
> need to check whether they make sense there.
>=20
> bdrv_probe_blocksizes() is used for the default values for the physical=

> and logical block sizes for block devices if no value is explicitly
> specified in -device. This makes sense as it will allow the guest to
> optimise its requests so that they align with the block size that is
> optimal for the storage that contains the image. (I also think that we
> probably should implement .bdrv_probe_blocksizes() not only for
> host_device, but also for regular files to get optimal performance by
> default.)
>=20
> Changing the defaults can be a problem for cross-version live migration=

> if the default values are used. Management tools that want to do live
> migration are supposed to explicitly provide all options they can, so
> this should be okay.
>=20
> Eric, does libvirt set the physical/logical block size explicitly? If
> not, it would be good if it started to do so.

Libvirt supports user control of block size via this XML in <disk>:
    <blockio logical_block_size=3D'512' physical_block_size=3D'4096'/>
which it translates to command-line logical_block_size=3D and
physical_block_size=3D.  But I didn't see anywhere that libvirt tries to
do anything with block size in QMP, which makes me wonder if that is a
libvirt bug for not allowing a block size when hot-plugging a drive, or
a weakness in QMP.

Your point that if libvirt isn't always specifying block size, then we
risk the block size changing on migration (that is, libvirt should be
patched to specify block size always, and not just when the XML
specifies it).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pN2IQl6Qoj6p1LLCv4TSKQNKvN52aLg2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXN5bAAoJEKeha0olJ0NqwBsIAJ+eDn2aah005aMonQJAZW5T
NuBbo2ymlqAWH2lfOh0vK0+7GhAi2cx6uehsZx8HaJ7Vzehpi7cap8X24BvnWC27
advM9D8ywLgRSjEfYB5Lt3Qf6B8nEcAbz7r8gWP/51wk6/phg+E3M745lCya/ERX
fteUNuJGH7sLRa121xqlZoKUYfJxYyjUdB+PE/HBNfBfPqcUSyIQ68ext5mNzs5j
b/glX1KRLmUG1UKM881mI73Vwu2FezLpvZJ6MAX3cxR7oyH3o8tVNruQrK9WWTUu
0DlfqEk2HTO53YEa5sK540D7X6LQJRXNZgJR0pPuqF1klb20udtuCBRwNA53oxo=
=yqQj
-----END PGP SIGNATURE-----

--pN2IQl6Qoj6p1LLCv4TSKQNKvN52aLg2B--
