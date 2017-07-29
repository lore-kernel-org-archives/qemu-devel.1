Received: from eggs.gnu.org ([2001:4830:134:3::10]:40806)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ps@pks.im>)
	id 1dbS8o-00025B-HJ
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ps@pks.im>) id 1dbS8l-0006TF-ES
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:50:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ps@pks.im>) id 1dbS8l-0006RF-8i
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:50:47 -0400
Date: Sat, 29 Jul 2017 15:50:42 +0200
From: Patrick Steinhardt <ps@pks.im>
Message-ID: <20170729135042.GA1139@pks-xps>
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
	<CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
	<cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair23@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 02:20:49PM -0300, Philippe Mathieu-Daud=E9 wrote:
> > On Mon, Jun 26, 2017 at 12:20 PM, Patrick Steinhardt <ps@pks.im> wrote:
> >> The function `v9fs_xattrcreate` makes use of the define `XATTR_SIZE_MA=
X`
> >> to reject attempts of creating xattrs with an invalid size, which is
> >> defined in <linux/limits.h>. On glibc-based systems, this header is
> >> indirectly included via <limits.h>, <bits/posix1_lim.h>,
> >> <bitts/local_lim.h>, but on other platforms this is not guaranteed due
> >> to not being part of the POSIX standard. One examples are systems based
> >> on musl libc, which do not include the <linux/limits.h> indirectly,
> >> which leads to `XATTR_SIZE_MAX` being undefined.
> >>
> >> Fix this error by directly include <linux/limits.h>. As the 9P fs code
> >> is being Linux-based either way, we can simply do so without breaking
> >> other platforms. This enables building 9pfs on musl-based systems.
> >>
> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> >> ---
> >>   hw/9pfs/9p.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> >> index 96d2683348..48cd558e96 100644
> >> --- a/hw/9pfs/9p.c
> >> +++ b/hw/9pfs/9p.c
> >> @@ -13,6 +13,7 @@
> >>
> >>   #include "qemu/osdep.h"
> >>   #include <glib/gprintf.h>
>=20
> This is likely to break on BSD, but now than patchew has a NetBSD job=20
> you can trigger a build RESENDing this patch.
>=20
> This should probably work:
>=20
> #ifdef __linux__
>=20
> >> +#include <linux/limits.h>
>=20
> #endif
>=20
> >>   #include "hw/virtio/virtio.h"
> >>   #include "qapi/error.h"
> >>   #include "qemu/error-report.h"
> >> --
> >> 2.13.2
>=20
> Regards,
>=20
> Phil.

Thanks for the feedback! Is this really relevant in this context,
though? Both 9p-local.c and 9p-handle.c already include linux
headers, especially <linux/fs.h> is included without any ifdef
around. As such, I simply assumed that this code is being built
on Linux systems, only.

Regards
Patrick

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAll8krIACgkQEXxntp6r
8Sz1TQ/+JWom4KIelP/KOfAYHEpHdjs8jA2gMNskOC16ftwyrVH/xAfKvb1/LDU7
+ByK4DQC7NTQb5fTvQDRcvc68m3LjWwde6Qblc8ykIxsO/8e6jLlaI9aAdOMCA5w
GoW5gjTKXE0AdE2lh+1Ja3caPb5fkkwcLBq+mkelySfUujVT7POZ1rYVPP/irYCT
jv4Bk97tNM9GKbI7jKwAmsMxEXx44blViw/Gxo61Yj1b5ilpBZM5fFGrZ65qvang
6HYn49SlONYiT4ZFmK2S+dOvH9SVxEeZxj/ui7lXTNqWPYSsFlTm03sZ7I0GWfX0
o2mNyMKlzTd0D8oppERc/sjN8NLn51iF8Kuuolr2A5+Gdnog0kwx1WVGhvZQAYKj
RFhn0yf47H64ct/FOQv34U8Cd+nmxudmiaancjXy1cFyABqd+tJTXRk/QwUynoWn
3wlme503GL1lK9+JXARs9tHvGRbUgDhJ+b746UrWWtnX5O4HPOOSLnz6EGqCvrlc
AY1GM1v5GmItxoU6ZMt7TYvWKOuWiBR8ToJRbbWtCPx3SOmNOjUVivMThlzTQJUY
bfDBP0oaQuYM/FIzgIhRmteFWpUs0625MaYXMaArBdRVlrwSEZzhgyXX5LBGbJ5p
cYgrPYKIeFmRh/9fn1NEBQ6uWNOlF2LidVdAcxhcJGrcLNNF/ns=
=i1Ft
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
