Received: from eggs.gnu.org ([2001:4830:134:3::10]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPM-0006KW-VP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPL-0007qY-Vc
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:05 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPL-0007mN-GY
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:03 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:48 +0100
Message-Id: <20180420145249.32435-13-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 12/13] vl.c: Remove compile time limit on
 number of serial ports
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

Instead of having a fixed sized global serial_hds[] array,
use a local dynamically reallocated one, so we don't have
a compile time limit on how many serial ports a system has.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/sysemu.h |  2 --
 vl.c                    | 15 +++++++--------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index bd5b55c514..989cbc2b7b 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -161,8 +161,6 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
 
 #define MAX_SERIAL_PORTS 4
 
-extern Chardev *serial_hds[MAX_SERIAL_PORTS];
-
 /* Return the Chardev for serial port i, or NULL if none */
 Chardev *serial_hd(int i);
 
diff --git a/vl.c b/vl.c
index 6daf026da6..a8a98c5a37 100644
--- a/vl.c
+++ b/vl.c
@@ -154,7 +154,8 @@ QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static DisplayOptions dpy;
 int no_frame;
-Chardev *serial_hds[MAX_SERIAL_PORTS];
+static int num_serial_hds = 0;
+static Chardev **serial_hds = NULL;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
 Chardev *sclp_hds[MAX_SCLP_CONSOLES];
@@ -2496,30 +2497,28 @@ static int foreach_device_config(int type, int (*func)(const char *cmdline))
 
 static int serial_parse(const char *devname)
 {
-    static int index = 0;
+    int index = num_serial_hds;
     char label[32];
 
     if (strcmp(devname, "none") == 0)
         return 0;
-    if (index == MAX_SERIAL_PORTS) {
-        error_report("too many serial ports");
-        exit(1);
-    }
     snprintf(label, sizeof(label), "serial%d", index);
+    serial_hds = g_renew(Chardev *, serial_hds, index + 1);
+
     serial_hds[index] = qemu_chr_new(label, devname);
     if (!serial_hds[index]) {
         error_report("could not connect serial device"
                      " to character backend '%s'", devname);
         return -1;
     }
-    index++;
+    num_serial_hds++;
     return 0;
 }
 
 Chardev *serial_hd(int i)
 {
     assert(i >= 0);
-    if (i < ARRAY_SIZE(serial_hds)) {
+    if (i < num_serial_hds) {
         return serial_hds[i];
     }
     return NULL;
-- 
2.17.0
