Received: from eggs.gnu.org ([209.51.188.92]:42525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gv4ne-0003pF-H1
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 13:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gv4nd-0002Mj-54
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 13:34:54 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gv4nb-0002MK-VP
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 13:34:53 -0500
Received: by mail-wm1-f42.google.com with SMTP id x10so12736113wmg.2
	for <qemu-devel@nongnu.org>; Sat, 16 Feb 2019 10:34:51 -0800 (PST)
References: <154937205518.29984.9188603364499998604.stgit@pasha-VirtualBox>
	<001c01d4c1cb$65a26390$30e72ab0$@ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <43520125-e1d5-7ee6-60a8-5efc1dc061fe@redhat.com>
Date: Sat, 16 Feb 2019 19:34:47 +0100
MIME-Version: 1.0
In-Reply-To: <001c01d4c1cb$65a26390$30e72ab0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] mips: implement qmp query-cpu-definitions
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: arikalo@wavecomp.com, mdroth@linux.vnet.ibm.com, natalia.fursova@ispras.ru, aurelien@aurel32.net

Hi Pavel,

On 2/11/19 6:34 AM, Pavel Dovgalyuk wrote:
> Ping.

You forgot to Cc Aleksandar, to get his MIPS maintainer Ack-by:

./scripts/get_maintainer.pl -f target/mips/helper.c
Aleksandar Markovic <amarkovic@wavecomp.com> (maintainer:MIPS)

> 
> Pavel Dovgalyuk
> 
>> -----Original Message-----
>> From: Pavel Dovgalyuk [mailto:Pavel.Dovgaluk@ispras.ru]
>> Sent: Tuesday, February 05, 2019 4:08 PM
>> To: qemu-devel@nongnu.org
>> Cc: pavel.dovgaluk@ispras.ru; arikalo@wavecomp.com; mdroth@linux.vnet.ibm.com;
>> armbru@redhat.com; dovgaluk@ispras.ru; natalia.fursova@ispras.ru; eblake@redhat.com;
>> aurelien@aurel32.net
>> Subject: [PATCH] mips: implement qmp query-cpu-definitions command
>>
>> This patch enables QMP-based querying of the available CPU types for MIPS
>> and MIPS64 platforms.

Your patch is a simple copy of the ARM code, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Also:

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

However this clashes with Marc-André's "qapi: make query-cpu-definitions
depend on specific targets" posted here by Markus:
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg03831.html

I believe your patch will go thru the QMP tree, so you might want to
rebase on top of the series Markus sent; or see if Markus is OK to do
the manual cleanup when applying.

Regards,

Phil.

>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> ---
>>  monitor.c            |    2 +-
>>  target/mips/helper.c |   33 +++++++++++++++++++++++++++++++++
>>  2 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index c09fa63940..25d3b141ad 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1165,7 +1165,7 @@ static void qmp_unregister_commands_hack(void)
>>      qmp_unregister_command(&qmp_commands, "query-cpu-model-comparison");
>>  #endif
>>  #if !defined(TARGET_PPC) && !defined(TARGET_ARM) && !defined(TARGET_I386) \
>> -    && !defined(TARGET_S390X)
>> +    && !defined(TARGET_S390X) && !defined(TARGET_MIPS)
>>      qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
>>  #endif
>>  }
>> diff --git a/target/mips/helper.c b/target/mips/helper.c
>> index 8988452dbd..c84d056c09 100644
>> --- a/target/mips/helper.c
>> +++ b/target/mips/helper.c
>> @@ -24,6 +24,7 @@
>>  #include "exec/cpu_ldst.h"
>>  #include "exec/log.h"
>>  #include "hw/mips/cpudevs.h"
>> +#include "sysemu/arch_init.h"
>>
>>  enum {
>>      TLBRET_XI = -6,
>> @@ -1472,3 +1473,35 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env,
>>
>>      cpu_loop_exit_restore(cs, pc);
>>  }
>> +
>> +static void mips_cpu_add_definition(gpointer data, gpointer user_data)
>> +{
>> +    ObjectClass *oc = data;
>> +    CpuDefinitionInfoList **cpu_list = user_data;
>> +    CpuDefinitionInfoList *entry;
>> +    CpuDefinitionInfo *info;
>> +    const char *typename;
>> +
>> +    typename = object_class_get_name(oc);
>> +    info = g_malloc0(sizeof(*info));
>> +    info->name = g_strndup(typename,
>> +                           strlen(typename) - strlen("-" TYPE_MIPS_CPU));
>> +    info->q_typename = g_strdup(typename);
>> +
>> +    entry = g_malloc0(sizeof(*entry));
>> +    entry->value = info;
>> +    entry->next = *cpu_list;
>> +    *cpu_list = entry;
>> +}
>> +
>> +CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
>> +{
>> +    CpuDefinitionInfoList *cpu_list = NULL;
>> +    GSList *list;
>> +
>> +    list = object_class_get_list(TYPE_MIPS_CPU, false);
>> +    g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
>> +    g_slist_free(list);
>> +
>> +    return cpu_list;
>> +}
> 
> 
> 
