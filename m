Received: from eggs.gnu.org ([209.51.188.92]:42583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY74-0006cU-EY
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY73-0002RK-KJ
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:17:10 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gxY73-0002Qj-Cm
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:17:09 -0500
Received: by mail-wr1-x442.google.com with SMTP id w2so5270067wrt.11
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 06:17:08 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 23 Feb 2019 16:16:44 +0200
Message-Id: <20190223141644.6609-12-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
References: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH PULL 11/11] hw/rdma: another clang compilation
 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, philmd@redhat.com, dgilbert@redhat.com

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
Message-Id: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 325bbf58ec..e00091e730 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -120,7 +120,7 @@ typedef struct RdmaRmStats {
     uint64_t missing_cqe;
 } RdmaRmStats;
 
-typedef struct RdmaDeviceResources {
+struct RdmaDeviceResources {
     RdmaRmPort port;
     RdmaRmResTbl pd_tbl;
     RdmaRmResTbl mr_tbl;
@@ -131,6 +131,6 @@ typedef struct RdmaDeviceResources {
     GHashTable *qp_hash; /* Keeps mapping between real and emulated */
     QemuMutex lock;
     RdmaRmStats stats;
-} RdmaDeviceResources;
+};
 
 #endif
-- 
2.17.1
