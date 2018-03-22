Received: from eggs.gnu.org ([2001:4830:134:3::10]:36444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eywig-0006jC-AY
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eywiZ-0001KQ-Fr
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:41:14 -0400
MIME-Version: 1.0
In-Reply-To: <16df2073-4c45-1ca8-5477-5c9a5de26a57@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-44-marcandre.lureau@redhat.com>
	<16df2073-4c45-1ca8-5477-5c9a5de26a57@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 22 Mar 2018 10:41:04 +0100
Message-ID: <CAJ+F1CKjGGBswK9BGZPJ6_hHVM1XVok1pJfbHQrfa05EqqWwqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 43/49] qapi: make s390 commands depend
 on TARGET_S390X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Hi

On Thu, Mar 22, 2018 at 6:42 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 21.03.2018 12:52, Marc-Andr=C3=A9 Lureau wrote:
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  qapi/misc.json                          | 101 ----------------------
>>  qapi/target.json                        | 106 ++++++++++++++++++++++++
>>  include/sysemu/arch_init.h              |   7 --
>>  hw/s390x/s390-skeys.c                   |   2 +-
>>  monitor.c                               |  14 ----
>>  qmp.c                                   |  14 ----
>>  stubs/arch-query-cpu-model-baseline.c   |  13 ---
>>  stubs/arch-query-cpu-model-comparison.c |  13 ---
>>  target/s390x/cpu_models.c               |   5 +-
>>  stubs/Makefile.objs                     |   2 -
>>  10 files changed, 110 insertions(+), 167 deletions(-)
>>  delete mode 100644 stubs/arch-query-cpu-model-baseline.c
>>  delete mode 100644 stubs/arch-query-cpu-model-comparison.c
>>
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 690eeda41f..1753a81b1e 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -1821,27 +1821,6 @@
>>  { 'command': 'query-dump-guest-memory-capability',
>>    'returns': 'DumpGuestMemoryCapability' }
>>
>> -##
>> -# @dump-skeys:
>> -#
>> -# Dump guest's storage keys
>> -#
>> -# @filename: the path to the file to dump to
>> -#
>> -# This command is only supported on s390 architecture.
>> -#
>> -# Since: 2.5
>> -#
>> -# Example:
>> -#
>> -# -> { "execute": "dump-skeys",
>> -#      "arguments": { "filename": "/tmp/skeys" } }
>> -# <- { "return": {} }
>> -#
>> -##
>> -{ 'command': 'dump-skeys',
>> -  'data': { 'filename': 'str' } }
>> -
>>  ##
>>  # @object-add:
>>  #
>> @@ -2208,46 +2187,6 @@
>>            }
>>  }
>>
>> -##
>> -# @query-cpu-model-comparison:
>> -#
>> -# Compares two CPU models, returning how they compare in a specific
>> -# configuration. The results indicates how both models compare regardin=
g
>> -# runnability. This result can be used by tooling to make decisions if =
a
>> -# certain CPU model will run in a certain configuration or if a compati=
ble
>> -# CPU model has to be created by baselining.
>> -#
>> -# Usually, a CPU model is compared against the maximum possible CPU mod=
el
>> -# of a certain configuration (e.g. the "host" model for KVM). If that C=
PU
>> -# model is identical or a subset, it will run in that configuration.
>> -#
>> -# The result returned by this command may be affected by:
>> -#
>> -# * QEMU version: CPU models may look different depending on the QEMU v=
ersion.
>> -#   (Except for CPU models reported as "static" in query-cpu-definition=
s.)
>> -# * machine-type: CPU model may look different depending on the machine=
-type.
>> -#   (Except for CPU models reported as "static" in query-cpu-definition=
s.)
>> -# * machine options (including accelerator): in some architectures, CPU=
 models
