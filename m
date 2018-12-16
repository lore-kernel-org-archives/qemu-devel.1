Received: from eggs.gnu.org ([2001:4830:134:3::10]:33156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX7I-0001d4-Cp
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX7G-0005Jk-V3
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:10:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gYX7G-0005JJ-ML
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13F8D3695F
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 14:09:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Dec 2018 18:08:59 +0400
Message-Id: <20181216140902.23986-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181216140902.23986-1-marcandre.lureau@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/13] qapi: make query-cpu-model-expansion
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
Cc: armbru@redhat.com

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 qapi/misc.json                         | 51 -------------------------
 qapi/target.json                       | 52 ++++++++++++++++++++++++++
 include/sysemu/arch_init.h             |  3 --
 monitor.c                              |  3 --
 qmp.c                                  |  7 ----
 stubs/arch-query-cpu-model-expansion.c | 13 -------
 target/i386/cpu.c                      |  3 +-
 target/s390x/cpu_models.c              |  2 +-
 stubs/Makefile.objs                    |  1 -
 9 files changed, 55 insertions(+), 80 deletions(-)
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c

diff --git a/qapi/misc.json b/qapi/misc.json
index 951518ee46..8f4ebd5a46 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2133,57 +2133,6 @@
   'data': [ 'static', 'full' ] }
=20
=20
-##
-# @CpuModelExpansionInfo:
-#
-# The result of a cpu model expansion.
-#
-# @model: the expanded CpuModelInfo.
-#
-# Since: 2.8.0
-##
-{ 'struct': 'CpuModelExpansionInfo',
-  'data': { 'model': 'CpuModelInfo' } }
-
-
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
index 14bc02d90c..dd37c459c1 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -375,3 +375,55 @@
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
   'if': 'defined(TARGET_ARM)' }
+
+##
+# @CpuModelExpansionInfo:
+#
+# The result of a cpu model expansion.
+#
+# @model: the expanded CpuModelInfo.
+#
+# Since: 2.8.0
+##
+{ 'struct': 'CpuModelExpansionInfo',
+  'data': { 'model': 'CpuModelInfo' },
+  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
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
index f0ef652b2a..2497fd3351 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -33,7 +33,4 @@ int kvm_available(void);
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
index 15da71607e..6a041c11b9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1218,9 +1218,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObj=
ect **ret_data,
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
index a480f96f57..0f930014fa 100644
--- a/qmp.c
+++ b/qmp.c
@@ -604,13 +604,6 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Err=
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
index 26273a8b10..0000000000
--- a/stubs/arch-query-cpu-model-expansion.c
+++ /dev/null
@@ -1,13 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "sysemu/arch_init.h"
-#include "qapi/error.h"
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
index 677a3bd5fb..18579bc5e8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -41,6 +41,7 @@
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
 #include "sysemu/arch_init.h"
+#include "qapi/target-qapi-commands.h"
=20
 #include "standard-headers/asm-x86/kvm_para.h"
=20
@@ -4027,7 +4028,7 @@ out:
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
index 106c5fd008..a1e745855b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -567,7 +567,7 @@ static void cpu_info_from_model(CpuModelInfo *info, c=
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
index 48eb080bfb..e28f443b7b 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,5 +1,4 @@
 stub-obj-y +=3D arch-query-cpu-def.o
-stub-obj-y +=3D arch-query-cpu-model-expansion.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
--=20
2.20.0
