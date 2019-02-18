Received: from eggs.gnu.org ([209.51.188.92]:54797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gvcvT-0008OF-GL
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 02:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gvcvR-0006hv-Ok
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 02:01:15 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43696)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gvcvR-0006de-7s
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 02:01:13 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <154937205518.29984.9188603364499998604.stgit@pasha-VirtualBox>
	<001c01d4c1cb$65a26390$30e72ab0$@ru>,
	<43520125-e1d5-7ee6-60a8-5efc1dc061fe@redhat.com>
	<BN6PR2201MB1251B9927732A72EB237EA66C6630@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251B9927732A72EB237EA66C6630@BN6PR2201MB1251.namprd22.prod.outlook.com>
Date: Mon, 18 Feb 2019 10:01:08 +0300
Message-ID: <001301d4c757$b94cb040$2be610c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: 'Aleksandar Markovic' <amarkovic@wavecomp.com>, =?iso-8859-1?Q?'Philippe_Mathieu-Daud=E9'?= <philmd@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, =?iso-8859-1?Q?'Marc-Andr=E9_Lureau'?= <marcandre.lureau@redhat.com>, 'Markus Armbruster' <armbru@redhat.com>
Cc: 'Aleksandar Rikalo' <arikalo@wavecomp.com>, mdroth@linux.vnet.ibm.com, natalia.fursova@ispras.ru, aurelien@aurel32.net

> From: Aleksandar Markovic [mailto:amarkovic@wavecomp.com]
> > From: Pavel Dovgalyuk [mailto:Pavel.Dovgaluk@ispras.ru]
> >
> > This patch enables QMP-based querying of the available CPU types for MIPS
> > and MIPS64 platforms.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > ---
> >  monitor.c            |    2 +-
> >  target/mips/helper.c |   33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> 
> Hello, Pavel,
> 
> Thanks for involving in this area!
> 
> I have just a couple of question:
> 
> 1) What are the effects of these two patches on the end user?

This patch make qmp query-cpu-definitions available for the MIPS users.
This command allows requesting possible CPU models with QMP.

> 2) What is the context of these patches? Do you intend to send more related patches in the
> future? Are these patches preconditions for some other not yet implemented features?

Not yet.
We are developing GUI for virtual machine management and debugging
with record-replay feature: https://github.com/ispras/qemu-gui
Therefore we need to request possible CPU and hardware options.

> 3) Why is only target MIPS included? Do other targets need similar improvements?

We use MIPS in our projects. Some other targets need similar improvements, but we do
not focus on them right now.

Pavel Dovgalyuk

> 
> Thanks,
> Aleksandar
> 
> 
> > diff --git a/monitor.c b/monitor.c
> > index c09fa63940..25d3b141ad 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -1165,7 +1165,7 @@ static void qmp_unregister_commands_hack(void)
> >      qmp_unregister_command(&qmp_commands, "query-cpu-model-comparison");
> >  #endif
> >  #if !defined(TARGET_PPC) && !defined(TARGET_ARM) && !defined(TARGET_I386) \
> > -    && !defined(TARGET_S390X)
> > +    && !defined(TARGET_S390X) && !defined(TARGET_MIPS)
> >      qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
> >  #endif
> >  }
> > diff --git a/target/mips/helper.c b/target/mips/helper.c
> > index 8988452dbd..c84d056c09 100644
> > --- a/target/mips/helper.c
> > +++ b/target/mips/helper.c
> > @@ -24,6 +24,7 @@
> >  #include "exec/cpu_ldst.h"
> >  #include "exec/log.h"
> >  #include "hw/mips/cpudevs.h"
> > +#include "sysemu/arch_init.h"
> >
> >  enum {
> >      TLBRET_XI = -6,
> > @@ -1472,3 +1473,35 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env,
> >
> >      cpu_loop_exit_restore(cs, pc);
> >  }
> > +
> > +static void mips_cpu_add_definition(gpointer data, gpointer user_data)
> > +{
> > +    ObjectClass *oc = data;
> > +    CpuDefinitionInfoList **cpu_list = user_data;
> > +    CpuDefinitionInfoList *entry;
> > +    CpuDefinitionInfo *info;
> > +    const char *typename;
> > +
> > +    typename = object_class_get_name(oc);
> > +    info = g_malloc0(sizeof(*info));
> > +    info->name = g_strndup(typename,
> > +                           strlen(typename) - strlen("-" TYPE_MIPS_CPU));
> > +    info->q_typename = g_strdup(typename);
> > +
> > +    entry = g_malloc0(sizeof(*entry));
> > +    entry->value = info;
> > +    entry->next = *cpu_list;
> > +    *cpu_list = entry;
> > +}
> > +
> > +CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
> > +{
> > +    CpuDefinitionInfoList *cpu_list = NULL;
> > +    GSList *list;
> > +
> > +    list = object_class_get_list(TYPE_MIPS_CPU, false);
> > +    g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
> > +    g_slist_free(list);
> > +
> > +    return cpu_list;
> > +}
> 
> 
