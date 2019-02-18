Received: from eggs.gnu.org ([209.51.188.92]:60007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYu-0001y1-PM
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYm-0005R0-8x
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvjYk-0005PD-2Y
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A995099CE0
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 15:05:59 +0100
Message-Id: <20190218140607.31998-11-armbru@redhat.com>
In-Reply-To: <20190218140607.31998-1-armbru@redhat.com>
References: <20190218140607.31998-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/18] qapi: make s390 commands depend on
 TARGET_S390X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190214152251.2073-11-armbru@redhat.com>
---
 hw/s390x/s390-skeys.c                   |   2 +-
 include/sysemu/arch_init.h              |   7 --
 monitor.c                               |  14 ---
 qapi/misc.json                          | 137 -----------------------
 qapi/target.json                        | 142 ++++++++++++++++++++++++
 qmp.c                                   |  14 ---
 stubs/Makefile.objs                     |   2 -
 stubs/arch-query-cpu-model-baseline.c   |  13 ---
 stubs/arch-query-cpu-model-comparison.c |  13 ---
 target/s390x/cpu_models.c               |   5 +-
 10 files changed, 146 insertions(+), 203 deletions(-)
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 15f7ab0e53..daac936698 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -14,7 +14,7 @@
 #include "hw/boards.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-target.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 32abdfe6a1..f0ef652b2a 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -36,11 +36,4 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Erro=
r **errp);
 CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionT=
ype type,
                                                       CpuModelInfo *mode=
,
                                                       Error **errp);
-CpuModelCompareInfo *arch_query_cpu_model_comparison(CpuModelInfo *model=
a,
-                                                     CpuModelInfo *model=
b,
-                                                     Error **errp);
-CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *modela=
,
-                                                    CpuModelInfo *modelb=
,
-                                                    Error **errp);
-
 #endif
diff --git a/monitor.c b/monitor.c
index ec901fbb47..621e26cc94 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1145,19 +1145,12 @@ static void qmp_query_qmp_schema(QDict *qdict, QO=
bject **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#ifndef TARGET_S390X
-    qmp_unregister_command(&qmp_commands, "dump-skeys");
-#endif
 #ifndef TARGET_ARM
     qmp_unregister_command(&qmp_commands, "query-gic-capabilities");
 #endif
 #if !defined(TARGET_S390X) && !defined(TARGET_I386)
     qmp_unregister_command(&qmp_commands, "query-cpu-model-expansion");
 #endif
-#if !defined(TARGET_S390X)
-    qmp_unregister_command(&qmp_commands, "query-cpu-model-baseline");
-    qmp_unregister_command(&qmp_commands, "query-cpu-model-comparison");
-#endif
 #if !defined(TARGET_PPC) && !defined(TARGET_ARM) && !defined(TARGET_I386=
) \
     && !defined(TARGET_S390X)
     qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
@@ -4664,13 +4657,6 @@ QemuOptsList qemu_mon_opts =3D {
     },
 };
=20
-#ifndef TARGET_S390X
-void qmp_dump_skeys(const char *filename, Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "dump-skeys");
-}
-#endif
-
 #ifndef TARGET_ARM
 GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
 {
diff --git a/qapi/misc.json b/qapi/misc.json
index 0d9682ba4c..431de64590 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1907,27 +1907,6 @@
 { 'command': 'query-dump-guest-memory-capability',
   'returns': 'DumpGuestMemoryCapability' }
=20
-##
-# @dump-skeys:
-#
-# Dump guest's storage keys
-#
-# @filename: the path to the file to dump to
-#
-# This command is only supported on s390 architecture.
-#
-# Since: 2.5
-#
-# Example:
-#
-# -> { "execute": "dump-skeys",
-#      "arguments": { "filename": "/tmp/skeys" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'dump-skeys',
-  'data': { 'filename': 'str' } }
-
 ##
 # @object-add:
 #
