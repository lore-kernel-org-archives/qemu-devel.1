Received: from eggs.gnu.org ([2001:4830:134:3::10]:36724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suravee.Suthikulpanit@amd.com>) id 1g0Moy-0004Z6-5R
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Suravee.Suthikulpanit@amd.com>) id 1g0Mot-0001ej-5Z
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:17:52 -0400
Received: from mail-by2nam05on0618.outbound.protection.outlook.com
	([2a01:111:f400:fe52::618]:13088
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Suravee.Suthikulpanit@amd.com>)
	id 1g0Mos-0001cc-HP
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:17:47 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-3-git-send-email-brijesh.singh@amd.com>
	<20180912035214.GC3829@xz-x1>
	<9ecccc2d-9274-36c1-c0a5-56a24836d075@amd.com>
	<20180913031503.GC10763@xz-x1>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <c6d1e6be-18ba-a078-3464-2f7f539dc626@amd.com>
Date: Thu, 13 Sep 2018 15:15:27 +0700
MIME-Version: 1.0
In-Reply-To: <20180913031503.GC10763@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] x86_iommu/amd: Prepare for interrupt
 remap support
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

Brijesh / Peter,

On 9/13/18 10:15 AM, Peter Xu wrote:
> On Wed, Sep 12, 2018 at 01:59:06PM -0500, Brijesh Singh wrote:
> 
> [...]
> 
>>>>        }
>>>>        return &iommu_as[devfn]->as;
>>>>    }
>>>> @@ -1172,6 +1274,10 @@ static void amdvi_realize(DeviceState *dev, Error **err)
>>>>            return;
>>>>        }
>>>> +    /* Pseudo address space under root PCI bus. */
>>>> +    pcms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_SB_IOAPIC_ID);
>>>> +    s->intr_enabled = x86_iommu->intr_supported;
>>>
>>> So does this mean that AMD IR cannot be disabled if declared support?
>>> For VT-d, IR needs to be explicitly enabled otherwise disabled (even
>>> supported).
>>>
>>
>>
>> Yes, once its declared as supported then it can not disabled. Its
>> upto the guest OS to decide whether it want to use the intr remapping
>> feature by parsing the IVRS. This also brings question, should we
>> just enable it by default because its guest OS decision whether it
>> wants to use it or not.
> 
> It's by default off?  I mean:
> 
>      DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, false),
> 
> Then it's good to me, thanks.  You could add a comment there
> explicitly mentioning that "IR will be enabled as long as declared
> support for AMD" since it might confuse some of the people like me...
> but it's optional.
> 
> Regards,
> 

Actually, there are two separate knobs here:

* This option basically means the interrupt remapping support is available/unavailable,
   which should default to available unless specified to unavailable at the QEMU command line.
   For example, the AMD IOMMU v1 does not have interrupt remapping support, which means
   the interrupt remapping bit fields in DTE (e.g. IV, IntCtl, EIntPass, INITPass, NMIPass,
   Lint0Pass, Lint1Pass) are ignored.

* If interrupt remapping support is available, the guest OS can decide to enable or disable the feature
   using DTE bit fileds (e.g. Linux option intremap=off would disable interrupt remapping
   by not setting DTE[IV] bit). For Linux AMD IOMMU driver, the default is to enable the interrupt remapping.

In facts, we should not need this option. However, if you prefer to keep this option,
we probably should rename this to "intremap_sup", in which if the default value should be 1.

Regards,
Suravee
