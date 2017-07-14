Received: from eggs.gnu.org ([2001:4830:134:3::10]:41404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12F-00024B-BI
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12E-0001ld-K4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12E-0001ki-Ep
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:34 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:04 +0200
Message-Id: <1500040339-119465-14-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 13/28] hppa: replace cpu_hppa_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>

drop custom cpu_hppa_init() in favor of cpu_generic_init(),
to make cpu_generic_init() work all we need is to provide
cc->class_by_name callback that would resolve any cpu_model
to the sole TYPE_HPPA_CPU to match current behaviour.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <rth@twiddle.net>

tested with linux-user
---
 target/hppa/cpu.h |  4 +---
 target/hppa/cpu.c | 11 +++--------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 4cf4ac6..8d14077 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -112,9 +112,7 @@ static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 
 void hppa_translate_init(void);
 
-HPPACPU *cpu_hppa_init(const char *cpu_model);
-
-#define cpu_init(cpu_model) CPU(cpu_hppa_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_HPPA_CPU, cpu_model)
 
 void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 30299e9..a477b45 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -112,15 +112,9 @@ static void hppa_cpu_initfn(Object *obj)
     hppa_translate_init();
 }
 
-HPPACPU *cpu_hppa_init(const char *cpu_model)
+static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 {
-    HPPACPU *cpu;
-
-    cpu = HPPA_CPU(object_new(TYPE_HPPA_CPU));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
+    return object_class_by_name(TYPE_HPPA_CPU);
 }
 
 static void hppa_cpu_class_init(ObjectClass *oc, void *data)
@@ -132,6 +126,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     acc->parent_realize = dc->realize;
     dc->realize = hppa_cpu_realizefn;
 
+    cc->class_by_name = hppa_cpu_class_by_name;
     cc->do_interrupt = hppa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt;
     cc->dump_state = hppa_cpu_dump_state;
-- 
2.7.4
