Received: from eggs.gnu.org ([2001:4830:134:3::10]:58571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1JW3-0000st-C2
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1JVz-0004WH-VU
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:21:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d1JVz-0004VA-LW
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:21:23 -0400
References: <58F92229.1080402@windriver.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a09762ce-092f-6fb1-6cc3-08a94a3c3dd1@redhat.com>
Date: Thu, 20 Apr 2017 16:21:16 -0500
MIME-Version: 1.0
In-Reply-To: <58F92229.1080402@windriver.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WQHX0INf0l7FqHLSuHi1PTWqArTVD1miE"
Subject: Re: [Qemu-devel] question about block size and virtual disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Friesen <chris.friesen@windriver.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WQHX0INf0l7FqHLSuHi1PTWqArTVD1miE
From: Eric Blake <eblake@redhat.com>
To: Chris Friesen <chris.friesen@windriver.com>, qemu-devel@nongnu.org
Message-ID: <a09762ce-092f-6fb1-6cc3-08a94a3c3dd1@redhat.com>
Subject: Re: [Qemu-devel] question about block size and virtual disks
References: <58F92229.1080402@windriver.com>
In-Reply-To: <58F92229.1080402@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 04:03 PM, Chris Friesen wrote:
> Hi,
>=20
> Suppose the host has a physical disk that only supports 4KB access, wit=
h
> no 512B fallback.
>=20
> If we boot a guest with "cache=3Dnone", does the guest need to be able =
to
> handle disks with 4KB blocks or is qemu able to handle guests trying to=

> access the disk with 512B granularity?

qemu should be able to handle the fallback automatically (that is, the
block layer is smart enough to honor bs->bl.request_alignment=3D4096 such=

that it will never submit a request smaller than 4096 to the underlying
host storage, regardless of what size request the guest uses).

In fact, the blkdebug driver can be used to test this setup on top of
any real driver constraints, so we have some pretty good assurance that
our minimum-size code works even when tested on a platform that still
has 512B granularity.

>=20
> Also, does the 4KB block size get "passed-through" to the guest somehow=

> so that the guest knows it needs to use 4KB blocks, or does that need t=
o
> be explicitly specified via virtio-blk-pci.logical_block_size and/or
> virtio-blk-pci.physical_block_size parameters?  (Assuming I'm using
> virtio-blk-pci.)

Again, qemu should be passing the advertisement of host properties down
to the guest insofar as possible (so a good guest will see that the
hardware is 4k only and will not try to make 512-byte requests), but at
the same time, qemu should handle guests that are so old that they are
blissfully unaware of the hardware advertisements and send 512-byte
requests anyway.  Of course, such guests are penalized with
read-modify-write delays when submitting 512-byte IO.  But explicitly
stating available parameters is always the wisest course of action, if
you don't want to rely on defaults changing underneath you.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WQHX0INf0l7FqHLSuHi1PTWqArTVD1miE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+SZMAAoJEKeha0olJ0Nqy9sH/jy/aszYhVmFlUCZvqIY3GhK
iROq1vGQVXFltBX+cEvdg/6F8QLiudnQ9ef0TbrHYiwBaO64IxI8vNAtlh1bgKTW
lTnedHczf1VPbJirQHwpfHcg71Yy4Ua6bSuct15+yQQMaXJVh0jLx/dWzpToJuxf
wgaZBMyAj76ZFCur0v9o6Mwzl7CVv6WjHIoHpPOMIxDqqhkzYkjusn/h4T1psA65
lWgdaglaecr6wqRJXML79i3wIDfmLEBOhuMS+ZfeTFR4sEyYEn2Z7fJeCGRKWXJS
dpdBZrt0QErfZR8Hs7mestR6sZSGNZZccGwyngj5EwZO/sMduQewnTRZnEVCaIA=
=oEMI
-----END PGP SIGNATURE-----

--WQHX0INf0l7FqHLSuHi1PTWqArTVD1miE--
