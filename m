Received: from eggs.gnu.org ([2001:4830:134:3::10]:40952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkA6J-00006x-Lf
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkA6D-0006QL-94
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:24:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkA6D-0006Ph-02
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:24:09 -0400
Date: Tue, 22 Aug 2017 16:24:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170822162400.51f07d89.cohuck@redhat.com>
In-Reply-To: <20170822132255.23945-52-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-52-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 51/54] qapi: make s390 commands depend
 on TARGET_S390X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

On Tue, 22 Aug 2017 15:22:52 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi-schema.json                        | 10 +++++++---
>  include/sysemu/arch_init.h              |  6 ------
>  monitor.c                               | 14 --------------
>  qmp.c                                   | 14 --------------
>  stubs/arch-query-cpu-model-baseline.c   | 12 ------------
>  stubs/arch-query-cpu-model-comparison.c | 12 ------------
>  target/s390x/cpu_models.c               |  4 ++--
>  stubs/Makefile.objs                     |  2 --
>  8 files changed, 9 insertions(+), 65 deletions(-)
>  delete mode 100644 stubs/arch-query-cpu-model-baseline.c
>  delete mode 100644 stubs/arch-query-cpu-model-comparison.c
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 58574b3044..d4e1552ddc 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3577,7 +3577,8 @@
>  #
>  ##
>  { 'command': 'dump-skeys',
> -  'data': { 'filename': 'str' } }
> +  'data': { 'filename': 'str' },
> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}

I agree with making this s390x specific...
> =20
>  ##
>  # @netdev_add:
> @@ -4621,7 +4622,9 @@
>  ##
>  { 'command': 'query-cpu-model-comparison',
>    'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
> -  'returns': 'CpuModelCompareInfo' }
> +  'returns': 'CpuModelCompareInfo',
> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}
> +
> =20
>  ##
>  # @CpuModelBaselineInfo:
> @@ -4673,7 +4676,8 @@
>  { 'command': 'query-cpu-model-baseline',
>    'data': { 'modela': 'CpuModelInfo',
>              'modelb': 'CpuModelInfo' },
> -  'returns': 'CpuModelBaselineInfo' }
> +  'returns': 'CpuModelBaselineInfo',
> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}

...but I'm not sure about the cpu model stuff. Wasn't the idea to move
to this model for all architectures later? (Given that we have stubs
for architectures not implementing this, instead of ifdeffing it in
monitor.c)

