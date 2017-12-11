Received: from eggs.gnu.org ([2001:4830:134:3::10]:48794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOUmR-0000Vd-6t
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 15:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOUmO-0008HK-4G
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 15:34:27 -0500
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-5-david@redhat.com>
	<20171211181754.4a3b847d.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <08154f0d-d526-d735-a952-853fcabe946b@redhat.com>
Date: Mon, 11 Dec 2017 21:34:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171211181754.4a3b847d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 04/15] s390x/flic: simplify
 flic initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On 11.12.2017 18:17, Cornelia Huck wrote:
> On Mon, 11 Dec 2017 14:47:29 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> This makes it clearer, which device is used for which accelerator.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/intc/s390_flic.c          |  9 +++++++--
>>  hw/intc/s390_flic_kvm.c      | 12 ------------
>>  include/hw/s390x/s390_flic.h |  9 ---------
>>  3 files changed, 7 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>> index 6eaf178d79..a78bdf1d90 100644
>> --- a/hw/intc/s390_flic.c
>> +++ b/hw/intc/s390_flic.c
>> @@ -40,11 +40,16 @@ void s390_flic_init(void)
>>  {
>>      DeviceState *dev;
>>  
>> -    dev = s390_flic_kvm_create();
>> -    if (!dev) {
>> +    if (kvm_enabled()) {
>> +        dev = qdev_create(NULL, TYPE_KVM_S390_FLIC);
>> +        object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
>> +                                  OBJECT(dev), NULL);
>> +    } else if (tcg_enabled()) {
>>          dev = qdev_create(NULL, TYPE_QEMU_S390_FLIC);
>>          object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
>>                                    OBJECT(dev), NULL);
> 
> Can you use TYPE_S390_FLIC_COMMON for attaching the flic to the machine?

I suggest doing that in a separate patch. (I remember that changing the
name should not harm migration).

> 
>> +    } else {
>> +        g_assert_not_reached();
> 
> Checking for tcg_enabled() explicitly does not seem the common pattern,
> although it is fine with me (I doubt we'll support other accelerators
> for s390x in the foreseeable future).

Indeed, I can drop that.

> 
>>      }
>>      qdev_init_nofail(dev);
>>  }
> 
> Do we want to switch to the same pattern for the storage attribute
> device as well?

Yes, can have a look, thanks!

> 
> Change looks fine to me.
> 


-- 

Thanks,

David / dhildenb
