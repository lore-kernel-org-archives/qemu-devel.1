Received: from eggs.gnu.org ([2001:4830:134:3::10]:43560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTXmO-00013q-03
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTXmK-0002Cp-PN
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:42:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTXmK-0002Bb-Gv
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:42:40 -0500
Date: Tue, 17 Jan 2017 19:42:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170117193800-mutt-send-email-mst@kernel.org>
References: <D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
	<20161211052355-mutt-send-email-mst@kernel.org>
	<FBD67273-74C4-4183-8FCF-8260D13B04D4@skyportsystems.com>
	<20170116161857-mutt-send-email-mst@kernel.org>
	<85C3D50B-7AFD-41E7-AD1B-634A42D04BB2@skyportsystems.com>
	<20170117142650.2a2a351f@nial.brq.redhat.com>
	<CAO_EM_km-04HBOZP2H3UvPPaCKyQx1nZD1QKPVYuawwTJjdYSQ@mail.gmail.com>
	<20170117163002-mutt-send-email-mst@kernel.org>
	<CAO_EM_kcfhVPye+5vUZPY=mWS3TrcCWYh_ozTy8gPRgkCLMG-w@mail.gmail.com>
	<20170117172404.779ba6fa@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170117172404.779ba6fa@nial.brq.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Virtual Machine Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ed Swierk <eswierk@skyportsystems.com>, Ben Warren <ben@skyportsystems.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On Tue, Jan 17, 2017 at 05:24:04PM +0100, Igor Mammedov wrote:
> On Tue, 17 Jan 2017 07:01:27 -0800
> Ed Swierk <eswierk@skyportsystems.com> wrote:
>=20
> > You mean what causes the guest to re-read the vmgenid guid? The
> > vmgenid ACPI table defines a notify method, and when the guest
> > receives the corresponding event, it re-reads the guid. (Also it
> > appears that with Windows Server 2012 at least, if no notify method i=
s
> > defined, as is the case with Xen, the guest just re-reads it on
> > demand.)
> >=20
> > Wouldn't it be sufficient for the qmp set-vmgenid command to call
> > acpi_ram_update() with the new guid, and acpi_send_event() to notify
> > the guest?
> pls note that acpi_ram_update() updates only memory on qemu side and
> it's not mapped into guest. Updated memory will be re-read by firmware
> when guest reboots.
>=20
> But with vmgenid, QEMU might want to update guest RAM which
> contains GUID without reboot, and for this it needs to know GPA
> of GUID buffer and only after updating it send ACPI event.

+1 thanks, thanks is what I was trying to say.

> BTW in-place update is racy anyways as OS could be reading it
> at the same time,

That would be up to the applications to use correctly.
E.g.

	check id
	send transaction
	---> racy

	send transaction
	check id
	---> not racy

I can't of course answer for it that all applications use the id correctl=
y.
Some of them might decide to accept the risk of a race condition.

> but we can't do anything about it as vmgenid
> spec didn't provide means for atomic update.

I agree it's not up to us to fix.

>=20
> > --Ed
> >=20
> >=20
> > On Tue, Jan 17, 2017 at 6:33 AM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
> > > Because this relies on guest to run code to read out the new fw cfg=
.
> > > Thus guest can not reliably detect that host didn't update the gen =
id -
> > > new one might be there in fw cfg but not yet read.
> > >
> > > RSDP never changes during guest lifetime so the issue does
> > > not occur.
> > >
> > > On Tue, Jan 17, 2017 at 06:26:57AM -0800, Ed Swierk wrote: =20
> > >> Why is using fw_cfg for vmgenid preferable to the approach used fo=
r
> > >> RSDP: call acpi_add_rom_blob() to allocate a MemoryRegion with the
> > >> initial vmgenid guid, and call acpi_ram_update() with the new guid
> > >> whenever the host needs to change it?
> > >>
> > >> --Ed
> > >>
> > >>
> > >> On Tue, Jan 17, 2017 at 5:26 AM, Igor Mammedov <imammedo@redhat.co=
m> wrote: =20
> > >> > On Mon, 16 Jan 2017 10:57:42 -0800
> > >> > Ben Warren <ben@skyportsystems.com> wrote:
> > >> > =20
> > >> >> > On Jan 16, 2017, at 6:21 AM, Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >> >> >
> > >> >> > On Sat, Jan 14, 2017 at 10:17:53PM -0800, Ben Warren wrote: =20
> > >> >> >> Hi Michael,
> > >> >> >>
> > >> >> >>
> > >> >> >>    On Dec 10, 2016, at 7:28 PM, Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > >> >> >>
> > >> >> >>    On Tue, Dec 06, 2016 at 06:15:34PM -0800, Ben Warren wrot=
e:
> > >> >> >>
> > >> >> >>        Hi Michael,
> > >> >> >>
> > >> >> >>        I=E2=80=99m well on my way to implementing this, but =
I am really new to the
> > >> >> >>        QEMU code base and am struggling with some concepts. =
 Please see below:
> > >> >> >>
> > >> >> >>            On Oct 5, 2016, at 6:29 PM, Michael S. Tsirkin <m=
st@redhat.com>
> > >> >> >>            wrote:
> > >> >> >>
> > >> >> >>            On Tue, Oct 04, 2016 at 03:51:40PM -0700, Ed Swie=
rk wrote:
> > >> >> >>
> > >> >> >>                On Thu, Sep 15, 2016 at 5:36 PM, Michael S. T=
sirkin < =20
> > >> >> >>                mst@redhat.com> wrote: =20
> > >> >> >>
> > >> >> >>                    On Thu, Sep 15, 2016 at 05:23:28PM -0700,=
 Ed Swierk wrote:
> > >> >> >>
> > >> >> >>                        I'm wondering what it will take to fi=
nish up work on
> > >> >> >>                        vmgenid.
> > >> >> >>
> > >> >> >>                        https://lists.gnu.org/archive/html/qe=
mu-devel/2016-01/
> > >> >> >>                        msg05599.html
> > >> >> >>
> > >> >> >>
> > >> >> >>                    We have ACPI_BUILD_TPMLOG_FILE in tree no=
w and I think it
> > >> >> >>                    could be
> > >> >> >>                    allocated in a similar way.
> > >> >> >>                    Integrate patch "fw-cfg: support writeabl=
e blobs" to
> > >> >> >>                    communicate the
> > >> >> >>                    allocated address back to QEMU.
> > >> >> >>
> > >> >> >>
> > >> >> >>                Starting with Igor's last version at
> > >> >> >>                https://github.com/imammedo/qemu/commits/vmge=
n_wip , it's not
> > >> >> >>                clear to
> > >> >> >>                me which changes need to be ported, which cha=
nges are obsoleted
> > >> >> >>                by
> > >> >> >>                your new fw-cfg stuff and/or upstream churn i=
n ACPI, device
> > >> >> >>                properties, etc. In particular ACPI is still =
a total mystery to
> > >> >> >>                me,
> > >> >> >>                though passing a single address from guest to=
 host can't be
> > >> >> >>                that hard,
> > >> >> >>                can it?
> > >> >> >>
> > >> >> >>                Any clues would be appreciated.
> > >> >> >>
> > >> >> >>                --Ed
> > >> >> >>
> > >> >> >>
> > >> >> >>            It might be best to just re-start from the beginn=
ing.
> > >> >> >>            So the idea is that ACPI should be about supplyin=
g the address
> > >> >> >>            to guest. To supply address to host we'll use fw =
cfg.
> > >> >> >>            This would be new I think:
> > >> >> >>
> > >> >> >>            - add support for writeable fw cfg blobs
> > >> >> >>
> > >> >> >>        patch applied
> > >> >> >>
> > >> >> >>            - add linker/loader command to write address of a=
 blob into
> > >> >> >>            such a fw cfg file
> > >> >> >>            - add a new file used for vm gen id, use loader c=
ommand above
> > >> >> >>            to pass the address of a blob allocated for it to=
 host
> > >> >> >>
> > >> >> >>        I don=E2=80=99t really understand the meaning of =E2=80=
=9Cfile=E2=80=9D in this context.  It
> > >> >> >>        seems to be a way of specifying individual fw_cfg ent=
ries without
> > >> >> >>        explicitly giving an index, but is not something that=
 is visible in
> > >> >> >>        either the host or guest file system.  Is this about =
right?  In my code
> > >> >> >>        I=E2=80=99m using =E2=80=9C/etc/vmgenid=E2=80=9D
> > >> >> >>
> > >> >> >>
> > >> >> >>    yes
> > >> >> >>
> > >> >> >>
> > >> >> >>        As for the blob, I=E2=80=99m thinking this is where m=
y main problem is.  The
> > >> >> >>        =E2=80=98fw_cfg_add_*()=E2=80=99 functions take a dat=
a pointer but doesn=E2=80=99t seem to copy
> > >> >> >>        the data anywhere.  We pass essentially a pointer via=
 ACPI to the
> > >> >> >>        guest, so what it points to needs to be in an accessi=
ble region.  I
> > >> >> >>        don=E2=80=99t get how to define the blob contents.  T=
here are command-line
> > >> >> >>        =E2=80=98fw-cfg=E2=80=99 options where you can specif=
y a file, but it=E2=80=99s not clear to me
> > >> >> >>        how to use them.  Maybe I reserve some IO memory or s=
omething?
> > >> >> >>
> > >> >> >>
> > >> >> >>    Not sure I understand the question. fw cfg device will ma=
ke
> > >> >> >>    memory accessible to guest. Put the guest physical addres=
s there.
> > >> >> >>    the address needs to be calculated by linker.
> > >> >> >>
> > >> >> >>
> > >> >> >> I=E2=80=99m almost ready to submit a V2 of the patch set, bu=
t there=E2=80=99s still one issue
> > >> >> >> that I can=E2=80=99t figure out.  From the guest, I can read=
 the contents of the blob.
> > >> >> >> If I make a change to the contents of the blob (via QMP) the=
 guest does not
> > >> >> >> see the changes.  Is there something I need to do on the QEM=
U side to =E2=80=9Cpush=E2=80=9D
> > >> >> >> the updated fw_cfg contents to the guest?  I=E2=80=99ve noti=
ced this both when writing
> > >> >> >> a qtest for the feature, and also in a Linux kernel module I=
 wrote that reads
> > >> >> >> the ACPI contents in a guest.
> > >> >> >>
> > >> >> >> thanks,
> > >> >> >> Ben =20
> > >> >> >
> > >> >> > fw cfg entities are assumed to be immutable. This week
> > >> >> > I'll merge support for writeable fw cfg entries.
> > >> >> > I don't see why you want to change fw cfg transparently
> > >> >> > though - I think it should be like this
> > >> >> > - guest writes GPA into fw cfg
> > >> >> > - qemu writes gen id at this GPA
> > >> >> > =20
> > >> >> I=E2=80=99ve tried with your patch "fw-cfg-support-writeable-bl=
obs=E2=80=9D, setting the =E2=80=98read-only=E2=80=99 flag on my blob to =
false:
> > >> >>
> > >> >> fw_cfg_add_file_callback(s, VMGENID_FW_CFG_FILE, NULL, NULL, vm=
s->guid.data, sizeof(vms->guid.data), false);
> > >> >>
> > >> >> and it doesn=E2=80=99t seem to make a difference.
> > >> >>
> > >> >> I think we have a misunderstanding here.  I=E2=80=99m storing t=
he VM Generation ID __data__ (a GUID) in a fw_cfg blob, not the address. =
 I=E2=80=99ll submit the patch set ASAP so you will understand. =20
> > >> > there  should be another fw_cfg file for address so
> > >> > that guest would be able to write it back into QEMU
> > >> > =20
> > >> >> =20
> > >> >> > --
> > >> >> > MST =20
> > >> >>
> > >> >> regards,
> > >> >> Ben
> > >> >> =20
> > >> > =20
