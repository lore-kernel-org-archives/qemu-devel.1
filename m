Received: from eggs.gnu.org ([2001:4830:134:3::10]:43345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPL-0006Jh-Hu
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPK-0007pY-Ps
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:03 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPK-0007mN-Iy
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:02 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:49 +0100
Message-Id: <20180420145249.32435-14-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 13/13] vl.c: new function max_serial_hds()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Create a new function max_serial_hds() which returns the number of
serial ports defined by the user. This is needed only by spapr.

This allows us to remove the MAX_SERIAL_PORTS define.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/sysemu.h | 6 ++++--
 hw/ppc/spapr.c          | 2 +-
 vl.c                    | 5 +++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 989cbc2b7b..612659a718 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -159,10 +159,12 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
 
 /* serial ports */
 
-#define MAX_SERIAL_PORTS 4
-
 /* Return the Chardev for serial port i, or NULL if none */
 Chardev *serial_hd(int i);
+/* return the number of serial ports defined by the user. serial_hd(i)
+ * will always return NULL for any i which is greater than or equal to this.
+ */
+int max_serial_hds(void);
 
 /* parallel ports */
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b0ecfaca9e..8d2d36a606 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2589,7 +2589,7 @@ static void spapr_machine_init(MachineState *machine)
     /* Set up VIO bus */
     spapr->vio_bus = spapr_vio_bus_init();
 
-    for (i = 0; i < MAX_SERIAL_PORTS; i++) {
+    for (i = 0; i < max_serial_hds(); i++) {
         if (serial_hd(i)) {
             spapr_vty_create(spapr->vio_bus, serial_hd(i));
         }
diff --git a/vl.c b/vl.c
index a8a98c5a37..b587187052 100644
--- a/vl.c
+++ b/vl.c
@@ -2524,6 +2524,11 @@ Chardev *serial_hd(int i)
     return NULL;
 }
 
+int max_serial_hds(void)
+{
+    return num_serial_hds;
+}
+
 static int parallel_parse(const char *devname)
 {
     static int index = 0;
-- 
2.17.0