@@ -2294,122 +2273,6 @@
 { 'enum': 'CpuModelCompareResult',
   'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
=20
-##
-# @CpuModelCompareInfo:
-#
-# The result of a CPU model comparison.
-#
-# @result: The result of the compare operation.
-# @responsible-properties: List of properties that led to the comparison=
 result
-#                          not being identical.
-#
-# @responsible-properties is a list of QOM property names that led to
-# both CPUs not being detected as identical. For identical models, this
-# list is empty.
-# If a QOM property is read-only, that means there's no known way to mak=
e the
-# CPU models identical. If the special property name "type" is included,=
 the
-# models are by definition not identical and cannot be made identical.
-#
-# Since: 2.8.0
-##
-{ 'struct': 'CpuModelCompareInfo',
-  'data': {'result': 'CpuModelCompareResult',
-           'responsible-properties': ['str']
-          }
-}
-
-##
-# @query-cpu-model-comparison:
-#
-# Compares two CPU models, returning how they compare in a specific
-# configuration. The results indicates how both models compare regarding
-# runnability. This result can be used by tooling to make decisions if a
-# certain CPU model will run in a certain configuration or if a compatib=
le
-# CPU model has to be created by baselining.
-#
-# Usually, a CPU model is compared against the maximum possible CPU mode=
l
-# of a certain configuration (e.g. the "host" model for KVM). If that CP=
U
-# model is identical or a subset, it will run in that configuration.
-#
-# The result returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine-type: CPU model may look different depending on the machine-=
type.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine options (including accelerator): in some architectures, CPU =
models
-#   may look different depending on machine and accelerator options. (Ex=
cept for
-#   CPU models reported as "static" in query-cpu-definitions.)
-# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
-#   global properties may affect expansion of CPU models. Using
-#   query-cpu-model-expansion while using these is not advised.
-#
-# Some architectures may not support comparing CPU models. s390x support=
s
-# comparing CPU models.
-#
-# Returns: a CpuModelBaselineInfo. Returns an error if comparing CPU mod=
els is
-#          not supported, if a model cannot be used, if a model contains
-#          an unknown cpu definition name, unknown properties or propert=
ies
-#          with wrong types.
-#
-# Since: 2.8.0
-##
-{ 'command': 'query-cpu-model-comparison',
-  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
-  'returns': 'CpuModelCompareInfo' }
-
-##
-# @CpuModelBaselineInfo:
-#
-# The result of a CPU model baseline.
-#
-# @model: the baselined CpuModelInfo.
-#
-# Since: 2.8.0
-##
-{ 'struct': 'CpuModelBaselineInfo',
-  'data': { 'model': 'CpuModelInfo' } }
-
-##
-# @query-cpu-model-baseline:
-#
-# Baseline two CPU models, creating a compatible third model. The create=
d
-# model will always be a static, migration-safe CPU model (see "static"
-# CPU model expansion for details).
-#
-# This interface can be used by tooling to create a compatible CPU model=
 out
-# two CPU models. The created CPU model will be identical to or a subset=
 of
-# both CPU models when comparing them. Therefore, the created CPU model =
is
-# guaranteed to run where the given CPU models run.
-#
-# The result returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine-type: CPU model may look different depending on the machine-=
type.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine options (including accelerator): in some architectures, CPU =
models
-#   may look different depending on machine and accelerator options. (Ex=
cept for
-#   CPU models reported as "static" in query-cpu-definitions.)
-# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
-#   global properties may affect expansion of CPU models. Using
-#   query-cpu-model-expansion while using these is not advised.
-#
-# Some architectures may not support baselining CPU models. s390x suppor=
ts
-# baselining CPU models.
-#
-# Returns: a CpuModelBaselineInfo. Returns an error if baselining CPU mo=
dels is
-#          not supported, if a model cannot be used, if a model contains
-#          an unknown cpu definition name, unknown properties or propert=
ies
-#          with wrong types.
-#
-# Since: 2.8.0
-##
-{ 'command': 'query-cpu-model-baseline',
-  'data': { 'modela': 'CpuModelInfo',
-            'modelb': 'CpuModelInfo' },
-  'returns': 'CpuModelBaselineInfo' }
-
 ##
 # @AddfdInfo:
 #
diff --git a/qapi/target.json b/qapi/target.json
index 2cafd7a0be..17671d77c1 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -5,6 +5,8 @@
 # =3D Target-specific commands & events
 ##
=20
+{ 'include': 'misc.json' }
+
 ##
 # @rtc-reset-reinjection:
 #
@@ -180,3 +182,143 @@
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
   'if': 'defined(TARGET_I386)' }
