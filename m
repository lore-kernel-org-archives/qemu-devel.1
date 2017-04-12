Received: from eggs.gnu.org ([2001:4830:134:3::10]:59310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cyOl2-0005YT-4z
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cyOky-0000es-48
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:20:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cyOkx-0000eV-Ps
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:20:48 -0400
Date: Wed, 12 Apr 2017 23:20:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170412231644-mutt-send-email-mst@kernel.org>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-3-git-send-email-mst@redhat.com>
	<CAJ+F1C+kLB5VCsSakbd6+CKx4uNbxZNqd+vNMAWte4yKqcbw9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+kLB5VCsSakbd6+CKx4uNbxZNqd+vNMAWte4yKqcbw9Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/15] docs: VM Generation ID device
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gal Hammer <ghammer@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Apr 12, 2017 at 08:06:32PM +0000, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Thu, Mar 2, 2017 at 10:22 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
>=20
>     From: Ben Warren <ben@skyportsystems.com>
>=20
>     This patch is based off an earlier version by
>     Gal Hammer (ghammer@redhat.com)
>=20
>     Requirements section, ASCII diagrams and overall help
>     provided by Laszlo Ersek (lersek@redhat.com)
>=20
>     Signed-off-by: Gal Hammer <ghammer@redhat.com>
>     Signed-off-by: Ben Warren <ben@skyportsystems.com>
>     Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>     Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>     ---
>     =A0docs/specs/vmgenid.txt | 245
>     +++++++++++++++++++++++++++++++++++++++++++++++++
>     =A01 file changed, 245 insertions(+)
>     =A0create mode 100644 docs/specs/vmgenid.txt
>=20
>     diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
>     new file mode 100644
>     index 0000000..aa9f518
>     --- /dev/null
>     +++ b/docs/specs/vmgenid.txt
>     @@ -0,0 +1,245 @@
>     +VIRTUAL MACHINE GENERATION ID
>     +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>     +
>     +Copyright (C) 2016 Red Hat, Inc.
>     +Copyright (C) 2017 Skyport Systems, Inc.
>     +
>     +This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
>     +See the COPYING file in the top-level directory.
>     +
>     +=3D=3D=3D
>     +
>     +The VM generation ID (vmgenid) device is an emulated device which
>     +exposes a 128-bit, cryptographically random, integer value identif=
ier,
>     +referred to as a Globally Unique Identifier, or GUID.
>     +
>     +This allows management applications (e.g. libvirt) to notify the g=
uest
>     +operating system when the virtual machine is executed with a diffe=
rent
>     +configuration (e.g. snapshot execution or creation from a template=
).=A0 The
>     +guest operating system notices the change, and is then able to rea=
ct as
>     +appropriate by marking its copies of distributed databases as dirt=
y,
>     +re-initializing its random number generator etc.
>     +
>     +
>     +Requirements
>     +------------
>     +
>     +These requirements are extracted from the "How to implement virtua=
l
>     machine
>     +generation ID support in a virtualization platform" section of the
>     +specification, dated August 1, 2012.
>     +
>     +
>     +The document may be found on the web at:
>     +=A0 http://go.microsoft.com/fwlink/?LinkId=3D260709
>     +
>     +R1a. The generation ID shall live in an 8-byte aligned buffer.
>     +
>     +R1b. The buffer holding the generation ID shall be in guest RAM, R=
OM, or
>     device
>     +=A0 =A0 =A0MMIO range.
>     +
>     +R1c. The buffer holding the generation ID shall be kept separate f=
rom
>     areas
>     +=A0 =A0 =A0used by the operating system.
>     +
>     +R1d. The buffer shall not be covered by an AddressRangeMemory or
>     +=A0 =A0 =A0AddressRangeACPI entry in the E820 or UEFI memory map.
>     +
>     +R1e. The generation ID shall not live in a page frame that could b=
e mapped
>     with
>     +=A0 =A0 =A0caching disabled. (In other words, regardless of whethe=
r the
>     generation ID
>     +=A0 =A0 =A0lives in RAM, ROM or MMIO, it shall only be mapped as c=
acheable.)
>     +
>     +R2 to R5. [These AML requirements are isolated well enough in the
>     Microsoft
>     +=A0 =A0 =A0 =A0 =A0 specification for us to simply refer to them h=
ere.]
>     +
>     +R6. The hypervisor shall expose a _HID (hardware identifier) objec=
t in the
>     +=A0 =A0 VMGenId device's scope that is unique to the hypervisor ve=
ndor.
>     +
>     +
>     +QEMU Implementation
>     +-------------------
>     +
>     +The above-mentioned specification does not dictate which ACPI desc=
riptor
>     table
>     +will contain the VM Generation ID device.=A0 Other implementations=
 (Hyper-V
>     and
>     +Xen) put it in the main descriptor table (Differentiated System
>     Description
>     +Table or DSDT).=A0 For ease of debugging and implementation, we ha=
ve decided
>     to
>     +put it in its own Secondary System Description Table, or SSDT.
>     +
>     +The following is a dump of the contents from a running system:
>     +
>     +# iasl -p ./SSDT -d /sys/firmware/acpi/tables/SSDT
>     +
>     +Intel ACPI Component Architecture
>     +ASL+ Optimizing Compiler version 20150717-64
>     +Copyright (c) 2000 - 2015 Intel Corporation
>     +
>     +Reading ACPI table from file /sys/firmware/acpi/tables/SSDT - Leng=
th
>     +00000198 (0x0000C6)
>     +ACPI: SSDT 0x0000000000000000 0000C6 (v01 BOCHS=A0 VMGENID=A0 0000=
0001 BXPC
>     +00000001)
>     +Acpi table [SSDT] successfully installed and loaded
>     +Pass 1 parse of [SSDT]
>     +Pass 2 parse of [SSDT]
>     +Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>     +
>     +Parsing completed
>     +Disassembly completed
>     +ASL Output:=A0 =A0 ./SSDT.dsl - 1631 bytes
>     +# cat SSDT.dsl
>     +/*
>     + * Intel ACPI Component Architecture
>     + * AML/ASL+ Disassembler version 20150717-64
>     + * Copyright (c) 2000 - 2015 Intel Corporation
>     + *
>     + * Disassembling to symbolic ASL+ operators
>     + *
>     + * Disassembly of /sys/firmware/acpi/tables/SSDT, Sun Feb=A0 5 00:=
19:37 2017
>     + *
>     + * Original Table Header:
>     + *=A0 =A0 =A0Signature=A0 =A0 =A0 =A0 "SSDT"
>     + *=A0 =A0 =A0Length=A0 =A0 =A0 =A0 =A0 =A00x000000CA (202)
>     + *=A0 =A0 =A0Revision=A0 =A0 =A0 =A0 =A00x01
>     + *=A0 =A0 =A0Checksum=A0 =A0 =A0 =A0 =A00x4B
>     + *=A0 =A0 =A0OEM ID=A0 =A0 =A0 =A0 =A0 =A0"BOCHS "
>     + *=A0 =A0 =A0OEM Table ID=A0 =A0 =A0"VMGENID"
>     + *=A0 =A0 =A0OEM Revision=A0 =A0 =A00x00000001 (1)
>     + *=A0 =A0 =A0Compiler ID=A0 =A0 =A0 "BXPC"
>     + *=A0 =A0 =A0Compiler Version 0x00000001 (1)
>     + */
>     +DefinitionBlock ("/sys/firmware/acpi/tables/SSDT.aml", "SSDT", 1, =
"BOCHS
>     ",
>     +"VMGENID", 0x00000001)
>     +{
>     +=A0 =A0 Name (VGIA, 0x07FFF000)
>     +=A0 =A0 Scope (\_SB)
>     +=A0 =A0 {
>     +=A0 =A0 =A0 =A0 Device (VGEN)
>     +=A0 =A0 =A0 =A0 {
>     +=A0 =A0 =A0 =A0 =A0 =A0 Name (_HID, "QEMUVGID")=A0 // _HID: Hardwa=
re ID
>     +=A0 =A0 =A0 =A0 =A0 =A0 Name (_CID, "VM_Gen_Counter")=A0 // _CID: =
Compatible ID
>     +=A0 =A0 =A0 =A0 =A0 =A0 Name (_DDN, "VM_Gen_Counter")=A0 // _DDN: =
DOS Device Name
>     +=A0 =A0 =A0 =A0 =A0 =A0 Method (_STA, 0, NotSerialized)=A0 // _STA=
: Status
>     +=A0 =A0 =A0 =A0 =A0 =A0 {
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Local0 =3D 0x0F
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 If ((VGIA =3D=3D Zero))
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Local0 =3D Zero
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>     +
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Return (Local0)
>     +=A0 =A0 =A0 =A0 =A0 =A0 }
>     +
>     +=A0 =A0 =A0 =A0 =A0 =A0 Method (ADDR, 0, NotSerialized)
>     +=A0 =A0 =A0 =A0 =A0 =A0 {
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Local0 =3D Package (0x02) {}
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Index (Local0, Zero) =3D (VGIA + 0=
x28)
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Index (Local0, One) =3D Zero
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Return (Local0)
>     +=A0 =A0 =A0 =A0 =A0 =A0 }
>     +=A0 =A0 =A0 =A0 }
>     +=A0 =A0 }
>     +
>     +=A0 =A0 Method (\_GPE._E05, 0, NotSerialized)=A0 // _Exx: Edge-Tri=
ggered GPE
>     +=A0 =A0 {
>     +=A0 =A0 =A0 =A0 Notify (\_SB.VGEN, 0x80) // Status Change
>     +=A0 =A0 }
>     +}
>     +
>     +
>     +Design Details:
>     +---------------
>     +
>     +Requirements R1a through R1e dictate that the memory holding the
>     +VM Generation ID must be allocated and owned by the guest firmware=
,
>     +in this case BIOS or UEFI.=A0 However, to be useful, QEMU must be =
able to
>     +change the contents of the memory at runtime, specifically when st=
arting a
>     +backed-up or snapshotted image.=A0 In order to do this, QEMU must =
know the
>     +address that has been allocated.
>     +
>     +The mechanism chosen for this memory sharing is writeable fw_cfg b=
lobs.
>     +These are data object that are visible to both QEMU and guests, an=
d are
>     +addressable as sequential files.
>     +
>     +More information about fw_cfg can be found in "docs/specs/fw_cfg.t=
xt"
>     +
>     +Two fw_cfg blobs are used in this case:
>     +
>     +/etc/vmgenid_guid - contains the actual VM Generation ID GUID
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - read-only to the guest
>     +/etc/vmgenid_addr - contains the address of the downloaded vmgenid=
 blob
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - writeable by the guest
>     +
>     +
>     +QEMU sends the following commands to the guest at startup:
>     +
>     +1. Allocate memory for vmgenid_guid fw_cfg blob.
>     +2. Write the address of vmgenid_guid into the SSDT (VGIA ACPI vari=
able as
>     +=A0 =A0shown above in the iasl dump).=A0 Note that this change is =
not propagated
>     +=A0 =A0back to QEMU.
>     +3. Write the address of vmgenid_guid back to QEMU's copy of vmgeni=
d_addr
>     +=A0 =A0via the fw_cfg DMA interface.
>     +
>     +After step 3, QEMU is able to update the contents of vmgenid_guid =
at will.
>     +
>     +Since BIOS or UEFI does not necessarily run when we wish to change=
 the
