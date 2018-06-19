Received: from eggs.gnu.org ([2001:4830:134:3::10]:46335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ic-0002FB-Av
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ib-0000E3-J0
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:02 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:18 -0500
Message-Id: <20180619014319.28272-53-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 052/113] exec: fix memory leak in
 find_max_supported_pagesize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Eduardo Habkost <ehabkost@redhat.com>

From: Greg Kurz <groug@kaod.org>

The string returned by object_property_get_str() is dynamically allocated.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <152231458624.69730.1752893648612848392.stgit@bahia.lan>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit 72a841d2a403b56ff894fa007b172dc9bcb3dae8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index 5f8017a5d7..e60ad94a42 100644
--- a/exec.c
+++ b/exec.c
@@ -1455,6 +1455,7 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
         mem_path = object_property_get_str(obj, "mem-path", NULL);
         if (mem_path) {
             long hpsize = qemu_mempath_getpagesize(mem_path);
+            g_free(mem_path);
             if (hpsize < *hpsize_min) {
                 *hpsize_min = hpsize;
             }
-- 
2.11.0
