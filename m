Received: from eggs.gnu.org ([2001:4830:134:3::10]:43934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMaF-00070t-1g
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMaD-0007bE-I0
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMaD-0007af-9Q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:53 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:06:22 +0200
Message-Id: <20170911110623.24981-50-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 49/50] qapi: make query-cpu-model-expansion
 depend on s390 or x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json                       | 38 ----------------------------=
-----
 qapi/target.json                       | 39 ++++++++++++++++++++++++++++=
++++++
 include/sysemu/arch_init.h             |  3 ---
 monitor.c                              |  3 ---
 qmp.c                                  |  7 ------
 stubs/arch-query-cpu-model-expansion.c | 12 -----------
 target/i386/cpu.c                      |  3 ++-
 target/s390x/cpu_models.c              |  2 +-
 stubs/Makefile.objs                    |  1 -
 9 files changed, 42 insertions(+), 66 deletions(-)
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c

diff --git a/qapi-schema.json b/qapi-schema.json
index 23151506e7..98525c7702 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2020,44 +2020,6 @@
   'data': { 'model': 'CpuModelInfo' } }
=20
=20
-##
-# @query-cpu-model-expansion:
-#
-# Expands a given CPU model (or a combination of CPU model + additional =
options)
-# to different granularities, allowing tooling to get an understanding w=
hat a
-# specific CPU model looks like in QEMU under a certain configuration.
-#
-# This interface can be used to query the "host" CPU model.
-#
-# The data returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine-type: CPU model  may look different depending on the machine=
-type.
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
-# Some architectures may not support all expansion types. s390x supports
-# "full" and "static".
-#
-# Returns: a CpuModelExpansionInfo. Returns an error if expanding CPU mo=
dels is
-#          not supported, if the model cannot be expanded, if the model =
contains
-#          an unknown CPU definition name, unknown properties or propert=
ies
-#          with a wrong type. Also returns an error if an expansion type=
 is
-#          not supported.
-#
-# Since: 2.8.0
-##
-{ 'command': 'query-cpu-model-expansion',
-  'data': { 'type': 'CpuModelExpansionType',
-            'model': 'CpuModelInfo' },
-  'returns': 'CpuModelExpansionInfo' }
-
 ##
 # @CpuModelCompareResult:
 #
diff --git a/qapi/target.json b/qapi/target.json
index daf4bfa8f1..d9f3bce22f 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -175,3 +175,42 @@
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
   'if': 'defined(TARGET_ARM)' }
+
+##
+# @query-cpu-model-expansion:
+#
+# Expands a given CPU model (or a combination of CPU model + additional =
options)
+# to different granularities, allowing tooling to get an understanding w=
hat a
+# specific CPU model looks like in QEMU under a certain configuration.
+#
+# This interface can be used to query the "host" CPU model.
+#
+# The data returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine-type: CPU model  may look different depending on the machine=
-type.
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
+# Some architectures may not support all expansion types. s390x supports
+# "full" and "static".
+#
+# Returns: a CpuModelExpansionInfo. Returns an error if expanding CPU mo=
dels is
+#          not supported, if the model cannot be expanded, if the model =
contains
+#          an unknown CPU definition name, unknown properties or propert=
ies
+#          with a wrong type. Also returns an error if an expansion type=
 is
+#          not supported.
+#
+# Since: 2.8.0
+##
+{ 'command': 'query-cpu-model-expansion',
+  'data': { 'type': 'CpuModelExpansionType',
+            'model': 'CpuModelInfo' },
+  'returns': 'CpuModelExpansionInfo',
+  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index f193f5189b..08a607b89b 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -32,7 +32,4 @@ int kvm_available(void);
 int xen_available(void);
=20
 CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp);
-CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionT=
ype type,
-                                                      CpuModelInfo *mode=
,
-                                                      Error **errp);
 #endif
diff --git a/monitor.c b/monitor.c
index acf4721b30..24680f37a6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -971,9 +971,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
t **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#if !defined(TARGET_S390X) && !defined(TARGET_I386)
-    qmp_unregister_command(&qmp_commands, "query-cpu-model-expansion");
-#endif
 #if !defined(TARGET_PPC) && !defined(TARGET_ARM) && !defined(TARGET_I386=
) \
     && !defined(TARGET_S390X)
     qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
diff --git a/qmp.c b/qmp.c
index 7b6861846f..afa266ec1e 100644
--- a/qmp.c
+++ b/qmp.c
@@ -546,13 +546,6 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Err=
or **errp)
     return arch_query_cpu_definitions(errp);
 }
=20
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionTy=
pe type,
-                                                     CpuModelInfo *model=
,
-                                                     Error **errp)
-{
-    return arch_query_cpu_model_expansion(type, model, errp);
-}
-
 void qmp_add_client(const char *protocol, const char *fdname,
                     bool has_skipauth, bool skipauth, bool has_tls, bool=
 tls,
                     Error **errp)
diff --git a/stubs/arch-query-cpu-model-expansion.c b/stubs/arch-query-cp=
u-model-expansion.c
deleted file mode 100644
index ae7cf554d1..0000000000
--- a/stubs/arch-query-cpu-model-expansion.c
+++ /dev/null
@@ -1,12 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "sysemu/arch_init.h"
-#include "qapi/qmp/qerror.h"
-
-CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionT=
ype type,
-                                                      CpuModelInfo *mode=
,
-                                                      Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69676e13e1..f8719cb2de 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -36,6 +36,7 @@
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
 #include "sysemu/arch_init.h"
+#include "target-qmp-commands.h"
=20
 #if defined(CONFIG_KVM)
 #include <linux/kvm_para.h>
@@ -2618,7 +2619,7 @@ out:
 }
=20
 CpuModelExpansionInfo *
-arch_query_cpu_model_expansion(CpuModelExpansionType type,
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                       CpuModelInfo *mode=
l,
                                                       Error **errp)
 {
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 5f8151925a..872dc78455 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -524,7 +524,7 @@ static void cpu_info_from_model(CpuModelInfo *info, c=
onst S390CPUModel *model,
     }
 }
=20
-CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionT=
ype type,
+CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionTy=
pe type,
                                                       CpuModelInfo *mode=
l,
                                                       Error **errp)
 {
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5419f0f995..8d024a2b71 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,5 +1,4 @@
 stub-obj-y +=3D arch-query-cpu-def.o
-stub-obj-y +=3D arch-query-cpu-model-expansion.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
--=20
2.14.1.146.gd35faa819
