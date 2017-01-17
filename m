Received: from eggs.gnu.org ([2001:4830:134:3::10]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cTVH0-0006lD-Ip
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cTVGy-0002iA-Sc
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:02:10 -0500
Received: from mail-vk0-x235.google.com ([2607:f8b0:400c:c05::235]:34993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cTVGy-0002hz-M6
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:02:08 -0500
Received: by mail-vk0-x235.google.com with SMTP id x75so93911548vke.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 07:02:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170117163002-mutt-send-email-mst@kernel.org>
References: <20160916033402-mutt-send-email-mst@kernel.org>
	<CAO_EM_mHyC7cywV4KUqH_MWwt2vVkK6GEOuaUX0FHpffdfaAuQ@mail.gmail.com>
	<20161006041949-mutt-send-email-mst@kernel.org>
	<D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
	<20161211052355-mutt-send-email-mst@kernel.org>
	<FBD67273-74C4-4183-8FCF-8260D13B04D4@skyportsystems.com>
	<20170116161857-mutt-send-email-mst@kernel.org>
	<85C3D50B-7AFD-41E7-AD1B-634A42D04BB2@skyportsystems.com>
	<20170117142650.2a2a351f@nial.brq.redhat.com>
	<CAO_EM_km-04HBOZP2H3UvPPaCKyQx1nZD1QKPVYuawwTJjdYSQ@mail.gmail.com>
	<20170117163002-mutt-send-email-mst@kernel.org>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Tue, 17 Jan 2017 07:01:27 -0800
Message-ID: <CAO_EM_kcfhVPye+5vUZPY=mWS3TrcCWYh_ozTy8gPRgkCLMG-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

You mean what causes the guest to re-read the vmgenid guid? The
vmgenid ACPI table defines a notify method, and when the guest
receives the corresponding event, it re-reads the guid. (Also it
appears that with Windows Server 2012 at least, if no notify method is
defined, as is the case with Xen, the guest just re-reads it on
demand.)

Wouldn't it be sufficient for the qmp set-vmgenid command to call
acpi_ram_update() with the new guid, and acpi_send_event() to notify
the guest?

--Ed


On Tue, Jan 17, 2017 at 6:33 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Because this relies on guest to run code to read out the new fw cfg.
> Thus guest can not reliably detect that host didn't update the gen id -
> new one might be there in fw cfg but not yet read.
>
> RSDP never changes during guest lifetime so the issue does
> not occur.
>
> On Tue, Jan 17, 2017 at 06:26:57AM -0800, Ed Swierk wrote:
>> Why is using fw_cfg for vmgenid preferable to the approach used for
>> RSDP: call acpi_add_rom_blob() to allocate a MemoryRegion with the
>> initial vmgenid guid, and call acpi_ram_update() with the new guid
>> whenever the host needs to change it?
>>
>> --Ed
>>
>>
>> On Tue, Jan 17, 2017 at 5:26 AM, Igor Mammedov <imammedo@redhat.com> wro=
te:
>> > On Mon, 16 Jan 2017 10:57:42 -0800
>> > Ben Warren <ben@skyportsystems.com> wrote:
>> >
>> >> > On Jan 16, 2017, at 6:21 AM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>> >> >
>> >> > On Sat, Jan 14, 2017 at 10:17:53PM -0800, Ben Warren wrote:
>> >> >> Hi Michael,
>> >> >>
>> >> >>
>> >> >>    On Dec 10, 2016, at 7:28 PM, Michael S. Tsirkin <mst@redhat.com=
> wrote:
>> >> >>
>> >> >>    On Tue, Dec 06, 2016 at 06:15:34PM -0800, Ben Warren wrote:
>> >> >>
>> >> >>        Hi Michael,
>> >> >>
>> >> >>        I=E2=80=99m well on my way to implementing this, but I am r=
eally new to the
>> >> >>        QEMU code base and am struggling with some concepts.  Pleas=
e see below:
>> >> >>
>> >> >>            On Oct 5, 2016, at 6:29 PM, Michael S. Tsirkin <mst@red=
hat.com>
>> >> >>            wrote:
>> >> >>
>> >> >>            On Tue, Oct 04, 2016 at 03:51:40PM -0700, Ed Swierk wro=
te:
>> >> >>
>> >> >>                On Thu, Sep 15, 2016 at 5:36 PM, Michael S. Tsirkin=
 <
>> >> >>                mst@redhat.com> wrote:
>> >> >>
>> >> >>                    On Thu, Sep 15, 2016 at 05:23:28PM -0700, Ed Sw=
ierk wrote:
>> >> >>
>> >> >>                        I'm wondering what it will take to finish u=
p work on
>> >> >>                        vmgenid.
>> >> >>
>> >> >>                        https://lists.gnu.org/archive/html/qemu-dev=
el/2016-01/
>> >> >>                        msg05599.html
>> >> >>
>> >> >>
>> >> >>                    We have ACPI_BUILD_TPMLOG_FILE in tree now and =
I think it
>> >> >>                    could be
>> >> >>                    allocated in a similar way.
>> >> >>                    Integrate patch "fw-cfg: support writeable blob=
s" to
>> >> >>                    communicate the
>> >> >>                    allocated address back to QEMU.
>> >> >>
>> >> >>
>> >> >>                Starting with Igor's last version at
>> >> >>                https://github.com/imammedo/qemu/commits/vmgen_wip =
, it's not
>> >> >>                clear to
>> >> >>                me which changes need to be ported, which changes a=
re obsoleted
>> >> >>                by
>> >> >>                your new fw-cfg stuff and/or upstream churn in ACPI=
, device
>> >> >>                properties, etc. In particular ACPI is still a tota=
l mystery to
>> >> >>                me,
>> >> >>                though passing a single address from guest to host =
can't be
>> >> >>                that hard,
>> >> >>                can it?
>> >> >>
>> >> >>                Any clues would be appreciated.
>> >> >>
>> >> >>                --Ed
>> >> >>
>> >> >>
>> >> >>            It might be best to just re-start from the beginning.
>> >> >>            So the idea is that ACPI should be about supplying the =
address
>> >> >>            to guest. To supply address to host we'll use fw cfg.
>> >> >>            This would be new I think:
>> >> >>
>> >> >>            - add support for writeable fw cfg blobs
>> >> >>
>> >> >>        patch applied
>> >> >>
>> >> >>            - add linker/loader command to write address of a blob =
into
>> >> >>            such a fw cfg file
>> >> >>            - add a new file used for vm gen id, use loader command=
 above
>> >> >>            to pass the address of a blob allocated for it to host
>> >> >>
>> >> >>        I don=E2=80=99t really understand the meaning of =E2=80=9Cf=
ile=E2=80=9D in this context.  It
>> >> >>        seems to be a way of specifying individual fw_cfg entries w=
ithout
>> >> >>        explicitly giving an index, but is not something that is vi=
sible in
>> >> >>        either the host or guest file system.  Is this about right?=
  In my code
>> >> >>        I=E2=80=99m using =E2=80=9C/etc/vmgenid=E2=80=9D
>> >> >>
>> >> >>
>> >> >>    yes
>> >> >>
>> >> >>
>> >> >>        As for the blob, I=E2=80=99m thinking this is where my main=
 problem is.  The
>> >> >>        =E2=80=98fw_cfg_add_*()=E2=80=99 functions take a data poin=
ter but doesn=E2=80=99t seem to copy
>> >> >>        the data anywhere.  We pass essentially a pointer via ACPI =
to the
>> >> >>        guest, so what it points to needs to be in an accessible re=
gion.  I
>> >> >>        don=E2=80=99t get how to define the blob contents.  There a=
re command-line
>> >> >>        =E2=80=98fw-cfg=E2=80=99 options where you can specify a fi=
le, but it=E2=80=99s not clear to me
>> >> >>        how to use them.  Maybe I reserve some IO memory or somethi=
ng?
>> >> >>
>> >> >>
>> >> >>    Not sure I understand the question. fw cfg device will make
>> >> >>    memory accessible to guest. Put the guest physical address ther=
e.
>> >> >>    the address needs to be calculated by linker.
>> >> >>
>> >> >>
>> >> >> I=E2=80=99m almost ready to submit a V2 of the patch set, but ther=
e=E2=80=99s still one issue
>> >> >> that I can=E2=80=99t figure out.  From the guest, I can read the c=
ontents of the blob.
>> >> >> If I make a change to the contents of the blob (via QMP) the guest=
 does not
>> >> >> see the changes.  Is there something I need to do on the QEMU side=
 to =E2=80=9Cpush=E2=80=9D
>> >> >> the updated fw_cfg contents to the guest?  I=E2=80=99ve noticed th=
is both when writing
>> >> >> a qtest for the feature, and also in a Linux kernel module I wrote=
 that reads
>> >> >> the ACPI contents in a guest.
>> >> >>
>> >> >> thanks,
>> >> >> Ben
>> >> >
>> >> > fw cfg entities are assumed to be immutable. This week
>> >> > I'll merge support for writeable fw cfg entries.
>> >> > I don't see why you want to change fw cfg transparently
>> >> > though - I think it should be like this
>> >> > - guest writes GPA into fw cfg
>> >> > - qemu writes gen id at this GPA
>> >> >
>> >> I=E2=80=99ve tried with your patch "fw-cfg-support-writeable-blobs=E2=
=80=9D, setting the =E2=80=98read-only=E2=80=99 flag on my blob to false:
>> >>
>> >> fw_cfg_add_file_callback(s, VMGENID_FW_CFG_FILE, NULL, NULL, vms->gui=
d.data, sizeof(vms->guid.data), false);
>> >>
>> >> and it doesn=E2=80=99t seem to make a difference.
>> >>
>> >> I think we have a misunderstanding here.  I=E2=80=99m storing the VM =
Generation ID __data__ (a GUID) in a fw_cfg blob, not the address.  I=E2=80=
=99ll submit the patch set ASAP so you will understand.
>> > there  should be another fw_cfg file for address so
>> > that guest would be able to write it back into QEMU
>> >
>> >>
>> >> > --
>> >> > MST
>> >>
>> >> regards,
>> >> Ben
>> >>
>> >
