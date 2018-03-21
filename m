Received: from eggs.gnu.org ([2001:4830:134:3::10]:49076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJl-0006ms-GJ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJj-0000Cn-F5
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42124 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJj-0000Cc-8n
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD8A8406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:54:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:52:05 +0100
Message-Id: <20180321115211.17937-44-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 43/49] qapi: make s390 commands depend on
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 qapi/misc.json                          | 101 ----------------------
 qapi/target.json                        | 106 ++++++++++++++++++++++++
 include/sysemu/arch_init.h              |   7 --
 hw/s390x/s390-skeys.c                   |   2 +-
 monitor.c                               |  14 ----
 qmp.c                                   |  14 ----
 stubs/arch-query-cpu-model-baseline.c   |  13 ---
 stubs/arch-query-cpu-model-comparison.c |  13 ---
 target/s390x/cpu_models.c               |   5 +-
 stubs/Makefile.objs                     |   2 -
 10 files changed, 110 insertions(+), 167 deletions(-)
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c

diff --git a/qapi/misc.json b/qapi/misc.json
index 690eeda41f..1753a81b1e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1821,27 +1821,6 @@
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
@@ -2208,46 +2187,6 @@
           }
 }
=20
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
 ##
 # @CpuModelBaselineInfo:
 #
@@ -2260,46 +2199,6 @@
 { 'struct': 'CpuModelBaselineInfo',
   'data': { 'model': 'CpuModelInfo' } }
=20
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
index f277b69a2a..b07a8926d8 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -7,6 +7,8 @@
=20
 { 'pragma': { 'top-unit': 'target' } }
=20
+{ 'include': 'misc.json' }
+
 ##
 # @rtc-reset-reinjection:
 #
@@ -182,3 +184,107 @@
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
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 76241c240e..59d28c2358 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -13,7 +13,7 @@
 #include "hw/boards.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/target-qapi-commands.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
diff --git a/monitor.c b/monitor.c
index 4ad9225425..bd9a6950cf 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1157,19 +1157,12 @@ static void qmp_query_qmp_schema(QDict *qdict, QO=
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
@@ -4703,13 +4696,6 @@ QemuOptsList qemu_mon_opts =3D {
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
diff --git a/qmp.c b/qmp.c
index d8f80cb04e..14972b78df 100644
--- a/qmp.c
+++ b/qmp.c
@@ -601,20 +601,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion=
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
index 2741b6803f..ffca1d9a2d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -25,6 +25,7 @@
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
 #endif
+#include "qapi/target-qapi-commands.h"
=20
 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc)=
 \
     {                                                                   =
 \
@@ -597,7 +598,7 @@ static void list_add_feat(const char *name, void *opa=
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
@@ -670,7 +671,7 @@ CpuModelCompareInfo *arch_query_cpu_model_comparison(=
CpuModelInfo *infoa,
     return compare_info;
 }
=20
-CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
+CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
                                                     CpuModelInfo *infob,
                                                     Error **errp)
 {
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 2d59d84091..9a91e49578 100644
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
--=20
2.16.2.521.g9aa15f885a
