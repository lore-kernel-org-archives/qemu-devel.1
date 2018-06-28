Received: from eggs.gnu.org ([2001:4830:134:3::10]:35178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYVok-0001Gl-Vh
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYVok-0002bW-4f
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:14:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Jun 2018 14:14:15 +0200
Message-Id: <20180628121417.1980-3-david@redhat.com>
In-Reply-To: <20180628121417.1980-1-david@redhat.com>
References: <20180628121417.1980-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] util/oslib-win32: indicate alignment
 for qemu_anon_ram_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, David Hildenbrand <david@redhat.com>

Let's set the alignment just like for the posix variant. This will
implicitly set the alignment of the underlying memory region and
therefore make memory_region_get_alignment(mr) return something > 0 for
all memory backends applicable to PCDIMM/NVDIMM.

This will allow us to drop special handling in pc.c for
memory_region_get_alignment(mr) == 0, as we can then assume that it is
always set (and AFAICS >= getpagesize()).

For pc in pc_memory_plug(), under Windows TARGET_PAGE_SIZE == getpagesize(),
therefore alignment of DIMMs will not change, and therefore also not the
guest physical memory layout.

For spapr in spapr_memory_plug(), an alignment of 0 would have been used
until now. Now getpagesize() is used. But as the size of DIMMs has to be
multiple of 256MB on spapr, automatic address asignment will not change
the layout (no memory holes will be created as the alignment change will
not apply if DIMMs start/end on 256MB boundaries).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/oslib-win32.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index bb5ad28bd3..6e87721419 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -76,6 +76,10 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
        memory is page aligned. */
     ptr = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
     trace_qemu_anon_ram_alloc(size, ptr);
+
+    if (ptr && align) {
+        *align = getpagesize();
+    }
     return ptr;
 }
 
-- 
2.17.1
