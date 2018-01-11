Received: from eggs.gnu.org ([2001:4830:134:3::10]:52261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXt-0000Qm-33
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXr-0007qV-Eq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:57 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:49 +0100
Message-Id: <20180111213250.16511-51-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 50/51] qapi: make query-cpu-definitions
 depend on specific targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

It depends on TARGET_PPC || TARGET_ARM || TARGET_I386 || TARGET_S390X.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 qapi-schema.json            | 10 ----------
 qapi/target.json            | 12 ++++++++++++
 include/sysemu/arch_init.h  |  1 -
 monitor.c                   | 22 ----------------------
 qmp.c                       |  5 -----
 stubs/arch-query-cpu-def.c  | 10 ----------
 target/arm/helper.c         |  3 ++-
 target/i386/cpu.c           |  2 +-
 target/ppc/translate_init.c |  3 ++-
 target/s390x/cpu_models.c   |  2 +-
 stubs/Makefile.objs         |  1 -
 11 files changed, 18 insertions(+), 53 deletions(-)
 delete mode 100644 stubs/arch-query-cpu-def.c

diff --git a/qapi-schema.json b/qapi-schema.json
index b5b9103180..b0b8e2806d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1965,16 +1965,6 @@
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
index abf1423fba..973da4a849 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -216,3 +216,15 @@
             'model': 'CpuModelInfo' },
   'returns': 'CpuModelExpansionInfo',
   'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
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
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 08a607b89b..e9721b9ce8 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -31,5 +31,4 @@ extern const uint32_t arch_type;
 int kvm_available(void);
 int xen_available(void);
=20
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp);
 #endif
diff --git a/monitor.c b/monitor.c
index 707cc49385..a8d5af70ad 100644
--- a/monitor.c
+++ b/monitor.c
@@ -957,26 +957,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObje=
ct **ret_data,
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
 void monitor_init_qmp_commands(void)
 {
     /*
@@ -998,8 +978,6 @@ void monitor_init_qmp_commands(void)
     qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
                          QCO_NO_OPTIONS);
=20
-    qmp_unregister_commands_hack();
-
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
     qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilitie=
s",
                          qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
diff --git a/qmp.c b/qmp.c
index a1f42bcac8..4acf693edf 100644
--- a/qmp.c
+++ b/qmp.c
@@ -536,11 +536,6 @@ DevicePropertyInfoList *qmp_device_list_properties(c=
onst char *typename,
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
diff --git a/stubs/arch-query-cpu-def.c b/stubs/arch-query-cpu-def.c
deleted file mode 100644
index cefe4beb82..0000000000
--- a/stubs/arch-query-cpu-def.c
+++ /dev/null
@@ -1,10 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "sysemu/arch_init.h"
-#include "qapi/qmp/qerror.h"
-
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1395f9b73..eafa640687 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -15,6 +15,7 @@
 #include <zlib.h> /* For crc32 */
 #include "exec/semihost.h"
 #include "sysemu/kvm.h"
+#include "target-qmp-commands.h"
=20
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable =
*/
=20
@@ -5420,7 +5421,7 @@ static void arm_cpu_add_definition(gpointer data, g=
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
index 99f3688060..82c5d140bd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2385,7 +2385,7 @@ static void x86_cpu_definition_entry(gpointer data,=
 gpointer user_data)
     *cpu_list =3D entry;
 }
=20
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list =3D NULL;
     GSList *list =3D get_sorted_cpu_model_list();
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 70ff15a51a..b56218bb84 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -36,6 +36,7 @@
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
 #include "disas/capstone.h"
+#include "target-qmp-commands.h"
=20
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -10293,7 +10294,7 @@ static void ppc_cpu_defs_entry(gpointer data, gpo=
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
index 8b83cc9cf9..52615b9f1b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -424,7 +424,7 @@ static void create_cpu_model_list(ObjectClass *klass,=
 void *opaque)
     *cpu_list =3D entry;
 }
=20
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
     struct CpuDefinitionInfoListData list_data =3D {
         .list =3D NULL,
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index b35bc8e473..642584f26d 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,4 +1,3 @@
-stub-obj-y +=3D arch-query-cpu-def.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
--=20
2.16.0.rc1.1.gef27df75a1
