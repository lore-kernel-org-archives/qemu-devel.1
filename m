Received: from eggs.gnu.org ([2001:4830:134:3::10]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPR-0006Pu-VP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPR-0007tK-86
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPR-0007mN-1T
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:09 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:42 +0100
Message-Id: <20180420145249.32435-7-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 06/13] vl.c: Provide accessor function
 serial_hd() for serial_hds[] array
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

Provide an accessor function serial_hd() to return the Chardev
(if any) associated with the numbered serial port. This will
be used to replace direct accesses to the serial_hds[] array,
so that calling code doesn't need to care about the size of
that array.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/sysemu.h | 3 +++
 vl.c                    | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 2b42151c63..bd5b55c514 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -163,6 +163,9 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
 
 extern Chardev *serial_hds[MAX_SERIAL_PORTS];
 
+/* Return the Chardev for serial port i, or NULL if none */
+Chardev *serial_hd(int i);
+
 /* parallel ports */
 
 #define MAX_PARALLEL_PORTS 3
diff --git a/vl.c b/vl.c
index fce1fd12d8..6daf026da6 100644
--- a/vl.c
+++ b/vl.c
@@ -2516,6 +2516,15 @@ static int serial_parse(const char *devname)
     return 0;
 }
 
+Chardev *serial_hd(int i)
+{
+    assert(i >= 0);
+    if (i < ARRAY_SIZE(serial_hds)) {
+        return serial_hds[i];
+    }
+    return NULL;
+}
+
 static int parallel_parse(const char *devname)
 {
     static int index = 0;
-- 
2.17.0
