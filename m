Received: from eggs.gnu.org ([2001:4830:134:3::10]:36742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gJZxf-0000uR-VH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gJZwC-0005DL-Sz
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:08:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:49607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gJZwC-00050T-C7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:08:44 -0500
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Mon,  5 Nov 2018 16:08:02 +0800
Message-Id: <4773dd7667ce53e3894ac705badd6e580808c6ce.1541425595.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1541425595.git.yi.z.zhang@linux.intel.com>
References: <cover.1541425595.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH v5 1/7] numa: Fixed the memory leak of numa
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, dan.j.williams@intel.com, stefanha@redhat.com, pbonzini@redhat.com, yu.c.zhang@linux.intel.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com, Zhang Yi <yi.z.zhang@linux.intel.com>

object_get_canonical_path_component() returns a string which
must be freed using g_free().

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/numa.c b/numa.c
index 50ec016..3875e1e 100644
--- a/numa.c
+++ b/numa.c
@@ -533,6 +533,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
             error_report("memory backend %s is used multiple times. Each "
                          "-numa option must use a different memdev value.",
                          path);
+            g_free(path);
             exit(1);
         }
 
-- 
2.7.4
