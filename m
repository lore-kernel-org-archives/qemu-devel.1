Received: from eggs.gnu.org ([2001:4830:134:3::10]:55466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Jq-0008U6-7m
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Jp-0007Mv-50
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Jo-0007MC-Ro
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:09 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:54 +0200
Message-Id: <20170822132255.23945-54-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 53/54] qapi: make query-cpu-model-expansion
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json                       |  4 +++-
 include/sysemu/arch_init.h             |  3 ---
 monitor.c                              |  3 ---
 qmp.c                                  |  7 -------
 stubs/arch-query-cpu-model-expansion.c | 12 ------------
 target/i386/cpu.c                      |  2 +-
 target/s390x/cpu_models.c              |  3 ++-
 stubs/Makefile.objs                    |  1 -
 8 files changed, 6 insertions(+), 29 deletions(-)
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c

diff --git a/qapi-schema.json b/qapi-schema.json
index 6c1adb35b5..127a2c71c6 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4535,7 +4535,9 @@
 { 'command': 'query-cpu-model-expansion',
   'data': { 'type': 'CpuModelExpansionType',
             'model': 'CpuModelInfo' },
-  'returns': 'CpuModelExpansionInfo' }
+  'returns': 'CpuModelExpansionInfo',
+  'if': ['defined(NEED_CPU_H)',
+         'defined(TARGET_S390X) || defined(TARGET_I386)']}
=20
 ##
 # @CpuModelCompareResult:
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index e9f1ea0cca..fb3d20a1b8 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -32,8 +32,5 @@ int kvm_available(void);
 int xen_available(void);
=20
 CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp);
-CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionT=
ype type,
-                                                      CpuModelInfo *mode=
,
-                                                      Error **errp);
=20
 #endif
diff --git a/monitor.c b/monitor.c
index 6ddc3c7ff7..ca67a584d2 100644
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
index ddc45abd70..d683e70a13 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2574,7 +2574,7 @@ out:
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
index cdff9cdd3b..863dce064f 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -22,6 +22,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/arch_init.h"
 #endif
+#include "qmp-commands.h"
=20
 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc)=
 \
     {                                                                   =
 \
@@ -520,7 +521,7 @@ static void cpu_info_from_model(CpuModelInfo *info, c=
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
index 1421824eb3..eb17628ede 100644
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
