Received: from eggs.gnu.org ([2001:4830:134:3::10]:51746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dQKU5-00080n-F7
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 17:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dQKU2-00088i-65
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 17:26:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dQKU1-00088C-So
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 17:26:46 -0400
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
	<20170628152214.3qhegqrjfpfh2sgs@redhat.com>
	<3b06e98c-33df-fa4d-e0ba-fcedf941619e@redhat.com>
	<f1e02018-7920-7c17-d5c9-91271d6f093c@linux.vnet.ibm.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1eb6cb7a-5ce7-a866-0c57-eab5b1e88010@redhat.com>
Date: Wed, 28 Jun 2017 23:26:36 +0200
MIME-Version: 1.0
In-Reply-To: <f1e02018-7920-7c17-d5c9-91271d6f093c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Jones <pjones@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>

On 06/28/17 22:57, Stefan Berger wrote:
> On 06/28/2017 12:44 PM, Laszlo Ersek wrote:
>> On 06/28/17 17:22, Peter Jones wrote:
>>> On Tue, Jun 27, 2017 at 12:12:50PM -0400, Stefan Berger wrote:
>>>> On 06/14/2017 09:51 AM, Laszlo Ersek wrote:
>>>>> Hi Stefan,
>>>>>
>>>>> the MAINTAINERS file doesn't seem to cover any of the TPM-related
>>>>> files
>>>>> in the tree:
>>>>>
>>>>>     backends/tpm.c
>>>>>     hw/tpm/
>>>>>     include/hw/acpi/tpm.h
>>>>>     include/sysemu/tpm*
>>>>>     tpm.c
>>>>>
>>>>> but I have a gut feeling that you are semi-officially maintaining TPM
>>>>> anyway, so I'm going to ask you. :)
>>>>>
>>>>> Can you please write a document, to be placed under docs/specs/, that
>>>>> describes the TPM device from a guest perspective, also explaining how
>>>>> the guest-visible bits are connected to (current) TPM backend(s)?
>>>>>
>>>>> The document wouldn't have to be very long; I think all standardized
>>>>> interfaces could be mentioned by reference only (by spec names and
>>>>> locations). The document should however describe any QEMU
>>>>> specifics, and
>>>>> how the relevant specs are brought together in the implementation.
>>>>>
>>>>> Some text files I'm familiar with and can recommend as examples:
>>>>> - docs/specs/fw_cfg.txt
>>>>> - docs/specs/pvpanic.txt
>>>>> - docs/specs/vmgenid.txt
>>>>>
>>>>> (There may be more and/or better examples of course.)
>>>>>
>>>>> This document should be the starting point for developers that want to
>>>>> support QEMU's TPM(s) in guest firmware that is different from
>>>>> SeaBIOS.
>>>>> (You've been maintaining the related SeaBIOS feature.)
>>>>>
>>>>> Would you be willing to author such a design document?
>>>> Here's what I have so far with pointers to TCG specs. Does that go
>>>> in the
>>>> right direction?
>>>>
>>>>
>>>> QEMU TPM Device
>>>> ===============
>>>>
>>>> = Guest-side Hardware Interface =
>>>>
>>>> The QEMU TPM emulation implements a TPM TIS hardware interface
>>>> following
>>>> the Trusted Computing Group's specification "TCG PC Client Specific TPM
>>>> Interface Specification (TIS)", Specifcation Version 1.3, 21 March
>>>> 2013.
>>>> This specification, or a later version of it, can be accessed from the
>>>> following URL:
>>>>
>>>> https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
>>>>
>>>>
>>>> The TIS interface makes a memory mapped IO region in the area
>>>> 0xfed40000 -
>>>> 0xfed44fff available to the guest operating system.
>>>>
>>>> = ACPI Interface =
>>>>
>>>> The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT
>>>> and passes it into the guest through the fw_cfg device. The device
>>>> description contains the base address of the TIS interface  0xfed40000
>>>> and the size of the MMIO area (0x5000). In case a TPM2 is used by
>>>> QEMU, a TPM2 ACPI table is also provided. The device is described to
>>>> be used in polling mode rather than interrupt mode primarily because
>>>> no unused IRQ could be found.
>>>>
>>>> To support measurements logs to be written by the firmware, e.g.
>>>> SeaBIOS, a TCPA table is implemented. This table provides a 64kb
>>>> buffer where the firmware can write its log into.
>>> How does this work if we boot with edk2?
>> My expectation is that it doesn't work at all, without doing some OVMF
>> platform enablement first. (See
>> <https://bugzilla.tianocore.org/show_bug.cgi?id=594>.) My plan is to use
>> Stefan's document as a starting point for the edk2 / OVMF investigation
>> -- one known and one unknown are better than two unknowns (to me).
>>> Do we get what's described in
>>> https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
>>>
>>> instead of this interface?  As well as it?  It'd be good to have some
>>> text about this here.
>> I don't think that Stefan has spent any time on EFI enablement, so this
>> part of the document will have to be written later, once there is any
>> EFI-related functionality we can document. (I expect.)
> 
> Right, I did not spend any time on EFI. I suppose the ACPI tables going
> to a BIOS are also useful for EFI.
> 
> For BIOS there is unfortunately only a spec for TPM 1.2, none anymore
> for TPM2, at least back then when I last looked for it. So I ended up
> passing that TCPA table that has the pointer for the logging area also
> in case of a TPM 2. So SeaBIOS writes its log to it in both cases,
> following the TPM 2 format form the EFI specs for the entries. The Linux
> driver in the meantime has modified the code so  that it doesn't show
> the log anymore in case of TPM 2 :-( . I think the above referenced
> specs would explain how the logging area is to be allocated. My guess is
> that after detecting the presence of a TPM 2 (for which there is also a
> TPM2 ACPI table passed, so maybe that can be used as an indicator) one
> would malloc() the logging area and then proceed similar to how the BIOS
> does. The difference to a BIOS is that EFI has an API for getting to
> that log iirc.

I haven't checked yet, but my worry is that the TPM drivers in edk2 will
want to install the ACPI tables related to the TPM device /
infrastructure themselves. If that's the case, we'll either have to
modify QEMU not to produce those tables in the ACPI payload, despite
exposing a TPM device to the guest -- clearly this will take another
command line option, or an extension to one --, or else the TPM drivers
in edk2 will have to be convinced to cope with the ACPI tables
pre-installed, by some other firmware module. Again, I'm not sure if
either of these will be necessary, but if one is, then the former looks
way more feasible to me. The TPM drivers in edk2 could reasonably argue
that on a physical platform they "own" the TPM device, along with all
ACPI tables related to it. We'll see.

Thanks
Laszlo
