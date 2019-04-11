Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFF7C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1EA2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cZoFiRgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1EA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXdZ-0002B2-Dc
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:12:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEXTZ-0003Il-PR
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEXTP-0000uL-Bw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hEXTO-00082s-Gt
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BAriEe084211; Thu, 11 Apr 2019 11:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references : mime-version :
	content-transfer-encoding; s=corp-2018-07-02;
	bh=Eg/wEs0utPORKGoF88LpTrGrUTtR/V5GQyoGvYxNZGA=;
	b=cZoFiRgVtmZtq9zfV4T+IcL7EpOd8B9QAoVDHN5asWOD6JrL84tuty8RsB/WOKwZKDwB
	ZIoR34bts2eSsmaEnhT8oGBL2Avu5EkYiB+VYx4APRGgvrwpoROkNtIIJxDVlRF4gJX2
	OMlNH9L8UD/MHWkg2IlC8vod25bPwczX3q6lPAXTfpMLOYlHvZyAGyoHrYiHf0+XwSmR
	fu4qtD/9yxcN+lRVbBY+wpWbo+5efOBU51Ekz6FlnxD6oRc+86L6s57QiDeVDoh9ljbu
	0BeHJ+Cj4ybQ5xJku18X4ua64kyqn+4tz2y/M+FfPJKKjtrAeYuygdbOLnlkx3j8QOid
	Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2rpkht8b11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2019 11:02:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BB1gYA059789; Thu, 11 Apr 2019 11:02:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2rpytcq8vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2019 11:02:10 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3BB2APN005791;
	Thu, 11 Apr 2019 11:02:10 GMT
Received: from host4.lan (/77.138.183.59)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 11 Apr 2019 04:02:09 -0700
From: Yuval Shaia <yuval.shaia@oracle.com>
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org,
	mst@redhat.com, cohuck@redhat.com, marcel.apfelbaum@gmail.com,
	linux-rdma@vger.kernel.org, jgg@mellanox.com
Date: Thu, 11 Apr 2019 14:01:57 +0300
Message-Id: <20190411110157.14252-4-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411110157.14252-1-yuval.shaia@oracle.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904110077
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904110077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC 3/3] RDMA/virtio-rdma: VirtIO rdma driver
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
Message-ID: <20190411110157.se78d2uhpRdUvMBkXkEwBTZ69HgRKLlwO7kYTKOjOfw@z>

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/infiniband/Kconfig                    |   1 +
 drivers/infiniband/hw/Makefile                |   1 +
 drivers/infiniband/hw/virtio/Kconfig          |   6 +
 drivers/infiniband/hw/virtio/Makefile         |   4 +
 drivers/infiniband/hw/virtio/virtio_rdma.h    |  40 +
 .../infiniband/hw/virtio/virtio_rdma_device.c |  59 ++
 .../infiniband/hw/virtio/virtio_rdma_device.h |  32 +
 drivers/infiniband/hw/virtio/virtio_rdma_ib.c | 711 ++++++++++++++++++
 drivers/infiniband/hw/virtio/virtio_rdma_ib.h |  48 ++
 .../infiniband/hw/virtio/virtio_rdma_main.c   | 149 ++++
 .../infiniband/hw/virtio/virtio_rdma_netdev.c |  44 ++
 .../infiniband/hw/virtio/virtio_rdma_netdev.h |  33 +
 include/uapi/linux/virtio_ids.h               |   1 +
 13 files changed, 1129 insertions(+)
 create mode 100644 drivers/infiniband/hw/virtio/Kconfig
 create mode 100644 drivers/infiniband/hw/virtio/Makefile
 create mode 100644 drivers/infiniband/hw/virtio/virtio_rdma.h
 create mode 100644 drivers/infiniband/hw/virtio/virtio_rdma_device.c
 create mode 100644 drivers/infiniband/hw/virtio/virtio_rdma_device.h
 create mode 100644 drivers/infiniband/hw/virtio/virtio_rdma_ib.c
 create mode 100644 drivers/infiniband/hw/virtio/virtio_rdma_ib.h
 create mode 100644 drivers/infiniband/hw/virtio/virtio_rdma_main.c
 create mode 100644 drivers/infiniband/hw/virtio/virtio_rdma_netdev.c
 create mode 100644 drivers/infiniband/hw/virtio/virtio_rdma_netdev.h

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index a1fb840de45d..218a47d4cecf 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -107,6 +107,7 @@ source "drivers/infiniband/hw/hfi1/Kconfig"
 source "drivers/infiniband/hw/qedr/Kconfig"
 source "drivers/infiniband/sw/rdmavt/Kconfig"
 source "drivers/infiniband/sw/rxe/Kconfig"
