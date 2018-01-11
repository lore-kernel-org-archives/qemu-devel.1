Received: from eggs.gnu.org ([2001:4830:134:3::10]:52025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXU-0008S9-L2
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXS-00070p-Eq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:32 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:45 +0100
Message-Id: <20180111213250.16511-47-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 46/51] qapi: make s390 commands depend on
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 qapi-schema.json                        | 101 --------------------------=
-----
 qapi/target.json                        | 104 ++++++++++++++++++++++++++=
++++++
 include/sysemu/arch_init.h              |   7 ---
 hw/s390x/s390-skeys.c                   |   2 +-
 monitor.c                               |  14 -----
 qmp.c                                   |  14 -----
 stubs/arch-query-cpu-model-baseline.c   |  12 ----
 stubs/arch-query-cpu-model-comparison.c |  12 ----
 target/s390x/cpu_models.c               |   5 +-
 stubs/Makefile.objs                     |   2 -
 10 files changed, 108 insertions(+), 165 deletions(-)
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c

diff --git a/qapi-schema.json b/qapi-schema.json
index 2cd13a07c4..ee9b2f53ff 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1759,27 +1759,6 @@
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
@@ -2146,46 +2125,6 @@
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
@@ -2198,46 +2137,6 @@
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
index 9bfbb54276..776f2da5e1 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -22,3 +22,107 @@
 ##
 { 'command': 'rtc-reset-reinjection',
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
index 8751c468ed..f193f5189b 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -35,11 +35,4 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Erro=
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
index 53ad5d38d4..5af2f89994 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -11,7 +11,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/boards.h"
-#include "qmp-commands.h"
+#include "target-qmp-commands.h"
 #include "hw/s390x/storage-keys.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
diff --git a/monitor.c b/monitor.c
index f78a3aee9e..5d1ae89421 100644
--- a/monitor.c
+++ b/monitor.c
@@ -971,19 +971,12 @@ static void qmp_query_qmp_schema(QDict *qdict, QObj=
ect **ret_data,
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
@@ -4142,13 +4135,6 @@ QemuOptsList qemu_mon_opts =3D {
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
index 2a8dfa5058..5824ac793b 100644
--- a/qmp.c
+++ b/qmp.c
@@ -548,20 +548,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion=
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
index 094ec13c2c..0000000000
--- a/stubs/arch-query-cpu-model-baseline.c
+++ /dev/null
@@ -1,12 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "sysemu/arch_init.h"
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
index d5486ae980..0000000000
--- a/stubs/arch-query-cpu-model-comparison.c
+++ /dev/null
@@ -1,12 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "sysemu/arch_init.h"
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
index 212a5f0697..acd9b9698e 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -24,6 +24,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/arch_init.h"
 #endif
+#include "target-qmp-commands.h"
=20
 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc)=
 \
     {                                                                   =
 \
@@ -596,7 +597,7 @@ static void list_add_feat(const char *name, void *opa=
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
@@ -669,7 +670,7 @@ CpuModelCompareInfo *arch_query_cpu_model_comparison(=
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
index 8cfe34328a..8288a27e34 100644
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
2.16.0.rc1.1.gef27df75a1
