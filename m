Received: from eggs.gnu.org ([209.51.188.92]:36187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaV-000684-ML
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaU-0003e6-SH
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:15 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:52030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaU-0003Mt-Im
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:14 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 28 Feb 2019 17:34:38 +0000
Message-ID: <20190228173439.8013-4-anthony.perard@citrix.com>
In-Reply-To: <20190228173439.8013-1-anthony.perard@citrix.com>
References: <20190228173439.8013-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 3/4] xen-block: report error condition from
 vbd_name_to_disk()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>

From: Paul Durrant <paul.durrant@citrix.com>

The function needs to make sure it is passed a valid disk name. This is
easily done by making sure that the parsing loop results in a non-zero
value.

Spotted by Coverity: CID 1398640

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190215162533.19475-4-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/xen-block.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 29afe2703a..37a456c207 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -351,21 +351,28 @@ static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
     g_free(str);
 }
 
-static unsigned int vbd_name_to_disk(const char *name, const char **endp)
+static int vbd_name_to_disk(const char *name, const char **endp,
+                            unsigned long *disk)
 {
-    unsigned int disk = 0;
+    unsigned int n = 0;
 
     while (*name != '\0') {
         if (!g_ascii_isalpha(*name) || !g_ascii_islower(*name)) {
             break;
         }
 
-        disk *= 26;
-        disk += *name++ - 'a' + 1;
+        n *= 26;
+        n += *name++ - 'a' + 1;
     }
     *endp = name;
 
-    return disk - 1;
+    if (!n) {
+        return -1;
+    }
+
+    *disk = n - 1;
+
+    return 0;
 }
 
 static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
@@ -418,7 +425,9 @@ static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
             }
         }
     } else {
-        vdev->disk = vbd_name_to_disk(p, &end);
+        if (vbd_name_to_disk(p, &end, &vdev->disk)) {
+            goto invalid;
+        }
     }
 
     if (*end != '\0') {
-- 
Anthony PERARD