>     GUID,
>     +the value of VGIA is persisted via the VMState mechanism.
>     +
>     +As spelled out in the specification, any change to the GUID execut=
es an
>     +ACPI notification.=A0 The exact handler to use is not specified, s=
o the
>     vmgenid
>     +device uses the first unused one:=A0 \_GPE._E05.
>     +
>     +
>     +Endian-ness Considerations:
>     +---------------------------
>     +
>     +Although not specified in Microsoft's document, it is assumed that=
 the
>     +device is expected to use little-endian format.
>     +
>     +All GUID passed in via command line or monitor are treated as big-=
endian.
>     +GUID values displayed via monitor are shown in big-endian format.
>     +
>     +
>     +GUID Storage Format:
>     +--------------------
>     +
>     +In order to implement an OVMF "SDT Header Probe Suppressor", the c=
ontents
>     of
>     +the vmgenid_guid fw_cfg blob are not simply a 128-bit GUID.=A0 The=
re is also
>     +significant padding in order to align and fill a memory page, as s=
hown in
>     the
>     +following diagram:
>     +
>     ++----------------------------------+
>     +| SSDT with OEM Table ID =3D VMGENID |
>     ++----------------------------------+
>     +| ...=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
=A0 =A0 =A0 =A0TOP OF PAGE
>     +| VGIA dword object ---------------|-----> +----------------------=
-----+
>     +| ...=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
=A0 =A0 =A0 =A0| fw-allocated array for=A0 =A0 |
>     +| _STA method referring to VGIA=A0 =A0 |=A0 =A0 =A0 =A0| "etc/vmge=
nid_guid"=A0 =A0 =A0 =A0 |
>     +| ...=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
=A0 =A0 =A0 =A0+---------------------------+
>     +| ADDR method referring to VGIA=A0 =A0 |=A0 =A0 =A0 =A0|=A0 0: OVM=
F SDT Header probe |
>     +| ...=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
=A0 =A0 =A0 =A0|=A0 =A0 =A0suppressor=A0 =A0 =A0 =A0 =A0 =A0 |
>     ++----------------------------------+=A0 =A0 =A0 =A0| 36: padding f=
or 8-byte=A0 =A0 |
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0|=A0 =A0 =A0alignment=A0 =A0 =A0 =A0 =A0 =A0 =A0|
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0| 40: GUID=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0| 56: padding to page size=A0 |
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0+---------------------------+
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0END OF PAGE
>     +
>     +
>     +Device Usage:
>     +-------------
>     +
>     +The device has one property, which may be only be set using the co=
mmand
>     line:
>     +
>     +=A0 guid - sets the value of the GUID.=A0 A special value "auto" i=
nstructs
>     +=A0 =A0 =A0 =A0 =A0QEMU to generate a new random GUID.
>     +
>     +For example:
>     +
>     +=A0 QEMU=A0 -device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c=
91fb87"
>     +=A0 QEMU=A0 -device vmgenid,guid=3Dauto
>=20
>=20
> The default will keep uuid to null, should it be documented? Wouldn't i=
t make
> sense to default to auto?

Interesting. I'd say default should fail init.

>=20
>     +The property may be queried via QMP/HMP:
>     +
>     +=A0 (QEMU) query-vm-generation-id
>     +=A0 {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
>     +
>     +Setting of this parameter is intentionally left out from the QMP/H=
MP
>     +interfaces.=A0 There are no known use cases for changing the GUID =
once QEMU
>     is
>     +running, and adding this capability would greatly increase the com=
plexity.
>=20
> =A0
> Is this supposed to be not permitted?
>=20
> { "execute": "qom-set", "arguments": { "path": "/machine/peripheral-ano=
n/device
> [1]", "property": "guid", "value": "auto" } }

anon means in particular no stability.

Also we are yet to tie this to generate
an interrupt and update guest memory properly.
Patches welcome.

> Is there any linux kernel support being worked on?

I vaguely rememeber some patches but couldn't find them.
An ACPI driver would be easy to implement, one thing to
be careful about is to make sure all memory maps are cached
as spec requires this.

> thanks
> --
> Marc-Andr=E9 Lureau
