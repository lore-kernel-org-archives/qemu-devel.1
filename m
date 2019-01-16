Received: from eggs.gnu.org ([209.51.188.92]:48189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjnY1-0008Ch-V6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjnY0-0000g3-Pr
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:56:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjnY0-0000fq-HR
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:56:08 -0500
Date: Wed, 16 Jan 2019 15:56:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190116155602.GD20275@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
	<20181211105329.GE921@redhat.com>
	<52c43506-ef39-6d08-7db4-ad3c0f96dd1f@samsung.com>
	<20181212064936.ubnv3yif34e7ga5j@sirius.home.kraxel.org>
	<20190116153027.GC14807@habkost.net>
	<856c189d-937e-2471-c3c1-77e4d1e61ed6@samsung.com>
	<20190116154857.GC20275@redhat.com>
	<58907276-dcc3-3f5b-bb12-647fff13325e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58907276-dcc3-3f5b-bb12-647fff13325e@samsung.com>
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
To: Ilya Maximets <i.maximets@samsung.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Jan 16, 2019 at 06:54:38PM +0300, Ilya Maximets wrote:
> On 16.01.2019 18:48, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jan 16, 2019 at 06:46:39PM +0300, Ilya Maximets wrote:
> >>
> >>
> >> On 16.01.2019 18:30, Eduardo Habkost wrote:
> >>> On Wed, Dec 12, 2018 at 07:49:36AM +0100, Gerd Hoffmann wrote:
> >>>> On Tue, Dec 11, 2018 at 02:09:11PM +0300, Ilya Maximets wrote:
> >>>>> On 11.12.2018 13:53, Daniel P. Berrang=C3=A9 wrote:
> >>>>>>>
> >>>>>>> Let's restrict memfd backend to systems with sealing support.
> >>>>>>
> >>>>>> I don't think we need todo that - sealing is optional in the QEM=
U code,
> >>>>>> we simply have it set to the wrong default when sealing is not a=
vailable.
> >>>>>
> >>>>> That was literally what I've fixed in v1:
> >>>>>     https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg0=
5483.html
> >>>>>
> >>>>> but 2 people suggested me to disable memfd entirely for this case=
.
> >>>>> Do you think I need to get patch from v1 back ?
> >>>>>
> >>>>> Gerd, Marc-Andr=C3=A9, what do you think?
> >>>>
> >>>> I still think it makes sense to require sealing support.  Sealing =
is
> >>>> very useful, and there are only a few kernel versions with memfd b=
ut
> >>>> without sealing.  So finding such kernels in the wild will become =
more
> >>>> rare over time.  I wouldn't worry too much about them.
> >>>
> >>> -object memory-backend-memfd,id=3Dmem,size=3D2M,seal=3Doff still
> >>> works on those systems, doesn't it?  What's the rationale for
> >>> breaking a working configuration without following the
> >>> deprecation policy?
> >>>
> >>
> >> See the commit message.
> >> '.seal' property is not registered if sealing is not supported.
> >> So, there is no way to disable sealing on the system that does not s=
upport it.
> >=20
> > As I pointed out a few lines up, this is simply because QEMU has a bu=
g
> > setting seal=3Dtrue as the built-in default value even when it isn't
> > supported.=20
>=20
> So, do you think I need to return to the solution from my v1:
>   https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg05483.htm=
l

That is my preference, but we don't have  universal agreement :-(

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
