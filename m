Received: from eggs.gnu.org ([2001:4830:134:3::10]:51653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emfsO-00019N-27
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emfsN-0005Ys-4w
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emfsN-0005YQ-06
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A48A4EAE91
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 13:16:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Feb 2018 13:15:58 +0000
Message-Id: <20180216131625.9639-3-dgilbert@redhat.com>
In-Reply-To: <20180216131625.9639-1-dgilbert@redhat.com>
References: <20180216131625.9639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/29] qemu_ram_block_host_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, imammedo@redhat.com, mst@redhat.com
Cc: quintela@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Utility to give the offset of a host pointer within a RAMBlock
(assuming we already know it's in that RAMBlock)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 exec.c                    | 10 ++++++++++
 include/exec/cpu-common.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/exec.c b/exec.c
index b1bb477776..0ec73bc917 100644
--- a/exec.c
+++ b/exec.c
@@ -2293,6 +2293,16 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
     return ramblock_ptr(block, addr);
 }
 
+/* Return the offset of a hostpointer within a ramblock */
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
+{
+    ram_addr_t res = (uint8_t *)host - (uint8_t *)rb->host;
+    assert((uintptr_t)host >= (uintptr_t)rb->host);
+    assert(res < rb->max_length);
+
+    return res;
+}
+
 /*
  * Translates a host ptr back to a RAMBlock, a ram_addr and an offset
  * in that RAMBlock.
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 74341b19d2..0d861a6289 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -68,6 +68,7 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr);
 RAMBlock *qemu_ram_block_by_name(const char *name);
 RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
                                    ram_addr_t *offset);
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
 void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
 void qemu_ram_unset_idstr(RAMBlock *block);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
-- 
2.14.3
