Received: from eggs.gnu.org ([2001:4830:134:3::10]:41259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNd-0005AI-Bk
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005lP-Ei
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNY-0005jH-Vu
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FCC630D47CB
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:03 +0200
Message-Id: <20181008173125.19678-10-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 09/31] ioapic: Fix error handling in realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  ioapic_realize() does that, and then exit()s.
Currently mostly harmless, as the device cannot be hot-plugged.

Fixes: 20fd4b7b6d9282fe0cb83601f1821f31bd257458
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/intc/ioapic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index b6896ac4ce..4e529729b4 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -21,7 +21,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
@@ -393,9 +393,9 @@ static void ioapic_realize(DeviceState *dev, Error **errp)
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
 
     if (s->version != 0x11 && s->version != 0x20) {
-        error_report("IOAPIC only supports version 0x11 or 0x20 "
-                     "(default: 0x%x).", IOAPIC_VER_DEF);
-        exit(1);
+        error_setg(errp, "IOAPIC only supports version 0x11 or 0x20 "
+                   "(default: 0x%x).", IOAPIC_VER_DEF);
+        return;
     }
 
     memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
-- 
2.17.1
