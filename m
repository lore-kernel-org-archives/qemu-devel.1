Received: from eggs.gnu.org ([2001:4830:134:3::10]:46941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyuji-0001l0-An
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyujf-0004dX-8T
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:01:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dyujf-0004d7-0o
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:01:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170907201335.13956-1-david@redhat.com>
	<20170907201335.13956-9-david@redhat.com>
	<1603f6bf-f481-13c2-c7eb-ac155c5a14cc@redhat.com>
	<87lglp9xwf.fsf@dusky.pond.sub.org>
	<18360db6-0a06-375e-5ff7-a601c34b7123@redhat.com>
Date: Mon, 02 Oct 2017 09:01:45 +0200
In-Reply-To: <18360db6-0a06-375e-5ff7-a601c34b7123@redhat.com> (Thomas Huth's
	message of "Mon, 11 Sep 2017 04:19:03 +0200")
Message-ID: <87shf2qbhi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 08/21] s390x: move sclp_service_call()
 to sclp.h
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 08.09.2017 14:29, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> On 07.09.2017 22:13, David Hildenbrand wrote:
>>>> Implemented in sclp.c, so let's move it to the right include file.
>>>> Fix up one include. Do a forward declaration of CPUS390XState to fix the
>>>> two sclp consoles complaining.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  include/hw/s390x/sclp.h    | 2 ++
>>>>  target/s390x/cpu.h         | 1 -
>>>>  target/s390x/misc_helper.c | 1 +
>>>>  3 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>>>> index a72d096081..4b86a8a293 100644
>>>> --- a/include/hw/s390x/sclp.h
>>>> +++ b/include/hw/s390x/sclp.h
>>>> @@ -242,5 +242,7 @@ sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
>>>>  sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
>>>>  void sclp_service_interrupt(uint32_t sccb);
>>>>  void raise_irq_cpu_hotplug(void);
>>>> +typedef struct CPUS390XState CPUS390XState;
>>>> +int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
>>>
>>> That's dangerous and likely does not work with certain versions of GCC.
>>> You can't do a "forward declaration" with typedef in C, I'm afraid. See
>>> for example:
>>>
>>>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01454.html
>>>  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03337.html
>>>  https://stackoverflow.com/questions/8367646/redefinition-of-typedef
>>>
>>> All this typedef'ing in QEMU is pretty bad ... we run into this problem
>>> again and again. include/qemu/typedefs.h is just a work-around for this.
>>> I know people like typedefs for some reasons (I used to do that, too,
>>> before I realized the trouble with them), but IMHO we should rather
>>> adopt the typedef-related rules from the kernel coding conventions instead:
>>>
>>>  https://www.kernel.org/doc/html/v4.13/process/coding-style.html#typedefs
>> 
>> I prefer the kernel style for typedefs myself.  But it's strictly a
>> matter of style.  Excessive typedeffing makes code harder to understand,
>> it isn't wrong.  The part that's wrong is defining things more than
>> once, and that applies to everything, not just typedefs.
>> 
>> Sometimes you get away with defining something more than once.  It's
>> still wrong.
>> 
>> You're not supposed to define the same variable more than once, either
>> (although many C compilers let you get away with it, see -fno-common).
>> You define it in *one* place.  If you need to declare it, declare it in
>> *one* place, and make sure that place is in scope at the definition, so
>> the compiler can check the two match.
>> 
>> Likewise, you're not supposed to define the same struct tag more than
>> once, and you should declare it in just one place.
>
> AFAIK it's perfect valid C to do a forward declaration of a struct
> multiple times by just writing e.g. "struct CPUS390XState;" somewhere in
> your code. This is also what is done in various Linux kernel headers all
> over the place.

"Define it in one place" is dictated by the language, i.e. violating the
rule is wrong.

"Declare it in one place" is merely style.  I insist on it for
declarations the compiler can meaningfully check against definitions,
such as function declarations.  It can't for struct tags, and I consider
"one place" a matter of taste there.

>> Likewise, you're not supposed to define (with typedef) the same type
>> more than once.  There is no such thing as a typedef declaration.
>> 
>> qemu/typedefs.h is not a work-around for a typedef-happy style.  Its
>> purpose is breaking inclusion cycles.  Secondary purpose is reducing the
>> need for non-cyclic includes.  If we didn't typedef, we'd still put our
>> struct declarations there.
>
> No, since it's not required for struct forward declarations, only to
> avoid multiple typedef definitions.

I definitely would, because I prefer sticking to "declare in one place"
style.
