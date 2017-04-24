Received: from eggs.gnu.org ([2001:4830:134:3::10]:58376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1d2cAE-0000Li-TH
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1d2cA9-0001WI-S1
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:28:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1d2cA9-0001WC-IT
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:28:13 -0400
References: <76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
	<20170321113428.GC15920@cbox> <58D17AF0.2010802@arm.com>
	<20170321193933.GB31111@cbox> <58DA3F68.6090901@arm.com>
	<20170328112328.GA31156@cbox> <20170328115413.GJ23682@e104320-lin>
	<b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com>
	<58DA67BA.8070404@arm.com>
	<5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
	<20170329103658.GQ23682@e104320-lin>
	<2a427164-9b37-6711-3a56-906634ba7f12@redhat.com>
	<7c5c8ab7-8fcc-1c98-0bc1-cccb66c4c84d@huawei.com>
	<6ac1597a-2ed5-36b2-848d-5fd048b16d66@redhat.com>
	<3fdc8c8c-1cd9-b609-c7af-52d40e6141c5@huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2aa1180d-2d05-d898-e1f2-be56c342a170@redhat.com>
Date: Mon, 24 Apr 2017 13:27:51 +0200
MIME-Version: 1.0
In-Reply-To: <3fdc8c8c-1cd9-b609-c7af-52d40e6141c5@huawei.com>
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
To: gengdongjiu <gengdongjiu@huawei.com>, Achin Gupta <achin.gupta@arm.com>
Cc: ard.biesheuvel@linaro.org, edk2-devel@lists.01.org, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, James Morse <james.morse@arm.com>, Christoffer Dall <cdall@linaro.org>, xiexiuqi@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, suzuki.poulose@arm.com, andre.przywara@arm.com, mark.rutland@arm.com, vladimir.murzin@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, Leif.Lindholm@linaro.comnd@arm.com, Michael Tsirkin <mtsirkin@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 04/21/17 15:27, gengdongjiu wrote:
> Hi all/Laszlo,
>=20
>   sorry, I have a question to consult with you.
>=20
>=20
> On 2017/4/7 2:55, Laszlo Ersek wrote:
>> On 04/06/17 14:35, gengdongjiu wrote:
>>> Dear, Laszlo
>>>    Thanks for your detailed explanation.
>>>
>>> On 2017/3/29 19:58, Laszlo Ersek wrote:
>>>> (This ought to be one of the longest address lists I've ever seen :)
>>>> Thanks for the CC. I'm glad Shannon is already on the CC list. For g=
ood
>>>> measure, I'm adding MST and Igor.)
>>>>
>>>> On 03/29/17 12:36, Achin Gupta wrote:
>>>>> Hi gengdongjiu,
>>>>>
>>>>> On Wed, Mar 29, 2017 at 05:36:37PM +0800, gengdongjiu wrote:
>>>>>>
>>>>>> Hi Laszlo/Biesheuvel/Qemu developer,
>>>>>>
>>>>>>    Now I encounter a issue and want to consult with you in ARM64 p=
latform=EF=BC=8C as described below:
>>>>>>
>>>>>> when guest OS happen synchronous or asynchronous abort, kvm needs
>>>>>> to send the error address to Qemu or UEFI through sigbus to
>>>>>> dynamically generate APEI table. from my investigation, there are
>>>>>> two ways:
>>>>>>
>>>>>> (1) Qemu get the error address, and generate the APEI table, then
>>>>>> notify UEFI to know this generation, then inject abort error to
>>>>>> guest OS, guest OS read the APEI table.
>>>>>> (2) Qemu get the error address, and let UEFI to generate the APEI
>>>>>> table, then inject abort error to guest OS, guest OS read the APEI
>>>>>> table.
>>>>>
>>>>> Just being pedantic! I don't think we are talking about creating th=
e APEI table
>>>>> dynamically here. The issue is: Once KVM has received an error that=
 is destined
>>>>> for a guest it will raise a SIGBUS to Qemu. Now before Qemu can inj=
ect the error
>>>>> into the guest OS, a CPER (Common Platform Error Record) has to be =
generated
>>>>> corresponding to the error source (GHES corresponding to memory sub=
system,
>>>>> processor etc) to allow the guest OS to do anything meaningful with=
 the
>>>>> error. So who should create the CPER is the question.
>>>>>
>>>>> At the EL3/EL2 interface (Secure Firmware and OS/Hypervisor), an er=
ror arrives
>>>>> at EL3 and secure firmware (at EL3 or a lower secure exception leve=
l) is
>>>>> responsible for creating the CPER. ARM is experimenting with using =
a Standalone
>>>>> MM EDK2 image in the secure world to do the CPER creation. This wil=
l avoid
>>>>> adding the same code in ARM TF in EL3 (better for security). The er=
ror will then
>>>>> be injected into the OS/Hypervisor (through SEA/SEI/SDEI) through A=
RM Trusted
>>>>> Firmware.
>>>>>
>>>>> Qemu is essentially fulfilling the role of secure firmware at the E=
L2/EL1
>>>>> interface (as discussed with Christoffer below). So it should gener=
ate the CPER
>>>>> before injecting the error.
>>>>>
>>>>> This is corresponds to (1) above apart from notifying UEFI (I am as=
suming you
>>>>> mean guest UEFI). At this time, the guest OS already knows where to=
 pick up the
>>>>> CPER from through the HEST. Qemu has to create the CPER and populat=
e its address
>>>>> at the address exported in the HEST. Guest UEFI should not be invol=
ved in this
>>>>> flow. Its job was to create the HEST at boot and that has been done=
 by this
>>>>> stage.
>>>>>
>>>>> Qemu folk will be able to add but it looks like support for CPER ge=
neration will
>>>>> need to be added to Qemu. We need to resolve this.
>>>>>
>>>>> Do shout if I am missing anything above.
>>>>
>>>> After reading this email, the use case looks *very* similar to what
>>>> we've just done with VMGENID for QEMU 2.9.
>>>>
>>>> We have a facility between QEMU and the guest firmware, called "ACPI
>>>> linker/loader", with which QEMU instructs the firmware to
>>>>
>>>> - allocate and download blobs into guest RAM (AcpiNVS type memory) -=
-
>>>> ALLOCATE command,
>>>>
>>>> - relocate pointers in those blobs, to fields in other (or the same)
>>>> blobs -- ADD_POINTER command,
>>>>
>>>> - set ACPI table checksums -- ADD_CHECKSUM command,
>>>>
>>>> - and send GPAs of fields within such blobs back to QEMU --
>>>> WRITE_POINTER command.
>>>>
>>>> This is how I imagine we can map the facility to the current use cas=
e
>>>> (note that this is the first time I read about HEST / GHES / CPER):
>=20
> Laszlo lists a Qemu GHES table generation solution, Mainly use the
> four commands: "ALLOCATE/ADD_POINTER/ADD_CHECKSUM/WRITE_POINTER" to
> communicate with BIOS so whether the four commands needs to be
> supported by the guest firware/UEFI.  I found the  "WRITE_POINTER"
> always failed. so I suspect guest UEFI/firmware not support the
> "WRITE_POINTER" command. please help me confirm it, thanks so much.

That's incorrect, both OVMF and ArmVirtQemu support the WRITE_POINTER
command (see <https://bugzilla.tianocore.org/show_bug.cgi?id=3D359>.) A
number of OvmfPkg/ modules are included in ArmVirtPkg binaries as well.

In QEMU, the WRITE_POINTER command is currently generated for the
VMGENID device only. If you try to test VMGENID with qemu-system-aarch64
(for the purposes of WRITE_POINTER testing), that won't work, because
the VMGENID device is not available for aarch64. (The Microsoft spec
that describes the device lists Windows OS versions that are x86 only.)

In other words, no QEMU code exists at the moment that would allow you
to readily test WRITE_POINTER in aarch64 guests. However, the
firmware-side code is not architecture specific, and WRITE_POINTER
support is already being built into ArmVirtQemu.

Thanks,
Laszlo
