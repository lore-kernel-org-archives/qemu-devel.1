Received: from eggs.gnu.org ([2001:4830:134:3::10]:35426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWMCw-00087q-Qw
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWMCs-0005fP-1q
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:57:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWMCr-0005dX-OZ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:57:41 -0500
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
	<20170124071724.4572.85855.stgit@PASHA-ISP>
	<5500e05f-2923-3378-aa42-600cf0c4bf9b@redhat.com>
	<000801d27701$7424d810$5c6e8830$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cab1a55-15cf-e9dc-f137-e55b613bd090@redhat.com>
Date: Wed, 25 Jan 2017 12:57:36 +0100
MIME-Version: 1.0
In-Reply-To: <000801d27701$7424d810$5c6e8830$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 05/14] apic: save apic_delivered flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, kraxel@redhat.com



On 25/01/2017 12:52, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
>> On 24/01/2017 08:17, Pavel Dovgalyuk wrote:
>>> This patch implements saving/restoring of static apic_delivered variable.
>>>
>>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>> ---
>>>  hw/intc/apic_common.c           |   32 ++++++++++++++++++++++++++++++++
>>>  include/hw/i386/apic_internal.h |    2 ++
>>>  2 files changed, 34 insertions(+)
>>>
>>> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
>>> index d78c885..ac6cc67 100644
>>> --- a/hw/intc/apic_common.c
>>> +++ b/hw/intc/apic_common.c
>>> @@ -384,6 +384,24 @@ static bool apic_common_sipi_needed(void *opaque)
>>>      return s->wait_for_sipi != 0;
>>>  }
>>>
>>> +static bool apic_irq_delivered_needed(void *opaque)
>>> +{
>>> +    return true;
>>
>> Is it needed for CPUs except the first (or the last?)?
>>
> 
> As this is global variable, it is needed only for one CPU.
> Do you mean that APIC state is saved for every CPU? 

Yes, each CPU has its own APIC.

Paolo

>>> +}
>>> +
>>> +static void apic_irq_delivered_pre_save(void *opaque)
>>> +{
>>> +    APICCommonState *s = APIC_COMMON(opaque);
>>> +    s->apic_irq_delivered = apic_irq_delivered;
>>> +}
>>> +
>>> +static int apic_irq_delivered_post_load(void *opaque, int version_id)
>>> +{
>>> +    APICCommonState *s = APIC_COMMON(opaque);
>>> +    apic_irq_delivered = s->apic_irq_delivered;
>>> +    return 0;
>>> +}
>>> +
>>>  static const VMStateDescription vmstate_apic_common_sipi = {
>>>      .name = "apic_sipi",
>>>      .version_id = 1,
>>> @@ -396,6 +414,19 @@ static const VMStateDescription vmstate_apic_common_sipi = {
>>>      }
>>>  };
>>>
>>> +static const VMStateDescription vmstate_apic_irq_delivered = {
>>> +    .name = "apic_irq_delivered",
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .needed = apic_irq_delivered_needed,
>>> +    .pre_save = apic_irq_delivered_pre_save,
>>> +    .post_load = apic_irq_delivered_post_load,
>>> +    .fields = (VMStateField[]) {
>>> +        VMSTATE_INT32(apic_irq_delivered, APICCommonState),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>>  static const VMStateDescription vmstate_apic_common = {
>>>      .name = "apic",
>>>      .version_id = 3,
>>> @@ -430,6 +461,7 @@ static const VMStateDescription vmstate_apic_common = {
>>>      },
>>>      .subsections = (const VMStateDescription*[]) {
>>>          &vmstate_apic_common_sipi,
>>> +        &vmstate_apic_irq_delivered,
>>>          NULL
>>>      }
>>>  };
>>> diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
>>> index 1209eb4..20ad28c 100644
>>> --- a/include/hw/i386/apic_internal.h
>>> +++ b/include/hw/i386/apic_internal.h
>>> @@ -189,6 +189,8 @@ struct APICCommonState {
>>>      DeviceState *vapic;
>>>      hwaddr vapic_paddr; /* note: persistence via kvmvapic */
>>>      bool legacy_instance_id;
>>> +
>>> +    int apic_irq_delivered; /* for saving static variable */
>>>  };
>>>
>>>  typedef struct VAPICState {
>>>
>>>
>>>
> 
> Pavel Dovgalyuk
> 