+
+##
+# @dump-skeys:
+#
+# Dump guest's storage keys
+#
+# @filename: the path to the file to dump to
+#
+# This command is only supported on s390 architecture.
+#
+# Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "dump-skeys",
+#      "arguments": { "filename": "/tmp/skeys" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'dump-skeys',
+  'data': { 'filename': 'str' },
+  'if': 'defined(TARGET_S390X)' }
+
+##
+# @CpuModelBaselineInfo:
+#
+# The result of a CPU model baseline.
+#
+# @model: the baselined CpuModelInfo.
+#
+# Since: 2.8.0
+##
+{ 'struct': 'CpuModelBaselineInfo',
+  'data': { 'model': 'CpuModelInfo' },
+  'if': 'defined(TARGET_S390X)' }
+
+##
+# @CpuModelCompareInfo:
+#
+# The result of a CPU model comparison.
+#
+# @result: The result of the compare operation.
+# @responsible-properties: List of properties that led to the comparison=
 result
+#                          not being identical.
+#
+# @responsible-properties is a list of QOM property names that led to
+# both CPUs not being detected as identical. For identical models, this
+# list is empty.
+# If a QOM property is read-only, that means there's no known way to mak=
e the
+# CPU models identical. If the special property name "type" is included,=
 the
+# models are by definition not identical and cannot be made identical.
+#
+# Since: 2.8.0
+##
+{ 'struct': 'CpuModelCompareInfo',
+  'data': { 'result': 'CpuModelCompareResult',
+            'responsible-properties': ['str'] },
+  'if': 'defined(TARGET_S390X)' }
+
+##
+# @query-cpu-model-comparison:
+#
+# Compares two CPU models, returning how they compare in a specific
+# configuration. The results indicates how both models compare regarding
+# runnability. This result can be used by tooling to make decisions if a
+# certain CPU model will run in a certain configuration or if a compatib=
le
+# CPU model has to be created by baselining.
+#
+# Usually, a CPU model is compared against the maximum possible CPU mode=
l
+# of a certain configuration (e.g. the "host" model for KVM). If that CP=
U
+# model is identical or a subset, it will run in that configuration.
+#
+# The result returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine-type: CPU model may look different depending on the machine-=
type.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine options (including accelerator): in some architectures, CPU =
models
+#   may look different depending on machine and accelerator options. (Ex=
cept for
+#   CPU models reported as "static" in query-cpu-definitions.)
+# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
+#   global properties may affect expansion of CPU models. Using
+#   query-cpu-model-expansion while using these is not advised.
+#
+# Some architectures may not support comparing CPU models. s390x support=
s
+# comparing CPU models.
+#
+# Returns: a CpuModelBaselineInfo. Returns an error if comparing CPU mod=
els is
+#          not supported, if a model cannot be used, if a model contains
+#          an unknown cpu definition name, unknown properties or propert=
ies
+#          with wrong types.
+#
+# Since: 2.8.0
+##
+{ 'command': 'query-cpu-model-comparison',
+  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
+  'returns': 'CpuModelCompareInfo',
+  'if': 'defined(TARGET_S390X)' }
+
+##
+# @query-cpu-model-baseline:
+#
+# Baseline two CPU models, creating a compatible third model. The create=
d
+# model will always be a static, migration-safe CPU model (see "static"
+# CPU model expansion for details).
+#
+# This interface can be used by tooling to create a compatible CPU model=
 out
+# two CPU models. The created CPU model will be identical to or a subset=
 of
