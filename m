Received: from eggs.gnu.org ([209.51.188.92]:51227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gwtTz-0004Z0-Na
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gwtTy-0005Qy-N0
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:54:07 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:34749 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gwtTy-0005N2-Du
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:54:06 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 21 Feb 2019 19:53:37 +0100
Message-Id: <1550775220-26797-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550775220-26797-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550775220-26797-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 5/8] target/mips: implement QMP
 query-cpu-definitions command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch enables QMP-based querying of the available CPU types for
MIPS and MIPS64 platforms.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/target.json     |  4 ++--
 target/mips/helper.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/qapi/target.json b/qapi/target.json
index da7b4be..1d4d54b 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -499,7 +499,7 @@
             'static': 'bool',
             '*unavailable-features': [ 'str' ],
             'typename': 'str' },
-  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X)' }
+  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
=20
 ##
 # @query-cpu-definitions:
@@ -511,4 +511,4 @@
 # Since: 1.2.0
 ##
 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
-  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X)' }
+  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 944f094..c44cdca 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -24,6 +24,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "hw/mips/cpudevs.h"
+#include "qapi/qapi-commands-target.h"
=20
 enum {
     TLBRET_XI =3D -6,
@@ -1470,3 +1471,35 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSS=
tate *env,
=20
     cpu_loop_exit_restore(cs, pc);
 }
+
+static void mips_cpu_add_definition(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc =3D data;
+    CpuDefinitionInfoList **cpu_list =3D user_data;
+    CpuDefinitionInfoList *entry;
+    CpuDefinitionInfo *info;
+    const char *typename;
+
+    typename =3D object_class_get_name(oc);
+    info =3D g_malloc0(sizeof(*info));
+    info->name =3D g_strndup(typename,
+                           strlen(typename) - strlen("-" TYPE_MIPS_CPU))=
;
+    info->q_typename =3D g_strdup(typename);
+
+    entry =3D g_malloc0(sizeof(*entry));
+    entry->value =3D info;
+    entry->next =3D *cpu_list;
+    *cpu_list =3D entry;
+}
+
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    CpuDefinitionInfoList *cpu_list =3D NULL;
+    GSList *list;
+
+    list =3D object_class_get_list(TYPE_MIPS_CPU, false);
+    g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
+    g_slist_free(list);
+
+    return cpu_list;
+}
--=20
2.7.4
