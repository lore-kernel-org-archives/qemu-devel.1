Received: from eggs.gnu.org ([208.118.235.92]:54957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfVUH-0005pJ-Mn
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfVUC-0003cc-5g
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:50:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfVUA-0003Xc-QB
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:50:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so37620406wrr.0
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 11:50:24 -0800 (PST)
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-21-yang.zhong@intel.com>
	<b29d2a27-f558-1d15-761b-2cc2f256cd5c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8965a62-df89-c324-33dd-787d4cadda75@redhat.com>
Date: Fri, 4 Jan 2019 20:50:23 +0100
MIME-Version: 1.0
In-Reply-To: <b29d2a27-f558-1d15-761b-2cc2f256cd5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 20/25] hyperv: express dependencies
 with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com

On 04/01/19 16:38, Thomas Huth wrote:
> On 2018-12-27 07:34, Yang Zhong wrote:
>> remove default-configs/hyperv.mak and make dependencies
>> with Kconfig.
>>
>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>> ---
>>  default-configs/hyperv.mak       | 2 --
>>  default-configs/i386-softmmu.mak | 1 -
>>  hw/hyperv/Kconfig                | 1 +
>>  hw/i386/Kconfig                  | 2 ++
>>  4 files changed, 3 insertions(+), 3 deletions(-)
>>  delete mode 100644 default-configs/hyperv.mak
>>
>> diff --git a/default-configs/hyperv.mak b/default-configs/hyperv.mak
>> deleted file mode 100644
>> index 5d0d9fd830..0000000000
>> --- a/default-configs/hyperv.mak
>> +++ /dev/null
>> @@ -1,2 +0,0 @@
>> -CONFIG_HYPERV=$(CONFIG_KVM)
>> -CONFIG_HYPERV_TESTDEV=y
>> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
>> index d2e58edd17..eb2d22de3c 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -1,6 +1,5 @@
>>  # Default configuration for i386-softmmu
>>  
>> -include hyperv.mak
>>  CONFIG_VMXNET3_PCI=y
>>  CONFIG_VIRTIO_VGA=y
>>  CONFIG_IPMI=y
>> diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
>> index be724b7f8b..632c3a675b 100644
>> --- a/hw/hyperv/Kconfig
>> +++ b/hw/hyperv/Kconfig
>> @@ -1,5 +1,6 @@
>>  config HYPERV
>>      bool
>> +    depends on KVM
>>  
>>  config HYPERV_TESTDEV
>>      bool
> 
> Should HYPERV_TESTDEV maybe get a "depends on HYPERV", too?

Yes, and also a "default y if PC".  That makes the "select
HYPERV_TESTDEV" unnecessary below.

Paolo

>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index 695a67f88d..af4b81bae1 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -11,6 +11,8 @@ config PC
>>      select I8257
>>      select MC146818RTC
>>      select TPM_TIS if TPM
>> +    select HYPERV
>> +    select HYPERV_TESTDEV
>>  
>>  config PC_PCI
>>      bool
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