>> -#   may look different depending on machine and accelerator options. (E=
xcept for
>> -#   CPU models reported as "static" in query-cpu-definitions.)
>> -# * "-cpu" arguments and global properties: arguments to the -cpu optio=
n and
>> -#   global properties may affect expansion of CPU models. Using
>> -#   query-cpu-model-expansion while using these is not advised.
>> -#
>> -# Some architectures may not support comparing CPU models. s390x suppor=
ts
>> -# comparing CPU models.
>> -#
>> -# Returns: a CpuModelBaselineInfo. Returns an error if comparing CPU mo=
dels is
>> -#          not supported, if a model cannot be used, if a model contain=
s
>> -#          an unknown cpu definition name, unknown properties or proper=
ties
>> -#          with wrong types.
>> -#
>> -# Since: 2.8.0
>> -##
>> -{ 'command': 'query-cpu-model-comparison',
>> -  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
>> -  'returns': 'CpuModelCompareInfo' }
>> -
>>  ##
>>  # @CpuModelBaselineInfo:
>>  #
>> @@ -2260,46 +2199,6 @@
>>  { 'struct': 'CpuModelBaselineInfo',
>>    'data': { 'model': 'CpuModelInfo' } }
>>
>> -##
>> -# @query-cpu-model-baseline:
>> -#
>> -# Baseline two CPU models, creating a compatible third model. The creat=
ed
>> -# model will always be a static, migration-safe CPU model (see "static"
>> -# CPU model expansion for details).
>> -#
>> -# This interface can be used by tooling to create a compatible CPU mode=
l out
>> -# two CPU models. The created CPU model will be identical to or a subse=
t of
>> -# both CPU models when comparing them. Therefore, the created CPU model=
 is
>> -# guaranteed to run where the given CPU models run.
>> -#
>> -# The result returned by this command may be affected by:
>> -#
>> -# * QEMU version: CPU models may look different depending on the QEMU v=
ersion.
>> -#   (Except for CPU models reported as "static" in query-cpu-definition=
s.)
>> -# * machine-type: CPU model may look different depending on the machine=
-type.
>> -#   (Except for CPU models reported as "static" in query-cpu-definition=
s.)
>> -# * machine options (including accelerator): in some architectures, CPU=
 models
>> -#   may look different depending on machine and accelerator options. (E=
xcept for
>> -#   CPU models reported as "static" in query-cpu-definitions.)
>> -# * "-cpu" arguments and global properties: arguments to the -cpu optio=
n and
>> -#   global properties may affect expansion of CPU models. Using
>> -#   query-cpu-model-expansion while using these is not advised.
>> -#
>> -# Some architectures may not support baselining CPU models. s390x suppo=
rts
>> -# baselining CPU models.
>> -#
>> -# Returns: a CpuModelBaselineInfo. Returns an error if baselining CPU m=
odels is
>> -#          not supported, if a model cannot be used, if a model contain=
s
>> -#          an unknown cpu definition name, unknown properties or proper=
ties
>> -#          with wrong types.
>> -#
>> -# Since: 2.8.0
>> -##
>> -{ 'command': 'query-cpu-model-baseline',
>> -  'data': { 'modela': 'CpuModelInfo',
>> -            'modelb': 'CpuModelInfo' },
>> -  'returns': 'CpuModelBaselineInfo' }
>> -
>>  ##
>>  # @AddfdInfo:
>>  #
>> diff --git a/qapi/target.json b/qapi/target.json
>> index f277b69a2a..b07a8926d8 100644
>> --- a/qapi/target.json
>> +++ b/qapi/target.json
>> @@ -7,6 +7,8 @@
>>
>>  { 'pragma': { 'top-unit': 'target' } }
>>
>> +{ 'include': 'misc.json' }
>> +
>>  ##
>>  # @rtc-reset-reinjection:
>>  #
>> @@ -182,3 +184,107 @@
>>  ##
>>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>>    'if': 'defined(TARGET_I386)' }
>> +
>> +##
>> +# @dump-skeys:
>> +#
>> +# Dump guest's storage keys
>> +#
>> +# @filename: the path to the file to dump to
>> +#
>> +# This command is only supported on s390 architecture.
>> +#
>> +# Since: 2.5
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "dump-skeys",
>> +#      "arguments": { "filename": "/tmp/skeys" } }
>> +# <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'dump-skeys',
>> +  'data': { 'filename': 'str' },
>> +  'if': 'defined(TARGET_S390X)' }
>> +
>> +##
>> +# @query-cpu-model-comparison:
>> +#
>> +# Compares two CPU models, returning how they compare in a specific
>> +# configuration. The results indicates how both models compare regardin=
g
>> +# runnability. This result can be used by tooling to make decisions if =
a
>> +# certain CPU model will run in a certain configuration or if a compati=
ble
>> +# CPU model has to be created by baselining.
>> +#
>> +# Usually, a CPU model is compared against the maximum possible CPU mod=
el
>> +# of a certain configuration (e.g. the "host" model for KVM). If that C=
PU
>> +# model is identical or a subset, it will run in that configuration.
>> +#
>> +# The result returned by this command may be affected by:
>> +#
>> +# * QEMU version: CPU models may look different depending on the QEMU v=
ersion.
>> +#   (Except for CPU models reported as "static" in query-cpu-definition=
s.)
>> +# * machine-type: CPU model may look different depending on the machine=
-type.
>> +#   (Except for CPU models reported as "static" in query-cpu-definition=
s.)
>> +# * machine options (including accelerator): in some architectures, CPU=
 models
