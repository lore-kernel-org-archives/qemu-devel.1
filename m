Received: from eggs.gnu.org ([2001:4830:134:3::10]:45185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39W3-0003EJ-CS
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39W0-0004R9-7O
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53060
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d39W0-0004Qx-1e
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PN44Oa079523
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:04:59 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebttxpa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:04:59 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 19:04:58 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 18:04:36 -0500
In-Reply-To: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1493161481-29595-4-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 3/8] qga-win: Fix a bug where qemu-ga service is
 stuck during stop operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sameeh Jubran <sameeh@daynix.com>

From: Sameeh Jubran <sameeh@daynix.com>

After triggering a freeze command without any following thaw command,
qemu-ga will not respond to stop operation. This behaviour is wanted on Linux
as there is no time limit for a freeze command and we want to prevent
quitting in the middle of freeze, on the other hand on Windows the time
limit for freeze is 10 seconds, so we should wait for the timeout, thaw
the file system and quit.

Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c                  | 23 +++++++++++++++++++++++
 qga/vss-win32.h             |  1 +
 qga/vss-win32/vss-common.h  | 11 +----------
 qga/vss-win32/vss-handles.h | 14 ++++++++++++++
 4 files changed, 39 insertions(+), 10 deletions(-)
 create mode 100644 qga/vss-win32/vss-handles.h

diff --git a/qga/main.c b/qga/main.c
index 07c2953..ad6f68f 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -131,9 +131,32 @@ static void quit_handler(int sig)
      * unless all log/pid files are on unfreezable filesystems. there's
      * also a very likely chance killing the agent before unfreezing
      * the filesystems is a mistake (or will be viewed as one later).
+     * On Windows the freeze interval is limited to 10 seconds, so
+     * we should quit, but first we should wait for the timeout, thaw
+     * the filesystem and quit.
      */
     if (ga_is_frozen(ga_state)) {
+#ifdef _WIN32
+        int i = 0;
+        Error *err = NULL;
+        HANDLE hEventTimeout;
+
+        g_debug("Thawing filesystems before exiting");
+
+        hEventTimeout = OpenEvent(EVENT_ALL_ACCESS, FALSE, EVENT_NAME_TIMEOUT);
+        if (hEventTimeout) {
+            WaitForSingleObject(hEventTimeout, 0);
+            CloseHandle(hEventTimeout);
+        }
+        qga_vss_fsfreeze(&i, false, &err);
+        if (err) {
+            g_debug("Error unfreezing filesystems prior to exiting: %s",
+                error_get_pretty(err));
+            error_free(err);
+        }
+#else
         return;
+#endif
     }
     g_debug("received signal num %d, quitting", sig);
 
diff --git a/qga/vss-win32.h b/qga/vss-win32.h
index 51d303a..4f8e39a 100644
--- a/qga/vss-win32.h
+++ b/qga/vss-win32.h
@@ -13,6 +13,7 @@
 #ifndef VSS_WIN32_H
 #define VSS_WIN32_H
 
+#include "qga/vss-win32/vss-handles.h"
 
 bool vss_init(bool init_requester);
 void vss_deinit(bool deinit_requester);
diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
index c81a856..61c170b 100644
--- a/qga/vss-win32/vss-common.h
+++ b/qga/vss-win32/vss-common.h
@@ -51,21 +51,12 @@
  * http://www.microsoft.com/en-us/download/details.aspx?id=23490
  */
 #include <inc/win2003/vss.h>
+#include "vss-handles.h"
 
 /* Macros to convert char definitions to wchar */
 #define _L(a) L##a
 #define L(a) _L(a)
 
-/* Constants for QGA VSS Provider */
-
-#define QGA_PROVIDER_NAME "QEMU Guest Agent VSS Provider"
-#define QGA_PROVIDER_LNAME L(QGA_PROVIDER_NAME)
-#define QGA_PROVIDER_VERSION L(QEMU_VERSION)
-
-#define EVENT_NAME_FROZEN  "Global\\QGAVSSEvent-frozen"
-#define EVENT_NAME_THAW    "Global\\QGAVSSEvent-thaw"
-#define EVENT_NAME_TIMEOUT "Global\\QGAVSSEvent-timeout"
-
 const GUID g_gProviderId = { 0x3629d4ed, 0xee09, 0x4e0e,
     {0x9a, 0x5c, 0x6d, 0x8b, 0xa2, 0x87, 0x2a, 0xef} };
 const GUID g_gProviderVersion = { 0x11ef8b15, 0xcac6, 0x40d6,
diff --git a/qga/vss-win32/vss-handles.h b/qga/vss-win32/vss-handles.h
new file mode 100644
index 0000000..ff399dd
--- /dev/null
+++ b/qga/vss-win32/vss-handles.h
@@ -0,0 +1,14 @@
+#ifndef VSS_HANDLES
+#define VSS_HANDLES
+
+/* Constants for QGA VSS Provider */
+
+#define QGA_PROVIDER_NAME "QEMU Guest Agent VSS Provider"
+#define QGA_PROVIDER_LNAME L(QGA_PROVIDER_NAME)
+#define QGA_PROVIDER_VERSION L(QEMU_VERSION)
+
+#define EVENT_NAME_FROZEN  "Global\\QGAVSSEvent-frozen"
+#define EVENT_NAME_THAW    "Global\\QGAVSSEvent-thaw"
+#define EVENT_NAME_TIMEOUT "Global\\QGAVSSEvent-timeout"
+
+#endif
-- 
2.7.4
