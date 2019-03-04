Received: from eggs.gnu.org ([209.51.188.92]:34060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0jBL-0005vU-LE
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0jBK-0003tg-W2
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:42:43 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1h0jBK-0003sW-Mb
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:42:42 -0500
Received: by mail-wm1-x341.google.com with SMTP id g20so3759657wmh.5
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 00:42:42 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Mon,  4 Mar 2019 10:42:38 +0200
Message-Id: <20190304084238.13481-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH] migration/rdma: clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com

Configuring QEMU with:
        ../configure --cc=clang --enable-rdma

Leads to compilation error:

  CC      migration/rdma.o
  CC      migration/block.o
  qemu/migration/rdma.c:3615:58: error: taking address of packed member 'rkey' of class or structure
      'RDMARegisterResult' may result in an unaligned pointer value [-Werror,-Waddress-of-packed-member]
                            (uintptr_t)host_addr, NULL, &reg_result->rkey,
                                                         ^~~~~~~~~~~~~~~~

This is a false warning; even if RDMARegisterResult is "packed", rkey
is the first field so is guaranteed to be aligned.

Fix it by disabling the warning only for this instance.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 migration/rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 54a3c11540..e0f66a4717 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3611,6 +3611,8 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
                 }
                 chunk_start = ram_chunk_start(block, chunk);
                 chunk_end = ram_chunk_end(block, chunk + reg->chunks);
+                #pragma clang diagnostic push
+                #pragma clang diagnostic ignored "-Waddress-of-packed-member"
                 if (qemu_rdma_register_and_get_keys(rdma, block,
                             (uintptr_t)host_addr, NULL, &reg_result->rkey,
                             chunk, chunk_start, chunk_end)) {
@@ -3618,6 +3620,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
                     ret = -EINVAL;
                     goto out;
                 }
+                #pragma clang diagnostic pop
 
                 reg_result->host_addr = (uintptr_t)block->local_host_addr;
 
-- 
2.17.1
