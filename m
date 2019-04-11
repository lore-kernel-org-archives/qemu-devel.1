Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18771C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B811E2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O4yvzB9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B811E2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXVJ-0004DF-Sk
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:04:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEXTR-0003Cj-Vj
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEXTL-0000Km-H0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hEXTL-0007id-5A
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BAri94084216; Thu, 11 Apr 2019 11:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references : mime-version :
	content-transfer-encoding; s=corp-2018-07-02;
	bh=S2u7RqPhmQ3j/mb66ctCfnUp9jyf44k+/Hb1+bpBH3E=;
	b=O4yvzB9dzjPiofgy9U5ZNMMXpdsDJ964Zx/p/cYY8EjF+p5O2yTkjyqbhB711jrz+3th
	hW16hDLQZEYsPT8FLOkXZ4wTMhJIJqFK0a5g4yHp49JWUGCCBmHPqdPXCBz+WzVnoGCv
	f4mcD3Btt25qtrbHRL3vUCUUX41GaapEkI3zM2pV5ZkuLw15+5Lnufdc2JmsGwh1BxnI
	mb+ysq54VfxLmJaoXe/S0s5uFLsjbrg2ha7PIsG8G2WrbEgXDXEYZr7U2bL97NTdEHRL
	Wp15hnwaG8KN5ys32lsQw/kOj4Zv95Hun5YAiocCZwUcVWQUU6la+lG946ftqNtJ2AVi
	2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 2rpkht8b0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2019 11:02:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BB28wA001689; Thu, 11 Apr 2019 11:02:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 2rpkekcngc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2019 11:02:08 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3BB27QK014732;
	Thu, 11 Apr 2019 11:02:07 GMT
Received: from host4.lan (/77.138.183.59)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 11 Apr 2019 04:02:07 -0700
From: Yuval Shaia <yuval.shaia@oracle.com>
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org,
	mst@redhat.com, cohuck@redhat.com, marcel.apfelbaum@gmail.com,
	linux-rdma@vger.kernel.org, jgg@mellanox.com
Date: Thu, 11 Apr 2019 14:01:56 +0300
Message-Id: <20190411110157.14252-3-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411110157.14252-1-yuval.shaia@oracle.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904110077
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904110077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC 2/3] hw/virtio-rdma: VirtIO rdma device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411110156.Duw_acSR-nV7Sh2eOMhs63Rc2daa2ImypU19ypRKn1c@z>

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/Kconfig                                  |   1 +
 hw/rdma/Kconfig                             |   4 +
 hw/rdma/Makefile.objs                       |   2 +
 hw/rdma/virtio/virtio-rdma-ib.c             | 287 ++++++++++++++++++++
 hw/rdma/virtio/virtio-rdma-ib.h             |  93 +++++++
 hw/rdma/virtio/virtio-rdma-main.c           | 185 +++++++++++++
 hw/virtio/Makefile.objs                     |   1 +
 hw/virtio/virtio-rdma-pci.c                 | 108 ++++++++
 include/hw/pci/pci.h                        |   1 +
 include/hw/virtio/virtio-rdma.h             |  44 +++
 include/standard-headers/linux/virtio_ids.h |   1 +
 11 files changed, 727 insertions(+)
 create mode 100644 hw/rdma/Kconfig
 create mode 100644 hw/rdma/virtio/virtio-rdma-ib.c
 create mode 100644 hw/rdma/virtio/virtio-rdma-ib.h
 create mode 100644 hw/rdma/virtio/virtio-rdma-main.c
 create mode 100644 hw/virtio/virtio-rdma-pci.c
 create mode 100644 include/hw/virtio/virtio-rdma.h

diff --git a/hw/Kconfig b/hw/Kconfig
index d5ecd02070..88b9f15007 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -26,6 +26,7 @@ source pci-bridge/Kconfig
 source pci-host/Kconfig
 source pcmcia/Kconfig
 source pci/Kconfig
