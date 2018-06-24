Received: from eggs.gnu.org ([2001:4830:134:3::10]:35117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fX4Ov-0004cv-AN
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 08:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fX4Oq-0003JU-FB
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 08:45:53 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fX4Oq-0003JL-77
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 08:45:48 -0400
Received: by mail-wr0-x241.google.com with SMTP id l14-v6so5820286wrq.13
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 05:45:47 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 24 Jun 2018 15:45:40 +0300
Message-Id: <20180624124540.6659-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH] qga-win: Handle fstrim for OSes lower than Win8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Sameeh Jubran <sjubran@redhat.com>

The defrag.exe tool which is used for executing the fstrim command
on Windows doesn't support retrim for OSes lower than Win8. This
commit handles this case and returns a suitable error.

Output of fstrim before this commit:
{"execute":"guest-fstrim"}
{"return": {"paths": [{"path": "C:\\", "error": "An invalid command line option
was specified. (0x89000008)"}, {"path": "F:\\", "error": "An invalid command
line option was specified. (0x89000008)"}, {"path": "S:\\", "error": "An
invalid command line option was specified. (0x89000008)"}]}}

Reported on:
https://bugzilla.redhat.com/show_bug.cgi?id=1594113

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 qga/commands-win32.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d79974f212..0bdcd9dd38 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -30,6 +30,7 @@
 #include <lm.h>
 #include <wtsapi32.h>
 #include <wininet.h>
+#include <versionhelpers.h>
 
 #include "qga/guest-agent-core.h"
 #include "qga/vss-win32.h"
@@ -852,6 +853,11 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
     HANDLE handle;
     WCHAR guid[MAX_PATH] = L"";
 
+   if (!IsWindows8OrGreater()) {
+        error_setg(errp, "fstrim is only supported for Win8+");
+        return NULL;
+   }
+
     handle = FindFirstVolumeW(guid, ARRAYSIZE(guid));
     if (handle == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to find any volume");
-- 
2.13.6
