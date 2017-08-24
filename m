Received: from eggs.gnu.org ([2001:4830:134:3::10]:55007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv36-0000fL-Di
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv35-0007VA-8a
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv35-0007Uj-29
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1988A8B137
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:02 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 941224139
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:33 +0200
Message-Id: <1503592308-93913-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v3 10/25] hppa: replace
 cpu_hppa_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

drop custom cpu_hppa_init() in favor of cpu_generic_init(),
to make cpu_generic_init() work all we need is to provide
cc->class_by_name callback that would resolve any cpu_model
to the sole TYPE_HPPA_CPU to match current behaviour.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Richard Henderson <rth@twiddle.net>
---

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
