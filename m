Received: from eggs.gnu.org ([2001:4830:134:3::10]:36061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0R-0008RX-S7
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0Q-0007pJ-Gt
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ezP0Q-0007og-B6
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:26 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Fri, 23 Mar 2018 18:53:04 +0300
Message-Id: <20180323155306.83812-7-marcel@redhat.com>
In-Reply-To: <20180323155306.83812-1-marcel@redhat.com>
References: <20180323155306.83812-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH PULL 6/8] hw/rdma: Change host_virt to void *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, mst@redhat.com, marcel@redhat.com, f4bug@amsat.org, eblake@redhat.com, berrange@redhat.com, stefanha@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

To avoid compilation warnings on 32-bit machines:
rdma_backend.c: In function 'rdma_backend_create_mr':
rdma_backend.c:409:37: error: cast to pointer from integer of different
size [-Werror=3Dint-to-pointer-cast]
	mr->ibmr =3D ibv_reg_mr(pd->ibpd, (void *)addr, length, access);

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180322095220.9976-2-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/rdma/rdma_backend.c |  8 ++++----
 hw/rdma/rdma_backend.h |  2 +-
 hw/rdma/rdma_rm.c      | 10 +++++-----
 hw/rdma/rdma_rm_defs.h |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 57f40d99a3..b1d2913b2c 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -222,7 +222,7 @@ static int build_host_sge_array(RdmaDeviceResources *=
rdma_dev_res,
             return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
         }
=20
-        dsge->addr =3D mr->user_mr.host_virt + ssge[ssge_idx].addr -
+        dsge->addr =3D (uintptr_t)mr->user_mr.host_virt + ssge[ssge_idx]=
.addr -
                      mr->user_mr.guest_start;
         dsge->length =3D ssge[ssge_idx].length;
         dsge->lkey =3D rdma_backend_mr_lkey(&mr->backend_mr);
@@ -401,12 +401,12 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
     }
 }
=20
-int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, uint64_=
t addr,
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *a=
ddr,
                            size_t length, int access)
 {
-    pr_dbg("addr=3D0x%lx\n", addr);
+    pr_dbg("addr=3D0x%p\n", addr);
     pr_dbg("len=3D%ld\n", length);
-    mr->ibmr =3D ibv_reg_mr(pd->ibpd, (void *)addr, length, access);
+    mr->ibmr =3D ibv_reg_mr(pd->ibpd, addr, length, access);
     if (mr->ibmr) {
         pr_dbg("lkey=3D0x%x\n", mr->ibmr->lkey);
         pr_dbg("rkey=3D0x%x\n", mr->ibmr->rkey);
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 505cad7e0e..3cd636dd88 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -61,7 +61,7 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev=
,
 int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *p=
d);
 void rdma_backend_destroy_pd(RdmaBackendPD *pd);
=20
-int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, uint64_=
t addr,
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *a=
ddr,
                            size_t length, int access);
 void rdma_backend_destroy_mr(RdmaBackendMR *mr);
=20
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 6d88ac5d23..b4938169b6 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -146,7 +146,7 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, ui=
nt32_t pd_handle,
     RdmaRmMR *mr;
     int ret =3D 0;
     RdmaRmPD *pd;
-    uint64_t addr;
+    void *addr;
     size_t length;
=20
     pd =3D rdma_rm_get_pd(dev_res, pd_handle);
@@ -165,10 +165,10 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, =
uint32_t pd_handle,
         /* TODO: This is my guess but not so sure that this needs to be
          * done */
         length =3D TARGET_PAGE_SIZE;
-        addr =3D (uint64_t)g_malloc(length);
+        addr =3D g_malloc(length);
     } else {
-        mr->user_mr.host_virt =3D (uint64_t) host_virt;
-        pr_dbg("host_virt=3D0x%lx\n", mr->user_mr.host_virt);
+        mr->user_mr.host_virt =3D host_virt;
+        pr_dbg("host_virt=3D0x%p\n", mr->user_mr.host_virt);
         mr->user_mr.length =3D guest_length;
         pr_dbg("length=3D0x%lx\n", guest_length);
         mr->user_mr.guest_start =3D guest_start;
@@ -216,7 +216,7 @@ void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res,=
 uint32_t mr_handle)
=20
     if (mr) {
         rdma_backend_destroy_mr(&mr->backend_mr);
-        munmap((void *)mr->user_mr.host_virt, mr->user_mr.length);
+        munmap(mr->user_mr.host_virt, mr->user_mr.length);
         res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
     }
 }
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 6522dca68f..fc646da61f 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -56,7 +56,7 @@ typedef struct RdmaRmCQ {
 } RdmaRmCQ;
=20
 typedef struct RdmaRmUserMR {
-    uint64_t host_virt;
+    void *host_virt;
     uint64_t guest_start;
     size_t length;
 } RdmaRmUserMR;
--=20
2.13.5
