Received: from eggs.gnu.org ([2001:4830:134:3::10]:53169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPG4-0007K2-TP
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPFz-0007eG-02
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:11:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnPFy-0007dy-Pk
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:11:38 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-4-david@redhat.com>
	<09179efb-0930-bd84-ff22-1f4b23fa6a8e@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aa375deb-69ba-e0a8-d617-bbb304207a12@redhat.com>
Date: Thu, 31 Aug 2017 15:11:28 +0200
MIME-Version: 1.0
In-Reply-To: <09179efb-0930-bd84-ff22-1f4b23fa6a8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/11] s390x: store cpu states inside
 machine state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>


>> +S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>> +{
>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
>> +
>> +    if (cpu_addr >= max_cpus) {
>> +        return NULL;
>> +    }
>> +
>> +    /* Fast lookup via CPU ID */
>> +    return ms->cpus[cpu_addr];
>> +}
> 
> I wonder whether that function should rather go into a file in
> target/s390x/ instead, since it is also used there and its prototype is
> in cpu.h ?

I thought about the same thing, but as it works directly on the machine,
like ri_allowed() and friends. So I decided to keep it here for now.

I'll think about moving the definition also into
include/hw/s390x/s390-virtio-ccw.h

> 
> [...]
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>> index 41a9d2862b..4bef28ec39 100644
>> --- a/include/hw/s390x/s390-virtio-ccw.h
>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>> @@ -21,11 +21,14 @@
>>  #define S390_MACHINE_CLASS(klass) \
>>      OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE)
>>  
>> +struct S390CPU;
> 
> You define a "struct S390CPU" here ...
> 
>>  typedef struct S390CcwMachineState {
>>      /*< private >*/
>>      MachineState parent_obj;
>>  
>>      /*< public >*/
>> +    S390CPU **cpus;

I'll simply convert this to struct S390CPU, so this header stays
independent from cpu headers.

> 
> ... but use the typedef'ed S390CPU here ... looks somewhat suspicious, I
> wonder whether the typedef is really in the right place?
> 
>>      bool aes_key_wrap;
>>      bool dea_key_wrap;
>>      uint8_t loadparm[8];
> 
> Anyway, that were just nits, I'm also fine with the patch as it is, so:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks!

-- 

Thanks,

David
