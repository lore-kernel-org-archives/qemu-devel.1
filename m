Received: from eggs.gnu.org ([2001:4830:134:3::10]:44317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dki4Y-00012h-0R
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dki4U-0008G3-RF
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:40:42 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dki4U-0008Fj-EQ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:40:38 -0400
Received: by mail-qt0-x241.google.com with SMTP id s11so1184538qtk.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 19:40:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-2-git-send-email-imammedo@redhat.com>
	<c65c99e5-5d60-5aef-7e69-ce236f6b7d4e@amsat.org>
	<20170821125505.37ce8935@nial.brq.redhat.com>
	<3d17f458-8f90-e5ee-da7d-0726a2105ff0@amsat.org>
Message-ID: <20cd3d85-12c2-41a2-8c97-da0ea81d94b2@amsat.org>
Date: Wed, 23 Aug 2017 23:40:33 -0300
MIME-Version: 1.0
In-Reply-To: <3d17f458-8f90-e5ee-da7d-0726a2105ff0@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 01/27] sparc: convert cpu models
 to SPARC cpu subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 08/22/2017 10:12 PM, Philippe Mathieu-Daudé wrote:
>>> On 08/18/2017 07:08 AM, Igor Mammedov wrote:
>>>> QOMfy cpu models handling introducing propper cpu types
>>>> for each cpu model.
>>>>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>> with this and conversion of features to properties,
>>>> it would be possible to replace cpu_sparc_init() with
>>>> cpu_generic_init() and reuse common -cpu handling
>>>> infrastructure.
>>>>
>>>> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> CC: Artyom Tarasenko <atar4qemu@gmail.com>
>>>> CC: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>
>>>> v2:
>>>>     * make base class abstract (Philippe Mathieu-Daudé 
>>>> <f4bug@amsat.org>)
>>>> ---
>>>>    target/sparc/cpu-qom.h |   2 +
>>>>    target/sparc/cpu.c     | 121 
>>>> +++++++++++++++++++++++++++++++++----------------
>>>>    2 files changed, 84 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
>>>> index f63af72..af6d57a 100644
>>>> --- a/target/sparc/cpu-qom.h
>>>> +++ b/target/sparc/cpu-qom.h
>>>> @@ -35,6 +35,7 @@
>>>>    #define SPARC_CPU_GET_CLASS(obj) \
>>>>        OBJECT_GET_CLASS(SPARCCPUClass, (obj), TYPE_SPARC_CPU)
>>>> +typedef struct sparc_def_t sparc_def_t;
>>>>    /**
>>>>     * SPARCCPUClass:
>>>>     * @parent_realize: The parent class' realize handler.
>>>> @@ -49,6 +50,7 @@ typedef struct SPARCCPUClass {
>>>>        DeviceRealize parent_realize;
>>>>        void (*parent_reset)(CPUState *cpu);
>>>> +    sparc_def_t *cpu_def;
>>>>    } SPARCCPUClass;
>>>>    typedef struct SPARCCPU SPARCCPU;
>>>> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
>>>> index d606eb5..2994c09 100644
>>>> --- a/target/sparc/cpu.c
>>>> +++ b/target/sparc/cpu.c
>>>> @@ -25,8 +25,6 @@
>>>>    //#define DEBUG_FEATURES
>>>> -static int cpu_sparc_find_by_name(sparc_def_t *cpu_def, const char 
>>>> *cpu_model);
>>>> -
>>>>    /* CPUClass::reset() */
>>>>    static void sparc_cpu_reset(CPUState *s)
>>>>    {
>>>> @@ -111,17 +109,9 @@ static int cpu_sparc_register(SPARCCPU *cpu, 
>>>> const char *cpu_model)
>>>>    {
>>>>        CPUSPARCState *env = &cpu->env;
>>>>        char *s = g_strdup(cpu_model);
>>>> -    char *featurestr, *name = strtok(s, ",");
>>>> -    sparc_def_t def1, *def = &def1;
>>>> +    char *featurestr = strtok(s, ",");
>>>>        Error *err = NULL;
>>>> -    if (cpu_sparc_find_by_name(def, name) < 0) {
>>>> -        g_free(s);
>>>> -        return -1;
>>>> -    }
>>>> -
>>>> -    env->def = g_memdup(def, sizeof(*def));
>>>> -
>>>>        featurestr = strtok(NULL, ",");
>>>>        sparc_cpu_parse_features(CPU(cpu), featurestr, &err);
>>>>        g_free(s);
>>>> @@ -130,18 +120,18 @@ static int cpu_sparc_register(SPARCCPU *cpu, 
>>>> const char *cpu_model)
>>>>            return -1;
>>>>        }
>>>> -    env->version = def->iu_version;
>>>> -    env->fsr = def->fpu_version;
>>>> -    env->nwindows = def->nwindows;
>>>> +    env->version = env->def->iu_version;
>>>> +    env->fsr = env->def->fpu_version;
>>>> +    env->nwindows = env->def->nwindows;
>>>>    #if !defined(TARGET_SPARC64)
>>>> -    env->mmuregs[0] |= def->mmu_version;
>>>> +    env->mmuregs[0] |= env->def->mmu_version;
>>>>        cpu_sparc_set_id(env, 0);
>>>> -    env->mxccregs[7] |= def->mxcc_version;
>>>> +    env->mxccregs[7] |= env->def->mxcc_version;
>>>>    #else
>>>> -    env->mmu_version = def->mmu_version;
>>>> -    env->maxtl = def->maxtl;
>>>> -    env->version |= def->maxtl << 8;
>>>> -    env->version |= def->nwindows - 1;
>>>> +    env->mmu_version = env->def->mmu_version;
>>>> +    env->maxtl = env->def->maxtl;
>>>> +    env->version |= env->def->maxtl << 8;
>>>> +    env->version |= env->def->nwindows - 1;
>>>>    #endif
>>>>        return 0;
>>>>    }
>>>> @@ -149,8 +139,19 @@ static int cpu_sparc_register(SPARCCPU *cpu, 
>>>> const char *cpu_model)
>>>>    SPARCCPU *cpu_sparc_init(const char *cpu_model)
>>>>    {
>>>>        SPARCCPU *cpu;
>>>> +    ObjectClass *oc;
>>>> +    char *str, *name;
>>>> +
>>>> +    str = g_strdup(cpu_model);
>>>> +    name = strtok(str, ",");
>>>
>>> you can free 'str' once here:
>>>
>>>          g_free(str);
>>>
>>>> +    oc = cpu_class_by_name(TYPE_SPARC_CPU, name);
>>>> +    if (oc == NULL) {
>>>> +        g_free(str);
>>>
>>> drop
>>>
>>>> +        return NULL;
>>>> +    }
>>>> +    g_free(str);
>>>
>>> drop
>>
>> I'll fix it up if I have to respin series (note this function is 
>> removed within series)

Indeed I didn't notice

>>
>> [...]
>>
>>> Anyway I can't start Aurelien's image [1] with this commit:
>> Can't reproduce it locally (either dirty/clean tree rebuild)
>> with ./configure --enable-debug
>>
>>> $ sparc-softmmu/qemu-system-sparc -hda debian_etch_sparc_small.qcow2
>>> qemu: Unable to find Sparc CPU definition
>> for this kind of error guest image doesn't matter as error happens 
>> during machine_init()
>>
>>> [1] https://people.debian.org/~aurel32/qemu/sparc/
>> It boots just fine with default CPU model:
>>
>> ./sparc-softmmu/qemu-system-sparc -hda debian_etch_sparc_small.qcow2

Yes, my bad!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Sorry I'v been distracted by something else :/
> I might have done something wrong, I'll test it again tomorrow.
> 
>>
>> and with explicitly specified one:
>>
>> sparc-softmmu/qemu-system-sparc -cpu "Fujitsu MB86904"
>>
>> I get from "info qom-tree"
>> ...
>>   /device[0] (Fujitsu-MB86904-sparc-cpu)
>> ...
>>