+source rdma/Kconfig
 source scsi/Kconfig
 source sd/Kconfig
 source smbios/Kconfig
diff --git a/hw/rdma/Kconfig b/hw/rdma/Kconfig
new file mode 100644
index 0000000000..b10bd7182b
--- /dev/null
+++ b/hw/rdma/Kconfig
@@ -0,0 +1,4 @@
+config VIRTIO_RDMA
+    bool
+    default y
+    depends on VIRTIO
diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
index c354e60e5b..ed640882be 100644
--- a/hw/rdma/Makefile.objs
+++ b/hw/rdma/Makefile.objs
@@ -3,3 +3,5 @@ obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o rdma.o
 obj-$(CONFIG_PCI) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
                      vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o
 endif
+obj-$(CONFIG_VIRTIO_RDMA) += virtio/virtio-rdma-main.o \
+                             virtio/virtio-rdma-ib.o
diff --git a/hw/rdma/virtio/virtio-rdma-ib.c b/hw/rdma/virtio/virtio-rdma-ib.c
new file mode 100644
index 0000000000..2590a831a2
--- /dev/null
+++ b/hw/rdma/virtio/virtio-rdma-ib.c
@@ -0,0 +1,287 @@
+/*
+ * Virtio RDMA Device - IB verbs
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include <infiniband/verbs.h>
+
+#include "qemu/osdep.h"
+
+#include "virtio-rdma-ib.h"
+#include "../rdma_utils.h"
+#include "../rdma_rm.h"
+#include "../rdma_backend.h"
+
+int virtio_rdma_query_device(VirtIORdma *rdev, struct iovec *in,
+                             struct iovec *out)
+{
+    struct ibv_device_attr attr = {};
+    int offs;
+    size_t s;
+
+    addrconf_addr_eui48((unsigned char *)&attr.sys_image_guid,
+                        (const char *)&rdev->netdev->mac);
+
+    attr.max_mr_size = 4096;
+    attr.page_size_cap = 4096;
+    attr.vendor_id = 1;
+    attr.vendor_part_id = 1;
+    attr.hw_ver = VIRTIO_RDMA_HW_VER;
+    attr.max_qp = 1024;
+    attr.max_qp_wr = 1024;
+    attr.device_cap_flags = 0;
+    attr.max_sge = 64;
+    attr.max_sge_rd = 64;
+    attr.max_cq = 1024;
+    attr.max_cqe = 64;
+    attr.max_mr = 1024;
+    attr.max_pd = 1024;
+    attr.max_qp_rd_atom = 0;
+    attr.max_ee_rd_atom = 0;
+    attr.max_res_rd_atom = 0;
+    attr.max_qp_init_rd_atom = 0;
+    attr.max_ee_init_rd_atom = 0;
+    attr.atomic_cap = IBV_ATOMIC_NONE;
+    attr.max_ee = 0;
+    attr.max_rdd = 0;
+    attr.max_mw = 0;
+    attr.max_raw_ipv6_qp = 0;
+    attr.max_raw_ethy_qp = 0;
+    attr.max_mcast_grp = 0;
+    attr.max_mcast_qp_attach = 0;
+    attr.max_total_mcast_qp_attach = 0;
+    attr.max_ah = 1024;
+    attr.max_fmr = 0;
+    attr.max_map_per_fmr = 0;
+    attr.max_srq = 0;
+    attr.max_srq_wr = 0;
+    attr.max_srq_sge = 0;
+    attr.max_pkeys = 1;
+    attr.local_ca_ack_delay = 0;
+    attr.phys_port_cnt = VIRTIO_RDMA_PORT_CNT;
+
+    offs = offsetof(struct ibv_device_attr, sys_image_guid);
+    s = iov_from_buf(out, 1, 0, (void *)&attr + offs, sizeof(attr) - offs);
+
+    return s == sizeof(attr) - offs ? VIRTIO_RDMA_CTRL_OK :
+                                      VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_query_port(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out)
+{
+    struct ibv_port_attr attr = {};
+    struct cmd_query_port cmd = {};
+    int offs;
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    if (cmd.port != 1) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    attr.state = IBV_PORT_ACTIVE;
+    attr.max_mtu = attr.active_mtu = IBV_MTU_1024;
+    attr.gid_tbl_len = 256;
+    attr.port_cap_flags = 0;
+    attr.max_msg_sz = 1024;
+    attr.bad_pkey_cntr = 0;
+    attr.qkey_viol_cntr = 0;
+    attr.pkey_tbl_len = 1;
+    attr.lid = 0;
+    attr.sm_lid = 0;
+    attr.lmc = 0;
+    attr.max_vl_num = 1;
+    attr.sm_sl = 0;
+    attr.subnet_timeout = 0;
+    attr.init_type_reply = 0;
+    attr.active_width = 0;
+    attr.active_speed = 0;
+    attr.phys_state = 0;
+
+    offs = offsetof(struct ibv_port_attr, state);
+    s = iov_from_buf(out, 1, 0, (void *)&attr + offs, sizeof(attr) - offs);
+
+    return s == sizeof(attr) - offs ? VIRTIO_RDMA_CTRL_OK :
+                                      VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_create_cq(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_create_cq cmd = {};
+    struct rsp_create_cq rsp = {};
+    size_t s;
+    int rc;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    /* TODO: Define MAX_CQE */
+#define MAX_CQE 1024
+    /* TODO: Check MAX_CQ */
+    if (cmd.cqe > MAX_CQE) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    printf("%s: %d\n", __func__, cmd.cqe);
+
+    /* TODO: Create VirtQ */
+
+    rc = rdma_rm_alloc_cq(rdev->rdma_dev_res, rdev->backend_dev, cmd.cqe,
+                          &rsp.cqn, NULL);
+    if (rc) {
+        /* TODO: Destroy VirtQ */
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    printf("%s: %d\n", __func__, rsp.cqn);
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_destroy_cq(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_destroy_cq cmd = {};
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    printf("%s: %d\n", __func__, cmd.cqn);
+
+    /* TODO: Destroy VirtQ */
+
+    rdma_rm_dealloc_cq(rdev->rdma_dev_res, cmd.cqn);
+
+    return VIRTIO_RDMA_CTRL_OK;
+}
+
+int virtio_rdma_create_pd(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct rsp_create_pd rsp = {};
+    size_t s;
+    int rc;
+
+    /* TODO: Check MAX_PD */
+
+    /* TODO: ctx */
+    rc = rdma_rm_alloc_pd(rdev->rdma_dev_res, rdev->backend_dev, &rsp.pdn,
+                          0);
+    if (rc)
+        return VIRTIO_RDMA_CTRL_ERR;
+
+    printf("%s: %d\n", __func__, rsp.pdn);
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_destroy_pd(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_destroy_pd cmd = {};
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    printf("%s: %d\n", __func__, cmd.pdn);
+
+    rdma_rm_dealloc_cq(rdev->rdma_dev_res, cmd.pdn);
+
+    return VIRTIO_RDMA_CTRL_OK;
+}
+
+int virtio_rdma_get_dma_mr(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out)
+{
+    struct cmd_get_dma_mr cmd = {};
+    struct rsp_get_dma_mr rsp = {};
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    /* TODO: Call rdma_rm_alloc_mr */
+    rsp.mrn = 0x10;
+    rsp.lkey = 0x11;
+    rsp.rkey = 0x12;
+    printf("%s: 0x%x\n", __func__, rsp.mrn);
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+static void virtio_rdma_init_dev_caps(VirtIORdma *rdev)
+{
+    rdev->dev_attr.max_qp_wr = 1024;
+}
+
+int virtio_rdma_init_ib(VirtIORdma *rdev)
+{
+    int rc;
+
+    virtio_rdma_init_dev_caps(rdev);
+
+    rdev->rdma_dev_res = g_malloc0(sizeof(RdmaDeviceResources));
+    rdev->backend_dev = g_malloc0(sizeof(RdmaBackendDev));
+
+    rc = rdma_backend_init(rdev->backend_dev, NULL, rdev->rdma_dev_res,
+                           rdev->backend_device_name,
+                           rdev->backend_port_num, &rdev->dev_attr,
+                           &rdev->mad_chr);
+    if (rc) {
+        rdma_error_report("Fail to initialize backend device");
+        return rc;
+    }
+
+    rc = rdma_rm_init(rdev->rdma_dev_res, &rdev->dev_attr);
+    if (rc) {
+        rdma_error_report("Fail to initialize resource manager");
+        return rc;
+    }
+
+    /* rdma_backend_start(rdev->backend_dev); */
+
+    return 0;
+}
+
+void virtio_rdma_fini_ib(VirtIORdma *rdev)
+{
+    /* rdma_backend_stop(rdev->backend_dev); */
+    rdma_rm_fini(rdev->rdma_dev_res, rdev->backend_dev,
+                 rdev->backend_eth_device_name);
+    rdma_backend_fini(rdev->backend_dev);
+    g_free(rdev->rdma_dev_res);
+    g_free(rdev->backend_dev);
+}
diff --git a/hw/rdma/virtio/virtio-rdma-ib.h b/hw/rdma/virtio/virtio-rdma-ib.h
new file mode 100644
index 0000000000..c4bdc063ac
--- /dev/null
+++ b/hw/rdma/virtio/virtio-rdma-ib.h
@@ -0,0 +1,93 @@
+/*
+ * Virtio RDMA Device - IB verbs
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "hw/virtio/virtio-rdma.h"
+
+/* TODO: Move to uapi header file */
+#define VIRTIO_RDMA_CTRL_OK    0
+#define VIRTIO_RDMA_CTRL_ERR   1
+
+enum {
+    VIRTIO_CMD_QUERY_DEVICE = 10,
+    VIRTIO_CMD_QUERY_PORT,
+    VIRTIO_CMD_CREATE_CQ,
+    VIRTIO_CMD_DESTROY_CQ,
+    VIRTIO_CMD_CREATE_PD,
+    VIRTIO_CMD_DESTROY_PD,
+    VIRTIO_CMD_GET_DMA_MR,
+};
+
+struct control_buf {
+    uint8_t cmd;
+    uint8_t status;
+};
+
+struct cmd_query_port {
+    uint8_t port;
+};
+
+struct cmd_create_cq {
+    uint32_t cqe;
+};
+
+struct rsp_create_cq {
+    uint32_t cqn;
+};
+
+struct cmd_destroy_cq {
+    uint32_t cqn;
+};
+
+struct rsp_create_pd {
+    uint32_t pdn;
+};
+
+struct cmd_destroy_pd {
+    uint32_t pdn;
+};
+
+struct cmd_get_dma_mr {
+    uint32_t pdn;
+    uint32_t access_flags;
+};
+
+struct rsp_get_dma_mr {
+    uint32_t mrn;
+    uint32_t lkey;
+    uint32_t rkey;
+};
+
+/* TODO: Move to uapi header file */
+
+#define VIRTIO_RDMA_PORT_CNT    1
+#define VIRTIO_RDMA_HW_VER      1
+
+int virtio_rdma_init_ib(VirtIORdma *rdev);
+void virtio_rdma_fini_ib(VirtIORdma *rdev);
+
+int virtio_rdma_query_device(VirtIORdma *rdev, struct iovec *in,
+                             struct iovec *out);
+int virtio_rdma_query_port(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out);
+int virtio_rdma_create_cq(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_destroy_cq(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_create_pd(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_destroy_pd(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_get_dma_mr(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out);
diff --git a/hw/rdma/virtio/virtio-rdma-main.c b/hw/rdma/virtio/virtio-rdma-main.c
new file mode 100644
index 0000000000..54f75b14c0
--- /dev/null
+++ b/hw/rdma/virtio/virtio-rdma-main.c
@@ -0,0 +1,185 @@
+/*
+ * Virtio RDMA Device
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include <infiniband/verbs.h>
+
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio.h"
+#include "qemu/error-report.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-rdma.h"
+#include "include/standard-headers/linux/virtio_ids.h"
+
+#include "virtio-rdma-ib.h"
+#include "../rdma_rm_defs.h"
+#include "../rdma_utils.h"
+
+static void virtio_rdma_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIORdma *r = VIRTIO_RDMA(vdev);
+    struct control_buf cb;
+    VirtQueueElement *e;
+    size_t s;
+
+    virtio_queue_set_notification(vq, 0);
+
+    for (;;) {
+        e = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!e) {
+            break;
+        }
+
+        if (iov_size(e->in_sg, e->in_num) < sizeof(cb.status) ||
+            iov_size(e->out_sg, e->out_num) < sizeof(cb.cmd)) {
+            virtio_error(vdev, "Got invalid message size");
+            virtqueue_detach_element(vq, e, 0);
+            g_free(e);
+            break;
+        }
+
+        s = iov_to_buf(&e->out_sg[0], 1, 0, &cb.cmd, sizeof(cb.cmd));
+        if (s != sizeof(cb.cmd)) {
+            cb.status = VIRTIO_RDMA_CTRL_ERR;
+        } else {
+            printf("cmd=%d\n", cb.cmd);
+            switch (cb.cmd) {
+            case VIRTIO_CMD_QUERY_DEVICE:
+                cb.status = virtio_rdma_query_device(r, &e->out_sg[1],
+                                                     &e->in_sg[0]);
+                break;
+            case VIRTIO_CMD_QUERY_PORT:
+                cb.status = virtio_rdma_query_port(r, &e->out_sg[1],
+                                                   &e->in_sg[0]);
+                break;
+            case VIRTIO_CMD_CREATE_CQ:
+                cb.status = virtio_rdma_create_cq(r, &e->out_sg[1],
+                                                  &e->in_sg[0]);
+                break;
+            case VIRTIO_CMD_DESTROY_CQ:
+                cb.status = virtio_rdma_destroy_cq(r, &e->out_sg[1],
+                                                  &e->in_sg[0]);
+                break;
+            case VIRTIO_CMD_CREATE_PD:
+                cb.status = virtio_rdma_create_pd(r, &e->out_sg[1],
+                                                  &e->in_sg[0]);
+                break;
+            case VIRTIO_CMD_DESTROY_PD:
+                cb.status = virtio_rdma_destroy_pd(r, &e->out_sg[1],
+                                                  &e->in_sg[0]);
+                break;
+            case VIRTIO_CMD_GET_DMA_MR:
+                cb.status = virtio_rdma_get_dma_mr(r, &e->out_sg[1],
+                                                  &e->in_sg[0]);
+                break;
+            default:
+                cb.status = VIRTIO_RDMA_CTRL_ERR;
+            }
+        }
+        printf("status=%d\n", cb.status);
+        s = iov_from_buf(&e->in_sg[1], 1, 0, &cb.status, sizeof(cb.status));
+        assert(s == sizeof(cb.status));
+
+        virtqueue_push(vq, e, sizeof(cb.status));
+        virtio_notify(vdev, vq);
+    }
+
+    virtio_queue_set_notification(vq, 1);
+}
+
+static void virtio_rdma_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIORdma *r = VIRTIO_RDMA(dev);
+    int rc;
+
+    rc = virtio_rdma_init_ib(r);
+    if (rc) {
+        rdma_error_report("Fail to initialize IB layer");
+        return;
+    }
+
+    virtio_init(vdev, "virtio-rdma", VIRTIO_ID_RDMA, 1024);
+
+    r->ctrl_vq = virtio_add_queue(vdev, 64, virtio_rdma_handle_ctrl);
+}
+
+static void virtio_rdma_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIORdma *r = VIRTIO_RDMA(dev);
+
+    virtio_del_queue(vdev, 0);
+
+    virtio_cleanup(vdev);
+
+    virtio_rdma_fini_ib(r);
+}
+
+static uint64_t virtio_rdma_get_features(VirtIODevice *vdev, uint64_t features,
+                                        Error **errp)
+{
+    /* virtio_add_feature(&features, VIRTIO_NET_F_MAC); */
+
+    vdev->backend_features = features;
+
+    return features;
+}
+
+
+static Property virtio_rdma_dev_properties[] = {
+    DEFINE_PROP_STRING("netdev", VirtIORdma, backend_eth_device_name),
+    DEFINE_PROP_STRING("ibdev",VirtIORdma, backend_device_name),
+    DEFINE_PROP_UINT8("ibport", VirtIORdma, backend_port_num, 1),
+    DEFINE_PROP_UINT64("dev-caps-max-mr-size", VirtIORdma, dev_attr.max_mr_size,
+                       MAX_MR_SIZE),
+    DEFINE_PROP_INT32("dev-caps-max-qp", VirtIORdma, dev_attr.max_qp, MAX_QP),
+    DEFINE_PROP_INT32("dev-caps-max-cq", VirtIORdma, dev_attr.max_cq, MAX_CQ),
+    DEFINE_PROP_INT32("dev-caps-max-mr", VirtIORdma, dev_attr.max_mr, MAX_MR),
+    DEFINE_PROP_INT32("dev-caps-max-pd", VirtIORdma, dev_attr.max_pd, MAX_PD),
+    DEFINE_PROP_INT32("dev-caps-qp-rd-atom", VirtIORdma,
+                       dev_attr.max_qp_rd_atom, MAX_QP_RD_ATOM),
+    DEFINE_PROP_INT32("dev-caps-max-qp-init-rd-atom", VirtIORdma,
+                      dev_attr.max_qp_init_rd_atom, MAX_QP_INIT_RD_ATOM),
+    DEFINE_PROP_INT32("dev-caps-max-ah", VirtIORdma, dev_attr.max_ah, MAX_AH),
+    DEFINE_PROP_CHR("mad-chardev", VirtIORdma, mad_chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_rdma_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    vdc->realize = virtio_rdma_device_realize;
+    vdc->unrealize = virtio_rdma_device_unrealize;
+    vdc->get_features = virtio_rdma_get_features;
+
+    dc->desc = "Virtio RDMA Device";
+    dc->props = virtio_rdma_dev_properties;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+}
+
+static const TypeInfo virtio_rdma_info = {
+    .name = TYPE_VIRTIO_RDMA,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIORdma),
+    .class_init = virtio_rdma_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_rdma_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index f2ab667a21..fd701feb9f 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -27,6 +27,7 @@ obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
 obj-$(CONFIG_VIRTIO_NET) += virtio-net-pci.o
+obj-$(CONFIG_VIRTIO_RDMA) += virtio-rdma-pci.o
 obj-$(CONFIG_VIRTIO_SERIAL) += virtio-serial-pci.o
 endif
 else
diff --git a/hw/virtio/virtio-rdma-pci.c b/hw/virtio/virtio-rdma-pci.c
new file mode 100644
index 0000000000..36efce285b
--- /dev/null
+++ b/hw/virtio/virtio-rdma-pci.c
@@ -0,0 +1,108 @@
+/*
+ * Virtio rdma PCI Bindings
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-net-pci.h"
+#include "hw/virtio/virtio-rdma.h"
+#include "virtio-pci.h"
+#include "qapi/error.h"
+
+typedef struct VirtIORdmaPCI VirtIORdmaPCI;
+
+/*
+ * virtio-rdma-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_RDMA_PCI "virtio-rdma-pci-base"
+#define VIRTIO_RDMA_PCI(obj) \
+        OBJECT_CHECK(VirtIORdmaPCI, (obj), TYPE_VIRTIO_RDMA_PCI)
+
+struct VirtIORdmaPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIORdma vdev;
+};
+
+static Property virtio_rdma_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_rdma_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIORdmaPCI *dev = VIRTIO_RDMA_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIONetPCI *vnet_pci;
+    PCIDevice *func0;
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+
+    func0 = pci_get_function_0(&vpci_dev->pci_dev);
+    /* Break if not virtio device in slot 0 */
+    if (strcmp(object_get_typename(OBJECT(func0)),
+               TYPE_VIRTIO_NET_PCI_GENERIC)) {
+        error_setg(errp, "Device on %x.0 is type %s but must be %s",
+                   PCI_SLOT(vpci_dev->pci_dev.devfn),
+                   object_get_typename(OBJECT(func0)),
+                   TYPE_VIRTIO_NET_PCI_GENERIC);
+        return;
+    }
+    vnet_pci = VIRTIO_NET_PCI(func0);
+    dev->vdev.netdev = &vnet_pci->vdev;
+}
+
+static void virtio_rdma_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
+
+    k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    k->device_id = PCI_DEVICE_ID_VIRTIO_RDMA;
+    k->revision = VIRTIO_PCI_ABI_VERSION;
+    k->class_id = PCI_CLASS_NETWORK_OTHER;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->props = virtio_rdma_properties;
+    vpciklass->realize = virtio_rdma_pci_realize;
+}
+
+static void virtio_rdma_pci_instance_init(Object *obj)
+{
+    VirtIORdmaPCI *dev = VIRTIO_RDMA_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_RDMA);
+    /*
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+    */
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_rdma_pci_info = {
+    .base_name             = TYPE_VIRTIO_RDMA_PCI,
+    .generic_name          = "virtio-rdma-pci",
+    .transitional_name     = "virtio-rdma-pci-transitional",
+    .non_transitional_name = "virtio-rdma-pci-non-transitional",
+    .instance_size = sizeof(VirtIORdmaPCI),
+    .instance_init = virtio_rdma_pci_instance_init,
+    .class_init    = virtio_rdma_pci_class_init,
+};
+
+static void virtio_rdma_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_rdma_pci_info);
+}
+
+type_init(virtio_rdma_pci_register)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d87f5f93e9..c2d34c382f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -85,6 +85,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VIRTIO_RDMA        0x1013
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
diff --git a/include/hw/virtio/virtio-rdma.h b/include/hw/virtio/virtio-rdma.h
new file mode 100644
index 0000000000..3c7534cd8a
--- /dev/null
+++ b/include/hw/virtio/virtio-rdma.h
@@ -0,0 +1,44 @@
+/*
+ * Virtio RDMA Device
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_VIRTIO_RDMA_H
+#define QEMU_VIRTIO_RDMA_H
+
+#include <infiniband/verbs.h>
+
+#include "chardev/char-fe.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-net.h"
+
+#define TYPE_VIRTIO_RDMA "virtio-rdma-device"
+#define VIRTIO_RDMA(obj) \
+        OBJECT_CHECK(VirtIORdma, (obj), TYPE_VIRTIO_RDMA)
+
+typedef struct RdmaBackendDev RdmaBackendDev;
+typedef struct RdmaDeviceResources RdmaDeviceResources;
+struct ibv_device_attr;
+
+typedef struct VirtIORdma {
+    VirtIODevice parent_obj;
+    VirtQueue *ctrl_vq;
+    VirtIONet *netdev;
+    RdmaBackendDev *backend_dev;
+    RdmaDeviceResources *rdma_dev_res;
+    CharBackend mad_chr;
+    char *backend_eth_device_name;
+    char *backend_device_name;
+    uint8_t backend_port_num;
+    struct ibv_device_attr dev_attr;
+} VirtIORdma;
+
+#endif
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6d5c3b2d4f..bd2c699450 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,5 +43,6 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_RDMA         26 /* virtio crypto */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.20.1


