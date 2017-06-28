Received: from eggs.gnu.org ([2001:4830:134:3::10]:56956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dQG4m-0006XJ-Bk
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dQG4j-0003Lz-8m
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:44:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dQG4i-0003Kn-W5
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:44:21 -0400
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
	<20170628152214.3qhegqrjfpfh2sgs@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3b06e98c-33df-fa4d-e0ba-fcedf941619e@redhat.com>
Date: Wed, 28 Jun 2017 18:44:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170628152214.3qhegqrjfpfh2sgs@redhat.com>
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
To: Peter Jones <pjones@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>

On 06/28/17 17:22, Peter Jones wrote:
> On Tue, Jun 27, 2017 at 12:12:50PM -0400, Stefan Berger wrote:
>> On 06/14/2017 09:51 AM, Laszlo Ersek wrote:
>>> Hi Stefan,
>>>
>>> the MAINTAINERS file doesn't seem to cover any of the TPM-related files
>>> in the tree:
>>>
>>>    backends/tpm.c
>>>    hw/tpm/
>>>    include/hw/acpi/tpm.h
>>>    include/sysemu/tpm*
>>>    tpm.c
>>>
>>> but I have a gut feeling that you are semi-officially maintaining TPM
>>> anyway, so I'm going to ask you. :)
>>>
>>> Can you please write a document, to be placed under docs/specs/, that
>>> describes the TPM device from a guest perspective, also explaining how
>>> the guest-visible bits are connected to (current) TPM backend(s)?
>>>
>>> The document wouldn't have to be very long; I think all standardized
>>> interfaces could be mentioned by reference only (by spec names and
>>> locations). The document should however describe any QEMU specifics, and
>>> how the relevant specs are brought together in the implementation.
>>>
>>> Some text files I'm familiar with and can recommend as examples:
>>> - docs/specs/fw_cfg.txt
>>> - docs/specs/pvpanic.txt
>>> - docs/specs/vmgenid.txt
>>>
>>> (There may be more and/or better examples of course.)
>>>
>>> This document should be the starting point for developers that want to
>>> support QEMU's TPM(s) in guest firmware that is different from SeaBIOS.
>>> (You've been maintaining the related SeaBIOS feature.)
>>>
>>> Would you be willing to author such a design document?
>>
>> Here's what I have so far with pointers to TCG specs. Does that go in the
>> right direction?
>>
>>
>> QEMU TPM Device
>> ===============
>>
>> = Guest-side Hardware Interface =
>>
>> The QEMU TPM emulation implements a TPM TIS hardware interface following
>> the Trusted Computing Group's specification "TCG PC Client Specific TPM
>> Interface Specification (TIS)", Specifcation Version 1.3, 21 March 2013.
>> This specification, or a later version of it, can be accessed from the
>> following URL:
>>
>> https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
>>
>> The TIS interface makes a memory mapped IO region in the area 0xfed40000 -
>> 0xfed44fff available to the guest operating system.
>>
>> = ACPI Interface =
>>
>> The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT
>> and passes it into the guest through the fw_cfg device. The device
>> description contains the base address of the TIS interface  0xfed40000
>> and the size of the MMIO area (0x5000). In case a TPM2 is used by
>> QEMU, a TPM2 ACPI table is also provided. The device is described to
>> be used in polling mode rather than interrupt mode primarily because
>> no unused IRQ could be found.
>>
>> To support measurements logs to be written by the firmware, e.g.
>> SeaBIOS, a TCPA table is implemented. This table provides a 64kb
>> buffer where the firmware can write its log into.
> 
> How does this work if we boot with edk2?

My expectation is that it doesn't work at all, without doing some OVMF
platform enablement first. (See
<https://bugzilla.tianocore.org/show_bug.cgi?id=594>.) My plan is to use
Stefan's document as a starting point for the edk2 / OVMF investigation
-- one known and one unknown are better than two unknowns (to me).

> Do we get what's described in 
> https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
> instead of this interface?  As well as it?  It'd be good to have some
> text about this here.

I don't think that Stefan has spent any time on EFI enablement, so this
part of the document will have to be written later, once there is any
EFI-related functionality we can document. (I expect.)

Thanks,
Laszlo
