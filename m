Received: from eggs.gnu.org ([2001:4830:134:3::10]:38294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eldGM-0000gv-W3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eldGJ-0004hB-Q2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:16:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eldGJ-0004gj-Kt
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:16:55 -0500
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212204609.GB30111@morn.lan>
	<b2725975-6823-8919-e937-56d8cb404372@linux.vnet.ibm.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e8cf7f36-249f-a3cc-f414-fac4e8b56b51@redhat.com>
Date: Tue, 13 Feb 2018 17:16:49 +0100
MIME-Version: 1.0
In-Reply-To: <b2725975-6823-8919-e937-56d8cb404372@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, Kevin O'Connor <kevin@koconnor.net>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, Igor Mammedov <imammedo@redhat.com>

On 02/12/18 21:49, Stefan Berger wrote:
> On 02/12/2018 03:46 PM, Kevin O'Connor wrote:
>> On Fri, Feb 09, 2018 at 03:19:31PM -0500, Stefan Berger wrote:
>>> The PPI device in this patch series allocates 0x400 bytes. 0x200
>>> bytes are
>>> used by the OperationRegion() in this patch series. The rest was
>>> thought of
>>> for future extensions.
>>>
>>> To allow both firmwares to use PPI, we would need to be able to have =
the
>>> OperationRegion() be flexible and located at 0xFFFF 0000 for EDK2 and
>>> 0xFED4
>>> 5000 for SeaBIOS, per choice of the firmware. One way to achieve this
>>> would
>>> be to have the firmwares choose their operation region base address b=
y
>>> writing into the PPI memory device at offset 0x200 (for example). A '=
1'
>>> there would mean that we want the OperationRegion() at 0xFFFF 0000,
>>> and a
>>> '2' would mean at the base address of the PPI device (0xFED4 5000). T=
his
>>> could be achieved by declaring a 2nd OperationRegion() in the ACPI
>>> code that
>>> is located at 0xFED4 5200 and we declare that 1st OperationRegion()'s
>>> address based on findings from there. Further, a flags variable at
>>> offset
>>> 0x201 could indicate whether an SMI is needed to enter SMM or not.
>>> Obviously, the ACPI code would become more complex to be able to supp=
ort
>>> both firmwares at the same time.
>>>
>>> This is a lot of details but I rather post this description before
>>> posting
>>> more patches. To make these changes and get it to work with at least
>>> SeaBIOS
>>> is probably fairly easy. But is this acceptable?
>> I'm not sure I fully understand the goals of the PPI interface.
>> Here's what I understand so far:
>>
>> The TPM specs define some actions that are considered privileged.=A0 A=
n
>> example of this would be disabling the TPM itself.=A0 In order to
>> prevent an attacker from performing these actions without
>> authorization, the TPM specs define a mechanism to assert "physical
>> presence" before the privileged action can be done.=A0 They do this by
>> having the firmware present a menu during early boot that permits
>> these privileged operations, and then the firmware locks the TPM chip
>> so the actions can no longer be done by any software that runs after
>> the firmware.=A0 Thus "physical presence" is asserted by demonstrating
>> one has console access to the machine during early boot.
>>
>> The PPI spec implements a work around for this - presumably some found
>> the enforcement mechanism too onerous.=A0 It allows the OS to provide =
a
>> request code to the firmware, and on the next boot the firmware will
>> take the requested action before it locks the chip.=A0 Thus allowing t=
he
>> OS to indirectly perform the privileged action even after the chip has
>> been locked.=A0 Thus, the PPI system seems to be an "elaborate hack" t=
o
>> allow users to circumvent the physical presence mechanism (if they
>> choose to).
>=20
> Correct.
>>
>> Here's what I understand the proposed implementation involves:
>>
>> 1 - in addition to emulating the TPM device itself, QEMU will also
>> =A0=A0=A0=A0 introduce a virtual memory device with 0x400 bytes.
> Correct.
>>
>> 2 - on first boot the firmware (seabios and uefi) will populate the
>> =A0=A0=A0=A0 memory region created in step 1.=A0 In particular it will=
 fill an
>> =A0=A0=A0=A0 array with the list of request codes it supports.=A0 (Eac=
h request
>> =A0=A0=A0=A0 is an 8bit value, the array has 256 entries.)
> Correct. Each firmware would fill out the 256 byte array depending on
> what it supports. The 8 bit values are basically flags and so on.
>> 3 - QEMU will produce AML code implementing the standard PPI ACPI
>> =A0=A0=A0=A0 interface.=A0 This AML code will take the request, find t=
he table
>> =A0=A0=A0=A0 produced in step 1, compare it to the list of accepted re=
quests
>> =A0=A0=A0=A0 produced in step 2, and then place the 8bit request in an=
other
>> =A0=A0=A0=A0 qemu virtual memory device (at 0xFFFF0000 or 0xFED45000).
>=20
> Correct.
>=20
> Now EDK2 wants to store the code in a UEFI variable in NVRAM. We
> therefore would need to trigger an SMI. In SeaBIOS we wouldn't have to
> do this.
>=20
>> 4 - the OS will signal a reboot, qemu will do its normal reboot logic,
>> =A0=A0=A0=A0 and the firmware will be run again.
>>
>> 5 - the firmware will extract the code written in stage 3, and if the
>> =A0=A0=A0=A0 tpm device has been configured to accept PPI codes from t=
he OS, it
>> =A0=A0=A0=A0 will invoke the requested action.
>=20
> SeaBIOS would look into memory to find the code. EDK2 will read the cod=
e
> from a UEFI variable.
>=20
>> Did I understand the above correctly?
> I think so. With the fine differences between SeaBIOS and EDK2 pointed =
out.

Here's what I suggest:

Please everyone continue working on this, according to Kevin's &
Stefan's description, but focus on QEMU and SeaBIOS *only*. Ignore edk2
for now. Generate as much as possible AML in QEMU, using the
linker/loader. If you generate data tables, please don't forget about
the "OVMF SDT header probe suppressor" padding (see vmgenid for
example). Focus on basic TPM enablement (measurements, PCRs) and PPI.
Please ignore the "memory clear request" TPM feature for now.

Also, please focus on TPM2 only.

It's obvious we are unable to target both firmwares at once. So finalize
a *sensible* hardware device model, and we'll drive it one way or
another from OVMF as a second step. "Sensible" means that it should be
dynamically detectable to the firmware, in some way; either via hardware
(MMIO) registers or fw_cfg.

Once everything is working with SeaBIOS and QEMU, and the Windows guest
is happy, I'll do my best to set time aside for the OVMF enablement. If
needed, I'll carve chunks out of the existing SecurityPkg modules and
implement the needed drivers and libraries under OvmfPkg. I fully intend
to remove both (a) the non-volatile UEFI variable storage for the PPI
opcodes, and (b) SMM, from the UEFI picture. There's no reason basic
TPM, and TPM PPI, shouldn't work under OVMF with i440fx, or (later)
under ArmVirtQemu with aarch64/"virt".

I've tried to avoid such major surgery under edk2, but I clearly see now
that there's no other way. Thus far I've lacked both commitment and time
for working on this; from now on I'm only lacking time. Please polish
*and document* the device model and get it 100% functional with SeaBIOS
and Windows; I'll do my best to take care of OVMF. Again, please focus
on measurements / PCRs and PPI, and ignore the "memory clear request"
for now. (I very much hope that Windows does not insist on the latter.)

It's possible that I'll scream for additional hw enlightement under OVMF
later; so I suggest designing in some kind of feature negotiation up-fron=
t.

Importantly, please make sure that the TPM *backend* works without using
the TPM hardware of the virtualization host; the backend should be a
full software emulator. Otherwise I won't be able to experiment with OVMF=
.

I don't want to ignore or reject work that's already been done for edk2
/ OVMF, but I'm still not seeing patches or discussion on edk2-devel.
Plus, as I mentioned above, I fully intend to kill the complicated
*accidental* artifacts, such as non-volatile UEFI variables for PPI
opcode storage, and the consequent SMI requirement for the AML->fw
calling convention. No such calls should be necessary in the first place.

Thanks
Laszlo

>> Separately, is there someone clamoring for PPI support today?=A0 That
>> is, is the goal to implement PPI to make QEMU more spec compliant, or
>> is there someone struggling to perform a particular task today that
>> this support would improve?
>=20
> We could defer the implementation of this. My main goal was to to
> support TPM migration in QEMU and the PPI device also needs to be
> migrated as part of TPM migration. So that's why I am looking at PPI no=
w.
>=20
> =A0=A0=A0 Stefan
>> Thanks,
>> -Kevin
>>
>=20
>=20
