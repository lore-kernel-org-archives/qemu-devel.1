Received: from eggs.gnu.org ([2001:4830:134:3::10]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFd-0007Kf-Mw
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFc-0003uO-R3
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48126 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFc-0003to-Gz
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DD25402315B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:55 +0200
Message-Id: <20180717113402.5510-19-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 18/25] check: Only test pvpanic when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

There was not possible to compile out pvpanic.  Use the same trick
that applesmc.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/misc/pvpanic.c         | 11 -----------
 include/hw/misc/pvpanic.h | 11 ++++++++++-
 tests/Makefile.include    |  4 ++--
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index b26250dec9..9d8961ba0c 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -99,17 +99,6 @@ static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
     isa_register_ioport(d, &s->io, s->ioport);
 }
 
-#define PVPANIC_IOPORT_PROP "ioport"
-
-uint16_t pvpanic_port(void)
-{
-    Object *o = object_resolve_path_type("", TYPE_PVPANIC, NULL);
-    if (!o) {
-        return 0;
-    }
-    return object_property_get_uint(o, PVPANIC_IOPORT_PROP, NULL);
-}
-
 static Property pvpanic_isa_properties[] = {
     DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicState, ioport, 0x505),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 36a54e270c..1ee071a703 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -16,6 +16,15 @@
 
 #define TYPE_PVPANIC "pvpanic"
 
-uint16_t pvpanic_port(void);
+#define PVPANIC_IOPORT_PROP "ioport"
+
+static inline uint16_t pvpanic_port(void)
+{
+    Object *o = object_resolve_path_type("", TYPE_PVPANIC, NULL);
+    if (!o) {
+        return 0;
+    }
+    return object_property_get_uint(o, PVPANIC_IOPORT_PROP, NULL);
+}
 
 #endif
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f635517a68..31d124ee44 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -274,8 +274,8 @@ check-qtest-i386-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
 gcov-files-i386-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
 gcov-files-i386-y += hw/net/net_rx_pkt.c
 gcov-files-i386-y += hw/net/net_tx_pkt.c
-check-qtest-i386-y += tests/pvpanic-test$(EXESUF)
-gcov-files-i386-y += i386-softmmu/hw/misc/pvpanic.c
+check-qtest-i386-$(CONFIG_PVPANIC) += tests/pvpanic-test$(EXESUF)
+gcov-files-i386-$(CONFIG_PVPANIC) += i386-softmmu/hw/misc/pvpanic.c
 check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
 gcov-files-i386-$(CONFIG_I82801B11) += hw/pci-bridge/i82801b11.c
 check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
-- 
2.17.1
