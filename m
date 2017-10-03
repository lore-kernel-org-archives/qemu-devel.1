Received: from eggs.gnu.org ([2001:4830:134:3::10]:36344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNKm-0004QN-Q3
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNKl-0005o1-Iz
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:34:04 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:52082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNKl-0005nn-FO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:34:03 -0400
Received: by mail-qt0-x244.google.com with SMTP id q4so12951843qtq.8
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:34:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-23-git-send-email-imammedo@redhat.com>
	<71226704-7e3b-25e7-3155-4a84ceba5c51@amsat.org>
	<20171003123754.0f2dd9fe@nial.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <536c3f1e-b424-db1e-cb3e-b30e7cb30a49@amsat.org>
Date: Tue, 3 Oct 2017 10:33:59 -0300
MIME-Version: 1.0
In-Reply-To: <20171003123754.0f2dd9fe@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 22/38] xtensa: cleanup cpu type name
 composition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, jcmvbkbc@gmail.com

On 10/03/2017 07:37 AM, Igor Mammedov wrote:
> On Mon, 2 Oct 2017 17:35:39 -0300
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> On 10/02/2017 06:08 AM, Igor Mammedov wrote:
>>> use new XTENSA_CPU_TYPE_NAME to compose CPU type name
>>> to bring xtensa in line with all other targets that
>>> will similar macro.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>> CC: jcmvbkbc@gmail.com
>>> ---
>>>   target/xtensa/cpu.h    | 4 ++++
>>>   target/xtensa/cpu.c    | 2 +-
>>>   target/xtensa/helper.c | 2 +-
>>>   3 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
>>> index 4803331..b17d7d9 100644
>>> --- a/target/xtensa/cpu.h
>>> +++ b/target/xtensa/cpu.h
>>> @@ -469,11 +469,15 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>>>   #define cpu_signal_handler cpu_xtensa_signal_handler
>>>   #define cpu_list xtensa_cpu_list
>>>   
>>> +#define XTENSA_CPU_TYPE_SUFFIX "-" TYPE_XTENSA_CPU
>>> +#define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
>>> +
>>>   #ifdef TARGET_WORDS_BIGENDIAN
>>>   #define XTENSA_DEFAULT_CPU_MODEL "fsf"
>>>   #else
>>>   #define XTENSA_DEFAULT_CPU_MODEL "dc232b"
>>>   #endif
>>> +#define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)  
>>
>> I see XTENSA_DEFAULT_CPU_MODEL is used in mc->desc, any idea to be able 
>> to use this instead?
> mc-desc is the reason why I've left XTENSA_DEFAULT_CPU_MODEL as is, and
> having that there were no point in adding yet another ifdef for type,
> XTENSA_DEFAULT_CPU_MODEL works just fine here.

Fine enough,

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>>
>> #ifdef TARGET_WORDS_BIGENDIAN
>> # define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME("fsf")
>> #else
>> # define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME("dc232b")
>> #endif
>>
>>>   
>>>   #define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
>>>   
>>> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
>>> index dcdc765..b5f7079 100644
>>> --- a/target/xtensa/cpu.c
>>> +++ b/target/xtensa/cpu.c
>>> @@ -83,7 +83,7 @@ static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
>>>       ObjectClass *oc;
>>>       char *typename;
>>>   
>>> -    typename = g_strdup_printf("%s-" TYPE_XTENSA_CPU, cpu_model);
>>> +    typename = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), cpu_model);
>>>       oc = object_class_by_name(typename);
>>>       g_free(typename);
>>>       if (oc == NULL || !object_class_dynamic_cast(oc, TYPE_XTENSA_CPU) ||
>>> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
>>> index e8fba20..216f198 100644
>>> --- a/target/xtensa/helper.c
>>> +++ b/target/xtensa/helper.c
>>> @@ -76,7 +76,7 @@ void xtensa_register_core(XtensaConfigList *node)
>>>   
>>>       node->next = xtensa_cores;
>>>       xtensa_cores = node;
>>> -    type.name = g_strdup_printf("%s-" TYPE_XTENSA_CPU, node->config->name);
>>> +    type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->config->name);
>>>       type_register(&type);
>>>       g_free((gpointer)type.name);
>>>   }
>>>   
> 
