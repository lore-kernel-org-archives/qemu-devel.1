Received: from eggs.gnu.org ([2001:4830:134:3::10]:59045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtiFT-0002UI-2I
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 18:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtiFO-0006bH-5F
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 18:41:11 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtiFO-0006ax-0b
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 18:41:06 -0400
Received: by mail-qt0-x242.google.com with SMTP id q8so4676401qtb.1
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 15:41:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170830225225.27925-8-f4bug@amsat.org>
	<20170916002013.GD21016@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d83fb510-3a16-4afe-2d0f-14764c4327cd@amsat.org>
Date: Sun, 17 Sep 2017 19:40:56 -0300
MIME-Version: 1.0
In-Reply-To: <20170916002013.GD21016@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 7/7] mips: update mips_cpu_list() to use
 object_class_get_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Marcel Apfelbaum <marcel@redhat.com>, James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 09/15/2017 09:20 PM, Eduardo Habkost wrote:
> On Wed, Aug 30, 2017 at 07:52:25PM -0300, Philippe Mathieu-Daudé wrote:
>> while here, move it from translate_init.c to helper.c
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Tested-by: Igor Mammedov <imammedo@redhat.com>
>> Tested-by: James Hogan <james.hogan@imgtec.com>
>> ---
>>   target/mips/helper.c         | 46 ++++++++++++++++++++++++++++++++++++++++++++
>>   target/mips/translate_init.c | 10 ----------
>>   2 files changed, 46 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/mips/helper.c b/target/mips/helper.c
>> index ea076261af..8d12b0088a 100644
>> --- a/target/mips/helper.c
>> +++ b/target/mips/helper.c
>> @@ -1093,3 +1093,49 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env,
>>   
>>       cpu_loop_exit_restore(cs, pc);
>>   }
>> +
>> +/* Sort alphabetically by type name, except for "any". */
>> +static gint mips_cpu_list_compare(gconstpointer a, gconstpointer b)
>> +{
>> +    ObjectClass *class_a = (ObjectClass *)a;
>> +    ObjectClass *class_b = (ObjectClass *)b;
>> +    const char *name_a, *name_b;
>> +
>> +    name_a = object_class_get_name(class_a);
>> +    name_b = object_class_get_name(class_b);
>> +    if (strcmp(name_a, "any-" TYPE_MIPS_CPU) == 0) {
>> +        return 1;
>> +    } else if (strcmp(name_b, "any-" TYPE_MIPS_CPU) == 0) {
>> +        return -1;
>> +    } else {
>> +        return strcmp(name_a, name_b);
>> +    }
> 
> This works, but I'd prefer to do like x86 and have a
> MIPSCPUClass::ordering field.
> 
> (Or, even better: to add a generic CPUClass::ordering field so
> all architectures can use the same method to order the model
> list)

I'll drop this patch, it is not required to QOMify MIPS CPU, and let 
another series properly refactor CPUClass::ordering.

> 
>> +}
>> +
>> +static void mips_cpu_list_entry(gpointer data, gpointer user_data)
>> +{
>> +    ObjectClass *oc = data;
>> +    CPUListState *s = user_data;
>> +    const char *typename;
>> +    char *name;
>> +
>> +    typename = object_class_get_name(oc);
>> +    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_MIPS_CPU));
>> +    (*s->cpu_fprintf)(s->file, "  %s\n", name);
>> +    g_free(name);
>> +}
>> +
>> +void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>> +{
>> +    CPUListState s = {
>> +        .file = f,
>> +        .cpu_fprintf = cpu_fprintf,
>> +    };
>> +    GSList *list;
>> +
>> +    list = object_class_get_list(TYPE_MIPS_CPU, false);
>> +    list = g_slist_sort(list, mips_cpu_list_compare);
>> +    (*cpu_fprintf)(f, "Available CPUs:\n");
>> +    g_slist_foreach(list, mips_cpu_list_entry, &s);
>> +    g_slist_free(list);
>> +}
> 
> I think it's about time we implement a generic mechanism to list
> CPU models using the QOM hierarchy, but this is out of the scope
> of this series.
> 
> 
>> diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
>> index 8bbded46c4..b75f4c9065 100644
>> --- a/target/mips/translate_init.c
>> +++ b/target/mips/translate_init.c
>> @@ -767,16 +767,6 @@ static const mips_def_t *cpu_mips_find_by_name (const char *name)
>>       return NULL;
>>   }
>>   
>> -void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf)
>> -{
>> -    int i;
>> -
>> -    for (i = 0; i < ARRAY_SIZE(mips_defs); i++) {
>> -        (*cpu_fprintf)(f, "MIPS '%s'\n",
>> -                       mips_defs[i].name);
>> -    }
>> -}
>> -
>>   #ifndef CONFIG_USER_ONLY
>>   static void no_mmu_init (CPUMIPSState *env, const mips_def_t *def)
>>   {
>> -- 
>> 2.14.1
>>
>>
> 
