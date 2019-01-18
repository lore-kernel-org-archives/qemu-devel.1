Received: from eggs.gnu.org ([209.51.188.92]:33994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkTXm-0003W7-CI
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkTXj-0008DW-Uw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:46:42 -0500
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 18 Jan 2019 14:46:13 +0200
Message-Id: <20190118124614.24548-3-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190118124614.24548-1-marcel.apfelbaum@gmail.com>
References: <20190118124614.24548-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/3] hw/rdma: modify struct initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, qemu-stable@nongnu.org, marcel.apfelbaum@gmail.com, cohuck@redhat.com

Do not initialize structs with {0} since some
CLANG versions do not support it.

Use {} construct instead.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 contrib/rdmacm-mux/main.c | 6 +++---
 hw/rdma/rdma_backend.c    | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index 64676030c5..ae88c77a1e 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -350,7 +350,7 @@ static int get_fd(const char *mad, int *fd, __be64 *gid_ifid)
 static void *umad_recv_thread_func(void *args)
 {
     int rc;
-    RdmaCmMuxMsg msg = {0};
+    RdmaCmMuxMsg msg = {};
     int fd = -2;
 
     msg.hdr.msg_type = RDMACM_MUX_MSG_TYPE_REQ;
@@ -387,7 +387,7 @@ static void *umad_recv_thread_func(void *args)
 static int read_and_process(int fd)
 {
     int rc;
-    RdmaCmMuxMsg msg = {0};
+    RdmaCmMuxMsg msg = {};
     struct umad_hdr *hdr;
     uint32_t *comm_id = 0;
     uint16_t attr_id;
@@ -744,7 +744,7 @@ static void signal_handler(int sig, siginfo_t *siginfo, void *context)
 static int init(void)
 {
     int rc;
-    struct sigaction sig = {0};
+    struct sigaction sig = {};
 
     rc = init_listener();
     if (rc) {
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c28bfbd44d..0b9767fde7 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -190,7 +190,7 @@ static inline int rdmacm_mux_can_process_async(RdmaBackendDev *backend_dev)
 
 static int check_mux_op_status(CharBackend *mad_chr_be)
 {
-    RdmaCmMuxMsg msg = {0};
+    RdmaCmMuxMsg msg = {};
     int ret;
 
     pr_dbg("Reading response\n");
@@ -387,7 +387,7 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
 static int mad_send(RdmaBackendDev *backend_dev, uint8_t sgid_idx,
                     union ibv_gid *sgid, struct ibv_sge *sge, uint32_t num_sge)
 {
-    RdmaCmMuxMsg msg = {0};
+    RdmaCmMuxMsg msg = {};
     char *hdr, *data;
     int ret;
 
@@ -1112,7 +1112,7 @@ int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
 int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
                          union ibv_gid *gid)
 {
-    RdmaCmMuxMsg msg = {0};
+    RdmaCmMuxMsg msg = {};
     int ret;
 
     pr_dbg("0x%llx, 0x%llx\n",
@@ -1138,7 +1138,7 @@ int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
 int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
                          union ibv_gid *gid)
 {
-    RdmaCmMuxMsg msg = {0};
+    RdmaCmMuxMsg msg = {};
     int ret;
 
     pr_dbg("0x%llx, 0x%llx\n",
-- 
2.17.1
