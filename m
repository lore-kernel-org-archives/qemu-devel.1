Received: from eggs.gnu.org ([2001:4830:134:3::10]:40878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnU8-00082h-Bs
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnU3-0002zA-My
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnU3-0002yw-EP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:00 -0300
Message-Id: <20170901150317.10380-13-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/29] s390x: replace cpu_s390x_init() with
 cpu_generic_init()
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
Message-Id: <1504185578-80843-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/s390x/cpu.h    |  3 +--
 target/s390x/cpu.c    |  7 +++++++
 target/s390x/helper.c | 14 --------------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 4ec338077e..0bd97a5670 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -688,8 +688,7 @@ const char *s390_default_cpu_model_name(void);
 
 
 /* helper.c */
-S390CPU *cpu_s390x_init(const char *cpu_model);
-#define cpu_init(model) CPU(cpu_s390x_init(model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
 S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 7267b60d41..74b3e4fd0d 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -306,6 +306,13 @@ static void s390_cpu_initfn(Object *obj)
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
index 3adb9de122..ba29504476 100644
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
 #ifndef CONFIG_USER_ONLY
 
 hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
-- 
2.13.5
