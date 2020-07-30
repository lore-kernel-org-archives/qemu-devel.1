Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5196C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0712082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ecgJHuBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0712082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1AmZ-0004LA-UD
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdZ-0007hN-Pt
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdV-0002CX-Vt
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSrl007533;
 Thu, 30 Jul 2020 15:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=UF79pvoFFJrsRYU2u2K28RtDkLoecSqXccCEeTdSY4A=;
 b=ecgJHuBNf/qK2wMV3XHPCVD5ikOXxVnRjA0Z5VMPbqQe+7mrlCR3wv4k1GSC7+nV1sKe
 jNznwLs0DIzWWfQ3fJM8sBsIwKgrSG6CRA33Bmkgkcc7lBpYygmnReQ65Lw4kdcDoEWZ
 tP4ICI+QlVXDI/Mt6q4+lvVXRYzj0rqF3RYNGDV/CPVZNEB2n4iGzlfuAx3XLbVX1a0L
 /vaxV2hx87nwKsAt6hjVJIOw5kO1aD7f9r8AGD0DGhRbJI8yuiNQmysppoGdZ5jjFi7M
 LQhIF039F4DdroVKmP4PJpmvaK1giD1081PuHih3gcGD6L14DQ9MC2QVPLL6sgeJb2n1 SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 32hu1jmfga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFWpjI188534;
 Thu, 30 Jul 2020 15:38:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 32hu5xja81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UFcIrw020542;
 Thu, 30 Jul 2020 15:38:18 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:18 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 31/32] vfio-pci: trace pci config
Date: Thu, 30 Jul 2020 08:14:35 -0700
Message-Id: <1596122076-341293-32-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new trace points trace_vfio_pci_config and trace_vfio_msix_table to dump
PCI config space and MSI data.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c        | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |  2 ++
 2 files changed, 101 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5743807..f72e277 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2715,6 +2715,90 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+/* To limit output, trace only this many bytes of config. */
+#define CONFIG_LEN 512
+
+static void vfio_dump_config(const char *name, int fd, off_t offset)
+{
+    int i, j, n, config[CONFIG_LEN / 4];
+    char buf[128];
+    const char *fmt;
+    char *ptr = buf;
+    int *v = config;
+    int len = sizeof(buf) - 1;
+
+#ifdef CONFIG_TRACE_DTRACE
+    if (!QEMU_VFIO_PCI_CONFIG_ENABLED()) {
+        return;
+    }
+#endif
+
+    if (pread(fd, &config, sizeof(config), offset) < 0) {
+        perror("pread");
+        return;
+    }
+
+    trace_vfio_pci_config(name);
+
+    for (i = 0; i < CONFIG_LEN; i += 32, v += 8) {
+        n = snprintf(buf, len, "+%3d:", i);
+        ptr += n;
+        len -= n;
+        for (j = 0; j < 8; j++) {
+            fmt = v[j] ?  " %08x" : " %8x";
+            n = snprintf(ptr, len, fmt, v[j]);
+            ptr += n;
+            len -= n;
+        }
+        *ptr = 0;   /* terminate in case of truncation above */
+        trace_vfio_pci_config(buf);
+    }
+}
+
+static void vfio_dump_config_vdev(VFIOPCIDevice *vdev)
+{
+    vfio_dump_config(vdev->vbasedev.name, vdev->vbasedev.fd,
+                     vdev->config_offset);
+}
+
+static void vfio_dump_msix_vdev(VFIOPCIDevice *vdev)
+{
+    int i;
+    int *ptr = (int *) vdev->pdev.msix_table;
+
+    for (i = 0; i < vdev->pdev.msix_entries_nr; i++, ptr += 4) {
+        trace_vfio_msix_table(vdev->vbasedev.name, i,
+                              ptr[0], ptr[1], ptr[2], ptr[3]);
+    }
+}
+
+static void vfio_diff_config(VFIOPCIDevice *vdev)
+{
+    int i;
+    unsigned char config[CONFIG_LEN];
+    int n = sizeof(config);
+    unsigned char *c1 = (unsigned char *)config;
+    unsigned char *c2 = (unsigned char *)vdev->pdev.config;
+    char buf[128];
+
+#ifdef CONFIG_TRACE_DTRACE
+    if (!QEMU_VFIO_PCI_CONFIG_ENABLED()) {
+        return;
+    }
+#endif
+
+    if (pread(vdev->vbasedev.fd, &config, n, vdev->config_offset) != n) {
+        error_report("vfio_diff_config pread failed");
+    }
+    for (i = 0; i < CONFIG_LEN; i++) {
+        if (c1[i] != c2[i]) {
+            snprintf(buf, sizeof(buf),
+                     "config mismatch at %d: %x vs %x", i, c1[i], c2[i]);
+            trace_vfio_pci_config(buf);
+        }
+    }
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = PCI_VFIO(pdev);
@@ -3037,6 +3121,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (pdev->reused) {
         pci_update_mappings(pdev);
     }
+    vfio_diff_config(vdev);
+    vfio_dump_config_vdev(vdev);
+    vfio_dump_msix_vdev(vdev);
 
     return;
 
@@ -3207,6 +3294,15 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static int vfio_pci_pre_save(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+
+    vfio_dump_config_vdev(vdev);
+    vfio_dump_msix_vdev(vdev);
+    return 0;
+}
+
 static int vfio_pci_post_load(void *opaque, int version_id)
 {
     int vector;
@@ -3226,6 +3322,8 @@ static int vfio_pci_post_load(void *opaque, int version_id)
             }
         }
 
+        vfio_dump_msix_vdev(vdev);
+
     } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
         vfio_intx_enable(vdev, &err);
         if (err) {
@@ -3246,6 +3344,7 @@ static const VMStateDescription vfio_pci_vmstate = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = vfio_pci_post_load,
+    .pre_save = vfio_pci_pre_save,
     .fields = (VMStateField[]) {
         VMSTATE_MSIX(pdev, VFIOPCIDevice),
         VMSTATE_END_OF_LIST()
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1ef55a..10d899c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -47,6 +47,8 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
+vfio_msix_table(const char *name, int index, int x0, int x1, int x2, int x3) "%s MSI-X[%d] = { %x %x %x %x }"
+vfio_pci_config(const char *buf) "%s"
 
 # pci-quirks.c
 vfio_quirk_rom_blacklisted(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"
-- 
1.8.3.1


