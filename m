Received: from eggs.gnu.org ([209.51.188.92]:60018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYu-0001yD-SX
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYm-0005Rt-G7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvjYm-0005PF-3q
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B90492D7FF
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 15:06:03 +0100
Message-Id: <20190218140607.31998-15-armbru@redhat.com>
In-Reply-To: <20190218140607.31998-1-armbru@redhat.com>
References: <20190218140607.31998-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/18] qapi: make query-cpu-definitions depend
 on specific targets
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

It depends on TARGET_PPC || TARGET_ARM || TARGET_I386 || TARGET_S390X.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190214152251.2073-15-armbru@redhat.com>
---
 include/sysemu/arch_init.h      |  1 -
 monitor.c                       | 22 ------------
 qapi/misc.json                  | 58 ------------------------------
 qapi/target.json                | 64 +++++++++++++++++++++++++++++++++
 qmp.c                           |  5 ---
 stubs/Makefile.objs             |  1 -
 stubs/arch-query-cpu-def.c      | 11 ------
 target/arm/helper.c             |  3 +-
 target/i386/cpu.c               |  2 +-
 target/ppc/translate_init.inc.c |  3 +-
 target/s390x/cpu_models.c       |  2 +-
 11 files changed, 70 insertions(+), 102 deletions(-)
 delete mode 100644 stubs/arch-query-cpu-def.c

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 2497fd3351..10cbafe970 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -32,5 +32,4 @@ extern const uint32_t arch_type;
 int kvm_available(void);
 int xen_available(void);
=20
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp);
 #endif
diff --git a/monitor.c b/monitor.c
index 22a551b16b..1673db7015 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1131,26 +1131,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QOb=
ject **ret_data,
     *ret_data =3D qobject_from_qlit(&qmp_schema_qlit);
 }
