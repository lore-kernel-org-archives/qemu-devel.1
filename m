Received: from eggs.gnu.org ([2001:4830:134:3::10]:55001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv36-0000f7-8I
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv33-0007UR-PY
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv33-0007Tw-Gh
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 828D95F7BE
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:00 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 021AA5D736
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:31:59 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:31 +0200
Message-Id: <1503592308-93913-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v3 08/25] s390x: replace
 cpu_s390x_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

cpu_s390x_init() is used only *-user targets indirectly
via cpu_init() macro and has a hack to assign ids to created
cpus (I'm not sure if 'id' really matters to *-user emulation).

So to on safe side, instead of having custom wrapper to do numbering
replace it with cpu_generic_init() and use S390CPUClass::next_cpu_id
which could serve the same purpose as static variable and move cpu->id
initialization to s390_cpu_initfn for CONFIG_USER_ONLY use-case.

PS:
ifdef is ugly but it allows us to hide s390x detail that isn't
set by *-user targets and reuse generic cpu creation utility
for btoh machine and user emulation.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
perhaps cpu->id isn't need by CONFIG_USER_ONLY but I'd leave to it
s390x maintainers to deal with it.
---
 target/s390x/cpu.h    |  3 +--
 target/s390x/cpu.c    |  7 +++++++
 target/s390x/helper.c | 14 --------------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 29fdd5d..7891d68 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -474,7 +474,6 @@ static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
     }
 }
 
-S390CPU *cpu_s390x_init(const char *cpu_model);
 S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
 S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp);
 void s390x_translate_init(void);
@@ -638,7 +637,7 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 
 extern void subsystem_reset(void);
 
-#define cpu_init(model) CPU(cpu_s390x_init(model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
 #define cpu_signal_handler cpu_s390x_signal_handler
 
 void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 489bc25..72b0b9e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -303,6 +303,13 @@ static void s390_cpu_initfn(Object *obj)
         inited = true;
         s390x_translate_init();
     }
+
+#if defined(CONFIG_USER_ONLY)
+    {
+        S390CPUClass *scc = S390_CPU_GET_CLASS(obj);
+        cpu->id = scc->next_cpu_id;
+    }
+#endif
 }
 
 static void s390_cpu_finalize(Object *obj)
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 0c989b1..5c23552 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -128,20 +128,6 @@ out:
     return cpu;
 }
 
-S390CPU *cpu_s390x_init(const char *cpu_model)
-{
-    Error *err = NULL;
-    S390CPU *cpu;
-    /* Use to track CPU ID for linux-user only */
-    static int64_t next_cpu_id;
-
-    cpu = s390x_new_cpu(cpu_model, next_cpu_id++, &err);
-    if (err) {
-        error_report_err(err);
-    }
-    return cpu;
-}
-
 #ifndef CONFIG_USER_ONLY
 
 hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
-- 
2.7.4
