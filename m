Received: from eggs.gnu.org ([209.51.188.92]:52359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjnmb-0007Vf-6s
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjnmT-0004Rr-NP
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:11:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gjnmR-0004Mr-JW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:11:05 -0500
Date: Wed, 16 Jan 2019 14:10:53 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190116161053.GD14807@habkost.net>
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
	<20181211105329.GE921@redhat.com>
	<52c43506-ef39-6d08-7db4-ad3c0f96dd1f@samsung.com>
	<20181212064936.ubnv3yif34e7ga5j@sirius.home.kraxel.org>
	<20190116153027.GC14807@habkost.net>
	<856c189d-937e-2471-c3c1-77e4d1e61ed6@samsung.com>
	<20190116154857.GC20275@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190116154857.GC20275@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Ilya Maximets <i.maximets@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Jan 16, 2019 at 03:48:57PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Jan 16, 2019 at 06:46:39PM +0300, Ilya Maximets wrote:
> >=20
> >=20
> > On 16.01.2019 18:30, Eduardo Habkost wrote:
> > > On Wed, Dec 12, 2018 at 07:49:36AM +0100, Gerd Hoffmann wrote:
> > >> On Tue, Dec 11, 2018 at 02:09:11PM +0300, Ilya Maximets wrote:
> > >>> On 11.12.2018 13:53, Daniel P. Berrang=E9 wrote:
> > >>>>>
> > >>>>> Let's restrict memfd backend to systems with sealing support.
> > >>>>
> > >>>> I don't think we need todo that - sealing is optional in the QEM=
U code,
> > >>>> we simply have it set to the wrong default when sealing is not a=
vailable.
> > >>>
> > >>> That was literally what I've fixed in v1:
> > >>>     https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg0=
5483.html
> > >>>
> > >>> but 2 people suggested me to disable memfd entirely for this case=
.
> > >>> Do you think I need to get patch from v1 back ?
> > >>>
> > >>> Gerd, Marc-Andr=E9, what do you think?
> > >>
> > >> I still think it makes sense to require sealing support.  Sealing =
is
> > >> very useful, and there are only a few kernel versions with memfd b=
ut
> > >> without sealing.  So finding such kernels in the wild will become =
more
> > >> rare over time.  I wouldn't worry too much about them.
> > >=20
> > > -object memory-backend-memfd,id=3Dmem,size=3D2M,seal=3Doff still
> > > works on those systems, doesn't it?  What's the rationale for
> > > breaking a working configuration without following the
> > > deprecation policy?
> > >=20
> >=20
> > See the commit message.
> > '.seal' property is not registered if sealing is not supported.
> > So, there is no way to disable sealing on the system that does not su=
pport it.
>=20
> As I pointed out a few lines up, this is simply because QEMU has a bug
> setting seal=3Dtrue as the built-in default value even when it isn't
> supported.=20

Changing to seal=3Dfalse by default may make it work on some hosts,
but I don't see the point of increasing our support burden just
for a few kernel versions.  I agree with Gerd, I think it's
simpler to keep it unsupported.

--=20
Eduardo
