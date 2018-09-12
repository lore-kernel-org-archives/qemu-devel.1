Received: from eggs.gnu.org ([2001:4830:134:3::10]:53539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g04Jh-0003CV-47
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g04Je-0001kM-0S
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:32:21 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g04Jd-0001jL-CN
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:32:17 -0400
Received: by mail-pg1-x542.google.com with SMTP id r1-v6so985439pgp.11
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 05:32:16 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 12 Sep 2018 05:32:09 -0700
Message-Id: <1536755529-2709-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] memory region: check the old.mmio.read status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, ehabkost@redhat.com, marcandre.lureau@gmail.com, lersek@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, ppandit@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

To avoid NULL-deref for the devices without read callbacks

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/memory.c b/memory.c
index 9b73892768..48d025426b 100644
--- a/memory.c
+++ b/memory.c
@@ -406,6 +406,10 @@ static MemTxResult memory_region_oldmmio_read_accessor(MemoryRegion *mr,
 {
     uint64_t tmp;
 
+    if (!mr->ops->old_mmio.read[ctz32(size)]) {
+        return MEMTX_DECODE_ERROR;
+    }
+
     tmp = mr->ops->old_mmio.read[ctz32(size)](mr->opaque, addr);
     if (mr->subpage) {
         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
-- 
2.11.0
