Received: from eggs.gnu.org ([2001:4830:134:3::10]:41229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cW4ln-0008Od-0P
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cW4ll-0007Ou-Go
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:20:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
	<1485164923-17736-7-git-send-email-armbru@redhat.com>
	<2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com>
	<877f5l1tak.fsf@dusky.pond.sub.org>
	<3512807d-d04e-50fa-9fcf-d1d5ba8ac350@redhat.com>
	<87r33saa6p.fsf@dusky.pond.sub.org>
	<4cd45561-60e9-2cd2-e317-880ba9eb2f86@redhat.com>
Date: Tue, 24 Jan 2017 18:20:23 +0100
In-Reply-To: <4cd45561-60e9-2cd2-e317-880ba9eb2f86@redhat.com> (Paolo
	Bonzini's message of "Tue, 24 Jan 2017 14:01:38 +0100")
Message-ID: <87fuk82x48.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/i386/i386: Stop auto-creating
 lsi53c895a SCSI HBAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 24/01/2017 13:56, Markus Armbruster wrote:
>> So, what do we want to deprecate?
>> 
>> I think the onboard SCSI HBA adopting if=scsi drives should stay,
>> because it matches what we do for other interface types.  Unless we
>> wanted to deprecate interface types other than none entirely.
>
> Yes, of course.
>
>> What about realview and versatile auto-creating lsi53c895a?
>
> That should go.

Peter, do you agree?

>> What about pseries auto-creating spapr-vscsi?
>
> That should stay I think.  The discriminant being that spapr-vscsi
> devices actually are likely to have drivers in the guests.

Okay.

>> What about cold-plug of HBAs auto-creating SCSI devices?  You proposed
>> deprecating it for PC types, but it's currently independent of the
>> machine type.  Deprecate it for all types?  If not, add a flag to
>> MachineClass so we can deprecate it just for PC types?
>
> I need --verbose for this, sorry.

No problem!  Let me explain how SCSI auto-creation works, and how it
differs from the other interface types.  Actually, let me start with the
other ones.

When a machine supports some if=T, T other than scsi or none, its
initialization code retrieves the drives of interface type T with
supported bus and unit numbers, creates suitable frontends, and wires
them up.  We commonly don't bother to check whether there are drives
with unsupported bus and unit numbers.

Example: within terrier_init(), spitz_microdrive_attach() runs and calls
drive_get(IF_IDE, 0, 0).  If it gets something back, it creates a
dscm1xxxx device model.

Example: pc_q35_init() calls ide_drive_get() to retrieve the IF_IDE
drives with bus=0..5, unit=0.  It creates ide-cd or ide-hd device models
for the ones it gets back.

Example: within machvirt_init(), create_one_flash() runs two times and
calls drive_get_next(IF_PFLASH) to retrieve bus=0, unit=0..1.  It
creates cfi.pflash01 device models unconditionally, and backs them with
the drives it gets back, if any.  I hate the drive_get_next() interface,
because it uses execution order to encode unit numbers.

if=scsi works differently.

SCSI HBA device models commonly call scsi_bus_legacy_handle_cmdline()
during realize() for their SCSI bus(es).  A SCSI bus gets assigned a bus
number on creation, counting up from zero.  The SCSI HBA device model
declares the maximum unit number it supports (SCSIBusInfo member
max_target).  scsi_bus_legacy_handle_cmdline() calls drive_get(IF_SCSI,
bus->busnr, unit) to retrieve the IF_SCSI drives, and creates
scsi-generic or scsi-disk device models.

When a machine has an onboard SCSI HBA whose realize() calls
scsi_bus_legacy_handle_cmdline(), then machine initialization code
doesn't have to do anything to support if=scsi.

Example: mips_jazz_init() simply calls esp_init(), which then adopts the
if=scsi,bus=0,unit=0..7.  Note that blockdev.c rejects unit>7.

Example: sun4m_hw_init() does the same, but also checks for and rejects
drives with bus>0.  This check becomes redundant when we make orphaned
drives an error.

A few machines don't have onboard SCSI HBA, but their initialization
code creates N default ones, where N is the largest bus number of any
if=scsi drive.  Again, nothing else needs to be done to create the
actual SCSI devices.

Example: before my patch, PC machine initialization calls
pc_pci_device_init(), which creates lsi53c895a device models in a loop.

If a machine doesn't create default SCSI HBAs, the user can do it
himself with -device, and as long as the HBA's realize() calls
scsi_bus_legacy_handle_cmdline(), if=scsi works.

Example: after my patch, PC machine initialization doesn't create SCSI
HBAs.  Options "-drive media=cdrom,if=scsi,bus=1 -device
megasas,id=scsi0 -device megasas,id=scsi1" create two megasas device
models, and one scsi-disk device model plugged into the second one.

My question is: do we want to deprecate "-device of a SCSI HBA
auto-creates SCSI devices for the HBA's bus number(s), with unit numbers
up to max_target"?

For all machine types, or just for PC?

If for all machine types, we need work a little harder for if=scsi in
machine initialization, exactly like we do for the other interface
types.

Clear as mud now?
