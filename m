Received: from eggs.gnu.org ([2001:4830:134:3::10]:45909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1fuYXP-0000tn-5q
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 03:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1fuYXK-0001pu-U4
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 03:35:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:25528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1fuYXJ-0001oN-OJ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 03:35:38 -0400
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Wed, 29 Aug 2018 00:14:22 +0800
Message-Id: <7328fb16c394eaf5d65437d11c2a9343647b6d3d.1535471899.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH 1/1] hostmem-file: fixed the memory leak while
 get pmem path.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peter.maydell@linaro.org, yu.c.zhang@linux.intel.com, ehabkost@redhat.com, imammedo@redhat.com, junyan.he@intel.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, crosthwaite.peter@gmail.com, richard.henderson@linaro.org, xiaoguangrong.eric@gmail.com, Zhang Yi <yi.z.zhang@linux.intel.com>

object_get_canonical_path_component() returns a string which
must be freed using g_free().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 backends/hostmem-file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 2476dcb..e8831a8 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -145,20 +145,26 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
 
     if (host_memory_backend_mr_inited(backend)) {
+        char *path = object_get_canonical_path_component(o);
+
         error_setg(errp, "cannot change property 'pmem' of %s '%s'",
                    object_get_typename(o),
-                   object_get_canonical_path_component(o));
+                   path);
+        g_free(path);
         return;
     }
 
 #ifndef CONFIG_LIBPMEM
     if (value) {
         Error *local_err = NULL;
+        char *path = object_get_canonical_path_component(o);
+
         error_setg(&local_err,
                    "Lack of libpmem support while setting the 'pmem=on'"
                    " of %s '%s'. We can't ensure data persistence.",
                    object_get_typename(o),
-                   object_get_canonical_path_component(o));
+                   path);
+        g_free(path);
         error_propagate(errp, local_err);
         return;
     }
-- 
2.7.4
