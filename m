Received: from eggs.gnu.org ([2001:4830:134:3::10]:60104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkr7-0002RM-UL
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkr4-0005B5-Pf
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:09 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fhkr4-0005Ar-KD
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:06 -0400
Received: by mail-oi0-x244.google.com with SMTP id s198-v6so4378267oih.11
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 17:07:06 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 19:01:25 -0500
Message-Id: <20180724000126.21787-2-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180724000126.21787-1-mdroth@linux.vnet.ibm.com>
References: <20180724000126.21787-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL for-3.0 1/2] qga-win: Handle fstrim for OSes
 lower than Win8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sameeh Jubran <sjubran@redhat.com>

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
* use alternative version query code proposed by Sameeh
* fix up version check logic
* avoid CamelCase variable names when possible
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 318d760a74..98d9735389 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -865,6 +865,19 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
     GuestFilesystemTrimResponse *resp;
     HANDLE handle;
     WCHAR guid[MAX_PATH] = L"";
+    OSVERSIONINFO osvi;
+    BOOL win8_or_later;
+
+    ZeroMemory(&osvi, sizeof(OSVERSIONINFO));
+    osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
+    GetVersionEx(&osvi);
+    win8_or_later = (osvi.dwMajorVersion > 6 ||
+                          ((osvi.dwMajorVersion == 6) &&
+                           (osvi.dwMinorVersion >= 2)));
+    if (!win8_or_later) {
+        error_setg(errp, "fstrim is only supported for Win8+");
+        return NULL;
+    }
 
     handle = FindFirstVolumeW(guid, ARRAYSIZE(guid));
     if (handle == INVALID_HANDLE_VALUE) {
-- 
2.17.1
