Received: from eggs.gnu.org ([2001:4830:134:3::10]:50028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suravee.Suthikulpanit@amd.com>) id 1g0Loz-0003IY-IS
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Suravee.Suthikulpanit@amd.com>) id 1g0Low-00031i-E5
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:13:49 -0400
Received: from mail-eopbgr700070.outbound.protection.outlook.com
	([40.107.70.70]:25695
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Suravee.Suthikulpanit@amd.com>)
	id 1g0Low-000312-0X
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:13:46 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-7-git-send-email-brijesh.singh@amd.com>
	<20180912045233.GE3829@xz-x1>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <40dec19b-51d7-d0ad-e1c6-82e1c63dbe63@amd.com>
Date: Thu, 13 Sep 2018 14:13:18 +0700
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
To: Peter Xu <peterx@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Peter,

On 9/12/18 11:52 AM, Peter Xu wrote:
> On Tue, Sep 11, 2018 at 11:49:49AM -0500, Brijesh Singh wrote:
>> Now that amd-iommu support interrupt remapping, enable the GASup in IVRS
>> table and GASup in extended feature register to indicate that IOMMU
>> support guest virtual APIC mode.
>>
>> Note that the GAMSup is set to zero to indicate that  Guest Virtual
>> APIC does not support advanced interrupt features (i.e virtualized
>> interrupts using the guest virtual APIC).
>>
>> See Table 21 from IOMMU spec for interrupt virtualization controls
>>
>> IOMMU spec: https://support.amd.com/TechDocs/48882_IOMMU.pdf
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
>> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   hw/i386/acpi-build.c | 3 ++-
>>   hw/i386/amd_iommu.h  | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
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
> Thanks,
> 

The naming of these bits are confusing. Please allow me to help explain.
There are two capability bits:

* GASup  : This is to allow 128-bit IRTE when GAEn is set.

* GAMSup : This is for Guest Virtual APIC mode support,
             which is not currently supported in vIOMMU.
            The commit message in patch 5 is incorrect.

Here, we set GASup in order to allow 128-bit IRTE support,
which is needed for some of future AMD IOMMU features.

Thanks,
Suravee
