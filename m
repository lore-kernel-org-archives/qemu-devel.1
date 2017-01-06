Received: from eggs.gnu.org ([2001:4830:134:3::10]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsa-0004J0-Nn
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsZ-00058U-Se
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsZ-000586-NC
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:31 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6587C050917
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:31 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:20 +0000
Message-Id: <20170106155543.12827-25-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 24/47] trace: switch hw/mem/ directory to
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

Switch files in the hw/mem/ directory to include the
hw/mem/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs        | 2 +-
 hw/mem/Makefile.objs | 3 +++
 hw/mem/pc-dimm.c     | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index a901f5d..89953e5 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -142,7 +142,7 @@ trace-events-subdirs += hw/dma
 trace-events-subdirs += hw/sparc
 trace-events-subdirs += hw/sd
 trace-events-subdirs += hw/isa
-trace-events-y += hw/mem/trace-events
+trace-events-subdirs += hw/mem
 trace-events-y += hw/i386/trace-events
 trace-events-y += hw/9pfs/trace-events
 trace-events-y += hw/ppc/trace-events
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
index f12f8b9..ae1f513 100644
--- a/hw/mem/Makefile.objs
+++ b/hw/mem/Makefile.objs
@@ -1,2 +1,5 @@
 common-obj-$(CONFIG_MEM_HOTPLUG) += pc-dimm.o
 common-obj-$(CONFIG_NVDIMM) += nvdimm.o
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9e8dab0..bcbaa32 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -26,7 +26,7 @@
 #include "qemu/range.h"
 #include "sysemu/numa.h"
 #include "sysemu/kvm.h"
-#include "trace.h"
+#include "hw/mem/trace.h"
 #include "hw/virtio/vhost.h"
 
 typedef struct pc_dimms_capacity {
-- 
2.9.3
