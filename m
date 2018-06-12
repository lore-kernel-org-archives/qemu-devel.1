Received: from eggs.gnu.org ([2001:4830:134:3::10]:58695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3i-0002ec-Nj
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3h-0001nc-LB
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:41 +1000
Message-Id: <20180612064503.14282-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/33] osdep: powerpc64 align memory to allow
 2MB radix THP page tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Nicholas Piggin <npiggin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nicholas Piggin <npiggin@gmail.com>

This allows KVM with the Book3S radix MMU mode to take advantage of
THP and install larger pages in the partition scope page tables (the
host translation).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/qemu/osdep.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index afc28e5903..9ed62423c0 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -367,7 +367,8 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #endif
 
 #if defined(__linux__) && \
-    (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__))
+    (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) \
+     || defined(__powerpc64__))
    /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
       Valgrind does not support alignments larger than 1 MiB,
       therefore we need special code which handles running on Valgrind. */
-- 
2.17.1