+source "drivers/infiniband/hw/virtio/Kconfig"
 endif
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index e4f31c1be8f7..10ffb2c421e4 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
 obj-$(CONFIG_INFINIBAND_HNS)		+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
+obj-$(CONFIG_INFINIBAND_VIRTIO_RDMA)	+= virtio/
diff --git a/drivers/infiniband/hw/virtio/Kconfig b/drivers/infiniband/hw/virtio/Kconfig
new file mode 100644
index 000000000000..92e41691cf5d
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/Kconfig
@@ -0,0 +1,6 @@
+config INFINIBAND_VIRTIO_RDMA
+	tristate "VirtIO Paravirtualized RDMA Driver"
+	depends on NETDEVICES && ETHERNET && PCI && INET
+	---help---
+	  This driver provides low-level support for VirtIO Paravirtual
+	  RDMA adapter.
diff --git a/drivers/infiniband/hw/virtio/Makefile b/drivers/infiniband/hw/virtio/Makefile
new file mode 100644
index 000000000000..fb637e467167
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_INFINIBAND_VIRTIO_RDMA) += virtio_rdma.o
+
+virtio_rdma-y := virtio_rdma_main.o virtio_rdma_device.o virtio_rdma_ib.o \
+		 virtio_rdma_netdev.o
diff --git a/drivers/infiniband/hw/virtio/virtio_rdma.h b/drivers/infiniband/hw/virtio/virtio_rdma.h
new file mode 100644
index 000000000000..7896a2dfb812
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/virtio_rdma.h
@@ -0,0 +1,40 @@
+/*
+ * Virtio RDMA device: Driver main data types
+ *
+ * Copyright (C) 2019 Yuval Shaia Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#ifndef __VIRTIO_RDMA__
+#define __VIRTIO_RDMA__
+
+#include <linux/virtio.h>
+#include <rdma/ib_verbs.h>
+
+struct virtio_rdma_info {
+	struct ib_device ib_dev;
+	struct virtio_device *vdev;
+	struct virtqueue *ctrl_vq;
+	wait_queue_head_t acked; /* arm on send to host, release on recv */
+	struct net_device *netdev;
+};
+
+static inline struct virtio_rdma_info *to_vdev(struct ib_device *ibdev)
+{
+	return container_of(ibdev, struct virtio_rdma_info, ib_dev);
+}
+
+#endif
diff --git a/drivers/infiniband/hw/virtio/virtio_rdma_device.c b/drivers/infiniband/hw/virtio/virtio_rdma_device.c
new file mode 100644
index 000000000000..ae41e530644f
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/virtio_rdma_device.c
@@ -0,0 +1,59 @@
+/*
+ * Virtio RDMA device: Device related functions and data
+ *
+ * Copyright (C) 2019 Yuval Shaia Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#include <linux/virtio_config.h>
+
+#include "virtio_rdma.h"
+
+static void rdma_ctrl_ack(struct virtqueue *vq)
+{
+	struct virtio_rdma_info *dev = vq->vdev->priv;
+
+	wake_up(&dev->acked);
+
+	printk("%s\n", __func__);
+}
+
+int init_device(struct virtio_rdma_info *dev)
+{
+#define TMP_MAX_VQ 1
+	int rc;
+	struct virtqueue *vqs[TMP_MAX_VQ];
+	vq_callback_t *cbs[TMP_MAX_VQ];
+	const char *names[TMP_MAX_VQ];
+
+	names[0] = "ctrl";
+	cbs[0] = rdma_ctrl_ack;
+	cbs[0] = NULL;
+
+	rc = virtio_find_vqs(dev->vdev, TMP_MAX_VQ, vqs, cbs, names, NULL);
+	if (rc)
+		return rc;
+
+	dev->ctrl_vq = vqs[0];
+
+	return 0;
+}
+
+void fini_device(struct virtio_rdma_info *dev)
+{
+	dev->vdev->config->reset(dev->vdev);
+	dev->vdev->config->del_vqs(dev->vdev);
+}
diff --git a/drivers/infiniband/hw/virtio/virtio_rdma_device.h b/drivers/infiniband/hw/virtio/virtio_rdma_device.h
new file mode 100644
index 000000000000..d9b1240daf92
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/virtio_rdma_device.h
@@ -0,0 +1,32 @@
+/*
+ * Virtio RDMA device: Device related functions and data
+ *
+ * Copyright (C) 2019 Yuval Shaia Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#ifndef __VIRTIO_RDMA_DEVICE__
+#define __VIRTIO_RDMA_DEVICE__
+
+#define VIRTIO_RDMA_BOARD_ID	1
+#define VIRTIO_RDMA_HW_NAME	"virtio-rdma"
+#define VIRTIO_RDMA_HW_REV	1
+#define VIRTIO_RDMA_DRIVER_VER	"1.0"
+
+int init_device(struct virtio_rdma_info *dev);
+void fini_device(struct virtio_rdma_info *dev);
+
+#endif
diff --git a/drivers/infiniband/hw/virtio/virtio_rdma_ib.c b/drivers/infiniband/hw/virtio/virtio_rdma_ib.c
new file mode 100644
index 000000000000..02bf4a332611
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/virtio_rdma_ib.c
@@ -0,0 +1,711 @@
+/*
+ * Virtio RDMA device: IB related functions and data
+ *
+ * Copyright (C) 2019 Yuval Shaia Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#include <linux/scatterlist.h>
+#include <linux/virtio.h>
+#include <rdma/ib_mad.h>
+
+#include "virtio_rdma.h"
+#include "virtio_rdma_device.h"
+#include "virtio_rdma_ib.h"
+
+/* TODO: Move to uapi header file */
+
+/*
+ * Control virtqueue data structures
+ *
+ * The control virtqueue expects a header in the first sg entry
+ * and an ack/status response in the last entry.  Data for the
+ * command goes in between.
+ */
+
+#define VIRTIO_RDMA_CTRL_OK	0
+#define VIRTIO_RDMA_CTRL_ERR	1
+
+struct control_buf {
+	__u8 cmd;
+	__u8 status;
+};
+
+enum {
+	VIRTIO_CMD_QUERY_DEVICE = 10,
+	VIRTIO_CMD_QUERY_PORT,
+	VIRTIO_CMD_CREATE_CQ,
+	VIRTIO_CMD_DESTROY_CQ,
+	VIRTIO_CMD_CREATE_PD,
+	VIRTIO_CMD_DESTROY_PD,
+	VIRTIO_CMD_GET_DMA_MR,
+};
+
+struct cmd_query_port {
+	__u8 port;
+};
+
+struct cmd_create_cq {
+	__u32 cqe;
+};
+
+struct rsp_create_cq {
+	__u32 cqn;
+};
+
+struct cmd_destroy_cq {
+	__u32 cqn;
+};
+
+struct rsp_create_pd {
+	__u32 pdn;
+};
+
+struct cmd_destroy_pd {
+	__u32 pdn;
+};
+
+struct cmd_get_dma_mr {
+	__u32 pdn;
+	__u32 access_flags;
+};
+
+struct rsp_get_dma_mr {
+	__u32 mrn;
+	__u32 lkey;
+	__u32 rkey;
+};
+
+/* TODO: Move to uapi header file */
+
+struct virtio_rdma_ib_cq {
+	struct ib_cq ibcq;
+	u32 cq_handle;
+};
+
+/* TODO: For the scope fof the RFC i'm utilizing ib*_*_attr structures */
+
+static int virtio_rdma_exec_cmd(struct virtio_rdma_info *di, int cmd,
+				struct scatterlist *in, struct scatterlist *out)
+{
+	struct scatterlist *sgs[4], hdr, status;
+	struct control_buf *ctrl;
+	unsigned tmp;
+	int rc;
+
+	ctrl = kmalloc(sizeof(*ctrl), GFP_ATOMIC);
+	ctrl->cmd = cmd;
+	ctrl->status = ~0;
+
+	sg_init_one(&hdr, &ctrl->cmd, sizeof(ctrl->cmd));
+	sgs[0] = &hdr;
+	sgs[1] = in;
+	sgs[2] = out;
+	sg_init_one(&status, &ctrl->status, sizeof(ctrl->status));
+	sgs[3] = &status;
+
+	rc = virtqueue_add_sgs(di->ctrl_vq, sgs, 2, 2, di, GFP_ATOMIC);
+	if (rc)
+		goto out;
+
+	if (unlikely(!virtqueue_kick(di->ctrl_vq))) {
+		goto out_with_status;
+	}
+
+	/* Spin for a response, the kick causes an ioport write, trapping
+	 * into the hypervisor, so the request should be handled
+	 * immediately */
+	while (!virtqueue_get_buf(di->ctrl_vq, &tmp) &&
+	       !virtqueue_is_broken(di->ctrl_vq))
+		cpu_relax();
+
+out_with_status:
+	printk("%s: cmd %d, status %d\n", __func__, ctrl->cmd, ctrl->status);
+	rc = ctrl->status == VIRTIO_RDMA_CTRL_OK ? 0 : 1;
+
+out:
+	kfree(ctrl);
+
+	return rc;
+}
+
+static int virtio_rdma_port_immutable(struct ib_device *ibdev, u8 port_num,
+				      struct ib_port_immutable *immutable)
+{
+	struct ib_port_attr attr;
+	int rc;
+
+	rc = ib_query_port(ibdev, port_num, &attr);
+	if (rc)
+		return rc;
+
+	immutable->core_cap_flags |= RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
+	immutable->pkey_tbl_len = attr.pkey_tbl_len;
+	immutable->gid_tbl_len = attr.gid_tbl_len;
+	immutable->max_mad_size = IB_MGMT_MAD_SIZE;
+
+	return 0;
+}
+
+static int virtio_rdma_query_device(struct ib_device *ibdev,
+				    struct ib_device_attr *props,
+				    struct ib_udata *uhw)
+{
+	struct scatterlist data;
+	int offs;
+	int rc;
+
+	if (uhw->inlen || uhw->outlen)
+		return -EINVAL;
+
+	/* We start with sys_image_guid because of inconsistency beween ib_
+	 * and ibv_ */
+	offs = offsetof(struct ib_device_attr, sys_image_guid);
+	sg_init_one(&data, (void *)props + offs, sizeof(*props) - offs);
+
+	rc = virtio_rdma_exec_cmd(to_vdev(ibdev), VIRTIO_CMD_QUERY_DEVICE, NULL,
+				  &data);
+
+	printk("%s: sys_image_guid 0x%llx\n", __func__,
+	       be64_to_cpu(props->sys_image_guid));
+
+	return rc;
+}
+
+static int virtio_rdma_query_port(struct ib_device *ibdev, u8 port,
+				  struct ib_port_attr *props)
+{
+	struct scatterlist in, out;
+	struct cmd_query_port *cmd;
+	int offs;
+	int rc;
+
+	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	/* We start with state because of inconsistency beween ib and ibv */
+	offs = offsetof(struct ib_port_attr, state);
+	sg_init_one(&out, (void *)props + offs, sizeof(*props) - offs);
+
+	cmd->port = port;
+	sg_init_one(&in, cmd, sizeof(*cmd));
+	printk("%s: port %d\n", __func__, cmd->port);
+
+	rc = virtio_rdma_exec_cmd(to_vdev(ibdev), VIRTIO_CMD_QUERY_PORT, &in,
+				  &out);
+
+	printk("%s: gid_tbl_len %d\n", __func__, props->gid_tbl_len);
+
+	kfree(cmd);
+
+	return rc;
+}
+
+static struct net_device *virtio_rdma_get_netdev(struct ib_device *ibdev,
+						 u8 port_num)
+{
+	struct virtio_rdma_info *ri = to_vdev(ibdev);
+
+	printk("%s:\n", __func__);
+
+	return ri->netdev;
+}
+
+struct ib_cq *virtio_rdma_create_cq(struct ib_device *ibdev,
+				    const struct ib_cq_init_attr *attr,
+				    struct ib_ucontext *context,
+				    struct ib_udata *udata)
+{
+	struct scatterlist in, out;
+	struct virtio_rdma_ib_cq *vcq;
+	struct cmd_create_cq *cmd;
+	struct rsp_create_cq *rsp;
+	struct ib_cq *cq = NULL;
+	int rc;
+
+	/* TODO: Check MAX_CQ */
+
+	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd)
+		return ERR_PTR(-ENOMEM);
+
+	rsp = kmalloc(sizeof(*rsp), GFP_ATOMIC);
+	if (!rsp) {
+		kfree(cmd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	vcq = kzalloc(sizeof(*vcq), GFP_KERNEL);
+	if (!vcq)
+		goto out;
+
+	cmd->cqe = attr->cqe;
+	sg_init_one(&in, cmd, sizeof(*cmd));
+	printk("%s: cqe %d\n", __func__, cmd->cqe);
+
+	sg_init_one(&out, rsp, sizeof(*rsp));
+
+	rc = virtio_rdma_exec_cmd(to_vdev(ibdev), VIRTIO_CMD_CREATE_CQ, &in,
+				  &out);
+	if (rc)
+		goto out_err;
+
+	printk("%s: cqn 0x%x\n", __func__, rsp->cqn);
+	vcq->cq_handle = rsp->cqn;
+	vcq->ibcq.cqe = attr->cqe;
+	cq = &vcq->ibcq;
+
+	goto out;
+
+out_err:
+	kfree(vcq);
+	return ERR_PTR(rc);
+
+out:
+	kfree(rsp);
+	kfree(cmd);
+	return cq;
+}
+
+int virtio_rdma_destroy_cq(struct ib_cq *cq)
+{
+	struct virtio_rdma_ib_cq *vcq;
+	struct scatterlist in;
+	struct cmd_destroy_cq *cmd;
+	int rc;
+
+	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	vcq = container_of(cq, struct virtio_rdma_ib_cq, ibcq);
+
+	cmd->cqn = vcq->cq_handle;
+	sg_init_one(&in, cmd, sizeof(*cmd));
+
+	rc = virtio_rdma_exec_cmd(to_vdev(cq->device), VIRTIO_CMD_DESTROY_CQ,
+				  &in, NULL);
+
+	kfree(cmd);
+
+	kfree(vcq);
+
+	return rc;
+}
+
+int virtio_rdma_alloc_pd(struct ib_pd *ibpd, struct ib_ucontext *context,
+			 struct ib_udata *udata)
+{
+	struct virtio_rdma_pd *pd = to_vpd(ibpd);
+	struct ib_device *ibdev = ibpd->device;
+	struct rsp_create_pd *rsp;
+	struct scatterlist out;
+	int rc;
+
+	/* TODO: Check MAX_PD */
+
+	rsp = kmalloc(sizeof(*rsp), GFP_ATOMIC);
+	if (!rsp)
+		return -ENOMEM;
+
+	sg_init_one(&out, rsp, sizeof(*rsp));
+
+	rc = virtio_rdma_exec_cmd(to_vdev(ibdev), VIRTIO_CMD_CREATE_PD, NULL,
+				  &out);
+	if (rc)
+		goto out;
+
+	pd->pd_handle = rsp->pdn;
+
+	printk("%s: pd_handle=%d\n", __func__, pd->pd_handle);
+
+out:
+	kfree(rsp);
+
+	printk("%s: rc=%d\n", __func__, rc);
+	return rc;
+}
+
+void virtio_rdma_dealloc_pd(struct ib_pd *pd)
+{
+	struct virtio_rdma_pd *vpd = to_vpd(pd);
+	struct ib_device *ibdev = pd->device;
+	struct cmd_destroy_pd *cmd;
+	struct scatterlist in;
+
+	printk("%s:\n", __func__);
+
+	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd)
+		return;
+
+	cmd->pdn = vpd->pd_handle;
+	sg_init_one(&in, cmd, sizeof(*cmd));
+
+	virtio_rdma_exec_cmd(to_vdev(ibdev), VIRTIO_CMD_DESTROY_PD, &in, NULL);
+
+	kfree(cmd);
+}
+
+struct ib_mr *virtio_rdma_get_dma_mr(struct ib_pd *pd, int acc)
+
+{
+	struct virtio_rdma_user_mr *mr;
+	struct scatterlist in, out;
+	struct cmd_get_dma_mr *cmd = NULL;
+	struct rsp_get_dma_mr *rsp = NULL;
+	int rc;
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd) {
+		kfree(mr);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rsp = kmalloc(sizeof(*rsp), GFP_ATOMIC);
+	if (!cmd) {
+		kfree(mr);
+		kfree(cmd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	cmd->pdn = to_vpd(pd)->pd_handle;
+	cmd->access_flags = acc;
+	sg_init_one(&in, cmd, sizeof(*cmd));
+
+	sg_init_one(&out, rsp, sizeof(*rsp));
+
+	rc = virtio_rdma_exec_cmd(to_vdev(pd->device), VIRTIO_CMD_GET_DMA_MR,
+				  &in, &out);
+	if (rc) {
+		kfree(mr);
+		kfree(cmd);
+		return ERR_PTR(rc);
+	}
+
+	mr->mr_handle = rsp->mrn;
+	mr->ibmr.lkey = rsp->lkey;
+	mr->ibmr.rkey = rsp->rkey;
+
+	printk("%s: mr_handle=0x%x\n", __func__, mr->mr_handle);
+
+	kfree(cmd);
+	kfree(rsp);
+
+	return &mr->ibmr;
+}
+
+struct ib_qp *virtio_rdma_create_qp(struct ib_pd *pd,
+				    struct ib_qp_init_attr *init_attr,
+				    struct ib_udata *udata)
+{
+	/* struct pvrdma_dev *dev = to_vdev(pd->device); */
+	struct virtio_rdma_qp *qp;
+
+	printk("%s:\n", __func__);
+
+	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return ERR_PTR(-ENOMEM);
+
+	return &qp->ibqp;
+}
+
+int virtio_rdma_query_gid(struct ib_device *ibdev, u8 port, int index,
+			  union ib_gid *gid)
+{
+	memset(gid, 0, sizeof(union ib_gid));
+
+	printk("%s: port %d, index %d\n", __func__, port, index);
+
+	return 0;
+}
+
+static int virtio_rdma_add_gid(const struct ib_gid_attr *attr, void **context)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+struct ib_mr *virtio_rdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
+				   u32 max_num_sg)
+{
+	printk("%s: mr_type %d, max_num_sg %d\n", __func__, mr_type,
+	       max_num_sg);
+
+	return NULL;
+}
+
+int virtio_rdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+struct ib_ah *virtio_rdma_create_ah(struct ib_pd *pd,
+				    struct rdma_ah_attr *ah_attr, u32 flags,
+				    struct ib_udata *udata)
+{
+	printk("%s:\n", __func__);
+
+	return NULL;
+}
+
+void virtio_rdma_dealloc_ucontext(struct ib_ucontext *ibcontext)
+
+{
+}
+
+static int virtio_rdma_del_gid(const struct ib_gid_attr *attr, void **context)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_dereg_mr(struct ib_mr *ibmr)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_destroy_ah(struct ib_ah *ah, u32 flags)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+struct virtio_rdma_cq {
+	struct ib_cq ibcq;
+};
+
+int virtio_rdma_destroy_qp(struct ib_qp *qp)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+static void virtio_rdma_get_fw_ver_str(struct ib_device *device, char *str)
+{
+	printk("%s:\n", __func__);
+}
+
+enum rdma_link_layer virtio_rdma_port_link_layer(struct ib_device *ibdev,
+						 u8 port)
+{
+	return IB_LINK_LAYER_ETHERNET;
+}
+
+int virtio_rdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
+			  int sg_nents, unsigned int *sg_offset)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_modify_port(struct ib_device *ibdev, u8 port, int mask,
+			    struct ib_port_modify *props)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+			  int attr_mask, struct ib_udata *udata)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
+			  const struct ib_recv_wr **bad_wr)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
+			  const struct ib_send_wr **bad_wr)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
+			   u16 *pkey)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+int virtio_rdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+			 int attr_mask, struct ib_qp_init_attr *init_attr)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+struct ib_mr *virtio_rdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
+				      u64 virt_addr, int access_flags,
+				      struct ib_udata *udata)
+{
+	printk("%s:\n", __func__);
+
+	return NULL;
+}
+
+int virtio_rdma_req_notify_cq(struct ib_cq *ibcq,
+			      enum ib_cq_notify_flags notify_flags)
+{
+	printk("%s:\n", __func__);
+
+	return 0;
+}
+
+static const struct ib_device_ops virtio_rdma_dev_ops = {
+	.get_port_immutable = virtio_rdma_port_immutable,
+	.query_device = virtio_rdma_query_device,
+	.query_port = virtio_rdma_query_port,
+	.get_netdev = virtio_rdma_get_netdev,
+	.create_cq = virtio_rdma_create_cq,
+	.destroy_cq = virtio_rdma_destroy_cq,
+	.alloc_pd = virtio_rdma_alloc_pd,
+	.dealloc_pd = virtio_rdma_dealloc_pd,
+	.get_dma_mr = virtio_rdma_get_dma_mr,
+	.create_qp = virtio_rdma_create_qp,
+	.query_gid = virtio_rdma_query_gid,
+	.add_gid = virtio_rdma_add_gid,
+	.alloc_mr = virtio_rdma_alloc_mr,
+	.alloc_ucontext = virtio_rdma_alloc_ucontext,
+	.create_ah = virtio_rdma_create_ah,
+	.dealloc_ucontext = virtio_rdma_dealloc_ucontext,
+	.del_gid = virtio_rdma_del_gid,
+	.dereg_mr = virtio_rdma_dereg_mr,
+	.destroy_ah = virtio_rdma_destroy_ah,
+	.destroy_qp = virtio_rdma_destroy_qp,
+	.get_dev_fw_str = virtio_rdma_get_fw_ver_str,
+	.get_link_layer = virtio_rdma_port_link_layer,
+	.get_port_immutable = virtio_rdma_port_immutable,
+	.map_mr_sg = virtio_rdma_map_mr_sg,
+	.mmap = virtio_rdma_mmap,
+	.modify_port = virtio_rdma_modify_port,
+	.modify_qp = virtio_rdma_modify_qp,
+	.poll_cq = virtio_rdma_poll_cq,
+	.post_recv = virtio_rdma_post_recv,
+	.post_send = virtio_rdma_post_send,
+	.query_device = virtio_rdma_query_device,
+	.query_pkey = virtio_rdma_query_pkey,
+	.query_port = virtio_rdma_query_port,
+	.query_qp = virtio_rdma_query_qp,
+	.reg_user_mr = virtio_rdma_reg_user_mr,
+	.req_notify_cq = virtio_rdma_req_notify_cq,
+	INIT_RDMA_OBJ_SIZE(ib_pd, virtio_rdma_pd, ibpd),
+};
+
+static ssize_t hca_type_show(struct device *device,
+			     struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s-%s\n", VIRTIO_RDMA_HW_NAME,
+		       VIRTIO_RDMA_DRIVER_VER);
+}
+static DEVICE_ATTR_RO(hca_type);
+
+static ssize_t hw_rev_show(struct device *device,
+			   struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", VIRTIO_RDMA_HW_REV);
+}
+static DEVICE_ATTR_RO(hw_rev);
+
+static ssize_t board_id_show(struct device *device,
+			     struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", VIRTIO_RDMA_BOARD_ID);
+}
+static DEVICE_ATTR_RO(board_id);
+
+static struct attribute *virtio_rdmaa_class_attributes[] = {
+	&dev_attr_hw_rev.attr,
+	&dev_attr_hca_type.attr,
+	&dev_attr_board_id.attr,
+	NULL,
+};
+
+static const struct attribute_group virtio_rdmaa_attr_group = {
+	.attrs = virtio_rdmaa_class_attributes,
+};
+
+int init_ib(struct virtio_rdma_info *ri)
+{
+	int rc;
+
+	ri->ib_dev.owner = THIS_MODULE;
+	ri->ib_dev.num_comp_vectors = 1;
+	ri->ib_dev.dev.parent = &ri->vdev->dev;
+	ri->ib_dev.node_type = RDMA_NODE_IB_CA;
+	ri->ib_dev.phys_port_cnt = 1;
+	ri->ib_dev.uverbs_cmd_mask =
+		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
+		(1ull << IB_USER_VERBS_CMD_QUERY_PORT)		|
+		(1ull << IB_USER_VERBS_CMD_CREATE_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_ALLOC_PD)		|
+		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD);
+
+	rdma_set_device_sysfs_group(&ri->ib_dev, &virtio_rdmaa_attr_group);
+
+	ib_set_device_ops(&ri->ib_dev, &virtio_rdma_dev_ops);
+
+	rc = ib_register_device(&ri->ib_dev, "virtio_rdma%d");
+
+	return rc;
+}
+
+void fini_ib(struct virtio_rdma_info *ri)
+{
+	ib_unregister_device(&ri->ib_dev);
+}
diff --git a/drivers/infiniband/hw/virtio/virtio_rdma_ib.h b/drivers/infiniband/hw/virtio/virtio_rdma_ib.h
new file mode 100644
index 000000000000..7b82a60581ff
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/virtio_rdma_ib.h
@@ -0,0 +1,48 @@
+/*
+ * Virtio RDMA device: IB related functions and data
+ *
+ * Copyright (C) 2019 Yuval Shaia Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#ifndef __VIRTIO_RDMA_IB__
+#define __VIRTIO_RDMA_IB__
+
+#include <rdma/ib_verbs.h>
+
+struct virtio_rdma_pd {
+	struct ib_pd ibpd;
+	u32 pd_handle;
+};
+
+struct virtio_rdma_user_mr {
+	struct ib_mr ibmr;
+	u32 mr_handle;
+};
+
+struct virtio_rdma_qp {
+	struct ib_qp ibqp;
+};
+
+static inline struct virtio_rdma_pd *to_vpd(struct ib_pd *ibpd)
+{
+	return container_of(ibpd, struct virtio_rdma_pd, ibpd);
+}
+
+int init_ib(struct virtio_rdma_info *ri);
+void fini_ib(struct virtio_rdma_info *ri);
+
+#endif
diff --git a/drivers/infiniband/hw/virtio/virtio_rdma_main.c b/drivers/infiniband/hw/virtio/virtio_rdma_main.c
new file mode 100644
index 000000000000..811533d63160
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/virtio_rdma_main.c
@@ -0,0 +1,149 @@
+/*
+ * Virtio RDMA device
+ *
+ * Copyright (C) 2019 Yuval Shaia Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#include <linux/err.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/virtio.h>
+#include <linux/module.h>
+#include <uapi/linux/virtio_ids.h>
+
+#include "virtio_rdma.h"
+#include "virtio_rdma_device.h"
+#include "virtio_rdma_ib.h"
+#include "virtio_rdma_netdev.h"
+
+/* TODO:
+ * - How to hook to unload driver, we need to undo all the stuff with did
+ *   for all the devices that probed
+ * -
+ */
+
+static int virtio_rdma_probe(struct virtio_device *vdev)
+{
+	struct virtio_rdma_info *ri;
+	int rc = -EIO;
+
+	ri = ib_alloc_device(virtio_rdma_info, ib_dev);
+	if (!ri) {
+		pr_err("Fail to allocate IB device\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	vdev->priv = ri;
+
+	ri->vdev = vdev;
+
+	rc = init_device(ri);
+	if (rc) {
+		pr_err("Fail to connect to device\n");
+		goto out_dealloc_ib_device;
+	}
+
+	rc = init_netdev(ri);
+	if (rc) {
+		pr_err("Fail to connect to NetDev layer\n");
+		goto out_fini_device;
+	}
+
+	rc = init_ib(ri);
+	if (rc) {
+		pr_err("Fail to connect to IB layer\n");
+		goto out_fini_netdev;
+	}
+
+	pr_info("VirtIO RDMA device %d probed\n", vdev->index);
+
+	goto out;
+
+out_fini_netdev:
+	fini_netdev(ri);
+
+out_fini_device:
+	fini_device(ri);
+
+out_dealloc_ib_device:
+	ib_dealloc_device(&ri->ib_dev);
+
+	vdev->priv = NULL;
+
+out:
+	return rc;
+}
+
+static void virtio_rdma_remove(struct virtio_device *vdev)
+{
+	struct virtio_rdma_info *ri = vdev->priv;
+
+	if (!ri)
+		return;
+
+	vdev->priv = NULL;
+
+	fini_ib(ri);
+
+	fini_netdev(ri);
+
+	fini_device(ri);
+
+	ib_dealloc_device(&ri->ib_dev);
+
+	pr_info("VirtIO RDMA device %d removed\n", vdev->index);
+}
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_RDMA, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_rdma_driver = {
+	.driver.name	= KBUILD_MODNAME,
+	.driver.owner	= THIS_MODULE,
+	.id_table	= id_table,
+	.probe		= virtio_rdma_probe,
+	.remove		= virtio_rdma_remove,
+};
+
+static int __init virtio_rdma_init(void)
+{
+	int rc;
+
+	rc = register_virtio_driver(&virtio_rdma_driver);
+	if (rc) {
+		pr_err("%s: Fail to register virtio driver (%d)\n", __func__,
+		       rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void __exit virtio_rdma_fini(void)
+{
+	unregister_virtio_driver(&virtio_rdma_driver);
+}
+
+module_init(virtio_rdma_init);
+module_exit(virtio_rdma_fini);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_AUTHOR("Yuval Shaia");
+MODULE_DESCRIPTION("Virtio RDMA driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/infiniband/hw/virtio/virtio_rdma_netdev.c b/drivers/infiniband/hw/virtio/virtio_rdma_netdev.c
new file mode 100644
index 000000000000..001f30b3e0b9
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/virtio_rdma_netdev.c
@@ -0,0 +1,44 @@
+/*
+ * Virtio RDMA device
+ *
+ * Copyright (C) 2019 Yuval Shaia Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#include "virtio_rdma_netdev.h"
+
+int init_netdev(struct virtio_rdma_info *ri)
+{
+	struct net_device *dev;
+	struct virtio_rdma_netdev_info *vrndi;
+
+	dev = alloc_etherdev(sizeof(struct virtio_rdma_netdev_info));
+	if (!dev) {
+		return -ENOMEM;
+	}
+
+	SET_NETDEV_DEV(dev, &ri->vdev->dev);
+	vrndi = netdev_priv(dev);
+	vrndi->ri = ri;
+	ri->netdev = dev;
+
+	return 0;
+}
+
+void fini_netdev(struct virtio_rdma_info *ri)
+{
+	unregister_netdev(ri->netdev);
+}
diff --git a/drivers/infiniband/hw/virtio/virtio_rdma_netdev.h b/drivers/infiniband/hw/virtio/virtio_rdma_netdev.h
new file mode 100644
index 000000000000..e7e5d276d8ec
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/virtio_rdma_netdev.h
@@ -0,0 +1,33 @@
+/*
+ * Virtio RDMA device: Netdev related functions and data
+ *
+ * Copyright (C) 2019 Yuval Shaia Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#ifndef __VIRTIO_RDMA_NETDEV__
+#define __VIRTIO_RDMA_NETDEV__
+
+#include "virtio_rdma.h"
+
+struct virtio_rdma_netdev_info {
+	struct virtio_rdma_info *ri;
+};
+
+int init_netdev(struct virtio_rdma_info *ri);
+void fini_netdev(struct virtio_rdma_info *ri);
+
+#endif
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 6d5c3b2d4f4d..288ee6fec8d3 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -43,5 +43,6 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_RDMA         26 /* RDMA */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.17.0


