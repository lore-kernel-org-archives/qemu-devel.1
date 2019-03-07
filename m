Received: from eggs.gnu.org ([209.51.188.92]:45721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1xF9-0007JD-R3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1xF8-0007re-Rv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:55:43 -0500
References: <20190307093723.655-1-armbru@redhat.com>
	<20190307093723.655-3-armbru@redhat.com>
	<87h8cft2x6.fsf@dusky.pond.sub.org>
	<20190307145532.GG5786@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <577a1757-4c00-1ea2-ae52-ffa8c244a797@redhat.com>
Date: Thu, 7 Mar 2019 11:55:36 -0600
MIME-Version: 1.0
In-Reply-To: <20190307145532.GG5786@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VZkULjj1I5POH7qQgUOYdzjEfVLJFxFAo"
Subject: Re: [Qemu-devel] [RFC PATCH v6 2/4] hw/block: Pad undersized
 read-only images with 0xFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, alex.bennee@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, lersek@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VZkULjj1I5POH7qQgUOYdzjEfVLJFxFAo
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, alex.bennee@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, lersek@redhat.com
Message-ID: <577a1757-4c00-1ea2-ae52-ffa8c244a797@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v6 2/4] hw/block: Pad undersized
 read-only images with 0xFF
References: <20190307093723.655-1-armbru@redhat.com>
 <20190307093723.655-3-armbru@redhat.com> <87h8cft2x6.fsf@dusky.pond.sub.org>
 <20190307145532.GG5786@linux.fritz.box>
In-Reply-To: <20190307145532.GG5786@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 8:55 AM, Kevin Wolf wrote:

>>     00000ff0:  79 0a 79 0a 79 0a 79 0a 79 0a 00 00 00 00 00 00  y.y.y.=
y.y.......
>>     read 96/96 bytes at offset 4000
>>     96 bytes, 1 ops; 0.0001 sec (694.444 KiB/sec and 7407.4074 ops/sec=
)
>>
>>    This patch then pads some more with 0xFF to the flash memory size.
>>
>>    Because of that the way the magic padding works makes no sense, to =
be
>>    frank.  Going back to v3's zero padding would at least be explainab=
le
>>    without blushing.
>>
>>    I consider the block layer's padding a misfeature here, but right n=
ow
>>    we got to play the hand we've been dealt.
>=20
> That will be solved as soon as the block layer is consistently converte=
d
> to byte granularity. We've already converted a lot, but bdrv_getlength(=
)
> is still sector (512 bytes) granularity.
>=20
> You could argue that file-posix should just reject files that are not
> sector aligned, but that's probably not right either because image
> formats don't necessarily have that alignment for their files.
>=20
> Maybe disk device should reject being attached to nodes that aren't a
> multiple of their physical and logical sector size. A 512-byte aligned
> image is probably suitable for most disks, but might not be for a virtu=
al
> native 4k disk.

nbdkit has a filter that allows padding any non-sector-aligned image out
to the next sector alignment, where reads from the tail see zero, writes
_of zero_ to the tail succeed, but writes of non-zero fail (I don't know
if it prefers EIO or ENOSPC, but that's secondary).  I have an open bug
against the nbd block driver where we can trigger assertions on
unaligned file sizes; and it would definitely be nice to fix it globally
in the block layer rather than copy-and-paste piecemeal in every
affected driver.

I may still fix NBD for 4.0 during soft freeze to avoid the assert, but
that fix will be a bare-bones bandaid (enough to avoid the assertion
failures, and no more).  But yes, I definitely agree that a 4.1 project
of making bdrv_getlength() be byte-aware coupled with block-layer smarts
about handling the tail when widening from a smaller alignment to a
larger is going to make a lot of things nicer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--VZkULjj1I5POH7qQgUOYdzjEfVLJFxFAo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBWxgACgkQp6FrSiUn
Q2qDhQf9HC0g6uhZg1odd9zokdE3ALwShHI574ROwt2RkHFuNsfbLEAydzWmpVSX
Sq16qzzdj8qjGysXCaNunoQ7/BHDIE+3aD9vr2Fkb/PTvaFHa9pR0NZB4sxye4h9
pQyjOfXF+yTpCiCNP7RdK7xPkbRg2R4kGsmg2ZiHGjIPEnlPXkrfNHUK4sQ2yMjo
HUyZAhObpRmIgyO5i0oDwtvewyR5auMuOEX+AkM/K27+HCP0iW+FALc/RJfvui9s
9GP8wH80GKN57OVpFYxR6K55EmzbcCFX1XtN+rXTowzJV86rXMhNxp5aDDRuFrfx
sUDsClGlNxCk9aJBAWjo2uumMgagwQ==
=w/T3
-----END PGP SIGNATURE-----

--VZkULjj1I5POH7qQgUOYdzjEfVLJFxFAo--
