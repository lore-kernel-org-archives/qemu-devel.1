Received: from eggs.gnu.org ([2001:4830:134:3::10]:47123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywib-0002GH-16
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiX-0006BL-MD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiX-0006Ay-G4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:49 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:04 +0200
Message-Id: <1506935300-132598-23-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 22/38] xtensa: cleanup cpu type name composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, jcmvbkbc@gmail.com
List-ID: <qemu-devel.nongnu.org>

use new XTENSA_CPU_TYPE_NAME to compose CPU type name
to bring xtensa in line with all other targets that
will similar macro.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: jcmvbkbc@gmail.com
---
 target/xtensa/cpu.h    | 4 ++++
 target/xtensa/cpu.c    | 2 +-
 target/xtensa/helper.c | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 4803331..b17d7d9 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -469,11 +469,15 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #define cpu_signal_handler cpu_xtensa_signal_handler
 #define cpu_list xtensa_cpu_list
 
+#define XTENSA_CPU_TYPE_SUFFIX "-" TYPE_XTENSA_CPU
+#define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
+
 #ifdef TARGET_WORDS_BIGENDIAN
 #define XTENSA_DEFAULT_CPU_MODEL "fsf"
 #else
 #define XTENSA_DEFAULT_CPU_MODEL "dc232b"
 #endif
+#define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index dcdc765..b5f7079 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -83,7 +83,7 @@ static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
     ObjectClass *oc;
     char *typename;
 
-    typename = g_strdup_printf("%s-" TYPE_XTENSA_CPU, cpu_model);
+    typename = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
     if (oc == NULL || !object_class_dynamic_cast(oc, TYPE_XTENSA_CPU) ||
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index e8fba20..216f198 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -76,7 +76,7 @@ void xtensa_register_core(XtensaConfigList *node)
 
     node->next = xtensa_cores;
     xtensa_cores = node;
-    type.name = g_strdup_printf("%s-" TYPE_XTENSA_CPU, node->config->name);
+    type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->config->name);
     type_register(&type);
     g_free((gpointer)type.name);
 }
-- 
2.7.4
