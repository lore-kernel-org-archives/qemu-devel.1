Received: from eggs.gnu.org ([2001:4830:134:3::10]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6Rs-0005p3-IJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6Rr-0002V8-MH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dn6Rr-0002Ut-DT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:39 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Aug 2017 19:05:57 +0200
Message-Id: <20170830170601.15855-8-david@redhat.com>
In-Reply-To: <20170830170601.15855-1-david@redhat.com>
References: <20170830170601.15855-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 07/11] target/s390x: rename next_cpu_id to
 next_cpu_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

Adapt the term address/adddr. While at it, fix the type and drop the
initialization to 0 (which is superfluous).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu-qom.h | 2 +-
 target/s390x/cpu.c     | 9 ++++-----
 target/s390x/helper.c  | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index 4e936e7788..a3a3ada226 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -52,7 +52,7 @@ typedef struct S390CPUClass {
     bool is_migration_safe;
     const char *desc;
 
-    int64_t next_cpu_id;
+    uint32_t next_cpu_addr;
 
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 156589e921..ffc1ff9a2b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -201,10 +201,10 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
                    cpu->env.cpu_addr);
         goto out;
     }
-    if (cpu->env.cpu_addr != scc->next_cpu_id) {
+    if (cpu->env.cpu_addr != scc->next_cpu_addr) {
         error_setg(&err, "Unable to add CPU: %" PRIu32
-                   ", the next available nr is %" PRIi64, cpu->env.cpu_addr,
-                   scc->next_cpu_id);
+                   ", the next available addr is %" PRIu32, cpu->env.cpu_addr,
+                   scc->next_cpu_addr);
         goto out;
     }
 
@@ -214,7 +214,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     if (err != NULL) {
         goto out;
     }
-    scc->next_cpu_id++;
+    scc->next_cpu_addr++;
 
 #if !defined(CONFIG_USER_ONLY)
     qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
@@ -459,7 +459,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(scc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    scc->next_cpu_id = 0;
     scc->parent_realize = dc->realize;
     dc->realize = s390_cpu_realizefn;
     dc->props = s390x_cpu_properties;
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 70d1ea8cf6..d8f198cf6f 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -134,9 +134,9 @@ S390CPU *cpu_s390x_init(const char *cpu_model)
     Error *err = NULL;
     S390CPU *cpu;
     /* Use to track CPU ID for linux-user only */
-    static int64_t next_cpu_id;
+    static uint32_t next_cpu_addr;
 
-    cpu = s390x_new_cpu(cpu_model, next_cpu_id++, &err);
+    cpu = s390x_new_cpu(cpu_model, next_cpu_addr++, &err);
     if (err) {
         error_report_err(err);
     }
-- 
2.13.5
