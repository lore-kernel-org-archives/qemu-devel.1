Received: from eggs.gnu.org ([2001:4830:134:3::10]:37891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAW-00079b-9T
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAS-0000ER-R6
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:27 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:37246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAS-0000Cq-IY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:24 -0400
Received: by mail-wr0-x22b.google.com with SMTP id k6-v6so6687292wrp.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:19 +0200
Message-Id: <1530216310-52873-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/60] exec: check that alignment is a power of
 two
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Right now we can crash QEMU using e.g.

qemu-system-x86_64 -m 256M,maxmem=20G,slots=2 \
 -object memory-backend-file,id=mem0,size=12288,mem-path=/dev/zero,align=12288 \
 -device pc-dimm,id=dimm1,memdev=mem0

qemu-system-x86_64: util/mmap-alloc.c:115:
 qemu_ram_mmap: Assertion `is_power_of_2(align)' failed

Fix this by adding a proper check.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180607154705.6316-3-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/exec.c b/exec.c
index 610d0c0..cdcf769 100644
--- a/exec.c
+++ b/exec.c
@@ -1841,6 +1841,10 @@ static void *file_ram_alloc(RAMBlock *block,
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
1.8.3.1
