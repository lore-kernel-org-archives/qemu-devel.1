Received: from eggs.gnu.org ([2001:4830:134:3::10]:36529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewm1g-0006YV-L6
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewm1d-00049r-J5
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:51:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40713 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ewm1d-000498-Ec
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:51:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 16 Mar 2018 10:51:29 +0100
Message-Id: <1521193892-15552-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1521193892-15552-1-git-send-email-thuth@redhat.com>
References: <1521193892-15552-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] hw/net/can: Fix segfaults when using the
 devices without bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Eduardo Habkost <ehabkost@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The CAN devices can currently be used to crash QEMU, e.g.:

$ x86_64-softmmu/qemu-system-x86_64 -device kvaser_pci
Segmentation fault (core dumped)

So we've got to add a proper check here that the corresponding
bus is available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/can/can_sja1000.c  | 4 ++++
 scripts/device-crash-test | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 6293233..9a85038 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -866,6 +866,10 @@ int can_sja_connect_to_bus(CanSJA1000State *s, CanBusState *bus)
 {
     s->bus_client.info = &can_sja_bus_client_info;
 
+    if (!bus) {
+        return -EINVAL;
+    }
+
     if (can_bus_insert_client(bus, &s->bus_client) < 0) {
         return -1;
     }
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index f04f349..7ff351d 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -223,9 +223,6 @@ ERROR_WHITELIST = [
     {'exitcode':-11, 'device':'sb16', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'cs4231a', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'mioe3680_pci', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'pcm3680_pci', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'kvaser_pci', 'loglevel':logging.ERROR, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
-- 
1.8.3.1
