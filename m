Received: from eggs.gnu.org ([2001:4830:134:3::10]:47304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsm-0004ky-BT
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsl-0005Fo-Gt
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsl-0005FG-Bl
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:43 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68D3581252
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:43 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:27 +0000
Message-Id: <20170106155543.12827-32-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 31/47] trace: switch hw/acpi/ directory to
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

Switch files in the hw/acpi/ directory to include the
hw/acpi/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs            | 2 +-
 hw/acpi/Makefile.objs    | 2 ++
 hw/acpi/cpu.c            | 2 +-
 hw/acpi/memory_hotplug.c | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index cea70ce..86c62cd 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -149,7 +149,7 @@ trace-events-subdirs += hw/ppc
 trace-events-subdirs += hw/pci
 trace-events-subdirs += hw/s390x
 trace-events-subdirs += hw/vfio
-trace-events-y += hw/acpi/trace-events
+trace-events-subdirs += hw/acpi
 trace-events-y += hw/arm/trace-events
 trace-events-y += hw/alpha/trace-events
 trace-events-y += ui/trace-events
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 489e63b..abdc809 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -8,3 +8,5 @@ common-obj-$(CONFIG_ACPI) += acpi_interface.o
 common-obj-$(CONFIG_ACPI) += bios-linker-loader.o
 common-obj-$(CONFIG_ACPI) += aml-build.o
 common-obj-$(call land,$(CONFIG_ACPI),$(CONFIG_IPMI)) += ipmi.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5ac89fe..68e1c0f 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -3,7 +3,7 @@
 #include "hw/acpi/cpu.h"
 #include "qapi/error.h"
 #include "qapi-event.h"
-#include "trace.h"
+#include "hw/acpi/trace.h"
 #include "sysemu/numa.h"
 
 #define ACPI_CPU_HOTPLUG_REG_LEN 12
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index ec4e64b..e442970 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -4,7 +4,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
-#include "trace.h"
+#include "hw/acpi/trace.h"
 #include "qapi-event.h"
 
 static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
-- 
2.9.3
