Received: from eggs.gnu.org ([2001:4830:134:3::10]:42152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eliBv-0004s1-6v
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 16:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eliBr-0004ib-VL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 16:32:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eliBr-0004i9-Lb
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 16:32:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1DLUiwA031452
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 16:32:38 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g42w5mh0q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 16:32:37 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 13 Feb 2018 16:32:35 -0500
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212204609.GB30111@morn.lan>
	<b2725975-6823-8919-e937-56d8cb404372@linux.vnet.ibm.com>
	<e8cf7f36-249f-a3cc-f414-fac4e8b56b51@redhat.com>
	<20180213193758.GA21083@morn.lan>
	<17e5dd66-e54d-56a3-7852-daf5bc11b741@redhat.com>
	<ead467f1-ab61-6350-e0bf-66ce0cbb06a1@linux.vnet.ibm.com>
	<637187b7-a5bc-9250-0ba7-7068dc83b7c5@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 16:32:32 -0500
MIME-Version: 1.0
In-Reply-To: <637187b7-a5bc-9250-0ba7-7068dc83b7c5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <ddf3e7c2-2fd3-a9d4-ec6c-0ba31b45cf9f@linux.vnet.ibm.com>
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
To: Laszlo Ersek <lersek@redhat.com>, Kevin O'Connor <kevin@koconnor.net>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, Igor Mammedov <imammedo@redhat.com>

On 02/13/2018 04:04 PM, Laszlo Ersek wrote:
> On 02/13/18 21:29, Stefan Berger wrote:
>> On 02/13/2018 02:59 PM, Laszlo Ersek wrote:
>>> On 02/13/18 20:37, Kevin O'Connor wrote:
>>>> On Tue, Feb 13, 2018 at 05:16:49PM +0100, Laszlo Ersek wrote:
>>>>> On 02/12/18 21:49, Stefan Berger wrote:
>>>>>> On 02/12/2018 03:46 PM, Kevin O'Connor wrote:
>>>>>>> I'm not sure I fully understand the goals of the PPI interface.
>>>>>>> Here's what I understand so far:
>>>>>>>
>>>>>>> The TPM specs define some actions that are considered privileged.  An
>>>>>>> example of this would be disabling the TPM itself.  In order to
>>>>>>> prevent an attacker from performing these actions without
>>>>>>> authorization, the TPM specs define a mechanism to assert "physical
>>>>>>> presence" before the privileged action can be done.  They do this by
>>>>>>> having the firmware present a menu during early boot that permits
>>>>>>> these privileged operations, and then the firmware locks the TPM chip
>>>>>>> so the actions can no longer be done by any software that runs after
>>>>>>> the firmware.  Thus "physical presence" is asserted by demonstrating
>>>>>>> one has console access to the machine during early boot.
>>>>>>>
>>>>>>> The PPI spec implements a work around for this - presumably some
>>>>>>> found
>>>>>>> the enforcement mechanism too onerous.  It allows the OS to provide a
>>>>>>> request code to the firmware, and on the next boot the firmware will
>>>>>>> take the requested action before it locks the chip.  Thus allowing
>>>>>>> the
>>>>>>> OS to indirectly perform the privileged action even after the chip
>>>>>>> has
>>>>>>> been locked.  Thus, the PPI system seems to be an "elaborate hack" to
>>>>>>> allow users to circumvent the physical presence mechanism (if they
>>>>>>> choose to).
>>>>>> Correct.
>>>>>>> Here's what I understand the proposed implementation involves:
>>>>>>>
>>>>>>> 1 - in addition to emulating the TPM device itself, QEMU will also
>>>>>>>        introduce a virtual memory device with 0x400 bytes.
>>>>>> Correct.
>>>>>>> 2 - on first boot the firmware (seabios and uefi) will populate the
>>>>>>>        memory region created in step 1.  In particular it will fill an
>>>>>>>        array with the list of request codes it supports.  (Each
>>>>>>> request
>>>>>>>        is an 8bit value, the array has 256 entries.)
>>>>>> Correct. Each firmware would fill out the 256 byte array depending on
>>>>>> what it supports. The 8 bit values are basically flags and so on.
>>>>>>> 3 - QEMU will produce AML code implementing the standard PPI ACPI
>>>>>>>        interface.  This AML code will take the request, find the table
>>>>>>>        produced in step 1, compare it to the list of accepted requests
>>>>>>>        produced in step 2, and then place the 8bit request in another
>>>>>>>        qemu virtual memory device (at 0xFFFF0000 or 0xFED45000).
>>>>>> Correct.
>>>>>>
>>>>>> Now EDK2 wants to store the code in a UEFI variable in NVRAM. We
>>>>>> therefore would need to trigger an SMI. In SeaBIOS we wouldn't have to
>>>>>> do this.
>>>>>>
>>>>>>> 4 - the OS will signal a reboot, qemu will do its normal reboot
>>>>>>> logic,
>>>>>>>        and the firmware will be run again.
>>>>>>>
>>>>>>> 5 - the firmware will extract the code written in stage 3, and if the
>>>>>>>        tpm device has been configured to accept PPI codes from the
>>>>>>> OS, it
>>>>>>>        will invoke the requested action.
>>>>>> SeaBIOS would look into memory to find the code. EDK2 will read the
>>>>>> code
>>>>>> from a UEFI variable.
>>>>>>
>>>>>>> Did I understand the above correctly?
>>>>>> I think so. With the fine differences between SeaBIOS and EDK2
>>>>>> pointed out.
>>>>> Here's what I suggest:
>>>>>
>>>>> Please everyone continue working on this, according to Kevin's &
>>>>> Stefan's description, but focus on QEMU and SeaBIOS *only*. Ignore edk2
>>>>> for now.
>>>> If this were targetted at SeaBIOS, I'd look for a simpler
>>>> QEMU/firmware interface.  Something like:
>>>>
>>>> A - QEMU produces AML code implementing the standard PPI ACPI
>>>>       interface that generates a request code and stores it in the
>>>>       device memory of an existing device (eg, writable fw_cfg or an
>>>>       extension field in the existing emulated TPM device).
>> ACPI code writing into fw_cfg sounds difficult.
>> I initially had PPI SeaBIOS code write into the TPM TIS device's memory
>> into some custom addresses. I'd consider this a hack. Now we have that
>> virtual memory device with those 0x400 bytes...
>>
>> In these 0x400 bytes we have 256 bytes that are used for configuration
>> flags describing the supported opcode as you previously described. This
>> array allows us to decouple the firmware implementation from the ACPI
>> code and we need not hard code what is supported in the firmware inside
>> the ACPI code (which would be difficult to do anyway since in QEMU we
>> would not what firmware will be started and what PPI opcodes are
>> support) and the ppi sysfs entries in Linux for example show exactly
>> those PPI opcodes that are supported. The firmware needs to set those
>> flags and the firmware knows what it supports.
>>
>> I hope we can settle that this device is the right path.
>>
>>>> B - after a reboot the firmware extracts the PPI request code
>>>>       (produced in step A) and performs the requested action (if the TPM
>>>>       is configured to accept OS generated codes).
>>>>
>>>> That is, skip steps 1 and 2 from the original proposal.
>>> I think A/B can work fine, as long as
>>> - the firmware can somehow dynamically recognize the device / "register
>>>     block" that the request codes have to be pulled from, and
>> I experimented with what Igor had suggested with the fw_cfg file
>> callback and so on.
>>
>>> - QEMU is free to move the device or register block around, from release
>>>     to release, without disturbing migration.
>> I think we should basically limit the firmware to writing two addresses
>> into this fw_cfg file:
>> - SeaBIOS: write back the same address that QEMU suggested in the file
>> (currently 0xfed4 5000)
>> - EDK2: write back 0xffff 0000
> Given that I intend to rip the SecurityPkg ASL code out of OVMF's
> solution for this, I don't think that the address 0xffff_0000 has any
> relevance for OVMF. If the QEMU x86 MMIO space generally has a suitable
> gap at 0xfed4_5000 (and I do think it has, even considering pflash &
> LAPIC), then just put the register block there.
>
> As long as Igor agrees. :)
>
> Another question just occurred to me. If the guest OS queues some PPI
> operations, and then the VM is powered down fully (instead of a reboot),
> then we're at liberty to forget the queued PPI ops, right?

I would say that is implementation-dependent. UEFI wouldn't forget due 
to these UEFI Variables in NVRAM...

     Stefan

>
> Thanks
> Laszlo
>
>> No other address would be accepted by QEMU since presumably QEMU knows
>> where otherwise address collisions can occur.
