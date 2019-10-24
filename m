Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E4720856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f+R//iSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E4720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZjc-0001GN-4Y
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9t-0000da-Qi
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9r-0004x8-MG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ9q-0004vN-Ph
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94MeW116323;
 Thu, 24 Oct 2019 09:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=AuHjnsJfixi1mdGb5rDbogFCok+K7oOPW4/ApU4ZAuc=;
 b=f+R//iSgIf0Uwjcz4UzFDrEfpuSMnQnvjZ8YDkKoiYdOuz1xFmYpVsaoFEH5rHzTHhyA
 S3LLO6+thIH6jPzSn9upuE9ZWVUUpEVmd2ipHseFdRaxdJ6UnY9sGRQ9+dqXsh0puZpj
 1eJRwuN7xPk1AQXnx2Rf6S9H/ZDFmEcdb5Qwb36SLBSWvvW3O5Vj0MF5qsWrryaLZyCt
 0hkvURjG2HjR1/8Ovmfj6uPIE0ny4voHxtk1nMZYjFXbc4uCuBqp4K07kHwZotBiAOpV
 OgxZT23Izx3xQbzN+tp2rBCqu+0rlwMM7PvthOW/5m/TjDptxArqVzrpnReMDJl8ruxr sQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2vqswtte3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O982jm093151;
 Thu, 24 Oct 2019 09:11:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2vtm244kf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9Bef1009868;
 Thu, 24 Oct 2019 09:11:41 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:40 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 41/49] multi-process/mig: Enable VMSD save in the Proxy
 object
Date: Thu, 24 Oct 2019 05:09:22 -0400
Message-Id: <8b15ab3d4fe51b792897ffc87e221bfb9317a836.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Collect the VMSD from remote process on the source and save
it to the channel leading to the destination

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v4

 hw/proxy/qemu-proxy.c         | 132 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |   2 +
 include/io/mpqemu-link.h      |   1 +
 3 files changed, 135 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 623a6c5..ce72e6a 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -52,6 +52,14 @@
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
@@ -62,6 +70,9 @@ static void stop_heartbeat_timer(void);
 static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx);
 static void broadcast_msg(MPQemuMsg *msg, bool need_reply);
 
+#define PAGE_SIZE getpagesize()
+uint8_t *mig_data;
+
 static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
 {
     /* TODO: Add proper handler. */
@@ -357,14 +368,135 @@ static void pci_proxy_dev_inst_init(Object *obj)
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
+    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
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
+    qemu_thread_cancel(&thread);
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
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
     k->exit = pci_dev_exit;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
+
+    dc->vmsd = &vmstate_pci_proxy_device;
 }
 
 static const TypeInfo pci_proxy_dev_type_info = {
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 17e07ac..b122e6d 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -89,6 +89,8 @@ struct PCIProxyDev {
     void (*init_proxy) (PCIDevice *dev, char *command, bool need_spawn, Error **errp);
 
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
+
+    uint64_t migsize;
 };
 
 typedef struct PCIProxyDevClass {
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 6fcc6f5..0ed7750 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -75,6 +75,7 @@ typedef enum {
     PROXY_PING,
     MMIO_RETURN,
     DEVICE_RESET,
+    START_MIG_OUT,
     MAX,
 } mpqemu_cmd_t;
 
-- 
1.8.3.1


