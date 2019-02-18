Received: from eggs.gnu.org ([209.51.188.92]:53204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gvci5-0006dw-S0
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 01:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gvci4-0005es-55
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 01:47:25 -0500
Received: from mail-eopbgr700114.outbound.protection.outlook.com
	([40.107.70.114]:7248
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gvci2-0005ab-Om
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 01:47:24 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 18 Feb 2019 06:47:18 +0000
Message-ID: <BN6PR2201MB1251B9927732A72EB237EA66C6630@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <154937205518.29984.9188603364499998604.stgit@pasha-VirtualBox>
	<001c01d4c1cb$65a26390$30e72ab0$@ru>,
	<43520125-e1d5-7ee6-60a8-5efc1dc061fe@redhat.com>
In-Reply-To: <43520125-e1d5-7ee6-60a8-5efc1dc061fe@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>, "natalia.fursova@ispras.ru" <natalia.fursova@ispras.ru>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Pavel Dovgalyuk [mailto:Pavel.Dovgaluk@ispras.ru]
> Sent: Tuesday, February 05, 2019 4:08 PM
> To: qemu-devel@nongnu.org
> Cc: pavel.dovgaluk@ispras.ru; arikalo@wavecomp.com; mdroth@linux.vnet.ibm=
.com;
> armbru@redhat.com; dovgaluk@ispras.ru; natalia.fursova@ispras.ru; eblake@=
redhat.com;
> aurelien@aurel32.net
> Subject: [PATCH] mips: implement qmp query-cpu-definitions command
>
> This patch enables QMP-based querying of the available CPU types for MIPS
> and MIPS64 platforms.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  monitor.c            |    2 +-
>  target/mips/helper.c |   33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>

Hello, Pavel,

Thanks for involving in this area!

I have just a couple of question:

1) What are the effects of these two patches on the end user?

2) What is the context of these patches? Do you intend to send more related=
 patches in the future? Are these patches preconditions for some other not =
yet implemented features?

3) Why is only target MIPS included? Do other targets need similar improvem=
ents?

Thanks,
Aleksandar


> diff --git a/monitor.c b/monitor.c
> index c09fa63940..25d3b141ad 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1165,7 +1165,7 @@ static void qmp_unregister_commands_hack(void)
>      qmp_unregister_command(&qmp_commands, "query-cpu-model-comparison");
>  #endif
>  #if !defined(TARGET_PPC) && !defined(TARGET_ARM) && !defined(TARGET_I386=
) \
> -    && !defined(TARGET_S390X)
> +    && !defined(TARGET_S390X) && !defined(TARGET_MIPS)
>      qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
>  #endif
>  }
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index 8988452dbd..c84d056c09 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/log.h"
>  #include "hw/mips/cpudevs.h"
> +#include "sysemu/arch_init.h"
>
>  enum {
>      TLBRET_XI =3D -6,
> @@ -1472,3 +1473,35 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSS=
tate *env,
>
>      cpu_loop_exit_restore(cs, pc);
>  }
> +
> +static void mips_cpu_add_definition(gpointer data, gpointer user_data)
> +{
> +    ObjectClass *oc =3D data;
> +    CpuDefinitionInfoList **cpu_list =3D user_data;
> +    CpuDefinitionInfoList *entry;
> +    CpuDefinitionInfo *info;
> +    const char *typename;
> +
> +    typename =3D object_class_get_name(oc);
> +    info =3D g_malloc0(sizeof(*info));
> +    info->name =3D g_strndup(typename,
> +                           strlen(typename) - strlen("-" TYPE_MIPS_CPU))=
;
> +    info->q_typename =3D g_strdup(typename);
> +
> +    entry =3D g_malloc0(sizeof(*entry));
> +    entry->value =3D info;
> +    entry->next =3D *cpu_list;
> +    *cpu_list =3D entry;
> +}
> +
> +CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
> +{
> +    CpuDefinitionInfoList *cpu_list =3D NULL;
> +    GSList *list;
> +
> +    list =3D object_class_get_list(TYPE_MIPS_CPU, false);
> +    g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
> +    g_slist_free(list);
> +
> +    return cpu_list;
> +}
