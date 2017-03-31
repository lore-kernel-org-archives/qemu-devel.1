Received: from eggs.gnu.org ([2001:4830:134:3::10]:44837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctv1w-0000mC-9s
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctv1t-00038S-8g
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:47:48 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ctv1t-00037m-28
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:47:45 -0400
Received: by mail-pg0-x244.google.com with SMTP id g2so16689707pge.2
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 04:47:44 -0700 (PDT)
References: <20170330124707.28142-1-aik@ozlabs.ru>
	<20170330124707.28142-3-aik@ozlabs.ru>
	<82c140ad-da36-5c2a-3f10-567d3108b15a@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a08e4150-6a3b-b6d3-efc6-16def8517b59@ozlabs.ru>
Date: Fri, 31 Mar 2017 22:47:38 +1100
MIME-Version: 1.0
In-Reply-To: <82c140ad-da36-5c2a-3f10-567d3108b15a@redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 2/5] spapr-iommu: Subclass
 TYPE_IOMMU_MEMORY_REGION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

On 31/03/17 00:00, Paolo Bonzini wrote:
> 
> 
> On 30/03/2017 14:47, Alexey Kardashevskiy wrote:
>> +static int spapr_tce_get_fd(IOMMUMemoryRegion *iommu)
>> +{
>> +    sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
>> +
>> +    return tcet->fd;
>> +}
>> +
>>  static int spapr_tce_table_post_load(void *opaque, int version_id)
>>  {
>>      sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
>> @@ -266,7 +273,7 @@ static int spapr_tce_table_realize(DeviceState *dev)
>>      memory_region_init(&tcet->root, tcetobj, tmp, UINT64_MAX);
>>  
>>      snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
>> -    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION,
>> +    memory_region_init_iommu_type(TYPE_SPAPR_IOMMU_MEMORY_REGION,
>>                                    &tcet->iommu, tcetobj, &spapr_iommu_ops,
>>                                    tmp, 0);
>>  
>> @@ -634,9 +641,25 @@ static TypeInfo spapr_tce_table_info = {
>>      .class_init = spapr_tce_table_class_init,
>>  };
>>  
>> +static void spapr_iommu_memory_region_class_init(ObjectClass *k, void *data)
>> +{
>> +    sPAPRIOMMUMemoryRegionClass *smrc = SPAPR_IOMMU_MEMORY_REGION_CLASS(k);
>> +
>> +    smrc->get_fd = spapr_tce_get_fd;
>> +}
>> +
> 
> You don't even need the virtual function.  Rather, make spapr_tce_get_fd
> public and give it a sPAPRTCETable argument.  Then vfio_spapr_notify_kvm
> can use SPAPR_IOMMU_MEMORY_REGION(iommumr).

Well, if I make spapr_tce_get_fd() public, vfio_spapr_notify_kvm() could
just take MemoryRegion and cast it to sPAPRTCETable without all these
dances with MemoryRegion, IOMMUMemoryRegion, what do I miss here? I have
made a big patch with IOMMUMemoryRegion though, post it?


-- 
Alexey
