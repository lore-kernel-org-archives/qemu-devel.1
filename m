Received: from eggs.gnu.org ([2001:4830:134:3::10]:41369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12A-0001xp-Bu
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW126-0001fp-FV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW126-0001ek-6H
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:26 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:02 +0200
Message-Id: <1500040339-119465-12-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 11/28] s390x: replace cpu_s390x_init() with
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

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
---
perhaps cpu->id isn't need by CONFIG_USER_ONLY but I'd leave to it
s390x maintainers to deal with it.

CC: Richard Henderson <rth@twiddle.net>
CC: Alexander Graf <agraf@suse.de>
CC: Cornelia Huck <cohuck@redhat.com>
CC: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu.h    |  3 +--
 target/s390x/cpu.c    |  7 +++++++
 target/s390x/helper.c | 14 --------------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index bdb9bdb..b6d25c6 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -477,7 +477,6 @@ static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
 #endif
 
-S390CPU *cpu_s390x_init(const char *cpu_model);
 S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
 S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp);
 void s390x_translate_init(void);
@@ -641,7 +640,7 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 
 extern void subsystem_reset(void);
 
-#define cpu_init(model) CPU(cpu_s390x_init(model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
 #define cpu_signal_handler cpu_s390x_signal_handler
 
 void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index accef03..e40a26f 100644
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
index aef09e1..632b030 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -129,20 +129,6 @@ out:
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
 #if defined(CONFIG_USER_ONLY)
 
 void s390_cpu_do_interrupt(CPUState *cs)
-- 
2.7.4
