Received: from eggs.gnu.org ([2001:4830:134:3::10]:36862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uVV-0005qQ-IB
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uVU-0003zj-7b
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:20:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  5 Apr 2018 12:20:01 +1000
Message-Id: <20180405022002.17809-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180405022002.17809-1-david@gibson.dropbear.id.au>
References: <20180405022002.17809-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 for-2.13 1/2] Make qemu_mempath_getpagesize()
 accept NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

qemu_mempath_getpagesize() gets the effective (host side) page size for
a block of memory backed by an mmap()ed file on the host.  It requires
the mem_path parameter to be non-NULL.

This ends up meaning all the callers need a different case for handling
anonymous memory (for memory-backend-ram or default memory with -mem-path
is not specified).

We can make all those callers a little simpler by
qemu_mempath_getpagesize() accept NULL, and treat that as the anonymous
memory case.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 exec.c            | 21 ++++++---------------
 target/ppc/kvm.c  |  8 ++------
 util/mmap-alloc.c | 26 ++++++++++++++------------
 3 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/exec.c b/exec.c
index 02b1efebb7..b38b004563 100644
--- a/exec.c
+++ b/exec.c
@@ -1488,19 +1488,14 @@ void ram_block_dump(Monitor *mon)
  */
 static int find_max_supported_pagesize(Object *obj, void *opaque)
 {
-    char *mem_path;
     long *hpsize_min = opaque;
 
     if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
-        mem_path = object_property_get_str(obj, "mem-path", NULL);
-        if (mem_path) {
-            long hpsize = qemu_mempath_getpagesize(mem_path);
-            g_free(mem_path);
-            if (hpsize < *hpsize_min) {
-                *hpsize_min = hpsize;
-            }
-        } else {
-            *hpsize_min = getpagesize();
+        char *mem_path = object_property_get_str(obj, "mem-path", NULL);
+        long hpsize = qemu_mempath_getpagesize(mem_path);
+        g_free(mem_path);
+        if (hpsize < *hpsize_min) {
+            *hpsize_min = hpsize;
         }
     }
 
@@ -1513,11 +1508,7 @@ long qemu_getrampagesize(void)
     long mainrampagesize;
     Object *memdev_root;
 
-    if (mem_path) {
-        mainrampagesize = qemu_mempath_getpagesize(mem_path);
-    } else {
-        mainrampagesize = getpagesize();
-    }
+    mainrampagesize = qemu_mempath_getpagesize(mem_path);
 
     /* it's possible we have memory-backend objects with
      * hugepage-backed RAM. these may get mapped into system
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 1bd38c6a90..f393eae127 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -496,12 +496,8 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
     char *mempath = object_property_get_str(mem_obj, "mem-path", NULL);
     long pagesize;
 
-    if (mempath) {
-        pagesize = qemu_mempath_getpagesize(mempath);
-        g_free(mempath);
-    } else {
-        pagesize = getpagesize();
-    }
+    pagesize = qemu_mempath_getpagesize(mempath);
+    g_free(mempath);
 
     return pagesize >= max_cpu_page_size;
 }
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 2fd8cbcc6f..fd329eccd8 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -50,19 +50,21 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     struct statfs fs;
     int ret;
 
-    do {
-        ret = statfs(mem_path, &fs);
-    } while (ret != 0 && errno == EINTR);
-
-    if (ret != 0) {
-        fprintf(stderr, "Couldn't statfs() memory path: %s\n",
-                strerror(errno));
-        exit(1);
-    }
+    if (mem_path) {
+        do {
+            ret = statfs(mem_path, &fs);
+        } while (ret != 0 && errno == EINTR);
 
-    if (fs.f_type == HUGETLBFS_MAGIC) {
-        /* It's hugepage, return the huge page size */
-        return fs.f_bsize;
+        if (ret != 0) {
+            fprintf(stderr, "Couldn't statfs() memory path: %s\n",
+                    strerror(errno));
+            exit(1);
+        }
+
+        if (fs.f_type == HUGETLBFS_MAGIC) {
+            /* It's hugepage, return the huge page size */
+            return fs.f_bsize;
+        }
     }
 #ifdef __sparc__
     /* SPARC Linux needs greater alignment than the pagesize */
-- 
2.14.3
