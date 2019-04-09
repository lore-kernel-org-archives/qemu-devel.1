Received: from eggs.gnu.org ([209.51.188.92]:48866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDujX-0005Pi-CF
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDujV-0002i5-Df
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:40:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDujU-0002dR-OW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:40:29 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 Apr 2019 19:40:18 +0200
Message-Id: <20190409174018.25798-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, slp@redhat.com

If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
computation of @dt_size overflows to a negative number, which then
gets converted to a very large size_t for g_malloc0() and
load_image_size().  In the (fortunately improbable) case g_malloc0()
succeeds and load_image_size() survives, we'd assign the negative
number to *sizep.  What that would do to the callers I can't say, but
it's unlikely to be good.

Fix by rejecting images whose size would overflow.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 device_tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/device_tree.c b/device_tree.c
index 296278e12a..f8b46b3c73 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, int *sizep)
                      filename_path);
         goto fail;
     }
+    if (dt_size > INT_MAX / 2 - 10000) {
+        error_report("Device tree file '%s' is too large", filename_path);
+        goto fail;
+    }
 
     /* Expand to 2x size to give enough room for manipulation.  */
     dt_size += 10000;
-- 
2.17.2
