Received: from eggs.gnu.org ([2001:4830:134:3::10]:47342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7x-0002F1-5n
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7w-0004gG-5A
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H7v-0004fZ-VM
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:47:02 -0300
Message-Id: <20170420184705.25018-13-ehabkost@redhat.com>
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] hostmem: introduce
 host_memory_backend_mr_inited()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

We were checking this against memory region size of host memory
backend's mr field to see whether the mr has been inited. This is
efficient but less elegant. Let's make a helper for it to avoid
confusions, along with some notes.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1489151370-15453-2-git-send-email-peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/hostmem.h | 1 +
 backends/hostmem.c       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index ecae0cff19..ed6a437f4d 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -62,6 +62,7 @@ struct HostMemoryBackend {
     MemoryRegion mr;
 };
 
+bool host_memory_backend_mr_inited(HostMemoryBackend *backend);
 MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend,
                                              Error **errp);
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 89feb9ed75..d8faab4bed 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -237,6 +237,15 @@ static void host_memory_backend_init(Object *obj)
     backend->prealloc = mem_prealloc;
 }
 
+bool host_memory_backend_mr_inited(HostMemoryBackend *backend)
+{
+    /*
+     * NOTE: We forbid zero-length memory backend, so here zero means
+     * "we haven't inited the backend memory region yet".
+     */
+    return memory_region_size(&backend->mr) != 0;
+}
+
 MemoryRegion *
 host_memory_backend_get_memory(HostMemoryBackend *backend, Error **errp)
 {
-- 
2.11.0.259.g40922b1
