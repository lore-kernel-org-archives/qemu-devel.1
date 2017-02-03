Received: from eggs.gnu.org ([2001:4830:134:3::10]:50268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY8f-0006jT-Bg
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY8e-000775-Jv
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cZY8e-00076t-E9
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:32 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  3 Feb 2017 15:18:17 +0800
Message-Id: <1486106298-3699-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1486106298-3699-1-git-send-email-peterx@redhat.com>
References: <1486106298-3699-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] ioapic: fix error report value of def
 version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>

It should be 0x20, rather than 0x11.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/ioapic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 9047b89..37c4386 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -408,13 +408,15 @@ static void ioapic_machine_done_notify(Notifier *notifier, void *data)
 #endif
 }
 
+#define IOAPIC_VER_DEF 0x20
+
 static void ioapic_realize(DeviceState *dev, Error **errp)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
 
     if (s->version != 0x11 && s->version != 0x20) {
         error_report("IOAPIC only supports version 0x11 or 0x20 "
-                     "(default: 0x11).");
+                     "(default: 0x%x).", IOAPIC_VER_DEF);
         exit(1);
     }
 
@@ -429,7 +431,7 @@ static void ioapic_realize(DeviceState *dev, Error **errp)
 }
 
 static Property ioapic_properties[] = {
-    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, 0x20),
+    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.7.4
