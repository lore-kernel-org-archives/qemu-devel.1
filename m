Received: from eggs.gnu.org ([2001:4830:134:3::10]:47462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt3-0005CJ-L6
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt2-0005TE-MY
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWt2-0005Sp-GM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:00 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92A947F7C8
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:57:00 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:38 +0000
Message-Id: <20170106155543.12827-43-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 42/47] trace: switch qom/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Switch files in the qom/ directory to include the
qom/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs     | 2 +-
 qom/Makefile.objs | 2 ++
 qom/object.c      | 2 +-
 qom/trace-events  | 7 +++++++
 trace-events      | 6 ------
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 5dbbf6c..cfef83b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -160,7 +160,7 @@ trace-events-subdirs += target/i386
 trace-events-subdirs += target/sparc
 trace-events-subdirs += target/s390x
 trace-events-subdirs += target/ppc
-trace-events-y += qom/trace-events
+trace-events-subdirs += qom
 trace-events-y += linux-user/trace-events
 trace-events-y += qapi/trace-events
 
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 516349e..8cc7800 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -1,4 +1,6 @@
 qom-obj-y = object.o container.o qom-qobject.o
 qom-obj-y += object_interfaces.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
 
 common-obj-y = cpu.o
diff --git a/qom/object.c b/qom/object.c
index 7a05e35..4e50fdd 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -20,7 +20,7 @@
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/qmp/qerror.h"
-#include "trace.h"
+#include "qom/trace.h"
 
 /* TODO: replace QObject with a simpler visitor to avoid a dependency
  * of the QOM core on QObject?  */
diff --git a/qom/trace-events b/qom/trace-events
index 97db357..37c43be 100644
--- a/qom/trace-events
+++ b/qom/trace-events
@@ -3,3 +3,10 @@
 # qom/object.c
 object_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
 object_class_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
+
+# qom/cpu.c
+# Reset the state of a virtual (guest) CPU
+#
+# Mode: user, softmmu
+# Targets: all
+vcpu guest_cpu_reset(void)
diff --git a/trace-events b/trace-events
index 1181486..01cd176 100644
--- a/trace-events
+++ b/trace-events
@@ -141,12 +141,6 @@ memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t
 # Targets: all
 vcpu guest_cpu_enter(void)
 
-# Reset the state of a virtual (guest) CPU
-#
-# Mode: user, softmmu
-# Targets: all
-vcpu guest_cpu_reset(void)
-
 # @vaddr: Access' virtual address.
 # @info : Access' information (see below).
 #
-- 
2.9.3
