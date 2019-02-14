Received: from eggs.gnu.org ([209.51.188.92]:60554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guJ8H-0004xg-Kt
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guJ8G-0003Gv-Py
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:41:01 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1guJ8F-0003Dm-72
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:40:59 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so6938695wrt.13
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:40:58 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 14 Feb 2019 17:40:53 +0200
Message-Id: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH] hw/rdma: another clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, kamalheib1@gmail.com, marcel.apfelbaum@gmail.com

Configuring QEMU with:
   configure --target-list="x86_64-softmmu" --cc=clang --enable-pvrdma
Results in:
   qemu/hw/rdma/rdma_rm_defs.h:108:3: error: redefinition of typedef 'RdmaDeviceResources' is a C11 feature [-Werror,-Wtypedef-redefinition]
   } RdmaDeviceResources;
     ^
   qemu/hw/rdma/rdma_backend_defs.h:24:36: note: previous definition is here
   typedef struct RdmaDeviceResources RdmaDeviceResources;

Fix by removing one of the 'typedef' definitions.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 0ba61d1838..5e877c1fd9 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -96,7 +96,7 @@ typedef struct RdmaRmPort {
     enum ibv_port_state state;
 } RdmaRmPort;
 
-typedef struct RdmaDeviceResources {
+struct RdmaDeviceResources {
     RdmaRmPort port;
     RdmaRmResTbl pd_tbl;
     RdmaRmResTbl mr_tbl;
@@ -105,6 +105,6 @@ typedef struct RdmaDeviceResources {
     RdmaRmResTbl cq_tbl;
     RdmaRmResTbl cqe_ctx_tbl;
     GHashTable *qp_hash; /* Keeps mapping between real and emulated */
-} RdmaDeviceResources;
+};
 
 #endif
-- 
2.17.1
