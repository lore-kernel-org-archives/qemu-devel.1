Received: from eggs.gnu.org ([2001:4830:134:3::10]:38728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drl2V-0003e4-Hh
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drl2S-0007UL-9g
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:15:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drl2S-0007Te-1J
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:15:40 -0400
References: <20170911152150.12535-1-david@redhat.com>
	<20170911152150.12535-14-david@redhat.com>
	<20170912150737.395a5045@nial.brq.redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <55850e26-53da-474a-328c-f56bad58774b@redhat.com>
Date: Tue, 12 Sep 2017 15:15:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170912150737.395a5045@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 13/21] target/s390x: use "core-id" for
 cpu number/address/id handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On 12.09.2017 15:07, Igor Mammedov wrote:
> On Mon, 11 Sep 2017 17:21:42 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Some time ago we discussed that using "id" as property name is not the
>> right thing to do, as it is a reserved property for other devices and
>> will not work with device_add.
>>
>> Switch to the term "core-id" instead, and use it as an equivalent to
>> "CPU address" mentioned in the PoP. There is no such thing as cpu number,
>> so rename env.cpu_num to env.core_id. We use "core-id" as this is the
>> common term to use for device_add later on (x86 and ppc).
> is there possibility that later The core (something that contains threads)
> would appear/exist in real hw?
> (my concern here is that we would have to use some other name for it as
> renaming of already shipped public property name would be not an option)

There is the possibility (s390x has SMP support starting with z13), but
it is really, really unlikely for KVM. There would be the chance of
implementing this somewhen in the future for TCG (although I also doubt
this will happen in the near future).

If so, I think there will only be one solution: a new machine type.

Faking threads now would be just plain wrong. So I think this should
just be fine for now.

[...]
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index f3624d75eb..293fc8428a 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -232,7 +232,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
>>              /* XXX make different for different CPUs? */
>>              ebcdic_put(sysib.sequence, "QEMUQEMUQEMUQEMU", 16);
>>              ebcdic_put(sysib.plant, "QEMU", 4);
>> -            stw_p(&sysib.cpu_addr, env->cpu_num);
>> +            stw_p(&sysib.cpu_addr, env->core_id);
>>              cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
>>          } else if ((sel1 == 2) && (sel2 == 2)) {
>>              /* Basic Machine CPUs */
>> @@ -260,7 +260,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
>>                  /* XXX make different for different CPUs? */
>>                  ebcdic_put(sysib.sequence, "QEMUQEMUQEMUQEMU", 16);
>>                  ebcdic_put(sysib.plant, "QEMU", 4);
>> -                stw_p(&sysib.cpu_addr, env->cpu_num);
>> +                stw_p(&sysib.cpu_addr, env->core_id);
>>                  stw_p(&sysib.cpu_id, 0);
>>                  cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
>>              } else if ((sel1 == 2) && (sel2 == 2)) {
>> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
>> index 909b12818d..5abd34fb34 100644
>> --- a/target/s390x/translate.c
>> +++ b/target/s390x/translate.c
>> @@ -3823,10 +3823,7 @@ static ExitStatus op_ssm(DisasContext *s, DisasOps *o)
>>  static ExitStatus op_stap(DisasContext *s, DisasOps *o)
>>  {
>>      check_privileged(s);
>> -    /* ??? Surely cpu address != cpu number.  In any case the previous
>> -       version of this stored more than the required half-word, so it
>> -       is unlikely this has ever been tested.  */
>> -    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, cpu_num));
>> +    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
>>      return NO_EXIT;
>>  }
> I see core_id is used in several instructions,
> does it really have any influence on code executed by *-user target?
> 
Nope, these should all be privileged instructions and therefore not
relevant for -user targets.

-- 

Thanks,

David
