Received: from eggs.gnu.org ([2001:4830:134:3::10]:36206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQEjH-0006FU-JC
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQEjG-0002aP-8m
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:22:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fQEjG-0002aB-1k
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:22:38 -0400
Date: Tue, 5 Jun 2018 19:22:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605192134-mutt-send-email-mst@kernel.org>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<53c37321-52d2-732c-19fb-8f6a9542c714@gmail.com>
	<20180605132948.GH32286@redhat.com>
	<5f7fad87-73dd-ef75-bb1d-983d36e42073@redhat.com>
	<20180605135152.GJ32286@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180605135152.GJ32286@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, ehabkost@redhat.com, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, rth@twiddle.net

On Tue, Jun 05, 2018 at 02:51:52PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jun 05, 2018 at 03:44:14PM +0200, Laszlo Ersek wrote:
> > On 06/05/18 15:29, Daniel P. Berrang=E9 wrote:
> > > On Tue, Jun 05, 2018 at 04:20:46PM +0300, Marcel Apfelbaum wrote:
> > >>
> > >>
> > >> On 06/05/2018 11:43 AM, Daniel P. Berrang=E9 wrote:
> > >>> On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
> > >>>>    Hi,
> > >>>>
> > >>>>>>    Add to that shortcuts like -cdrom
> > >>>>>> stop working,
> > >>>>> Maybe is fixable.
> > >>>> Already fixed for ages.
> > >>>>
> > >>>>> I see marking Q35 as the default machine a first step.
> > >>>> Maybe the better option is to go the arm route:  Just don't defi=
ne a
> > >>>> default, so users have to specify pc or q35.  That will make the=
m notice
> > >>>> there is a world beside 'pc', and we also avoid breaking things
> > >>>> silently.
> > >>
> > >> It can work, sure. And we can add user hints: "Use q35 for ...., s=
elect pc
> > >> if..."
> > >>
> > >>> If QEMU removes the default, then libvirt will have to hardcode
> > >>> 'pc' as the default to maintain back compatibility, so I don't
> > >>> think that ends up as a net win
> > >>
> > >> Can't libvirt preserve 'pc' for existing domains, while defaulting=
 to q35
> > >> the creation of new domains ? This way it aligns with Gerd's propo=
sal of no
> > >> default x86 machine.
> > >=20
> > > Existing domains wasn't the case I was concerned about. Consider yo=
u have
> > > libvirt 4.4.0 intsalled and you deploy a *new* domain from a prebui=
lt
> > > disk image "foo". Now update to a libvirt or QEMU which changes to =
q35
> > > and try to deploy another new domain from the same prebuilt disk
> > > image "foo". It may not work now if that disk image doesn't support
> > > q35. That would be a regression from the user's POV, whether libvir=
t or
> > > qemu has changed the default.
> >=20
> > How about:
> > - "create new domain with empty disk" --> i440fx now, q35 later
>=20
> "empty disk" is not something that can be determined by the
> host - libvirt might not even have direct access to the disk
> at the time this info would be needed.
>=20
> > - "create new domain from domain XML and disk image" --> whatever the
> >   domain definition dictates
> > - "create new domain from disk image and no domain XML" --> assume
> >   i440fx forever (with a detailed board / device config that's used f=
or
> >   all legacy (definition-less) disk images)
>=20
>=20
>=20
> > - convince disk image distributors to provide their domain definition=
s
> >   with their disks (need not be libvirt domain XML, other definitions
> >   might work)
>=20
> Libvirt domain XML is absolutely not suitable - it is a host specific
> instantiation of a guest, that is not guaranteed to be portable to
> any other host.
>=20
> Funnily enough though, I just remembered that 10 years ago we invented
> another XML format called "virt-image XML", that went along with a
> "virt-image" command line tool
>=20
>   https://github.com/virt-manager/virt-manager/blob/2e7d477156e9d0f6fb2=
18fa19fc00d6229d33e85/man/virt-image-xml.pod
>=20
> This was rarely used because the "virt-image" tool itself was rather
> broken by design, so we eventually deleted this entirely.
>=20
> The virt-image XML  description though could be resurrected as it
> is largely relevant to the conversation.

Oh, that might be a nice thing to put into qcow2 meta-data.
(Hopefully in a format that's easier to parse and write than xml).


> > - write converters from those other definition formats to libvirt XML=
,
> >   or QEMU cfg file?
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
