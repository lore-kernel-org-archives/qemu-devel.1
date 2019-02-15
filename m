Received: from eggs.gnu.org ([209.51.188.92]:54449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugJP-0001RQ-Fe
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugJO-0007DR-73
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:26:03 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 15 Feb 2019 16:25:33 +0000
Message-ID: <20190215162533.19475-4-paul.durrant@citrix.com>
In-Reply-To: <20190215162533.19475-1-paul.durrant@citrix.com>
References: <20190215162533.19475-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] xen-block: report error condition from
 vbd_name_to_disk()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The function needs to make sure it is passed a valid disk name. This is
easily done by making sure that the parsing loop results in a non-zero
value.

Spotted by Coverity: CID 1398640

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
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
2.20.1.2.gb21ebb6
