Received: from eggs.gnu.org ([2001:4830:134:3::10]:57431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Gd-000321-17
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Gc-0005f5-6Y
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6Gc-0005ek-0Z
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:36 +0200
Message-Id: <20170830165252.13421-29-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 28/44] s390x/cpumodel: factor out determination
 of default model name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Now we can drop inclusion of "sysemu/kvm.h" from "s390-virtio.c".

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-7-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio.c    | 7 +------
 target/s390x/cpu.h        | 1 +
 target/s390x/cpu_models.c | 8 ++++++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index afa4148e6b..da3f49e80e 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -33,7 +33,6 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/virtio/virtio.h"
-#include "sysemu/kvm.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
 
@@ -93,11 +92,7 @@ void s390_init_cpus(MachineState *machine)
     gchar *name;
 
     if (machine->cpu_model == NULL) {
-        if (kvm_enabled()) {
-            machine->cpu_model = "host";
-        } else {
-            machine->cpu_model = "qemu";
-        }
+        machine->cpu_model = s390_default_cpu_model_name();
     }
 
     cpu_states = g_new0(S390CPU *, max_cpus);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 798e299db1..3ce7ffc126 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -647,6 +647,7 @@ void s390_cpu_model_register_props(Object *obj);
 void s390_cpu_model_class_register_props(ObjectClass *oc);
 void s390_realize_cpu_model(CPUState *cs, Error **errp);
 ObjectClass *s390_cpu_class_by_name(const char *name);
+const char *s390_default_cpu_model_name(void);
 
 #define EXCP_EXT 1 /* external interrupt */
 #define EXCP_SVC 2 /* supervisor call (syscall) */
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index fa1338fc72..915f067991 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -1200,6 +1200,14 @@ ObjectClass *s390_cpu_class_by_name(const char *name)
     return oc;
 }
 
+const char *s390_default_cpu_model_name(void)
+{
+     if (kvm_enabled()) {
+        return "host";
+     }
+     return "qemu";
+}
+
 static const TypeInfo qemu_s390_cpu_type_info = {
     .name = S390_CPU_TYPE_NAME("qemu"),
     .parent = TYPE_S390_CPU,
-- 
2.13.5
