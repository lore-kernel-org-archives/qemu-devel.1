Received: from eggs.gnu.org ([2001:4830:134:3::10]:36141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3YGR-0001Yp-53
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 22:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3YGM-0000Ap-A6
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 22:02:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3YGM-000083-0V
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 22:02:46 -0400
Date: Sun, 15 Oct 2017 05:02:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171015045801-mutt-send-email-mst@kernel.org>
References: <20170911165929.2791-1-marcandre.lureau@redhat.com>
	<20170911165929.2791-3-marcandre.lureau@redhat.com>
	<20171009110336.GA17824@redhat.com>
	<20171009144344.38bbd1e9@nial.brq.redhat.com>
	<20171009130218.GK2954@redhat.com>
	<20171010003951-mutt-send-email-mst@kernel.org>
	<20171010083143.GA30015@redhat.com>
	<CAJ+F1CLGJLXYnJ8SnrbVkWc6bdU2geYKeEaKrxWaYBhXwA=Opg@mail.gmail.com>
	<20171010150628.GI30015@redhat.com>
	<20171010180110.GI3246@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171010180110.GI3246@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Dave Anderson <anderson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Tue, Oct 10, 2017 at 03:01:10PM -0300, Eduardo Habkost wrote:
> On Tue, Oct 10, 2017 at 04:06:28PM +0100, Daniel P. Berrange wrote:
> > On Tue, Oct 10, 2017 at 05:00:18PM +0200, Marc-Andr=E9 Lureau wrote:
> > > Hi
> > >=20
> > > On Tue, Oct 10, 2017 at 10:31 AM, Daniel P. Berrange
> > > <berrange@redhat.com> wrote:
> > > > On Tue, Oct 10, 2017 at 12:44:26AM +0300, Michael S. Tsirkin wrot=
e:
> > > >> On Mon, Oct 09, 2017 at 02:02:18PM +0100, Daniel P. Berrange wro=
te:
> > > >> > On Mon, Oct 09, 2017 at 02:43:44PM +0200, Igor Mammedov wrote:
> > > >> > > On Mon, 9 Oct 2017 12:03:36 +0100
> > > >> > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > > >> > >
> > > >> > > > On Mon, Sep 11, 2017 at 06:59:24PM +0200, Marc-Andr=E9 Lur=
eau wrote:
> > > >> > > > > See docs/specs/vmcoreinfo.txt for details.
> > > >> > > > >
> > > >> > > > > "etc/vmcoreinfo" fw_cfg entry is added when using "-devi=
ce vmcoreinfo".
> > > >> > > >
> > > >> > > > I'm wondering if you considered just adding the entry to f=
w_cfg by
> > > >> > > > default, without requiring any -device arg ? Unless I'm mi=
sunderstanding,
> > > >> > > > this doesn't feel like a device to me - its just a well kn=
own bucket
> > > >> > > > in fw_cfg IIUC ?  Obviously its existance would need to be=
 tied to
> > > >> > > > the latest machine type for ABI reasons though. The benefi=
t of this
> > > >> > > > is that it would "just work" without us having to plumb it=
 through to
> > > >> > > > all the downstream applications that use QEMU for mgmt gue=
st (OpenStack,
> > > >> > > > oVirt, GNOME Boxes, virt-manager, and countless other mgmt=
 apps).
> > > >> > > it follows model set by pvpanic device, it's easier to manag=
e from migration
> > > >> > > POV, one could use it even for old machine types with new qe=
mu (just by adding
> > > >> > > device, it makes instance not backwards migratable to old qe=
mu but should work
> > > >> > > for forward migration) and if user doesn't need it, device c=
ould be just omitted
> > > >> > > from CLI.
> > > >> >
> > > >> > Sure but it means that in effect no one will have this functio=
nality enabled
> > > >> > for several years. pvpanic has been around a long time and I r=
arely see it
> > > >> > present in configured guests :-(
> > > >> >
> > > >> >
> > > >> > Regards,
> > > >> > Daniel
> > > >>
> > > >> libvirt runs with -nodefaults, right? I'd argue pretty strongly =
-nodefaults
> > > >> shouldn't add optional devices anyway.
> > > >
> > > > This isn't really adding a device though is it - it is just a wel=
l known
> > > > location in fw_cfg to receive data.
> > >=20
> > > Enabling the device on some configurations by default can be done a=
s a
> > > follow-up patch. Can we get this series reviewed & merged?
> >=20
> > The problem with the -device approach + turning it on by default is t=
hat there
> > is no way to turn it off again if you don't want it. eg there's way t=
o undo
> > an implicit '-device foo' except via -nodefaults, but since libvirt u=
ses that
> > already it would negate the effect of enabling it by default uncondit=
ionally.
>=20
> It's still possible to add a -machine option that can
> enable/disable automatic creation of the device.
>
>
> But I also don't see why it needs to be implemented using -device
> if it's not really a device.  A boolean machine or fw_cfg
> property is good enough for that.

Device imho is a combination of guest/host interface and state.


> >=20
> > Your previous approach of "-global fw_cfg.vmcoreinfo=3Don" is nicer i=
n this
> > respect, as you can trivially turn it on/off, overriding the default =
state
> > in both directions.
>=20
> Both "-global fw_cfg.vmcoreinfo=3Don|off" and
> "-machine vmcoreinfo=3Don|off" sound good enough to me.

I can live with the second option if people really want it.
I'd like to see some way to add these things without
adding to the mess that is the pc initialization
but oh well.

> --=20
> Eduardo
