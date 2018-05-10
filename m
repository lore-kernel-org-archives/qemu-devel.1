Received: from eggs.gnu.org ([2001:4830:134:3::10]:37304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fGb1V-0003MW-59
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fGb1S-0006og-4C
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:24344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fGb1R-0006fc-Rm
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:34 -0400
From: junyan.he@gmx.com
Date: Thu, 10 May 2018 10:08:56 +0800
Message-Id: <1525918138-6189-8-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 7/9 V5] migration/ram: ensure write persistence
 on loading compressed pages to PMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

From: Junyan He <junyan.he@intel.com>

When loading a compressed page to persistent memory, flush CPU cache
after the data is decompressed. Combined with a call to pmem_drain()
at the end of memory loading, we can guarantee those compressed pages
are persistently loaded to PMEM.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 include/qemu/pmem.h |  1 +
 migration/ram.c     | 10 ++++++++--
 stubs/pmem.c        |  4 ++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index cb9fa5f..c9140fb 100644
--- a/include/qemu/pmem.h
+++ b/include/qemu/pmem.h
@@ -20,6 +20,7 @@ void *pmem_memcpy_nodrain(void *pmemdest, const void *src, size_t len);
 void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len);
 void *pmem_memset_nodrain(void *pmemdest, int c, size_t len);
 void pmem_drain(void);
+void pmem_flush(const void *addr, size_t len);
 
 #endif /* CONFIG_LIBPMEM */
 
diff --git a/migration/ram.c b/migration/ram.c
index 2a180bc..e0f3dbc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -286,6 +286,7 @@ struct DecompressParam {
     uint8_t *compbuf;
     int len;
     z_stream stream;
+    bool is_pmem;
 };
 typedef struct DecompressParam DecompressParam;
 
@@ -2591,6 +2592,9 @@ static void *do_data_decompress(void *opaque)
                 error_report("decompress data failed");
                 qemu_file_set_error(decomp_file, ret);
             }
+            if (param->is_pmem) {
+                pmem_flush(des, len);
+            }
 
             qemu_mutex_lock(&decomp_done_lock);
             param->done = true;
@@ -2702,7 +2706,8 @@ exit:
 }
 
 static void decompress_data_with_multi_threads(QEMUFile *f,
-                                               void *host, int len)
+                                               void *host, int len,
+                                               bool is_pmem)
 {
     int idx, thread_count;
 
@@ -2716,6 +2721,7 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
                 qemu_get_buffer(f, decomp_param[idx].compbuf, len);
                 decomp_param[idx].des = host;
                 decomp_param[idx].len = len;
+                decomp_param[idx].is_pmem = is_pmem;
                 qemu_cond_signal(&decomp_param[idx].cond);
                 qemu_mutex_unlock(&decomp_param[idx].mutex);
                 break;
@@ -3073,7 +3079,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                 ret = -EINVAL;
                 break;
             }
-            decompress_data_with_multi_threads(f, host, len);
+            decompress_data_with_multi_threads(f, host, len, is_pmem);
             break;
 
         case RAM_SAVE_FLAG_XBZRLE:
diff --git a/stubs/pmem.c b/stubs/pmem.c
index b50c35e..9e7d86a 100644
--- a/stubs/pmem.c
+++ b/stubs/pmem.c
@@ -31,3 +31,7 @@ void *pmem_memcpy_nodrain(void *pmemdest, const void *src, size_t len)
 {
     return memcpy(pmemdest, src, len);
 }
+
+void pmem_flush(const void *addr, size_t len)
+{
+}
-- 
2.7.4
