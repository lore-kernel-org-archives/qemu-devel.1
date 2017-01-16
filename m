Received: from eggs.gnu.org ([2001:4830:134:3::10]:39289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT51W-0007vA-Ao
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT51R-0003Uf-DV
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:00:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT51R-0003UG-4T
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:00:21 -0500
Date: Mon, 16 Jan 2017 11:00:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170116110017.GC12351@stefanha-x1.localdomain>
References: <20170113115651.17607-1-haozhong.zhang@intel.com>
	<20170113131727.GA10706@stefanha-x1.localdomain>
	<20170113180243.GA3565@thinpad.lan.raisama.net>
	<4ee4b67a-f00b-b2fd-f87b-4f0a74734412@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <4ee4b67a-f00b-b2fd-f87b-4f0a74734412@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: check if nvdimm is enabled before
 plugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com, Richard Henderson <rth@twiddle.net>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 01:55:34PM +0800, Xiao Guangrong wrote:
>=20
>=20
> On 01/14/2017 02:02 AM, Eduardo Habkost wrote:
> > On Fri, Jan 13, 2017 at 01:17:27PM +0000, Stefan Hajnoczi wrote:
> > > On Fri, Jan 13, 2017 at 07:56:51PM +0800, Haozhong Zhang wrote:
> > > > The missing of 'nvdimm' in the machine type option '-M' means NVDIMM
> > > > is disabled. QEMU should refuse to plug any NVDIMM device in this c=
ase
> > > > and report the misconfiguration.
> > > >=20
> > > > Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > > > Message-Id: 20170112110928.GF4621@stefanha-x1.localdomain
> > > > Message-Id: 20170111093630.2088-1-stefanha@redhat.com
> > > > ---
> > > >  hw/i386/pc.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > index 25e8586..3907609 100644
> > > > --- a/hw/i386/pc.c
> > > > +++ b/hw/i386/pc.c
> > > > @@ -1715,6 +1715,11 @@ static void pc_dimm_plug(HotplugHandler *hot=
plug_dev,
> > > >      }
> > > >=20
> > > >      if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> > > > +        if (!pcms->acpi_nvdimm_state.is_enabled) {
> > > > +            error_setg(&local_err,
> > > > +                       "nvdimm is not enabled: missing 'nvdimm' in=
 '-M'");
> > > > +            goto out;
> > > > +        }
> > >=20
> > > A warning is definitely useful to notify users of a possible
> > > configuration error.
> > >=20
> > > I wonder what happens when you plug an NVDIMM into a motherboard where
> > > the firmware lacks support.  Does it:
> > >  * Refuse to boot?
> > >  * Treat the DIMM as regular RAM?
> > >  * Boot but the DIMM will not be used by firmware and kernel?
> > >=20
> > > QEMU should act the same way as real hardware.
> >=20
> > If real hardware behavior is not useful in any way (e.g. first
> > and third options above), is there a good reason for QEMU to not
> > implement an additional safety mechanism preventing NVDIMM from
> > being connected to a machine that doesn't support it?
> >=20
>=20
> Yes. i agree with Eduardo.
>=20
> For the real hardware the behavior may be different between vendors, we
> are asking our HW people to check what will happen on Intel's hardware
> under this case.

Let's find out what real hardware/firmware does.  I guess it's the Intel
MRC component that handles memory initialization.

Stefan

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfKfBAAoJEJykq7OBq3PIt5wH+QGrw6tCQvWosjHelytI3va1
Sj2EpHmppL5k9yG+6LHMy6nYezikjqNxsxxF2uTBUWB2iMwKO1Vgn7l1ITLqt1WD
TFoW1CVvMtdxsKqOGnyB7GrXjBsJAq/z+ItCRzV5udqbKLJ0vQ1UbALXQxi/3+Wl
z0VHFFgoepZQzao54Q5+HDC0FcTzUMbf20x/xItVYs3Fv6CtoA9Nquc7p1ZObFN6
9XoiYCNyOKZPZkSssBuVN69o8OaFZNoQR9cM9ksPznLnzmZked0L7I0N3zo8ed9a
0fnjjbyU7SaatSipBT++pNs22LdYXa8aqfSrGwmqMKnaUhBBmR+zURx5SqEhAJg=
=tyhG
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
