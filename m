Received: from eggs.gnu.org ([2001:4830:134:3::10]:34878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <javierm@redhat.com>) id 1dQa6I-0005xi-KM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <javierm@redhat.com>) id 1dQa6D-0006tW-KX
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <javierm@redhat.com>) id 1dQa6D-0006tK-Bm
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:13 -0400
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
	<20170628152214.3qhegqrjfpfh2sgs@redhat.com>
	<3b06e98c-33df-fa4d-e0ba-fcedf941619e@redhat.com>
	<f1e02018-7920-7c17-d5c9-91271d6f093c@linux.vnet.ibm.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <a19eaa37-7bcd-be8b-8afb-092ef55b261f@redhat.com>
Date: Thu, 29 Jun 2017 16:07:07 +0200
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, Laszlo Ersek <lersek@redhat.com>, Peter Jones <pjones@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hello Stefan,

On 06/28/2017 10:57 PM, Stefan Berger wrote:
> On 06/28/2017 12:44 PM, Laszlo Ersek wrote:
>> On 06/28/17 17:22, Peter Jones wrote:
>>> On Tue, Jun 27, 2017 at 12:12:50PM -0400, Stefan Berger wrote:

[snip]

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
>>> instead of this interface?  As well as it?  It'd be good to have some
>>> text about this here.
>> I don't think that Stefan has spent any time on EFI enablement, so this
>> part of the document will have to be written later, once there is any
>> EFI-related functionality we can document. (I expect.)
> 
> Right, I did not spend any time on EFI. I suppose the ACPI tables going to a BIOS are also useful for EFI.
> 
> For BIOS there is unfortunately only a spec for TPM 1.2, none anymore for
> TPM2, at least back then when I last looked for it. So I ended up passing
> that TCPA table that has the pointer for the logging area also in case of
> a TPM 2. So SeaBIOS writes its log to it in both cases, following the TPM 2

But this isn't correct from a TPM2 pov, right? Because the TPM2 spec says
that the ACPI table that contains the TPM2.0 event logs is the TPM2 table.

So instead the LASA field in the passed TPM2 ACPI table should point to the
allocated buffer used by the firmware to store the event logs.

> format form the EFI specs for the entries. The Linux driver in the meantime
> has modified the code so  that it doesn't show the log anymore in case of
> TPM 2 :-( . I think the above referenced specs would explain how the logging

Do you mean that in the past Linux exposed the securityfs files with the event
logs for TPM2 chips as well? My understanding is that Linux does the correct
thing now, since as mentioned the TCPA table should only be used for TPM1.2.

There are patches posted to add Linux support to read the event logs for TPM2
chips but from the TPM2 ACPI table. I see that hose haven't landed yet though:

https://patchwork.kernel.org/project/tpmdd-devel/list/?submitter=7143

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
