Received: from eggs.gnu.org ([2001:4830:134:3::10]:42793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumk-0001ql-5d
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumi-0007kw-Co
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEumi-0007in-44
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so1274076wrw.3
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:39 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:19 +0200
Message-Id: <39758553c13a033021bd981d1cbaf1a170c453fd.1540293796.git.tgolembi@redhat.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 10/14] qga-win: report disk serial number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 5ebacd241f..e7d9cdea62 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -609,6 +609,31 @@ static void get_disk_properties(HANDLE vol_h, GuestDiskAddress *disk,
     disk->bus_type = find_bus_type(dev_desc->BusType);
     g_debug("bus type %d", disk->bus_type);
 
+    /* Query once more. Now with long enough buffer. */
+    size = dev_desc->Size;
+    dev_desc = g_malloc0(size);
+    if (!DeviceIoControl(vol_h, IOCTL_STORAGE_QUERY_PROPERTY, &query,
+                         sizeof(STORAGE_PROPERTY_QUERY), dev_desc,
+                         size, &received, NULL)) {
+        error_setg_win32(errp, GetLastError(), "failed to get serial number");
+        goto out_free;
+    }
+    if (dev_desc->SerialNumberOffset > 0) {
+        if (dev_desc->SerialNumberOffset >= received) {
+            error_setg(errp, "offset outside the buffer");
+            goto out_free;
+        }
+        const char *serial = (char *)dev_desc + dev_desc->SerialNumberOffset;
+        size_t len = received - dev_desc->SerialNumberOffset;
+        if (*serial != 0) {
+            disk->serial = g_strndup(serial, len);
+            disk->has_serial = true;
+            g_debug("serial number %s", disk->serial);
+        }
+    }
+out_free:
+    g_free(dev_desc);
+
     return;
 }
 
-- 
2.19.0