+# both CPU models when comparing them. Therefore, the created CPU model =
is
+# guaranteed to run where the given CPU models run.
+#
+# The result returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine-type: CPU model may look different depending on the machine-=
type.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine options (including accelerator): in some architectures, CPU =
models
+#   may look different depending on machine and accelerator options. (Ex=
cept for
+#   CPU models reported as "static" in query-cpu-definitions.)
+# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
+#   global properties may affect expansion of CPU models. Using
+#   query-cpu-model-expansion while using these is not advised.
+#
+# Some architectures may not support baselining CPU models. s390x suppor=
ts
+# baselining CPU models.
+#
+# Returns: a CpuModelBaselineInfo. Returns an error if baselining CPU mo=
dels is
+#          not supported, if a model cannot be used, if a model contains
+#          an unknown cpu definition name, unknown properties or propert=
ies
+#          with wrong types.
+#
+# Since: 2.8.0
+##
+{ 'command': 'query-cpu-model-baseline',
+  'data': { 'modela': 'CpuModelInfo',
+            'modelb': 'CpuModelInfo' },
+  'returns': 'CpuModelBaselineInfo',
+  'if': 'defined(TARGET_S390X)' }
diff --git a/qmp.c b/qmp.c
index 4c819dd8cf..8a613bf7c7 100644
--- a/qmp.c
+++ b/qmp.c
@@ -617,20 +617,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion=
(CpuModelExpansionType type,
     return arch_query_cpu_model_expansion(type, model, errp);
 }
=20
-CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *modela=
,
-                                                    CpuModelInfo *modelb=
,
-                                                    Error **errp)
-{
-    return arch_query_cpu_model_comparison(modela, modelb, errp);
-}
-
-CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *modela,
-                                                   CpuModelInfo *modelb,
-                                                   Error **errp)
-{
-    return arch_query_cpu_model_baseline(modela, modelb, errp);
-}
-
 void qmp_add_client(const char *protocol, const char *fdname,
                     bool has_skipauth, bool skipauth, bool has_tls, bool=
 tls,
                     Error **errp)
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 1558ff1fe7..8394a079d1 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,7 +1,5 @@
 stub-obj-y +=3D arch-query-cpu-def.o
 stub-obj-y +=3D arch-query-cpu-model-expansion.o
-stub-obj-y +=3D arch-query-cpu-model-comparison.o
-stub-obj-y +=3D arch-query-cpu-model-baseline.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
diff --git a/stubs/arch-query-cpu-model-baseline.c b/stubs/arch-query-cpu=
-model-baseline.c
deleted file mode 100644
index 0d066da328..0000000000
--- a/stubs/arch-query-cpu-model-baseline.c
+++ /dev/null
@@ -1,13 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "sysemu/arch_init.h"
-#include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
-
-CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *modela=
,
-                                                    CpuModelInfo *modelb=
,
-                                                    Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
diff --git a/stubs/arch-query-cpu-model-comparison.c b/stubs/arch-query-c=
pu-model-comparison.c
deleted file mode 100644
index 8eb311a26c..0000000000
--- a/stubs/arch-query-cpu-model-comparison.c
+++ /dev/null
@@ -1,13 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "sysemu/arch_init.h"
-#include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
-
-CpuModelCompareInfo *arch_query_cpu_model_comparison(CpuModelInfo *model=
a,
-                                                     CpuModelInfo *model=
b,
-                                                     Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7c253ff308..b532cd8d10 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -25,6 +25,7 @@
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
 #endif
+#include "qapi/qapi-commands-target.h"
=20
 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc)=
 \
     {                                                                   =
 \
@@ -605,7 +606,7 @@ static void list_add_feat(const char *name, void *opa=
que)
     *last =3D entry;
 }
=20
-CpuModelCompareInfo *arch_query_cpu_model_comparison(CpuModelInfo *infoa=
,
+CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
                                                      CpuModelInfo *infob=
,
                                                      Error **errp)
 {
@@ -678,7 +679,7 @@ CpuModelCompareInfo *arch_query_cpu_model_comparison(=
CpuModelInfo *infoa,
     return compare_info;
 }
=20
-CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
+CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
                                                     CpuModelInfo *infob,
                                                     Error **errp)
 {
--=20
2.17.2
