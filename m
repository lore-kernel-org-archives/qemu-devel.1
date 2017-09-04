Received: from eggs.gnu.org ([2001:4830:134:3::10]:37828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXi-0004mN-1j
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXd-0001G7-E8
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dotXd-0001FB-7z
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:01 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Sep 2017 17:43:11 +0200
Message-Id: <20170904154316.4148-15-david@redhat.com>
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/19] target/s390x: rename next_cpu_id to
 next_core_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

Adapt to the new term "core_id". While at it, fix the type and drop the
initialization to 0 (which is superfluous).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu-qom.h |  2 +-
 target/s390x/cpu.c     | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index c8fbf8ae03..21ea15e642 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -52,7 +52,7 @@ typedef struct S390CPUClass {
     bool is_migration_safe;
     const char *desc;
 
-    int64_t next_cpu_id;
+    uint32_t next_core_id;
 
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index a2570bbc6b..105ff13034 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -197,7 +197,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #else
     /* implicitly set for linux-user only */
-    cpu->env.core_id = scc->next_cpu_id;
+    cpu->env.core_id = scc->next_core_id;
 #endif
 
     if (cpu_exists(cpu->env.core_id)) {
@@ -205,10 +205,10 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
                    cpu->env.core_id);
         goto out;
     }
-    if (cpu->env.core_id != scc->next_cpu_id) {
+    if (cpu->env.core_id != scc->next_core_id) {
         error_setg(&err, "Unable to add CPU: %" PRIu32
-                   ", the next available nr is %" PRIi64, cpu->env.core_id,
-                   scc->next_cpu_id);
+                   ", the next available id is %" PRIu32, cpu->env.core_id,
+                   scc->next_core_id);
         goto out;
     }
 
@@ -218,7 +218,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     if (err != NULL) {
         goto out;
     }
-    scc->next_cpu_id++;
+    scc->next_core_id++;
 
 #if !defined(CONFIG_USER_ONLY)
     qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
@@ -463,7 +463,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(scc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    scc->next_cpu_id = 0;
     scc->parent_realize = dc->realize;
     dc->realize = s390_cpu_realizefn;
     dc->props = s390x_cpu_properties;
-- 
2.13.5
