Received: from eggs.gnu.org ([2001:4830:134:3::10]:59946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gFDhg-0006KY-AJ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gFDhc-0005Rj-SQ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:35:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:21197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gFDhb-0005H1-U0
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:35:40 -0400
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Wed, 24 Oct 2018 22:14:56 +0800
Message-Id: <a6491f996827f4039c1a52198ed5dcc7727cb0f9.1540389255.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1540389255.git.yi.z.zhang@linux.intel.com>
References: <cover.1540389255.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH 1/1] hostmem-file: remove the invalid pmem
 object id.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peter.maydell@linaro.org, yu.c.zhang@linux.intel.com, ehabkost@redhat.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, crosthwaite.peter@gmail.com, richard.henderson@linaro.org, xiaoguangrong.eric@gmail.com, Zhang Yi <yi.z.zhang@linux.intel.com>

We will never get the canonical path from the object
before object_property_add_child.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 backends/hostmem-file.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 639c8d4..9691c48 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -145,26 +145,20 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
 
     if (host_memory_backend_mr_inited(backend)) {
-        char *path = object_get_canonical_path_component(o);
 
-        error_setg(errp, "cannot change property 'pmem' of %s '%s'",
-                   object_get_typename(o),
-                   path);
-        g_free(path);
+        error_setg(errp, "cannot change property 'pmem' of %s.",
+                   object_get_typename(o));
         return;
     }
 
 #ifndef CONFIG_LIBPMEM
     if (value) {
         Error *local_err = NULL;
-        char *path = object_get_canonical_path_component(o);
 
         error_setg(&local_err,
                    "Lack of libpmem support while setting the 'pmem=on'"
-                   " of %s '%s'. We can't ensure data persistence.",
-                   object_get_typename(o),
-                   path);
-        g_free(path);
+                   " of %s. We can't ensure data persistence.",
+                   object_get_typename(o));
         error_propagate(errp, local_err);
         return;
     }
-- 
2.7.4
