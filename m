Received: from eggs.gnu.org ([2001:4830:134:3::10]:44508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ctCFP-0001Tg-8p
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ctCFM-0006Sn-3B
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ctCFL-0006Sh-QT
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:58:40 -0400
References: <76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
	<20170321113428.GC15920@cbox> <58D17AF0.2010802@arm.com>
	<20170321193933.GB31111@cbox> <58DA3F68.6090901@arm.com>
	<20170328112328.GA31156@cbox> <20170328115413.GJ23682@e104320-lin>
	<b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com>
	<58DA67BA.8070404@arm.com>
	<5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
	<20170329103658.GQ23682@e104320-lin>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2a427164-9b37-6711-3a56-906634ba7f12@redhat.com>
Date: Wed, 29 Mar 2017 13:58:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170329103658.GQ23682@e104320-lin>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] kvm: pass the virtual SEI syndrome to
 guest OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Achin Gupta <achin.gupta@arm.com>, gengdongjiu <gengdongjiu@huawei.com>
Cc: ard.biesheuvel@linaro.org, edk2-devel@lists.01.org, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, James Morse <james.morse@arm.com>, Christoffer Dall <cdall@linaro.org>, xiexiuqi@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, suzuki.poulose@arm.com, andre.przywara@arm.com, mark.rutland@arm.com, vladimir.murzin@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, Leif.Lindholm@linaro.comnd@arm.com, Michael Tsirkin <mtsirkin@redhat.com>, Igor Mammedov <imammedo@redhat.com>

