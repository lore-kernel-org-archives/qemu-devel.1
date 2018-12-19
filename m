Received: from eggs.gnu.org ([2001:4830:134:3::10]:59861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1gZXPd-0004pi-1Y
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1gZXPZ-0005Pl-1c
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:41:04 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1gZXPY-0005Om-Og
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:41:00 -0500
Received: by mail-wr1-x442.google.com with SMTP id j2so18604297wrw.1
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 00:41:00 -0800 (PST)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Wed, 19 Dec 2018 10:40:51 +0200
Message-Id: <1545208851-6906-2-git-send-email-bishara@daynix.com>
In-Reply-To: <1545208851-6906-1-git-send-email-bishara@daynix.com>
References: <1545208851-6906-1-git-send-email-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH] qga-win: Adding support for Windows Server
 2019 get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Samee Jubran <sameeh@daynix.com>

Since Windows Server 2016, Microsoft stopped upgrading the major and minor
versions of their new Windows Server product, so, the current functionality
of checking major and minor version numbers to determine the Windows Server
version wont work as expected.
The implemented solution here is to use the build number in addition to the
major and minor version numbers of the product to determine the Windows
Server product version.
The final build number of Windows Server 2016 is 14939, and
the final build number of Windows Server 2019 is 17764, so any Windows
Server product that has the major version of 10 and minor version of 0
with a build number lower or equal to 14939 will resemble 2016 and if the
build number is lower or equal to 17763 will resemble 2019.

Reference:
https://techcommunity.microsoft.com/t5/Windows-Server-Insiders/Windows-Server-2019-version-info/m-p/293112/highlight/true#M859

Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
---
 qga/commands-win32.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 62e1b51..3985b40 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2009,12 +2009,24 @@ static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][8] = {
         { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
         { 6, 2, "Microsoft Windows Server 2012",        "2012"},
         { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
-        {10, 0, "Microsoft Windows Server 2016",        "2016"},
+        { 0, 0, 0},
         { 0, 0, 0},
         { 0, 0, 0}
     }
 };
 
+typedef struct _ga_win_10_0_server_t {
+    int final_build;
+    char const *version;
+    char const *version_id;
+} ga_win_10_0_server_t;
+
+static ga_win_10_0_server_t const WIN_10_0_SERVER_VERSION_MATRIX[3] = {
+    {14393, "Microsoft Windows Server 2016",    "2016"},
+    {17763, "Microsoft Windows Server 2019",    "2019"},
+    {0, 0}
+};
+
 static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
 {
     typedef NTSTATUS(WINAPI * rtl_get_version_t)(
@@ -2039,10 +2051,23 @@ static char *ga_get_win_name(OSVERSIONINFOEXW const *os_version, bool id)
 {
     DWORD major = os_version->dwMajorVersion;
     DWORD minor = os_version->dwMinorVersion;
+    DWORD build = os_version->dwBuildNumber;
     int tbl_idx = (os_version->wProductType != VER_NT_WORKSTATION);
     ga_matrix_lookup_t const *table = WIN_VERSION_MATRIX[tbl_idx];
+    ga_win_10_0_server_t const *win_10_0_table = WIN_10_0_SERVER_VERSION_MATRIX;
     while (table->version != NULL) {
-        if (major == table->major && minor == table->minor) {
+        if (major == 10 && minor == 0 && tbl_idx) {
+            while (win_10_0_table->version != NULL) {
+                if (build <= win_10_0_table->final_build) {
+                    if (id) {
+                        return g_strdup(win_10_0_table->version_id);
+                    } else {
+                        return g_strdup(win_10_0_table->version);
+                    }
+                }
+                win_10_0_table++;
+            }
+        } else if (major == table->major && minor == table->minor) {
             if (id) {
                 return g_strdup(table->version_id);
             } else {
-- 
1.8.3.1
