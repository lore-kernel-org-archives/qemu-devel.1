Received: from eggs.gnu.org ([2001:4830:134:3::10]:48968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7uP-0007qV-W4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7uP-0002uD-4z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:02 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cg7uO-0002tz-Vk
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:01 -0500
Received: by mail-wr0-x242.google.com with SMTP id 89so8078186wrr.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:43:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 11:42:55 +0100
Message-Id: <20170221104256.5153-3-pbonzini@redhat.com>
In-Reply-To: <20170221104256.5153-1-pbonzini@redhat.com>
References: <20170221104256.5153-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] cpu: implement get_crash_info through QOM
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, anton.nefedov@virtuozzo.com, den@openvz.org

Provide a generic implementation for all CPU subclasses.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/cpu.h |  1 -
 qom/cpu.c         | 11 ++++-------
 target/i386/cpu.c |  2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1bc3ad2..04d3a2c 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -158,7 +158,6 @@ typedef struct CPUClass {
                            uint8_t *buf, int len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                        int flags);
-    GuestPanicInformation* (*get_crash_info)(CPUState *cpu);
     void (*dump_statistics)(CPUState *cpu, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
     int64_t (*get_arch_id)(CPUState *cpu);
diff --git a/qom/cpu.c b/qom/cpu.c
index 7e005af..a9482ce 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -22,6 +22,8 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qom/cpu.h"
+#include "qom/qom-qobject.h"
+#include "qapi-visit.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/notify.h"
 #include "qemu/log.h"
@@ -220,13 +222,8 @@ static bool cpu_common_exec_interrupt(CPUState *cpu, int int_req)
 
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-    GuestPanicInformation *res = NULL;
-
-    if (cc->get_crash_info) {
-        res = cc->get_crash_info(cpu);
-    }
-    return res;
+    return OBJECT_PROPERTY_GET_PTR(OBJECT(cpu), "crash-information",
+                                   GuestPanicInformation, NULL);
 }
 
 void cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 63be816..3071769 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3516,6 +3516,7 @@ static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
 
     return panic_info;
 }
+
 static void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
@@ -3731,7 +3732,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = x86_cpu_do_interrupt;
     cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
     cc->dump_state = x86_cpu_dump_state;
-    cc->get_crash_info = x86_cpu_get_crash_info;
     cc->set_pc = x86_cpu_set_pc;
     cc->synchronize_from_tb = x86_cpu_synchronize_from_tb;
     cc->gdb_read_register = x86_cpu_gdb_read_register;
-- 
2.9.3
