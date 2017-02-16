Received: from eggs.gnu.org ([2001:4830:134:3::10]:51689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6J-0003W1-Fh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6I-00080I-NL
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:03 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6I-0007z6-HK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:02 -0500
Received: by mail-wr0-x242.google.com with SMTP id q39so2263414wrb.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:26 +0100
Message-Id: <1487255507-106654-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/23] ioapic: fix error report value of def
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
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

It should be 0x20, rather than 0x11.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1486106298-3699-3-git-send-email-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
