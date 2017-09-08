Received: from eggs.gnu.org ([2001:4830:134:3::10]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqIPZ-0002ig-1A
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqIPV-0001Vd-Tg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dqIPV-0001Uu-Kb
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:29:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170907201335.13956-1-david@redhat.com>
	<20170907201335.13956-9-david@redhat.com>
	<1603f6bf-f481-13c2-c7eb-ac155c5a14cc@redhat.com>
Date: Fri, 08 Sep 2017 14:29:20 +0200
In-Reply-To: <1603f6bf-f481-13c2-c7eb-ac155c5a14cc@redhat.com> (Thomas Huth's
	message of "Fri, 8 Sep 2017 06:21:31 +0200")
Message-ID: <87lglp9xwf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 08/21] s390x: move sclp_service_call()
 to sclp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 07.09.2017 22:13, David Hildenbrand wrote:
>> Implemented in sclp.c, so let's move it to the right include file.
>> Fix up one include. Do a forward declaration of CPUS390XState to fix the
>> two sclp consoles complaining.
>> 
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/hw/s390x/sclp.h    | 2 ++
>>  target/s390x/cpu.h         | 1 -
>>  target/s390x/misc_helper.c | 1 +
>>  3 files changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>> index a72d096081..4b86a8a293 100644
>> --- a/include/hw/s390x/sclp.h
>> +++ b/include/hw/s390x/sclp.h
>> @@ -242,5 +242,7 @@ sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
>>  sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
>>  void sclp_service_interrupt(uint32_t sccb);
>>  void raise_irq_cpu_hotplug(void);
>> +typedef struct CPUS390XState CPUS390XState;
>> +int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
>
> That's dangerous and likely does not work with certain versions of GCC.
> You can't do a "forward declaration" with typedef in C, I'm afraid. See
> for example:
>
>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01454.html
>  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03337.html
>  https://stackoverflow.com/questions/8367646/redefinition-of-typedef
>
> All this typedef'ing in QEMU is pretty bad ... we run into this problem
> again and again. include/qemu/typedefs.h is just a work-around for this.
> I know people like typedefs for some reasons (I used to do that, too,
> before I realized the trouble with them), but IMHO we should rather
> adopt the typedef-related rules from the kernel coding conventions instead:
>
>  https://www.kernel.org/doc/html/v4.13/process/coding-style.html#typedefs

I prefer the kernel style for typedefs myself.  But it's strictly a
matter of style.  Excessive typedeffing makes code harder to understand,
it isn't wrong.  The part that's wrong is defining things more than
once, and that applies to everything, not just typedefs.

Sometimes you get away with defining something more than once.  It's
still wrong.

You're not supposed to define the same variable more than once, either
(although many C compilers let you get away with it, see -fno-common).
You define it in *one* place.  If you need to declare it, declare it in
*one* place, and make sure that place is in scope at the definition, so
the compiler can check the two match.

Likewise, you're not supposed to define the same struct tag more than
once, and you should declare it in just one place.

Likewise, you're not supposed to define (with typedef) the same type
more than once.  There is no such thing as a typedef declaration.

qemu/typedefs.h is not a work-around for a typedef-happy style.  Its
purpose is breaking inclusion cycles.  Secondary purpose is reducing the
need for non-cyclic includes.  If we didn't typedef, we'd still put our
struct declarations there.
