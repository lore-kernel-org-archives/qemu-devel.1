Received: from eggs.gnu.org ([2001:4830:134:3::10]:45744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmKIn-0002BF-MF
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 08:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmKIm-00020e-FE
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 08:09:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cmKIm-00020N-9h
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 08:09:48 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 10 Mar 2017 21:09:29 +0800
Message-Id: <1489151370-15453-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1489151370-15453-1-git-send-email-peterx@redhat.com>
References: <1489151370-15453-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] hostmem: introduce
 host_memory_backend_mr_inited()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

We were checking this against memory region size of host memory
backend's mr field to see whether the mr has been inited. This is
efficient but less elegant. Let's make a helper for it to avoid
confusions, along with some notes.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem.c       | 9 +++++++++
 include/sysemu/hostmem.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 7f5de70..4e9ef62 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -243,6 +243,15 @@ static void host_memory_backend_init(Object *obj)
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
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index ecae0cf..ed6a437 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -62,6 +62,7 @@ struct HostMemoryBackend {
     MemoryRegion mr;
 };
 
+bool host_memory_backend_mr_inited(HostMemoryBackend *backend);
 MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend,
                                              Error **errp);
 
-- 
2.7.4
