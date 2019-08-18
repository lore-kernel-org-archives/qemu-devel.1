Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD47C3A59F
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 13:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2702087E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 13:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fCVIUtWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2702087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzL8w-0007BC-B8
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 09:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1hzL7e-0006MK-38
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 09:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hzL7b-0000AN-3r
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 09:21:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hzL7a-00009X-UL
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 09:21:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7IDIfHs060883;
 Sun, 18 Aug 2019 13:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=zSUYcUr2OWd1phr39A7Ir4sANA6yOXwYXTKM2tqcpsQ=;
 b=fCVIUtWZVlgRQ+vvP4MjeFD8seJRfd9dD1p4abuuzcSYA0ySh2EtdkZ8TqW7dhcRJF53
 5xFn6NaTF4b689FbPNoiCHE4GwfpRKhQO3dc0VHBmwMdNIzOY81yXCftXn9OcbHlSAHW
 h+eIXa/vkzcremEg4IAU3OdiK9alwDiJLDKbp3tI1YEbGlwl0P5/oeeuvtJtN2ViT6yq
 YvmqH9YU4FSmfA7azgd8QVYwCPtBkBZNSF/6oZ/0fSumnSXKu9OGpD+FU+2xzorRCYL9
 hQPjh3PeFjjO60JPXK6ixxuNHSlep/9ev9MkUHo6IfVK8gZyFDbteg4UPVC6K+2P2Ft4 DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2ue9hp3hpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 18 Aug 2019 13:21:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7IDIA9c087295;
 Sun, 18 Aug 2019 13:21:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2ue8wx80nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 18 Aug 2019 13:21:20 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7IDLIsr011814;
 Sun, 18 Aug 2019 13:21:18 GMT
Received: from host4.lan (/77.138.183.59)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 18 Aug 2019 06:21:17 -0700
From: Yuval Shaia <yuval.shaia@oracle.com>
To: berrange@redhat.com, thuth@redhat.com, philmd@redhat.com,
 pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com
Date: Sun, 18 Aug 2019 16:21:07 +0300
Message-Id: <20190818132107.18181-3-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190818132107.18181-1-yuval.shaia@oracle.com>
References: <20190818132107.18181-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9352
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=995
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908180148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9352
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908180148
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [PATCH 2/2] hw/rdma: Utilize ibv_reg_mr_iova for
 memory registration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtual address that is provided by the guest in post_send and
post_recv operations is related to the guest address space. This address
space is unknown to the HCA resides on host so extra step in these
operations is needed to adjust the address to host virtual address.

This step, which is done in data-path affects performances.

An enhanced verion of MR registration introduced here
https://patchwork.kernel.org/patch/11044467/ can be used so that the
guest virtual address space for this MR is known to the HCA in host.

This will save the data-path adjustment.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c    | 13 +++++++++++++
 hw/rdma/rdma_backend.h    |  5 +++++
 hw/rdma/rdma_rm.c         |  5 +++++
 hw/rdma/vmw/pvrdma_main.c |  6 ++++++
 4 files changed, 29 insertions(+)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c39051068d..c346407cd3 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -391,7 +391,11 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
             return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
         }
 
+#ifdef LEGACY_RDMA_REG_MR
         dsge->addr = (uintptr_t)mr->virt + ssge[ssge_idx].addr - mr->start;
+#else
+        dsge->addr = ssge[ssge_idx].addr;
+#endif
         dsge->length = ssge[ssge_idx].length;
         dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
 
@@ -735,10 +739,19 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
     }
 }
 
+#ifdef LEGACY_RDMA_REG_MR
 int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
                            size_t length, int access)
+#else
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
+                           size_t length, uint64_t guest_start, int access)
+#endif
 {
+#ifdef LEGACY_RDMA_REG_MR
     mr->ibmr = ibv_reg_mr(pd->ibpd, addr, length, access);
+#else
+    mr->ibmr = ibv_reg_mr_iova(pd->ibpd, addr, length, guest_start, access);
+#endif
     if (!mr->ibmr) {
         rdma_error_report("ibv_reg_mr fail, errno=%d", errno);
         return -EIO;
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 7c1a19a2b5..127f96e2d5 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -78,8 +78,13 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
 int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd);
 void rdma_backend_destroy_pd(RdmaBackendPD *pd);
 
+#ifdef LEGACY_RDMA_REG_MR
 int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
                            size_t length, int access);
+#else
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
+                           size_t length, uint64_t guest_start, int access);
+#endif
 void rdma_backend_destroy_mr(RdmaBackendMR *mr);
 
 int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 1927f85472..1524dfaeaa 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -227,8 +227,13 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
         mr->length = guest_length;
         mr->virt += (mr->start & (TARGET_PAGE_SIZE - 1));
 
+#ifdef LEGACY_RDMA_REG_MR
         ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
                                      mr->length, access_flags);
+#else
+        ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
+                                     mr->length, guest_start, access_flags);
+#endif
         if (ret) {
             ret = -EIO;
             goto out_dealloc_mr;
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 3e36e13013..18075285f6 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -664,6 +664,12 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
     qemu_register_shutdown_notifier(&dev->shutdown_notifier);
 
+#ifdef LEGACY_RDMA_REG_MR
+    rdma_info_report("Using legacy reg_mr");
+#else
+    rdma_info_report("Using iova reg_mr");
+#endif
+
 out:
     if (rc) {
         pvrdma_fini(pdev);
-- 
2.20.1


