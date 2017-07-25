Received: from eggs.gnu.org ([2001:4830:134:3::10]:56778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da21y-0001V7-15
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da21t-0005pU-Vu
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:45:54 -0400
Date: Tue, 25 Jul 2017 16:45:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725154546.GR23343@stefanha-x1.localdomain>
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721034730.25612-4-crosa@redhat.com>
	<ddf57b6c-42b2-0ec1-7d53-71d5266727fe@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mjrw6G9AoRBv8oQK"
Content-Disposition: inline
In-Reply-To: <ddf57b6c-42b2-0ec1-7d53-71d5266727fe@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] qemu-iotests: require
 CONFIG_LINUX_AIO for test 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jing Liu <liujbjl@linux.vnet.ibm.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Daniel Berrange <berrange@redhat.com>


--mjrw6G9AoRBv8oQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 02:44:13PM +0800, Jing Liu wrote:
> On 2017/7/21 =E4=B8=8A=E5=8D=8811:47, Cleber Rosa wrote:
> > One of the "sub-"tests of test 087 requires CONFIG_LINUX_AIO.
> >=20
> > As a PoC/RFC, this goes the easy route and skips the test as a whole
> > when that feature is missing.  Other approaches include splitting
> > the test and adding extra filtering.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/qemu-iotests/087 | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> > index f8e4903..a2fb7de 100755
> > --- a/tests/qemu-iotests/087
> > +++ b/tests/qemu-iotests/087
> > @@ -34,6 +34,7 @@ status=3D1	# failure is the default!
> >   _supported_fmt qcow2
> >   _supported_proto file
> >   _supported_os Linux
> > +_require_feature CONFIG_LINUX_AIO
> I tested that CONFIG_NETTLE_KDF is also a necessary for 087.
>=20
> +_require_feature CONFIG_NETTLE_KDF

Are you sure?  Looks like either nettle or gcrypt is needed:

crypto/Makefile.objs:crypto-obj-$(CONFIG_NETTLE_KDF) +=3D pbkdf-nettle.o
crypto/Makefile.objs:crypto-obj-$(if $(CONFIG_NETTLE_KDF),n,$(CONFIG_GCRYPT=
_KDF)) +=3D pbkdf-gcrypt.o

But this shows why the compile-time testing of features is ugly:

1. It duplicates build dependency logic into the test cases.

2. The test cases don't care about nettle vs gcrypt and they shouldn't
   have to know about it.  They just care whether LUKS is available or
   not.

As I mentioned earlier, let's test whether the QEMU binaries offer
_features_, not which _config options_ they were built with.

--mjrw6G9AoRBv8oQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd2eqAAoJEJykq7OBq3PIMtsH/1ujuAG7uOfJHgi9PObSDpPo
Yh4DlC8/4a8Ajt21AiyBSB/gqAhIi/OG7Bglz35WWLGl9IpO4fVvu2YhsmWlhWT/
XvKNo0pnHIYsiX8J9lliB0613GvrB1yvtK9OiI93r0lhcWN6R2HDMSFJIlCFVOeH
qPsH05HUpoW8zEvRnvDAr+EpfJeOwcziS41a3Mm8DJTHUpo+QYW6pqBQy+NJN0Rp
uVBSSr4rUVLga7Aqft4PWTbxECUNwQ37TFBIJMKhVY9xQMngMcwnoLUWOArjcvbE
unQxcYgdbtbIJ2lzqF6icQ4tqOr8nIg5ULvbm4/e9K5kGBeGCv+jQ3Rrc7tjJvw=
=3mxG
-----END PGP SIGNATURE-----

--mjrw6G9AoRBv8oQK--