>> +#   may look different depending on machine and accelerator options. (E=
xcept for
>> +#   CPU models reported as "static" in query-cpu-definitions.)
>> +# * "-cpu" arguments and global properties: arguments to the -cpu optio=
n and
>> +#   global properties may affect expansion of CPU models. Using
>> +#   query-cpu-model-expansion while using these is not advised.
>> +#
>> +# Some architectures may not support comparing CPU models. s390x suppor=
ts
>> +# comparing CPU models.
>> +#
>> +# Returns: a CpuModelBaselineInfo. Returns an error if comparing CPU mo=
dels is
>> +#          not supported, if a model cannot be used, if a model contain=
s
>> +#          an unknown cpu definition name, unknown properties or proper=
ties
>> +#          with wrong types.
>> +#
>> +# Since: 2.8.0
>> +##
>> +{ 'command': 'query-cpu-model-comparison',
>> +  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
>> +  'returns': 'CpuModelCompareInfo',
>> +  'if': 'defined(TARGET_S390X)' }
>> +
>> +##
>> +# @query-cpu-model-baseline:
>> +#
>> +# Baseline two CPU models, creating a compatible third model. The creat=
ed
>> +# model will always be a static, migration-safe CPU model (see "static"
>> +# CPU model expansion for details).
>> +#
>> +# This interface can be used by tooling to create a compatible CPU mode=
l out
>> +# two CPU models. The created CPU model will be identical to or a subse=
t of
>> +# both CPU models when comparing them. Therefore, the created CPU model=
 is
>> +# guaranteed to run where the given CPU models run.
>> +#
>> +# The result returned by this command may be affected by:
>> +#
>> +# * QEMU version: CPU models may look different depending on the QEMU v=
ersion.
>> +#   (Except for CPU models reported as "static" in query-cpu-definition=
s.)
>> +# * machine-type: CPU model may look different depending on the machine=
-type.
>> +#   (Except for CPU models reported as "static" in query-cpu-definition=
s.)
>> +# * machine options (including accelerator): in some architectures, CPU=
 models
