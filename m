Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0CT3-0000Ds-SB
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 17:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0CT0-0003ny-D1
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 17:14:33 -0400
Received: from mail-eopbgr730088.outbound.protection.outlook.com
	([40.107.73.88]:14496
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0CT0-0003mK-0n
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 17:14:30 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-7-git-send-email-brijesh.singh@amd.com>
	<20180912045233.GE3829@xz-x1>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <60537599-37af-9a2b-9ddf-f6155624259f@amd.com>
Date: Wed, 12 Sep 2018 16:14:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180912045233.GE3829@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] x86_iommu/amd: Enable Guest virtual
 APIC support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>



On 09/11/2018 11:52 PM, Peter Xu wrote:
...

>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 5c2c638..1cbc8ba 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2565,7 +2565,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
>>       build_append_int_noprefix(table_data,
>>                                (48UL << 30) | /* HATS   */
>>                                (48UL << 28) | /* GATS   */
>> -                             (1UL << 2),    /* GTSup  */
>> +                             (1UL << 2)   | /* GTSup  */
>> +                             (1UL << 6),    /* GASup  */
> 
> Sorry if I misunderstood - is this for nested?
> 
> I'm a bit confused here... IIUC in your previous patches you didn't
> really implement guest_mode==1 case in IRTEs.  So if you have this set
> then the guest should be able to setup IRTEs with guest_mode==1?  How
> did it work?
> 

Yes, sometime spec can be confusing ;) let me see if I can explain it.

Suravee, please correct me if I misunderstood something

- A legacy interrupt remap support is available on all IOMMU versions.

   Guest OS makes the decision whether to use the feature. Guest OS
   sets the IV bit in DTE to indicate when there is a valid interrupt
   map (See Table 7 DTE definition).

   In this mode, IRTE is 32-bit. The field details are available
   in Table 20 - Section 2.2.5.2. The third patch in this series
   implements the support for this case.

   (NOTE: As I explained [1], the Linux guest enables intr remap only
    when it sees a special IVHD IOAPIC type device is present in IVRS)

   [1] https://marc.info/?l=qemu-devel&m=153677956506196&w=2

- When AVIC is used in the guest, the intr remap logic is different.

   Based on the guest_mode, IOMMU and AVIC may need to work together
   to remap the interrupts (IOMMU spec refers this as Guest Virtual APIC
   Enabled -- Section 2.2.5.3).

   The GASup bit in extended feature register and IVHD IOMMU feature
   reporting field in IVRS are used to tell whether the IOMMU supports
   intr remap when AVIC is enabled in the guest.

   In this mode, the IRTE is 128-bit.

   To make things interesting, there is a GAMSup bit in extended
   feature register. It is used by IOMMU to tell the AVIC supported
   modes:

   a) 0 = intr_remap only (i.e IOMMU can remap the interrupt on its own)
   b) 1 = Both guest AVIC and IOMMU will work together to remap the intr

   The patch 5 in the series implements the intr_remap (#a)

   I have not implemented the mode=1. I am not sure if its worth
   implementing this mode for the emulated IOMMU case.

   See Table 21 for control knobs from IOMMU. This patch series
   implements the first three rows.

I hope my explanation does not add more confusions ;)

-Brijesh