> =20
>  ##
>  # @AddfdInfo:
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 8751c468ed..e9f1ea0cca 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -35,11 +35,5 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Erro=
r **errp);
>  CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionT=
ype type,
>                                                        CpuModelInfo *mode,
>                                                        Error **errp);
> -CpuModelCompareInfo *arch_query_cpu_model_comparison(CpuModelInfo *model=
a,
> -                                                     CpuModelInfo *model=
b,
> -                                                     Error **errp);
> -CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *modela,
> -                                                    CpuModelInfo *modelb,
> -                                                    Error **errp);
> =20
>  #endif
> diff --git a/monitor.c b/monitor.c
> index fcacf10f59..c9f04652b4 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -971,19 +971,12 @@ static void qmp_query_qmp_schema(QDict *qdict, QObj=
ect **ret_data,
>   */
>  static void qmp_unregister_commands_hack(void)
>  {
> -#ifndef TARGET_S390X
> -    qmp_unregister_command(&qmp_commands, "dump-skeys");
> -#endif
>  #ifndef TARGET_ARM
>      qmp_unregister_command(&qmp_commands, "query-gic-capabilities");
>  #endif
>  #if !defined(TARGET_S390X) && !defined(TARGET_I386)
>      qmp_unregister_command(&qmp_commands, "query-cpu-model-expansion");
>  #endif
> -#if !defined(TARGET_S390X)
> -    qmp_unregister_command(&qmp_commands, "query-cpu-model-baseline");
> -    qmp_unregister_command(&qmp_commands, "query-cpu-model-comparison");
> -#endif
>  #if !defined(TARGET_PPC) && !defined(TARGET_ARM) && !defined(TARGET_I386=
) \
>      && !defined(TARGET_S390X)
>      qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
> @@ -4153,13 +4146,6 @@ QemuOptsList qemu_mon_opts =3D {
>      },
>  };
> =20
> -#ifndef TARGET_S390X
> -void qmp_dump_skeys(const char *filename, Error **errp)
> -{
> -    error_setg(errp, QERR_FEATURE_DISABLED, "dump-skeys");
> -}
> -#endif
> -
>  #ifndef TARGET_ARM
>  GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>  {
> diff --git a/qmp.c b/qmp.c
> index 90816ba283..7b6861846f 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -553,20 +553,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion=
(CpuModelExpansionType type,
>      return arch_query_cpu_model_expansion(type, model, errp);
>  }
> =20
> -CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *modela,
> -                                                    CpuModelInfo *modelb,
> -                                                    Error **errp)
> -{
> -    return arch_query_cpu_model_comparison(modela, modelb, errp);
> -}
> -
> -CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *modela,
> -                                                   CpuModelInfo *modelb,
> -                                                   Error **errp)
> -{
> -    return arch_query_cpu_model_baseline(modela, modelb, errp);
> -}
> -
>  void qmp_add_client(const char *protocol, const char *fdname,
>                      bool has_skipauth, bool skipauth, bool has_tls, bool=
 tls,
>                      Error **errp)
> diff --git a/stubs/arch-query-cpu-model-baseline.c b/stubs/arch-query-cpu=
-model-baseline.c
> deleted file mode 100644
> index 094ec13c2c..0000000000
> --- a/stubs/arch-query-cpu-model-baseline.c
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "qemu-common.h"
> -#include "sysemu/arch_init.h"
> -#include "qapi/qmp/qerror.h"
> -
> -CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *modela,
> -                                                    CpuModelInfo *modelb,
> -                                                    Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> diff --git a/stubs/arch-query-cpu-model-comparison.c b/stubs/arch-query-c=
pu-model-comparison.c
> deleted file mode 100644
> index d5486ae980..0000000000
> --- a/stubs/arch-query-cpu-model-comparison.c
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "qemu-common.h"
> -#include "sysemu/arch_init.h"
> -#include "qapi/qmp/qerror.h"
> -
> -CpuModelCompareInfo *arch_query_cpu_model_comparison(CpuModelInfo *model=
a,
> -                                                     CpuModelInfo *model=
b,
> -                                                     Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index fa1338fc72..cdff9cdd3b 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -559,7 +559,7 @@ static void list_add_feat(const char *name, void *opa=
que)
>      *last =3D entry;
>  }
> =20
> -CpuModelCompareInfo *arch_query_cpu_model_comparison(CpuModelInfo *infoa,
> +CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
>                                                       CpuModelInfo *infob,
>                                                       Error **errp)
>  {
> @@ -632,7 +632,7 @@ CpuModelCompareInfo *arch_query_cpu_model_comparison(=
CpuModelInfo *infoa,
>      return compare_info;
>  }
> =20
> -CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
> +CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
>                                                      CpuModelInfo *infob,
>                                                      Error **errp)
>  {
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 717b342c80..1421824eb3 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -1,7 +1,5 @@
>  stub-obj-y +=3D arch-query-cpu-def.o
>  stub-obj-y +=3D arch-query-cpu-model-expansion.o
> -stub-obj-y +=3D arch-query-cpu-model-comparison.o
> -stub-obj-y +=3D arch-query-cpu-model-baseline.o
>  stub-obj-y +=3D bdrv-next-monitor-owned.o
>  stub-obj-y +=3D blk-commit-all.o
>  stub-obj-y +=3D blockdev-close-all-bdrv-states.o
