Received: from eggs.gnu.org ([2001:4830:134:3::10]:46196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVG8-0007VZ-Pr
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVG7-00009N-Kr
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:44 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834]:44092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHVG7-0008Rg-Ak
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:43 -0400
Received: by mail-qt1-x834.google.com with SMTP id b22-v6so13703209qtr.11
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:44:36 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 09:43:46 -0500
Message-Id: <20181030144358.23144-13-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/24] qga-win: report disk serial number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tomáš Golembiovský <tgolembi@redhat.com>

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
*coding style fix-ups (declarations at beginning of block)
*improve readability for user-visible errors
*cover additional edge-cases with debug statements
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 1e91aa2343..2d7b56d538 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -634,6 +634,36 @@ static void get_disk_properties(HANDLE vol_h, GuestDiskAddress *disk,
     disk->bus_type = find_bus_type(dev_desc->BusType);
     g_debug("bus type %d", disk->bus_type);
 
+    /* Query once more. Now with long enough buffer. */
+    size = dev_desc->Size;
+    dev_desc = g_malloc0(size);
+    if (!DeviceIoControl(vol_h, IOCTL_STORAGE_QUERY_PROPERTY, &query,
+                         sizeof(STORAGE_PROPERTY_QUERY), dev_desc,
+                         size, &received, NULL)) {
+        error_setg_win32(errp, GetLastError(), "failed to get serial number");
+        g_debug("failed to get serial number");
+        goto out_free;
+    }
+    if (dev_desc->SerialNumberOffset > 0) {
+        const char *serial;
+        size_t len;
+
+        if (dev_desc->SerialNumberOffset >= received) {
+            error_setg(errp, "failed to get serial number: offset outside the buffer");
+            g_debug("serial number offset outside the buffer");
+            goto out_free;
+        }
+        serial = (char *)dev_desc + dev_desc->SerialNumberOffset;
+        len = received - dev_desc->SerialNumberOffset;
+        g_debug("serial number \"%s\"", serial);
+        if (*serial != 0) {
+            disk->serial = g_strndup(serial, len);
+            disk->has_serial = true;
+        }
+    }
+out_free:
+    g_free(dev_desc);
+
     return;
 }
 
-- 
2.17.1