=20
-/*
- * We used to define commands in qmp-commands.hx in addition to the
- * QAPI schema.  This permitted defining some of them only in certain
- * configurations.  query-commands has always reflected that (good,
- * because it lets QMP clients figure out what's actually available),
- * while query-qmp-schema never did (not so good).  This function is a
- * hack to keep the configuration-specific commands defined exactly as
- * before, even though qmp-commands.hx is gone.
- *
- * FIXME Educate the QAPI schema on configuration-specific commands,
- * and drop this hack.
- */
-static void qmp_unregister_commands_hack(void)
-{
-#if !defined(TARGET_PPC) && !defined(TARGET_ARM) && !defined(TARGET_I386=
) \
-    && !defined(TARGET_S390X)
-    qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
-#endif
-}
-
 static void monitor_init_qmp_commands(void)
 {
     /*
@@ -1169,8 +1149,6 @@ static void monitor_init_qmp_commands(void)
     qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
                          QCO_NO_OPTIONS);
=20
-    qmp_unregister_commands_hack();
-
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
     qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilitie=
s",
                          qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONF=
IG);
diff --git a/qapi/misc.json b/qapi/misc.json
index 1255201267..82f9147353 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2057,54 +2057,6 @@
 ##
 { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' =
}
=20
-##
-# @CpuDefinitionInfo:
-#
-# Virtual CPU definition.
-#
-# @name: the name of the CPU definition
-#
-# @migration-safe: whether a CPU definition can be safely used for
-#                  migration in combination with a QEMU compatibility ma=
chine
-#                  when migrating between different QEMU versions and be=
tween
-#                  hosts with different sets of (hardware or software)
-#                  capabilities. If not provided, information is not ava=
ilable
-#                  and callers should not assume the CPU definition to b=
e
-#                  migration-safe. (since 2.8)
-#
-# @static: whether a CPU definition is static and will not change depend=
ing on
-#          QEMU version, machine type, machine options and accelerator o=
ptions.
-#          A static model is always migration-safe. (since 2.8)
-#
-# @unavailable-features: List of properties that prevent
-#                        the CPU model from running in the current
-#                        host. (since 2.8)
-# @typename: Type name that can be used as argument to @device-list-prop=
erties,
-#            to introspect properties configurable using -cpu or -global=
.
-#            (since 2.9)
-#
-# @unavailable-features is a list of QOM property names that
-# represent CPU model attributes that prevent the CPU from running.
-# If the QOM property is read-only, that means there's no known
-# way to make the CPU model run in the current host. Implementations
-# that choose not to provide specific information return the
-# property name "type".
-# If the property is read-write, it means that it MAY be possible
-# to run the CPU model in the current host if that property is
-# changed. Management software can use it as hints to suggest or
-# choose an alternative for the user, or just to generate meaningful
-# error messages explaining why the CPU model can't be used.
-# If @unavailable-features is an empty list, the CPU model is
-# runnable using the current host and machine-type.
-# If @unavailable-features is not present, runnability
-# information for the CPU is not available.
-#
-# Since: 1.2.0
-##
-{ 'struct': 'CpuDefinitionInfo',
-  'data': { 'name': 'str', '*migration-safe': 'bool', 'static': 'bool',
-            '*unavailable-features': [ 'str' ], 'typename': 'str' } }
-
 ##
 # @MemoryInfo:
 #
@@ -2137,16 +2089,6 @@
 ##
 { 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
=20
-##
-# @query-cpu-definitions:
-#
-# Return a list of supported virtual CPU definitions
-#
-# Returns: a list of CpuDefInfo
-#
-# Since: 1.2.0
-##
-{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
=20
 ##
 # @CpuModelInfo:
diff --git a/qapi/target.json b/qapi/target.json
index 35653648bb..5c41a0aee7 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -425,3 +425,67 @@
             'model': 'CpuModelInfo' },
   'returns': 'CpuModelExpansionInfo',
   'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
+
+##
+# @CpuDefinitionInfo:
+#
+# Virtual CPU definition.
+#
+# @name: the name of the CPU definition
+#
+# @migration-safe: whether a CPU definition can be safely used for
+#                  migration in combination with a QEMU compatibility ma=
chine
+#                  when migrating between different QEMU versions and be=
tween
+#                  hosts with different sets of (hardware or software)
+#                  capabilities. If not provided, information is not ava=
ilable
+#                  and callers should not assume the CPU definition to b=
e
+#                  migration-safe. (since 2.8)
+#
+# @static: whether a CPU definition is static and will not change depend=
ing on
+#          QEMU version, machine type, machine options and accelerator o=
ptions.
+#          A static model is always migration-safe. (since 2.8)
+#
+# @unavailable-features: List of properties that prevent
+#                        the CPU model from running in the current
+#                        host. (since 2.8)
+# @typename: Type name that can be used as argument to @device-list-prop=
erties,
+#            to introspect properties configurable using -cpu or -global=
.
+#            (since 2.9)
+#
+# @unavailable-features is a list of QOM property names that
+# represent CPU model attributes that prevent the CPU from running.
+# If the QOM property is read-only, that means there's no known
+# way to make the CPU model run in the current host. Implementations
+# that choose not to provide specific information return the
+# property name "type".
+# If the property is read-write, it means that it MAY be possible
+# to run the CPU model in the current host if that property is
+# changed. Management software can use it as hints to suggest or
+# choose an alternative for the user, or just to generate meaningful
+# error messages explaining why the CPU model can't be used.
+# If @unavailable-features is an empty list, the CPU model is
+# runnable using the current host and machine-type.
+# If @unavailable-features is not present, runnability
+# information for the CPU is not available.
+#
+# Since: 1.2.0
+##
+{ 'struct': 'CpuDefinitionInfo',
+  'data': { 'name': 'str',
+            '*migration-safe': 'bool',
+            'static': 'bool',
+            '*unavailable-features': [ 'str' ],
+            'typename': 'str' },
+  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X)' }
+
+##
+# @query-cpu-definitions:
+#
+# Return a list of supported virtual CPU definitions
+#
+# Returns: a list of CpuDefInfo
+#
+# Since: 1.2.0
+##
+{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
+  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X)' }
diff --git a/qmp.c b/qmp.c
index c81af9d23f..b92d62cd5f 100644
--- a/qmp.c
+++ b/qmp.c
@@ -605,11 +605,6 @@ ObjectPropertyInfoList *qmp_qom_list_properties(cons=
t char *typename,
     return prop_list;
 }
=20
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
-{
-    return arch_query_cpu_definitions(errp);
-}
-
 void qmp_add_client(const char *protocol, const char *fdname,
                     bool has_skipauth, bool skipauth, bool has_tls, bool=
 tls,
                     Error **errp)
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f337208179..269dfa5832 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,4 +1,3 @@
-stub-obj-y +=3D arch-query-cpu-def.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
diff --git a/stubs/arch-query-cpu-def.c b/stubs/arch-query-cpu-def.c
deleted file mode 100644
index d436f95314..0000000000
--- a/stubs/arch-query-cpu-def.c
+++ /dev/null
@@ -1,11 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "sysemu/arch_init.h"
-#include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
-
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 55e9b77bb1..a018eb23fe 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -19,6 +19,7 @@
 #include "sysemu/kvm.h"
 #include "fpu/softfloat.h"
 #include "qemu/range.h"
+#include "qapi/qapi-commands-target.h"
=20
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable =
*/
=20
@@ -6733,7 +6734,7 @@ static void arm_cpu_add_definition(gpointer data, g=
pointer user_data)
     *cpu_list =3D entry;
 }
=20
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list =3D NULL;
     GSList *list;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index aa3a1f3a4f..d3aa6a815b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3791,7 +3791,7 @@ static void x86_cpu_definition_entry(gpointer data,=
 gpointer user_data)
     *cpu_list =3D entry;
 }
=20
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list =3D NULL;
     GSList *list =3D get_sorted_cpu_model_list();
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 59e0b86762..f393a408ac 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -38,6 +38,7 @@
 #include "qemu/cutils.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
+#include "qapi/qapi-commands-target.h"
=20
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -10201,7 +10202,7 @@ static void ppc_cpu_defs_entry(gpointer data, gpo=
inter user_data)
     *first =3D entry;
 }
=20
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list =3D NULL;
     GSList *list;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index cf87488bfc..5ef34abbf1 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -433,7 +433,7 @@ static void create_cpu_model_list(ObjectClass *klass,=
 void *opaque)
     *cpu_list =3D entry;
 }
=20
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
     struct CpuDefinitionInfoListData list_data =3D {
         .list =3D NULL,
--=20
2.17.2
