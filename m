Received: from eggs.gnu.org ([2001:4830:134:3::10]:46947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYcYI-0005y1-0H
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYcYE-0005Ln-Ux
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:53:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eYcYE-0005LW-KQ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:53:38 -0500
References: <20180107123224.100877-1-marcel@redhat.com>
	<20180107123224.100877-3-marcel@redhat.com>
	<20180108170553.6312b178.cohuck@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <57939a05-7733-23ef-3775-58ac99d887cc@redhat.com>
Date: Mon, 8 Jan 2018 20:53:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180108170553.6312b178.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Getting rid of phys_mem_set_alloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, borntraeger@de.ibm.com
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, mst@redhat.com

On 08/01/2018 18:05, Cornelia Huck wrote:
> On Sun,  7 Jan 2018 14:32:21 +0200
> Marcel Apfelbaum <marcel@redhat.com> wrote:
> 
> Looking at the churn below...
> 

Hi Cornelia,
Thanks for looking at the patch.

>> diff --git a/exec.c b/exec.c
>> index 4722e521d4..247f8bd0c0 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1278,7 +1278,7 @@ static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
>>                                uint16_t section);
>>   static subpage_t *subpage_init(FlatView *fv, hwaddr base);
>>   
>> -static void *(*phys_mem_alloc)(size_t size, uint64_t *align) =
>> +static void *(*phys_mem_alloc)(size_t size, uint64_t *align, bool shared) =
>>                                  qemu_anon_ram_alloc;
>>   
>>   /*
>> @@ -1286,7 +1286,7 @@ static void *(*phys_mem_alloc)(size_t size, uint64_t *align) =
>>    * Accelerators with unusual needs may need this.  Hopefully, we can
>>    * get rid of it eventually.
>>    */
>> -void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align))
>> +void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align, bool shared))
>>   {
>>       phys_mem_alloc = alloc;
>>   }
> 
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index bbf12a1723..85002ac49a 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -248,7 +248,7 @@ int kvm_on_sigbus(int code, void *addr);
>>   
>>   /* interface with exec.c */
>>   
>> -void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align));
>> +void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align, bool shared));
>>   
>>   /* internal API */
>>   
> 
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 9b8b59f2a2..6c0fc2f89c 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -144,7 +144,7 @@ static int cap_gs;
>>   
>>   static int active_cmma;
>>   
>> -static void *legacy_s390_alloc(size_t size, uint64_t *align);
>> +static void *legacy_s390_alloc(size_t size, uint64_t *align, bool shared);
>>   
>>   static int kvm_s390_query_mem_limit(uint64_t *memory_limit)
>>   {
>> @@ -743,7 +743,7 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
>>    * to grow. We also have to use MAP parameters that avoid
>>    * read-only mapping of guest pages.
>>    */
>> -static void *legacy_s390_alloc(size_t size, uint64_t *align)
>> +static void *legacy_s390_alloc(size_t size, uint64_t *align, bool shared)
>>   {
>>       void *mem;
>>   
> 
> ...I'm wondering whether we have any chance to get rid of this in the
> future?
> 

As far as I know, we don't usually stop supporting very ancient archs/systems;
if there is at least a system needing the support (e.g. s390x/kvm), it will
probably remain in the code. But is s390's maintainers decision, of course.

Thanks,
Marcel

> s390x/kvm is the only user:
> 
>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
>          phys_mem_set_alloc(legacy_s390_alloc);
>      }
> 
> In practice, this means depending on ESOP in the host. Are there still
> any machines/hypervisors without ESOP that we can reasonably expect
> people to run kvm on?
> 
