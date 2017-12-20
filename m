Received: from eggs.gnu.org ([2001:4830:134:3::10]:47188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRiiq-0004B4-Ji
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRiin-0002Kb-UG
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRiin-0002KI-Ol
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:01 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:40 +0100
Message-Id: <20171220180358.29316-2-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/19] apic: add function to apic that will be
 used by hvf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

This patch adds the function apic_get_highest_priority_irr to
apic.c and exports it through the interface in apic.h for use by hvf.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Message-Id: <20170913090522.4022-8-Sergio.G.DelReal@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.14.3
