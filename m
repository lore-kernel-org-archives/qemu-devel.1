Received: from eggs.gnu.org ([2001:4830:134:3::10]:38542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJF-0003Gu-6f
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJA-0003Zt-78
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55242
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7tJA-0003YL-1v
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9R1JGVU114607
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:33 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dunngw94f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:32 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 21:19:31 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 20:18:47 -0500
In-Reply-To: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
References: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171027011849.29195-3-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 2/4] qga-win: Updating guest_set_time action
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Bishara AbuHattoum <bishara@daynix.com>

From: Bishara AbuHattoum <bishara@daynix.com>

  At the moment, Windows libraries don't provide a way to access
  RTC, so, a workaround is to use the Windows w32tm command to
  resync the time.
  Related bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1183874

Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
Reviewed-by: Sameeh Jubran <sameeh@daynix.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 configure            |  2 +-
 qga/commands-win32.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 03547cea6a..325b08056c 100755
--- a/configure
+++ b/configure
@@ -827,7 +827,7 @@ if test "$mingw32" = "yes" ; then
   sysconfdir="\${prefix}"
   local_statedir=
   confsuffix=""
-  libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -liphlpapi -lnetapi32 $libs_qga"
+  libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32 $libs_qga"
 fi
 
 werror=""
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 619dbd2bc2..fbd7eb7bbb 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -29,6 +29,7 @@
 #endif
 #include <lm.h>
 #include <wtsapi32.h>
+#include <wininet.h>
 
 #include "qga/guest-agent-core.h"
 #include "qga/vss-win32.h"
@@ -1277,8 +1278,41 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
          * RTC yet:
          *
          * https://msdn.microsoft.com/en-us/library/aa908981.aspx
+         *
+         * Instead, a workaround is to use the Windows win32tm command to
+         * resync the time using the Windows Time service.
          */
-        error_setg(errp, "Time argument is required on this platform");
+        LPVOID msg_buffer;
+        DWORD ret_flags;
+
+        HRESULT hr = system("w32tm /resync /nowait");
+
+        if (GetLastError() != 0) {
+            strerror_s((LPTSTR) & msg_buffer, 0, errno);
+            error_setg(errp, "system(...) failed: %s", (LPCTSTR)msg_buffer);
+        } else if (hr != 0) {
+            if (hr == HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)) {
+                error_setg(errp, "Windows Time service not running on the "
+                                 "guest");
+            } else {
+                if (!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
+                                   FORMAT_MESSAGE_FROM_SYSTEM |
+                                   FORMAT_MESSAGE_IGNORE_INSERTS, NULL,
+                                   (DWORD)hr, MAKELANGID(LANG_NEUTRAL,
+                                   SUBLANG_DEFAULT), (LPTSTR) & msg_buffer, 0,
+                                   NULL)) {
+                    error_setg(errp, "w32tm failed with error (0x%lx), couldn'"
+                                     "t retrieve error message", hr);
+                } else {
+                    error_setg(errp, "w32tm failed with error (0x%lx): %s", hr,
+                               (LPCTSTR)msg_buffer);
+                    LocalFree(msg_buffer);
+                }
+            }
+        } else if (!InternetGetConnectedState(&ret_flags, 0)) {
+            error_setg(errp, "No internet connection on guest, sync not "
+                             "accurate");
+        }
         return;
     }
 
-- 
2.11.0
