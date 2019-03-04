Received: from eggs.gnu.org ([209.51.188.92]:54535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0seY-0001OH-FP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0seW-0006eU-Eo
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:49:29 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1h0seW-0006cU-4H
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:49:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id i16so6705481wrs.13
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:49:28 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Mon,  4 Mar 2019 20:49:23 +0200
Message-Id: <20190304184923.24215-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH V2] migration/rdma: clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, eblake@redhat.com

Configuring QEMU with:
        ../configure --cc=clang --enable-rdma

Leads to compilation error:

  CC      migration/rdma.o
  CC      migration/block.o
  qemu/migration/rdma.c:3615:58: error: taking address of packed member 'rkey' of class or structure
      'RDMARegisterResult' may result in an unaligned pointer value [-Werror,-Waddress-of-packed-member]
                            (uintptr_t)host_addr, NULL, &reg_result->rkey,
                                                         ^~~~~~~~~~~~~~~~
Fix it by using a temp local variable.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---

v1 -> v2: 
 - Use a temp local variable (Dave)

 migration/rdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 54a3c11540..e39ee77558 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3611,13 +3611,16 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
                 }
                 chunk_start = ram_chunk_start(block, chunk);
                 chunk_end = ram_chunk_end(block, chunk + reg->chunks);
+                /* avoid "-Waddress-of-packed-member" warning */
+                uint32_t tmp_rkey = 0;
                 if (qemu_rdma_register_and_get_keys(rdma, block,
-                            (uintptr_t)host_addr, NULL, &reg_result->rkey,
+                            (uintptr_t)host_addr, NULL, &tmp_rkey,
                             chunk, chunk_start, chunk_end)) {
                     error_report("cannot get rkey");
                     ret = -EINVAL;
                     goto out;
                 }
+                reg_result->rkey = tmp_rkey;
 
                 reg_result->host_addr = (uintptr_t)block->local_host_addr;
 
-- 
2.17.1
