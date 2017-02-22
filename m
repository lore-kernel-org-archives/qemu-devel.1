Received: from eggs.gnu.org ([2001:4830:134:3::10]:49930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgbHK-00028X-Cz
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgbHJ-0006Ew-ET
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:04:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgbHJ-0006EW-8s
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:04:37 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 604DA6AAEB
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:04:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 Feb 2017 19:04:22 +0100
Message-Id: <20170222180423.26571-3-pbonzini@redhat.com>
In-Reply-To: <20170222180423.26571-1-pbonzini@redhat.com>
References: <20170222180423.26571-1-pbonzini@redhat.com>
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
Cc: eblake@redhat.com, marcandre.lureau@redhat.com

Provide a generic implementation for all CPU subclasses.

Reviewed-by: Eric Blake <eblake@redhat.com>
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
