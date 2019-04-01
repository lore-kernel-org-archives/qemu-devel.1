Received: from eggs.gnu.org ([209.51.188.92]:41927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45v-0002ax-2J
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45u-0004Dk-37
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45t-000480-Ln
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L3SUN027834
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:38 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkq85hs40-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:35 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:10 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:03 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-90-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 89/97] hw/rdma: another clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Configuring QEMU with:
   configure --target-list=3D"x86_64-softmmu" --cc=3Dclang --enable-pvrdm=
a
Results in:
   qemu/hw/rdma/rdma_rm_defs.h:108:3: error: redefinition of typedef 'Rdm=
aDeviceResources' is a C11 feature [-Werror,-Wtypedef-redefinition]
   } RdmaDeviceResources;
     ^
   qemu/hw/rdma/rdma_backend_defs.h:24:36: note: previous definition is h=
ere
   typedef struct RdmaDeviceResources RdmaDeviceResources;

Fix by removing one of the 'typedef' definitions.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
(cherry picked from commit 59f911938fbaa6a5eff1146c8a4d74e1c55ecc2b)
*drop context dep. on c2dd117b385
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/rdma/rdma_rm_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 226011176d..f098d91813 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -89,7 +89,7 @@ typedef struct RdmaRmPort {
     enum ibv_port_state state;
 } RdmaRmPort;
=20
-typedef struct RdmaDeviceResources {
+struct RdmaDeviceResources {
     RdmaRmPort ports[MAX_PORTS];
     RdmaRmResTbl pd_tbl;
     RdmaRmResTbl mr_tbl;
@@ -98,6 +98,6 @@ typedef struct RdmaDeviceResources {
     RdmaRmResTbl cq_tbl;
     RdmaRmResTbl cqe_ctx_tbl;
     GHashTable *qp_hash; /* Keeps mapping between real and emulated */
-} RdmaDeviceResources;
+};
=20
 #endif
--=20
2.17.1
