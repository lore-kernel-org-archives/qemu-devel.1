Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61C8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F0220856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GZKogrjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F0220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZnh-0004ts-SQ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZBs-0006rx-RW
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZBr-0005zY-On
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:13:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZBr-0005z1-GQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:13:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94rg6100053;
 Thu, 24 Oct 2019 09:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=D/pJ3W/Qz9XHj2UuEyUytLHj665k521TrYBAmheGze8=;
 b=GZKogrjVclAuXGvEmw/PYM/HdkuoeOIkapBzA+RIBYwKckoZYnsP2L3qzHhzRhTvpcdV
 sG8OIPkkiSVU8PJwh8BRxmA7z2tEfoxIWmRxtsUTpGkVR3CwUelkPUJHqurG7AKvfwGK
 mfjh3QRUEWe2/g/Vxg/GHT5oahR9a5VwjQORtfdycCRooWWVaFUPnDN8VG3YoG+dBmvD
 54AG1/MPgdmSC2OXqjYcOmxN+7lTNDDJnMGsrZssNG2/r0JUJ3qpggNV2RHlxBVVkehC
 GWpdNrQS8sM1ahjilH4hFghp7H2RFquUOYWPtOUwnnvNvQ2cawxe4ySWpGRBT42UdHc9 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2vqteq2av8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:13:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O97kQ4170676;
 Thu, 24 Oct 2019 09:11:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2vtsk4898v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9BmYO024517;
 Thu, 24 Oct 2019 09:11:48 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:47 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 43/49] multi-process/mig: Load VMSD in the proxy object
Date: Thu, 24 Oct 2019 05:09:24 -0400
Message-Id: <78a6b0d7f11ff5fc14e2dcfe2f5db5a5e292e726.1571905346.git.jag.raman@oracle.com>
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

The Proxy object loads the VMSD of remote process in source
and send it to the remote process in the destination

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v4

 hw/proxy/qemu-proxy.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h |  1 +
 2 files changed, 51 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index ce72e6a..c85ffb3 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -473,12 +473,62 @@ static int proxy_post_save(void *opaque)
     return 0;
 }
 
+static int proxy_post_load(void *opaque, int version_id)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    PCIProxyDev *pdev = opaque;
+    QEMUFile *f_remote;
+    MPQemuMsg msg = {0};
+    Error *err = NULL;
+    QIOChannel *ioc;
+    uint64_t size;
+    uint8_t byte;
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
+    qio_channel_set_name(QIO_CHANNEL(ioc), "proxy-migration-channel");
+
+    f_remote = qemu_fopen_channel_output(ioc);
+
+    msg.cmd = START_MIG_IN;
+    msg.bytestream = 0;
+    msg.num_fds = 1;
+    msg.fds[0] = fd[1];
+
+    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
+
+    size = pdev->migsize;
+
+    while (size) {
+        byte = qemu_get_byte(mis->from_src_file);
+        qemu_put_byte(f_remote, byte);
+        size--;
+    }
+
+    qemu_fflush(f_remote);
+    qemu_fclose(f_remote);
+
+    close(fd[1]);
+
+    return 0;
+}
+
 const VMStateDescription vmstate_pci_proxy_device = {
     .name = "PCIProxyDevice",
     .version_id = 2,
     .minimum_version_id = 1,
     .pre_save = proxy_pre_save,
     .post_save = proxy_post_save,
+    .post_load = proxy_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_dev, PCIProxyDev),
         VMSTATE_UINT64(migsize, PCIProxyDev),
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 0ed7750..05dc55e 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -76,6 +76,7 @@ typedef enum {
     MMIO_RETURN,
     DEVICE_RESET,
     START_MIG_OUT,
+    START_MIG_IN,
     MAX,
 } mpqemu_cmd_t;
 
-- 
1.8.3.1


