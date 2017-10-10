Received: from eggs.gnu.org ([2001:4830:134:3::10]:54992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1zzv-0003i4-PQ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1zzs-0007CN-Ik
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:15:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e1zzs-0007Bv-0k
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:15:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7F064A702
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 19:15:18 +0000 (UTC)
Date: Tue, 10 Oct 2017 16:15:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171010191502.GA32108@localhost.localdomain>
References: <20170911165929.2791-1-marcandre.lureau@redhat.com>
	<20170911165929.2791-3-marcandre.lureau@redhat.com>
	<20171009110336.GA17824@redhat.com>
	<20171009144344.38bbd1e9@nial.brq.redhat.com>
	<20171009130218.GK2954@redhat.com>
	<20171010003951-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171010003951-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, anderson@redhat.com, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, lersek@redhat.com

On Tue, Oct 10, 2017 at 12:44:26AM +0300, Michael S. Tsirkin wrote:
> On Mon, Oct 09, 2017 at 02:02:18PM +0100, Daniel P. Berrange wrote:
> > On Mon, Oct 09, 2017 at 02:43:44PM +0200, Igor Mammedov wrote:
> > > On Mon, 9 Oct 2017 12:03:36 +0100
> > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > >=20
> > > > On Mon, Sep 11, 2017 at 06:59:24PM +0200, Marc-Andr=E9 Lureau wro=
te:
> > > > > See docs/specs/vmcoreinfo.txt for details.
> > > > >=20
> > > > > "etc/vmcoreinfo" fw_cfg entry is added when using "-device vmco=
reinfo". =20
> > > >=20
> > > > I'm wondering if you considered just adding the entry to fw_cfg b=
y
> > > > default, without requiring any -device arg ? Unless I'm misunders=
tanding,
> > > > this doesn't feel like a device to me - its just a well known buc=
ket
> > > > in fw_cfg IIUC ?  Obviously its existance would need to be tied t=
o
> > > > the latest machine type for ABI reasons though. The benefit of th=
is
> > > > is that it would "just work" without us having to plumb it throug=
h to
> > > > all the downstream applications that use QEMU for mgmt guest (Ope=
nStack,
> > > > oVirt, GNOME Boxes, virt-manager, and countless other mgmt apps).
> > > it follows model set by pvpanic device, it's easier to manage from =
migration
> > > POV, one could use it even for old machine types with new qemu (jus=
t by adding
> > > device, it makes instance not backwards migratable to old qemu but =
should work
> > > for forward migration) and if user doesn't need it, device could be=
 just omitted
> > > from CLI.
> >=20
> > Sure but it means that in effect no one will have this functionality =
enabled
> > for several years. pvpanic has been around a long time and I rarely s=
ee it
> > present in configured guests :-(
> >=20
> >=20
> > Regards,
> > Daniel
>=20
> libvirt runs with -nodefaults, right? I'd argue pretty strongly -nodefa=
ults
> shouldn't add optional devices anyway.

Does it mean every time we make a PC device configurable, we
should make it be disabled by -nodefaults, and require libvirt to
adapt?

I don't think that would be a good idea.  Imagine the hassle the
"pc: make .* configurable" patches[1] would generate for libvirt.

>=20
> So it's up to you guys, you can add it to VMs by default if you want to=
.

To be honest, I think "no defaults" is a misleading name for an
option.  If it really meant "create no optional device at all",
it would eventually become a synonym for "-machine none", and I
don't think that's its goal.

I expect PC to always have a set of devices/features that are
disabled by -nodefaults, and a set of devices/features that are
not disabled by -nodefaults.  We need good judgement to decide on
which set the device will be, and I believe Daniel exposed good
arguments to put vmcoreinfo in the second set.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg393493.html
    Subject: [RFC PATCH v2 00/12] Guest startup time optimization

--=20
Eduardo
