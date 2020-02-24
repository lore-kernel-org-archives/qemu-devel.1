Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E17C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B13620CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C8/eDHw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B13620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L6m-0000OB-6K
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn1-0008Up-PW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn0-00049S-9n
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kn0-0003yH-0d
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrk6m164205;
 Mon, 24 Feb 2020 20:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=qDYoW1AXMZqQa0NU/wGw7heCo/JWH/fuX33lk6JC2lc=;
 b=C8/eDHw+7CzGJb79ZLNS3sjiwMnvrzC1/QzeCcG3qQtrXU3FbLhcaTU8vsqdPOM16aqy
 va6nOEUXnShHL7bqYmwTXEtoZoLkDlcwyLfv4btZjR31Rh4I+MSAtpY4ZxnNEVHxvx5L
 b1zBQeUispft940of32oAUr5lBSL7cCoHPJDNuYgpw82XArgJcJNNUBG3H5pQTvBjHiI
 Hi8jSw1mDXUrEjMoc7l31WziLIxeLz3ZUu0O3Lu8bxHXLJBmxMDd4IacoRLIjvtAIwia
 s7Ez8gBm7HzeL78nL48fN2KrG+hYu3z+/uQCLEJ+ND2fMvBajViu3Iq1rwzhwY1OacL4 wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p98x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKucmE072901;
 Mon, 24 Feb 2020 20:57:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ybduv6dv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKv0Uf030099;
 Mon, 24 Feb 2020 20:57:00 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:59 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 41/50] multi-process/mig: Enable VMSD save in the Proxy
 object
Date: Mon, 24 Feb 2020 15:55:32 -0500
Message-Id: <f056d73bb7f749171626cb8abc5a317b0ec17845.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Collect the VMSD from remote process on the source and save
it to the channel leading to the destination

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 v4 -> v5:
  - Using qemu_file_shutdown() instead of qemu_thread_cancel(). Removed patch
    which introduced qemu_thread_cancel()

 hw/proxy/qemu-proxy.c         | 135 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |   2 +
 include/io/mpqemu-link.h      |   1 +
 3 files changed, 138 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index b1b9282..19f0dbb 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -23,6 +23,14 @@
 #include "util/event_notifier-posix.c"
 #include "hw/boards.h"
 #include "include/qemu/log.h"
+#include "io/channel.h"
+#include "migration/qemu-file-types.h"
+#include "qapi/error.h"
+#include "io/channel-util.h"
+#include "migration/qemu-file-channel.h"
+#include "migration/qemu-file.h"
+#include "migration/migration.h"
+#include "migration/vmstate.h"
 
 QEMUTimer *hb_timer;
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
@@ -35,6 +43,9 @@ static void broadcast_init(void);
 static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
                           unsigned int op);
 
+#define PAGE_SIZE qemu_real_host_page_size
+uint8_t *mig_data;
+
 static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
 {
     /* TODO: Add proper handler. */
@@ -460,6 +471,129 @@ static void pci_proxy_dev_inst_init(Object *obj)
     dev->mem_init = false;
 }
 
+typedef struct {
+    QEMUFile *rem;
+    PCIProxyDev *dev;
+} proxy_mig_data;
+
+static void *proxy_mig_out(void *opaque)
+{
+    proxy_mig_data *data = opaque;
+    PCIProxyDev *dev = data->dev;
+    uint8_t byte;
+    uint64_t data_size = PAGE_SIZE;
+
+    mig_data = g_malloc(data_size);
+
+    while (true) {
+        byte = qemu_get_byte(data->rem);
+
+        if (qemu_file_get_error(data->rem)) {
+            break;
+        }
+
+        mig_data[dev->migsize++] = byte;
+        if (dev->migsize == data_size) {
+            data_size += PAGE_SIZE;
+            mig_data = g_realloc(mig_data, data_size);
+        }
+    }
+
+    return NULL;
+}
+
+static int proxy_pre_save(void *opaque)
+{
+    PCIProxyDev *pdev = opaque;
+    proxy_mig_data *mig_data;
+    QEMUFile *f_remote;
+    MPQemuMsg msg = {0};
+    QemuThread thread;
+    Error *err = NULL;
+    QIOChannel *ioc;
+    uint64_t size;
+    int fd[2];
+
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
+        return -1;
+    }
+
+    ioc = qio_channel_new_fd(fd[0], &err);
+    if (err) {
+        error_report_err(err);
+        return -1;
+    }
+
+    qio_channel_set_name(QIO_CHANNEL(ioc), "PCIProxyDevice-mig");
+
+    f_remote = qemu_fopen_channel_input(ioc);
+
+    pdev->migsize = 0;
+
+    mig_data = g_malloc0(sizeof(proxy_mig_data));
+    mig_data->rem = f_remote;
+    mig_data->dev = pdev;
+
+    qemu_thread_create(&thread, "Proxy MIG_OUT", proxy_mig_out, mig_data,
+                       QEMU_THREAD_DETACHED);
+
+    msg.cmd = START_MIG_OUT;
+    msg.bytestream = 0;
+    msg.num_fds = 2;
+    msg.fds[0] = fd[1];
+    msg.fds[1] = GET_REMOTE_WAIT;
+
+    mpqemu_msg_send(&msg, pdev->mpqemu_link->com);
+    size = wait_for_remote(msg.fds[1]);
+    PUT_REMOTE_WAIT(msg.fds[1]);
+
+    assert(size != ULLONG_MAX);
+
+    /*
+     * migsize is being update by a separate thread. Using volatile to
+     * instruct the compiler to fetch the value of this variable from
+     * memory during every read
+     */
+    while (*((volatile uint64_t *)&pdev->migsize) < size) {
+    }
+
+    qemu_file_shutdown(f_remote);
+
+    qemu_fclose(f_remote);
+    close(fd[1]);
+
+    return 0;
+}
+
+static int proxy_post_save(void *opaque)
+{
+    MigrationState *ms = migrate_get_current();
+    PCIProxyDev *pdev = opaque;
+    uint64_t pos = 0;
+
+    while (pos < pdev->migsize) {
+        qemu_put_byte(ms->to_dst_file, mig_data[pos]);
+        pos++;
+    }
+
+    qemu_fflush(ms->to_dst_file);
+
+    return 0;
+}
+
+const VMStateDescription vmstate_pci_proxy_device = {
+    .name = "PCIProxyDevice",
+    .version_id = 2,
+    .minimum_version_id = 1,
+    .pre_save = proxy_pre_save,
+    .post_save = proxy_post_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_dev, PCIProxyDev),
+        VMSTATE_UINT64(migsize, PCIProxyDev),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -471,6 +605,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     k->config_write = pci_proxy_write_config;
 
     dc->reset = proxy_device_reset;
+    dc->vmsd = &vmstate_pci_proxy_device;
 }
 
 static const TypeInfo pci_proxy_dev_type_info = {
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 5de8129..537c227 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -75,6 +75,8 @@ struct PCIProxyDev {
                         bool need_spawn, Error **errp);
 
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
+
+    uint64_t migsize;
 };
 
 typedef struct PCIProxyDevClass {
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index d2234ca..b42c003 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -63,6 +63,7 @@ typedef enum {
     PROXY_PING,
     MMIO_RETURN,
     DEVICE_RESET,
+    START_MIG_OUT,
     MAX,
 } mpqemu_cmd_t;
 
-- 
1.8.3.1


