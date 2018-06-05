Received: from eggs.gnu.org ([2001:4830:134:3::10]:58814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQCE1-00054M-Dd
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQCDx-0001G7-75
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:42:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQCDx-0001FS-0j
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:42:09 -0400
Date: Tue, 5 Jun 2018 14:41:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180605134156.GI32286@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180605130646.GF7451@localhost.localdomain>
	<20180605131232.GG32286@redhat.com>
	<20180605133538.GG7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605133538.GG7451@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] libvirt default machine-type guarantees? (was Re:
 [PATCH RFC] hw/pc: set q35 as the default x86 machine)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com

On Tue, Jun 05, 2018 at 10:35:38AM -0300, Eduardo Habkost wrote:
> On Tue, Jun 05, 2018 at 02:12:32PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Tue, Jun 05, 2018 at 10:06:46AM -0300, Eduardo Habkost wrote:
> > > (CCing libvir-list)
> > >=20
> > > On Tue, Jun 05, 2018 at 09:43:00AM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > > On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
> > > > >   Hi,
> > > > >=20
> > > > > > >   Add to that shortcuts like -cdrom
> > > > > > > stop working,
> > > > > >=20
> > > > > > Maybe is fixable.
> > > > >=20
> > > > > Already fixed for ages.
> > > > >=20
> > > > > > I see marking Q35 as the default machine a first step.
> > > > >=20
> > > > > Maybe the better option is to go the arm route:  Just don't def=
ine a
> > > > > default, so users have to specify pc or q35.  That will make th=
em notice
> > > > > there is a world beside 'pc', and we also avoid breaking things
> > > > > silently.
> > > >=20
> > > > If QEMU removes the default, then libvirt will have to hardcode
> > > > 'pc' as the default to maintain back compatibility, so I don't
> > > > think that ends up as a net win
> > >=20
> > > Is there an actual promise to never change the default
> > > machine-type documented in the libvirt API, or is this just fear
> > > of breaking existing code?
> >=20
> > The risk of breaking things that currently work. Some of the things
> > discussed here that risk breaking users if QEMU changes the default,
> > have the same risk if libvirt changes the default.
> >=20
> > eg old OS versions that only work with PC, or more commonly pre-exist=
ing
> > cloud disk images that were built against PC can't be assumed to just
> > work against q35, even if the OS in the image supports it.
> >=20
> > If we want to get q35 broadly used for modern OS, then IMHO the best
> > option is to record that metadata in libosinfo, as ew do for other
> > virtual hardware preferences.  That doesn't fix the problem of disk
> > images that might not transparently boot between pc/q35, but at least
> > avoids breaking OS that don't support q35 at all.
>=20
> This leads to a more general question: sometimes the defaults
> chosen by libvirt are obsolete or broken, and we might want to
> change them.
>=20
> Is there a process for changing defaults in libvirt, or libvirt
> is bound by past decisions forever?

The general promise is that if you upgrade libvirt everything an applicat=
ion
was doing before should still work in the same way. We also aim to promis=
e
that if you upgrade the hypervisor underneath things will still work. Thi=
s
is much harder to guarantee but we'll make reasonable effort to try to
present an unchanged view to the mgmt app. Guest ABI is of course most
critical part of that but anything that affects APIs a mgmt app is using
relevant. This largely precludes changing defaults unless the feature goe=
s
away entirely or is unusable in some serious way.

This is why we try to push the idea of policy decisions into a layer
above with libosinfo suggesting defaults for individual guest OS.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