(This ought to be one of the longest address lists I've ever seen :)
Thanks for the CC. I'm glad Shannon is already on the CC list. For good
measure, I'm adding MST and Igor.)

On 03/29/17 12:36, Achin Gupta wrote:
> Hi gengdongjiu,
>=20
> On Wed, Mar 29, 2017 at 05:36:37PM +0800, gengdongjiu wrote:
>>
>> Hi Laszlo/Biesheuvel/Qemu developer,
>>
>>    Now I encounter a issue and want to consult with you in ARM64 platf=
orm=EF=BC=8C as described below:
>>
>> when guest OS happen synchronous or asynchronous abort, kvm needs
>> to send the error address to Qemu or UEFI through sigbus to
>> dynamically generate APEI table. from my investigation, there are
>> two ways:
>>
>> (1) Qemu get the error address, and generate the APEI table, then
>> notify UEFI to know this generation, then inject abort error to
>> guest OS, guest OS read the APEI table.
>> (2) Qemu get the error address, and let UEFI to generate the APEI
>> table, then inject abort error to guest OS, guest OS read the APEI
>> table.
>=20
> Just being pedantic! I don't think we are talking about creating the AP=
EI table
> dynamically here. The issue is: Once KVM has received an error that is =
destined
> for a guest it will raise a SIGBUS to Qemu. Now before Qemu can inject =
the error
> into the guest OS, a CPER (Common Platform Error Record) has to be gene=
rated
> corresponding to the error source (GHES corresponding to memory subsyst=
em,
> processor etc) to allow the guest OS to do anything meaningful with the
> error. So who should create the CPER is the question.
>=20
> At the EL3/EL2 interface (Secure Firmware and OS/Hypervisor), an error =
arrives
> at EL3 and secure firmware (at EL3 or a lower secure exception level) i=
s
> responsible for creating the CPER. ARM is experimenting with using a St=
andalone
> MM EDK2 image in the secure world to do the CPER creation. This will av=
oid
> adding the same code in ARM TF in EL3 (better for security). The error =
will then
> be injected into the OS/Hypervisor (through SEA/SEI/SDEI) through ARM T=
rusted
> Firmware.
>=20
> Qemu is essentially fulfilling the role of secure firmware at the EL2/E=
L1
> interface (as discussed with Christoffer below). So it should generate =
the CPER
> before injecting the error.
>=20
> This is corresponds to (1) above apart from notifying UEFI (I am assumi=
ng you
> mean guest UEFI). At this time, the guest OS already knows where to pic=
k up the
> CPER from through the HEST. Qemu has to create the CPER and populate it=
s address
> at the address exported in the HEST. Guest UEFI should not be involved =
in this
> flow. Its job was to create the HEST at boot and that has been done by =
this
> stage.
>=20
> Qemu folk will be able to add but it looks like support for CPER genera=
tion will
> need to be added to Qemu. We need to resolve this.
>=20
> Do shout if I am missing anything above.

After reading this email, the use case looks *very* similar to what
we've just done with VMGENID for QEMU 2.9.

We have a facility between QEMU and the guest firmware, called "ACPI
linker/loader", with which QEMU instructs the firmware to

- allocate and download blobs into guest RAM (AcpiNVS type memory) --
ALLOCATE command,

- relocate pointers in those blobs, to fields in other (or the same)
blobs -- ADD_POINTER command,

- set ACPI table checksums -- ADD_CHECKSUM command,

- and send GPAs of fields within such blobs back to QEMU --
WRITE_POINTER command.

This is how I imagine we can map the facility to the current use case
(note that this is the first time I read about HEST / GHES / CPER):

    etc/acpi/tables                 etc/hardware_errors
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                         +-----------+
    +--------------+     | address   |         +-> +--------------+
    |    HEST      +     | registers |         |   | Error Status |
    + +------------+     | +---------+         |   | Data Block 1 |
    | | GHES       | --> | | address | --------+   | +------------+
    | | GHES       | --> | | address | ------+     | |  CPER      |
    | | GHES       | --> | | address | ----+ |     | |  CPER      |
    | | GHES       | --> | | address | -+  | |     | |  CPER      |
    +-+------------+     +-+---------+  |  | |     +-+------------+
                                        |  | |
                                        |  | +---> +--------------+
                                        |  |       | Error Status |
                                        |  |       | Data Block 2 |
                                        |  |       | +------------+
                                        |  |       | |  CPER      |
                                        |  |       | |  CPER      |
                                        |  |       +-+------------+
                                        |  |
                                        |  +-----> +--------------+
                                        |          | Error Status |
                                        |          | Data Block 3 |
                                        |          | +------------+
                                        |          | |  CPER      |
                                        |          +-+------------+
                                        |
                                        +--------> +--------------+
                                                   | Error Status |
                                                   | Data Block 4 |
                                                   | +------------+
                                                   | |  CPER      |
                                                   | |  CPER      |
                                                   | |  CPER      |
                                                   +-+------------+

(1) QEMU generates the HEST ACPI table. This table goes in the current
"etc/acpi/tables" fw_cfg blob. Given N error sources, there will be N
GHES objects in the HEST.

(2) We introduce a new fw_cfg blob called "etc/hardware_errors". QEMU
also populates this blob.

(2a) Given N error sources, the (unnamed) table of address registers
will contain N address registers.

(2b) Given N error sources, the "etc/hardwre_errors" fw_cfg blob will
also contain N Error Status Data Blocks.

I don't know about the sizing (number of CPERs) each Error Status Data
Block has to contain, but I understand it is all pre-allocated as far as
the OS is concerned, which matches our capabilities well.

(3) QEMU generates the ACPI linker/loader script for the firmware, as
always.

(3a) The HEST table is part of "etc/acpi/tables", which the firmware
already allocates memory for, and downloads (because QEMU already
generates an ALLOCATE linker/loader command for it already).

(3b) QEMU will have to create another ALLOCATE command for the
"etc/hardware_errors" blob. The firmware allocates memory for this blob,
and downloads it.

(4) QEMU generates, in the ACPI linker/loader script for the firwmare, N
ADD_POINTER commands, which point the GHES."Error Status
Address" fields in the HEST table, to the corresponding address
registers in the downloaded "etc/hardware_errors" blob.

(5) QEMU generates an ADD_CHECKSUM command for the firmware, so that the
HEST table is correctly checksummed after executing the N ADD_POINTER
commands from (4).

(6) QEMU generates N ADD_POINTER commands for the firmware, pointing the
address registers (located in guest memory, in the downloaded
"etc/hardware_errors" blob) to the respective Error Status Data Blocks.

(7) (This is the trick.) For this step, we need a third, write-only
fw_cfg blob, called "etc/hardware_errors_addr". Through that blob, the
firmware can send back the guest-side allocation addresses to QEMU.

Namely, the "etc/hardware_errors_addr" blob contains N 8-byte entries.
QEMU generates N WRITE_POINTER commands for the firmware.

For error source K (0 <=3D K < N), QEMU instructs the firmware to
calculate the guest address of Error Status Data Block K, from the
QEMU-dictated offset within "etc/hardware_errors", and from the
guest-determined allocation base address for "etc/hardware_errors". The
firmware then writes the calculated address back to fw_cfg file
"etc/hardware_errors_addr", at offset K*8, according to the
WRITE_POINTER command.

This way QEMU will know the GPA of each Error Status Data Block.

(In fact this can be simplified to a single WRITE_POINTER command: the
address of the "address register table" can be sent back to QEMU as
well, which already contains all Error Status Data Block addresses.)

(8) When QEMU gets SIGBUS from the kernel -- I hope that's going to come
through a signalfd -- QEMU can format the CPER right into guest memory,
and then inject whatever interrupt (or assert whatever GPIO line) is
necessary for notifying the guest.

(9) This notification (in virtual hardware) can either be handled by the
guest kernel stand-alone, or else the guest kernel can invoke an ACPI
event handler method with it (which would be in the DSDT or one of the
SSDTs, also generated by QEMU). The ACPI event handler method could
invoke the specific guest kernel driver for errror handling via a
Notify() operation.

I'm attracted to the above design because:
- it would leave the firmware alone after OS boot, and
- it would leave the firmware blissfully ignorant about HEST, GHES,
CPER, and the like. (That's why QEMU's ACPI linker/loader was invented
in the first place.)

Thanks
Laszlo

>>    Do you think which modules generates the APEI table is better? UEFI=
 or Qemu?
>>
>>
>>
>>
>> On 2017/3/28 21:40, James Morse wrote:
>>> Hi gengdongjiu,
>>>
>>> On 28/03/17 13:16, gengdongjiu wrote:
>>>> On 2017/3/28 19:54, Achin Gupta wrote:
>>>>> On Tue, Mar 28, 2017 at 01:23:28PM +0200, Christoffer Dall wrote:
>>>>>> On Tue, Mar 28, 2017 at 11:48:08AM +0100, James Morse wrote:
>>>>>>> On the host, part of UEFI is involved to generate the CPER record=
s.
>>>>>>> In a guest?, I don't know.
>>>>>>> Qemu could generate the records, or drive some other component to=
 do it.
>>>>>>
>>>>>> I think I am beginning to understand this a bit.  Since the guet U=
EFI
>>>>>> instance is specifically built for the machine it runs on, QEMU's =
virt
>>>>>> machine in this case, they could simply agree (by some contract) t=
o
>>>>>> place the records at some specific location in memory, and if the =
guest
>>>>>> kernel asks its guest UEFI for that location, things should just w=
ork by
>>>>>> having logic in QEMU to process error reports and populate guest m=
emory.
>>>>>>
>>>>>> Is this how others see the world too?
>>>>>
>>>>> I think so!
>>>>>
>>>>> AFAIU, the memory where CPERs will reside should be specified in a =
GHES entry in
>>>>> the HEST. Is this not the case with a guest kernel i.e. the guest U=
EFI creates a
>>>>> HEST for the guest Kernel?
>>>>>
>>>>> If so, then the question is how the guest UEFI finds out where QEMU=
 (acting as
>>>>> EL3 firmware) will populate the CPERs. This could either be a contr=
act between
>>>>> the two or a guest DXE driver uses the MM_COMMUNICATE call (see [1]=
) to ask QEMU
>>>>> where the memory is.
>>>>
>>>> whether invoke the guest UEFI will be complex? not see the advantage=
. it seems x86 Qemu
>>>> directly generate the ACPI table, but I am not sure, we are checking=
 the qemu
>>> logical.
>>>> let Qemu generate CPER record may be clear.
>>>
>>> At boot UEFI in the guest will need to make sure the areas of memory =
that may be
>>> used for CPER records are reserved. Whether UEFI or Qemu decides wher=
e these are
>>> needs deciding, (but probably not here)...
>>>
>>> At runtime, when an error has occurred, I agree it would be simpler (=
fewer
>>> components involved) if Qemu generates the CPER records. But if UEFI =
made the
>>> memory choice above they need to interact and it gets complicated aga=
in. The
>>> CPER records are defined in the UEFI spec, so I would expect UEFI to =
contain
>>> code to generate/parse them.
>>>
>>>
>>> Thanks,
>>>
>>> James
>>>
>>>
>>> .
>>>
>>
