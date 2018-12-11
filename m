Received: from eggs.gnu.org ([2001:4830:134:3::10]:41120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLv-0005Gb-0I
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLp-0004ah-C9
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmLl-0004Rj-9k
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:43 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:06 -0200
Message-Id: <20181211180129.7661-2-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/24] hostmem-file: remove object id from pmem
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

We will never get the canonical path from the object
before object_property_add_child.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Message-Id: <a6491f996827f4039c1a52198ed5dcc7727cb0f9.1540389255.git.yi.z.zhang@linux.intel.com>
[ehabkost: reword commit message]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem-file.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 6630021226..78f058dee2 100644
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
2.18.0.rc1.1.g3f1ff2140
