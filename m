Received: from eggs.gnu.org ([2001:4830:134:3::10]:44410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7inJ-0004oe-9D
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7inD-00008R-9g
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7inD-00007K-3E
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:46 +0200
Message-Id: <20171026140404.21948-22-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/39] xtensa: cleanup cpu type name composition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

use new XTENSA_CPU_TYPE_NAME to compose CPU type name
to bring xtensa in line with all other targets that
will similar macro.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-25-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/xtensa/cpu.h    | 4 ++++
 target/xtensa/cpu.c    | 2 +-
 target/xtensa/helper.c | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 48033313c5..b17d7d96e9 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -469,11 +469,15 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, =
vaddr addr,
 #define cpu_signal_handler cpu_xtensa_signal_handler
 #define cpu_list xtensa_cpu_list
=20
+#define XTENSA_CPU_TYPE_SUFFIX "-" TYPE_XTENSA_CPU
+#define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
+
 #ifdef TARGET_WORDS_BIGENDIAN
 #define XTENSA_DEFAULT_CPU_MODEL "fsf"
 #else
 #define XTENSA_DEFAULT_CPU_MODEL "dc232b"
 #endif
+#define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_=
MODEL)
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
=20
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a5651e5dab..91961789a5 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -83,7 +83,7 @@ static ObjectClass *xtensa_cpu_class_by_name(const char=
 *cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    typename =3D g_strdup_printf("%s-" TYPE_XTENSA_CPU, cpu_model);
+    typename =3D g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
     if (oc =3D=3D NULL || !object_class_dynamic_cast(oc, TYPE_XTENSA_CPU=
) ||
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index e8fba20918..216f1988aa 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -76,7 +76,7 @@ void xtensa_register_core(XtensaConfigList *node)
=20
     node->next =3D xtensa_cores;
     xtensa_cores =3D node;
-    type.name =3D g_strdup_printf("%s-" TYPE_XTENSA_CPU, node->config->n=
ame);
+    type.name =3D g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->conf=
ig->name);
     type_register(&type);
     g_free((gpointer)type.name);
 }
--=20
2.13.6
