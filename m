Received: from eggs.gnu.org ([208.118.235.92]:34408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf22C-0005FW-F2
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf229-0004CX-9a
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:36 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <basil@daynix.com>) id 1gf228-0004BD-Q5
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id r24so34706911wmh.0
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 04:23:32 -0800 (PST)
From: Basil Salman <basil@daynix.com>
Date: Thu,  3 Jan 2019 14:23:20 +0200
Message-Id: <20190103122323.1273034-2-basil@daynix.com>
In-Reply-To: <20190103122323.1273034-1-basil@daynix.com>
References: <20190103122323.1273034-1-basil@daynix.com>
Subject: [Qemu-devel] [PATCH 1/4] qga-win: prevent crash when executing
 guest-file-read with large count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Bishara AbuHattoum <bishara@daynix.com>

BZ: #1594054
guest-file-read command is currently implelmented to read from a
file handle count number of bytes. when executed with a very large count number
qemu-ga crashes.
after some digging turns out that qemu-ga crashes after trying to allocate
a buffer large enough to save the data read in it, the buffer was allocated using
g_malloc0 which is not fail safe, and results a crash in case of failure.
g_malloc0 was replaced with g_try_malloc0() which returns NULL on failure,
A check was added for that case in order to prevent qemu-ga from crashing
and to send a response to the qemu-ga client accordingly.

Signed-off-by: Basil Salman <basil@daynix.com>
---
 qga/commands-win32.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 62e1b51dfe..4260faa573 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -345,7 +345,13 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
     }
 
     fh = gfh->fh;
-    buf = g_malloc0(count+1);
+    buf = g_try_malloc0(count + 1);
+    if (!buf) {
+        error_setg(errp,
+                   "failed to allocate sufficient memory"
+                   "to complete the requested service");
+        return read_data;
+    }
     is_ok = ReadFile(fh, buf, count, &read_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to read file");
-- 
2.17.2