>> +#   may look different depending on machine and accelerator options. (E=
xcept for
>> +#   CPU models reported as "static" in query-cpu-definitions.)
>> +# * "-cpu" arguments and global properties: arguments to the -cpu optio=
n and
>> +#   global properties may affect expansion of CPU models. Using
>> +#   query-cpu-model-expansion while using these is not advised.
>> +#
>> +# Some architectures may not support baselining CPU models. s390x suppo=
rts
>> +# baselining CPU models.
>> +#
>> +# Returns: a CpuModelBaselineInfo. Returns an error if baselining CPU m=
odels is
>> +#          not supported, if a model cannot be used, if a model contain=
s
>> +#          an unknown cpu definition name, unknown properties or proper=
ties
>> +#          with wrong types.
>> +#
>> +# Since: 2.8.0
>> +##
>> +{ 'command': 'query-cpu-model-baseline',
>> +  'data': { 'modela': 'CpuModelInfo',
>> +            'modelb': 'CpuModelInfo' },
>> +  'returns': 'CpuModelBaselineInfo',
>> +  'if': 'defined(TARGET_S390X)' }
>> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
>> index 32abdfe6a1..f0ef652b2a 100644
>> --- a/include/sysemu/arch_init.h
>> +++ b/include/sysemu/arch_init.h
>> @@ -36,11 +36,4 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Err=
or **errp);
>>  CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansion=
Type type,
>>                                                        CpuModelInfo *mod=
e,
>>                                                        Error **errp);
>> -CpuModelCompareInfo *arch_query_cpu_model_comparison(CpuModelInfo *mode=
la,
>> -                                                     CpuModelInfo *mode=
lb,
>> -                                                     Error **errp);
>> -CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *model=
a,
>> -                                                    CpuModelInfo *model=
b,
>> -                                                    Error **errp);
>> -
>>  #endif
>> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
>> index 76241c240e..59d28c2358 100644
>> --- a/hw/s390x/s390-skeys.c
>> +++ b/hw/s390x/s390-skeys.c
>> @@ -13,7 +13,7 @@
>>  #include "hw/boards.h"
>>  #include "hw/s390x/storage-keys.h"
>>  #include "qapi/error.h"
>> -#include "qapi/qapi-commands-misc.h"
>> +#include "qapi/target-qapi-commands.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qemu/error-report.h"
>>  #include "sysemu/kvm.h"
>> diff --git a/monitor.c b/monitor.c
>> index 4ad9225425..bd9a6950cf 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1157,19 +1157,12 @@ static void qmp_query_qmp_schema(QDict *qdict, Q=
Object **ret_data,
>>   */
>>  static void qmp_unregister_commands_hack(void)
>>  {
>> -#ifndef TARGET_S390X
>> -    qmp_unregister_command(&qmp_commands, "dump-skeys");
>> -#endif
>>  #ifndef TARGET_ARM
>>      qmp_unregister_command(&qmp_commands, "query-gic-capabilities");
>>  #endif
>>  #if !defined(TARGET_S390X) && !defined(TARGET_I386)
>>      qmp_unregister_command(&qmp_commands, "query-cpu-model-expansion");
>>  #endif
>> -#if !defined(TARGET_S390X)
>> -    qmp_unregister_command(&qmp_commands, "query-cpu-model-baseline");
>> -    qmp_unregister_command(&qmp_commands, "query-cpu-model-comparison")=
;
>> -#endif
>>  #if !defined(TARGET_PPC) && !defined(TARGET_ARM) && !defined(TARGET_I38=
6) \
>>      && !defined(TARGET_S390X)
>>      qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
>> @@ -4703,13 +4696,6 @@ QemuOptsList qemu_mon_opts =3D {
>>      },
>>  };
>>
>> -#ifndef TARGET_S390X
>> -void qmp_dump_skeys(const char *filename, Error **errp)
>> -{
>> -    error_setg(errp, QERR_FEATURE_DISABLED, "dump-skeys");
>> -}
>> -#endif
>> -
>>  #ifndef TARGET_ARM
>>  GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>>  {
>> diff --git a/qmp.c b/qmp.c
>> index d8f80cb04e..14972b78df 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -601,20 +601,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansio=
n(CpuModelExpansionType type,
>>      return arch_query_cpu_model_expansion(type, model, errp);
>>  }
>>
>> -CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *model=
a,
>> -                                                    CpuModelInfo *model=
b,
>> -                                                    Error **errp)
>> -{
>> -    return arch_query_cpu_model_comparison(modela, modelb, errp);
>> -}
>> -
>> -CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *modela=
,
>> -                                                   CpuModelInfo *modelb=
,
>> -                                                   Error **errp)
>> -{
>> -    return arch_query_cpu_model_baseline(modela, modelb, errp);
>> -}
>
> Not sure, but couldn't these two commands be implemented on other
> architectures in the long run, too? So removing them now here seems
> somewhat counterproductive?

They would have modify the qapi ifdef and implement the qmp handler in
their target, similar to what would be done by implementing arch_query
handlers. How counterproductive is that? The benefit is that we don't
have to have stubs and "de-register" the commands.



--=20
Marc-Andr=C3=A9 Lureau
