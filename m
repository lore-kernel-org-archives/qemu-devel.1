Received: from eggs.gnu.org ([2001:4830:134:3::10]:49264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGM9j-0004F3-6J
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGM9i-0003WA-44
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:12:35 -0400
Date: Thu, 1 Jun 2017 11:12:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170601091224.GB4987@noname.redhat.com>
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.05.2017 um 17:03 hat Eric Blake geschrieben:
> On 05/31/2017 09:43 AM, Pavel Butsykin wrote:
> > This patch adds the reduction of the image file for qcow2. As a result,=
 this
> > allows us to reduce the virtual image size and free up space on the dis=
k without
> > copying the image. Image can be fragmented and reduction is done by pun=
ching
> > holes in the image file.
> >=20
> > # ./qemu-img create -f qcow2 -o size=3D4G image.qcow2
> > Formatting 'image.qcow2', fmt=3Dqcow2 size=3D4294967296 encryption=3Dof=
f cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> >=20
> > # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
>=20
> So this is 1G of guest-visible data...
>=20
> > # ./qemu-img resize image.qcow2 128M
> > Image resized.
>=20
> ...and you are truncating the image by throwing away guest-visible
> content, with no warning or double-checking (such as requiring a -f
> force parameter or something) about the data loss.  Shrinking images is
> something we should allow, but it feels like is a rare enough operation
> that you don't want it to be casually easy to throw away data.
>=20
> Is it feasible to require that a shrink operation will not be performed
> unless all clusters being eliminated have been previously discarded (or
> maybe written to zero), as an assurance that the guest did not care
> about the tail of the image?

I think that ship has sailed long ago because raw images have always
supported shrinking images without any special checks or options. We
want consistency between raw and qcow2, and we also need to provide
backwards compatibility.

The only thing I can imagine we could do now is to introduce a --shrink
option in qemu-img, print a deprecation warning for shrinking without
this option, and then make it mandatory in a few years.

If we want to distinguish based on the block driver, so that we can
require --shrink for all drivers that didn't support shrinking until
now, we'd have to check the .bdrv_truncate() implementations of all
drivers to see whether it already allowed shrinking.

Kevin

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZL9p4AAoJEH8JsnLIjy/WshwQAIn6GWLUe1okTw6kbKRbJJ94
HJfXS/ZasYZGDhYSvqYxbtJv7whuDQdyx3kkMpJgfVTeY+P1oqsAqu7Eu9Ubc+PA
4Ge8GIZqxgnzti/p9/LTqHWwIczenlcCqP9h7QlHJDeTLghqFFr+wDfNFlTLN1po
phht7leEx9Oeef7+tDmi9HkZAo0xa/APM8uQWgeDGR4/JORfyH9CaUjx30+HUBRJ
1cmBjantyv9lhsUZwptGkTqydyx/11ww96Cx6cBhIurTwf2zBvJdpUwzslMU8iiO
4sSYbmH2VoAe98/RvCtZgeaUAys2QHBoFyRPiIwh6C2f74H7a1f/Yx0DnwB3zykB
eJv/EmFAqberKKfdVhF29iVGmTrPwqc2Xn8NNuvGpScxeWHLPgGJy4kZ3sQqFXER
53Dp/dGe+ANmV7ViCo0F6B1sgWLMdwPk6fECcSZG3g1M0M5xWCUoxXTNmkmuRFBk
g1m4kkCLBA+KgKrcVmdcHWa7kOQXCX/vhOCirFGsLwfX2cIh4POOXGsEIU4piRIE
gGq3igbcVHyyDPNIDfT6CY4uiVb+JZJ1pKmB4QsPSrdHqxhdms4k3q0Q1r7PKb7w
FJuSCXjamj0nULKqgrFMeSAiUhXl27dnJioX1uNXKpq3fgGgzlcEzt9y0O4dXPov
h+Pv/GEoOHDHBJdta9U6
=/uE+
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
