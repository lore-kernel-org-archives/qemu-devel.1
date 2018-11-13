Received: from eggs.gnu.org ([2001:4830:134:3::10]:59599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gMOwz-0007lF-8U
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gMOwu-0005Gp-DK
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:01:13 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:46429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gMOwu-0005FU-7J
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:01:08 -0500
Received: by mail-ot1-x32e.google.com with SMTP id w25so9274008otm.13
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 19:01:08 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 12 Nov 2018 21:00:46 -0600
Message-Id: <20181113030047.11711-2-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181113030047.11711-1-mdroth@linux.vnet.ibm.com>
References: <20181113030047.11711-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-3.1 1/2] qga-win: fix leaks of
 build_guest_disk_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Introduced in commit b1ba8890e63ce9432c41c5c3fc229f54c87c9c99, vol_h
handle should be closed, and "out" cleanup should be done after
DeviceIoControl() fails.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index ef1d7d48d2..62e1b51dfe 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -797,7 +797,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
                     0, extents, size, NULL, NULL)) {
                 error_setg_win32(errp, GetLastError(),
                     "failed to get disk extents");
-                return NULL;
+                goto out;
             }
         } else if (last_err == ERROR_INVALID_FUNCTION) {
             /* Possibly CD-ROM or a shared drive. Try to pass the volume */
@@ -855,6 +855,9 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
 
 
 out:
+    if (vol_h != INVALID_HANDLE_VALUE) {
+        CloseHandle(vol_h);
+    }
     qapi_free_GuestDiskAddress(disk);
     g_free(extents);
     g_free(name);
-- 
2.17.1
