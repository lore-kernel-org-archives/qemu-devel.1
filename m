Received: from eggs.gnu.org ([209.51.188.92]:42166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCp2-00044e-N9
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCp2-0004RR-4g
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:43:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1goCp1-0004Qi-Up
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:43:56 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 28 Jan 2019 17:43:50 -0200
Message-Id: <20190128194351.14679-2-ehabkost@redhat.com>
In-Reply-To: <20190128194351.14679-1-ehabkost@redhat.com>
References: <20190128194351.14679-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] numa: Fixed the memory leak of numa error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

object_get_canonical_path_component() returns a string which
must be freed using g_free().

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Reviewed-by: Pankaj gupta <pagupta@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <51ba6d7d0333a5517d824a870dd20887156dd15a.1546399191.git.yi.z.zhang@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/numa.c b/numa.c
index 50ec016013..3875e1efda 100644
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
2.18.0.rc1.1.g3f1ff2140
