Received: from eggs.gnu.org ([2001:4830:134:3::10]:37806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQx8A-0007xA-Dh
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQx88-0001GR-8A
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:47:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fQx88-0001GG-3H
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:47:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 17:47:05 +0200
Message-Id: <20180607154705.6316-3-david@redhat.com>
In-Reply-To: <20180607154705.6316-1-david@redhat.com>
References: <20180607154705.6316-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/2] exec: check that alignment is a power
 of two
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com

Right now we can crash QEMU using e.g.

qemu-system-x86_64 -m 256M,maxmem=20G,slots=2 \
 -object memory-backend-file,id=mem0,size=12288,mem-path=/dev/zero,align=12288 \
 -device pc-dimm,id=dimm1,memdev=mem0

qemu-system-x86_64: util/mmap-alloc.c:115:
 qemu_ram_mmap: Assertion `is_power_of_2(align)' failed

Fix this by adding a proper check.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/exec.c b/exec.c
index f6645ede0c..f54c83ac61 100644
--- a/exec.c
+++ b/exec.c
@@ -1681,6 +1681,10 @@ static void *file_ram_alloc(RAMBlock *block,
                    " must be multiples of page size 0x%zx",
                    block->mr->align, block->page_size);
         return NULL;
+    } else if (block->mr->align && !is_power_of_2(block->mr->align)) {
+        error_setg(errp, "alignment 0x%" PRIx64
+                   " must be a power of two", block->mr->align);
+        return NULL;
     }
     block->mr->align = MAX(block->page_size, block->mr->align);
 #if defined(__s390x__)
-- 
2.17.0
