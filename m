Received: from eggs.gnu.org ([2001:4830:134:3::10]:35792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1w7I-0001QA-6O
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1w7B-0008Fd-P0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:06:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1w7B-0008FM-FO
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:06:37 -0400
Date: Tue, 10 Oct 2017 16:06:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171010150628.GI30015@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170911165929.2791-1-marcandre.lureau@redhat.com>
	<20170911165929.2791-3-marcandre.lureau@redhat.com>
	<20171009110336.GA17824@redhat.com>
	<20171009144344.38bbd1e9@nial.brq.redhat.com>
	<20171009130218.GK2954@redhat.com>
	<20171010003951-mutt-send-email-mst@kernel.org>
	<20171010083143.GA30015@redhat.com>
	<CAJ+F1CLGJLXYnJ8SnrbVkWc6bdU2geYKeEaKrxWaYBhXwA=Opg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLGJLXYnJ8SnrbVkWc6bdU2geYKeEaKrxWaYBhXwA=Opg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/7] hw/misc: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Dave Anderson <anderson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Tue, Oct 10, 2017 at 05:00:18PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Oct 10, 2017 at 10:31 AM, Daniel P. Berrange
> <berrange@redhat.com> wrote:
> > On Tue, Oct 10, 2017 at 12:44:26AM +0300, Michael S. Tsirkin wrote:
> >> On Mon, Oct 09, 2017 at 02:02:18PM +0100, Daniel P. Berrange wrote:
> >> > On Mon, Oct 09, 2017 at 02:43:44PM +0200, Igor Mammedov wrote:
> >> > > On Mon, 9 Oct 2017 12:03:36 +0100
> >> > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> >> > >
> >> > > > On Mon, Sep 11, 2017 at 06:59:24PM +0200, Marc-Andr=C3=A9 Lure=
au wrote:
> >> > > > > See docs/specs/vmcoreinfo.txt for details.
> >> > > > >
> >> > > > > "etc/vmcoreinfo" fw_cfg entry is added when using "-device v=
mcoreinfo".
> >> > > >
> >> > > > I'm wondering if you considered just adding the entry to fw_cf=
g by
> >> > > > default, without requiring any -device arg ? Unless I'm misund=
erstanding,
> >> > > > this doesn't feel like a device to me - its just a well known =
bucket
> >> > > > in fw_cfg IIUC ?  Obviously its existance would need to be tie=
d to
> >> > > > the latest machine type for ABI reasons though. The benefit of=
 this
> >> > > > is that it would "just work" without us having to plumb it thr=
ough to
> >> > > > all the downstream applications that use QEMU for mgmt guest (=
OpenStack,
> >> > > > oVirt, GNOME Boxes, virt-manager, and countless other mgmt app=
s).
> >> > > it follows model set by pvpanic device, it's easier to manage fr=
om migration
> >> > > POV, one could use it even for old machine types with new qemu (=
just by adding
> >> > > device, it makes instance not backwards migratable to old qemu b=
ut should work
> >> > > for forward migration) and if user doesn't need it, device could=
 be just omitted
> >> > > from CLI.
> >> >
> >> > Sure but it means that in effect no one will have this functionali=
ty enabled
> >> > for several years. pvpanic has been around a long time and I rarel=
y see it
> >> > present in configured guests :-(
> >> >
> >> >
> >> > Regards,
> >> > Daniel
> >>
> >> libvirt runs with -nodefaults, right? I'd argue pretty strongly -nod=
efaults
> >> shouldn't add optional devices anyway.
> >
> > This isn't really adding a device though is it - it is just a well kn=
own
> > location in fw_cfg to receive data.
>=20
> Enabling the device on some configurations by default can be done as a
> follow-up patch. Can we get this series reviewed & merged?

The problem with the -device approach + turning it on by default is that =
there
is no way to turn it off again if you don't want it. eg there's way to un=
do
an implicit '-device foo' except via -nodefaults, but since libvirt uses =
that
already it would negate the effect of enabling it by default unconditiona=
lly.

Your previous approach of "-global fw_cfg.vmcoreinfo=3Don" is nicer in th=
is
respect, as you can trivially turn it on/off, overriding the default stat=
e
in both directions.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
