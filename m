Received: from eggs.gnu.org ([209.51.188.92]:47417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwGrm-0002Q6-7c
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwGrl-0003lM-13
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:40:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:30312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gwGrk-0003hK-O5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:40:04 -0500
Date: Wed, 20 Feb 2019 09:39:25 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190220013924.GA24772@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
	<20190220005124.24224-4-richardw.yang@linux.intel.com>
	<d203d22a-0f29-cbd3-e073-868bf9a35233@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d203d22a-0f29-cbd3-e073-868bf9a35233@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] pc-dimm: revert "introduce realize
 callback"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com

On Wed, Feb 20, 2019 at 02:26:16AM +0100, Philippe Mathieu-Daudé wrote:
>On 2/20/19 1:51 AM, Wei Yang wrote:
>> realize callback in introduced to check if the backend memory is large
>> enough to contain label data and init its memory region, while this task
>> is handled in pre_plug stage.
>> 
>> Now it's time to remove it.
>
>Good cleanup!
>

Glad you like it :-)

>Michael, can you add:
>
>"This reverts commit 9f318f8f7e689b9653b42bac73047f9719a1f34e."
>
>Thanks,
>
>Phil.
>
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>
>> ---
>>  hw/mem/pc-dimm.c         | 5 -----
>>  include/hw/mem/pc-dimm.h | 3 ---
>>  2 files changed, 8 deletions(-)
>> 
>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index 152400b1fc..5832c0ba92 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -159,7 +159,6 @@ static void pc_dimm_init(Object *obj)
>>  static void pc_dimm_realize(DeviceState *dev, Error **errp)
>>  {
>>      PCDIMMDevice *dimm = PC_DIMM(dev);
>> -    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>>  
>>      if (!dimm->hostmem) {
>>          error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
>> @@ -178,10 +177,6 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
>>          return;
>>      }
>>  
>> -    if (ddc->realize) {
>> -        ddc->realize(dimm, errp);
>> -    }
>> -
>>      host_memory_backend_set_mapped(dimm->hostmem, true);
>>  }
>>  
>> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
>> index 01436b9f50..d18f8246b7 100644
>> --- a/include/hw/mem/pc-dimm.h
>> +++ b/include/hw/mem/pc-dimm.h
>> @@ -59,8 +59,6 @@ typedef struct PCDIMMDevice {
>>  
>>  /**
>>   * PCDIMMDeviceClass:
>> - * @realize: called after common dimm is realized so that the dimm based
>> - * devices get the chance to do specified operations.
>>   * @get_vmstate_memory_region: returns #MemoryRegion which indicates the
>>   * memory of @dimm should be kept during live migration. Will not fail
>>   * after the device was realized.
>> @@ -70,7 +68,6 @@ typedef struct PCDIMMDeviceClass {
>>      DeviceClass parent_class;
>>  
>>      /* public */
>> -    void (*realize)(PCDIMMDevice *dimm, Error **errp);
>>      MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
>>                                                 Error **errp);
>>  } PCDIMMDeviceClass;
>> 

-- 
Wei Yang
Help you, Help me
