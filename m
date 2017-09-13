Received: from eggs.gnu.org ([2001:4830:134:3::10]:34013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cL-0001UO-Mt
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cK-0007US-Oz
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:57 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:36816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1ds3cK-0007U6-La
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:56 -0400
Received: by mail-vk0-x242.google.com with SMTP id x85so3322425vkx.3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 02:05:56 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Wed, 13 Sep 2017 04:05:15 -0500
Message-Id: <20170913090522.4022-8-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
References: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH v4 07/14] apic: add function to apic that will
 be used by hvf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@gmail.com, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This patch adds the function apic_get_highest_priority_irr to
apic.c and exports it through the interface in apic.h for use by hvf.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 hw/intc/apic.c         | 12 ++++++++++++
 include/hw/i386/apic.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index fe15fb6024..6fda52b86c 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -305,6 +305,18 @@ static void apic_set_tpr(APICCommonState *s, uint8_t val)
     }
 }
 
+int apic_get_highest_priority_irr(DeviceState *dev)
+{
+    APICCommonState *s;
+
+    if (!dev) {
+        /* no interrupts */
+        return -1;
+    }
+    s = APIC_COMMON(dev);
+    return get_highest_priority_int(s->irr);
+}
+
 static uint8_t apic_get_tpr(APICCommonState *s)
 {
     apic_sync_vapic(s, SYNC_FROM_VAPIC);
diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index ea48ea9389..a9f6c0aa33 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -20,6 +20,7 @@ void apic_init_reset(DeviceState *s);
 void apic_sipi(DeviceState *s);
 void apic_poll_irq(DeviceState *d);
 void apic_designate_bsp(DeviceState *d, bool bsp);
+int apic_get_highest_priority_irr(DeviceState *dev);
 
 /* pc.c */
 DeviceState *cpu_get_current_apic(void);
-- 
2.14.1
