Received: from eggs.gnu.org ([209.51.188.92]:60014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYu-0001yB-S6
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYm-0005Rm-Fr
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvjYk-0005PA-8H
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89724811AC
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 15:06:02 +0100
Message-Id: <20190218140607.31998-14-armbru@redhat.com>
In-Reply-To: <20190218140607.31998-1-armbru@redhat.com>
References: <20190218140607.31998-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/18] qapi: make query-cpu-model-expansion
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190214152251.2073-14-armbru@redhat.com>
---
 include/sysemu/arch_init.h             |  3 --
 monitor.c                              |  3 --
 qapi/misc.json                         | 51 -------------------------
 qapi/target.json                       | 52 ++++++++++++++++++++++++++
 qmp.c                                  |  7 ----
 stubs/Makefile.objs                    |  1 -
 stubs/arch-query-cpu-model-expansion.c | 13 -------
 target/i386/cpu.c                      |  5 ++-
 target/s390x/cpu_models.c              |  2 +-
 9 files changed, 57 insertions(+), 80 deletions(-)
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c

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
index 33a0d81677..22a551b16b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1145,9 +1145,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObj=
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
diff --git a/qapi/misc.json b/qapi/misc.json
index 9df45a27ca..1255201267 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2199,57 +2199,6 @@
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
index f4a7054921..35653648bb 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -373,3 +373,55 @@
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
diff --git a/qmp.c b/qmp.c
index 8a613bf7c7..c81af9d23f 100644
--- a/qmp.c
+++ b/qmp.c
@@ -610,13 +610,6 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Err=
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
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 8394a079d1..f337208179 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,5 +1,4 @@
 stub-obj-y +=3D arch-query-cpu-def.o
-stub-obj-y +=3D arch-query-cpu-model-expansion.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
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
index b077196611..aa3a1f3a4f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -41,6 +41,7 @@
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
 #include "sysemu/arch_init.h"
+#include "qapi/qapi-commands-target.h"
=20
 #include "standard-headers/asm-x86/kvm_para.h"
=20
@@ -3918,6 +3919,7 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDef=
inition *def, Error **errp)
=20
 }
=20
+#ifndef CONFIG_USER_ONLY
 /* Return a QDict containing keys for all properties that can be include=
d
  * in static expansion of CPU models. All properties set by x86_cpu_load=
_def()
  * must be included in the dictionary.
@@ -4065,7 +4067,7 @@ out:
 }
=20
 CpuModelExpansionInfo *
-arch_query_cpu_model_expansion(CpuModelExpansionType type,
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                       CpuModelInfo *mode=
l,
                                                       Error **errp)
 {
@@ -4120,6 +4122,7 @@ out:
     }
     return ret;
 }
+#endif  /* !CONFIG_USER_ONLY */
=20
 static gchar *x86_gdb_arch_name(CPUState *cs)
 {
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index b532cd8d10..cf87488bfc 100644
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
--=20
2.17.2
