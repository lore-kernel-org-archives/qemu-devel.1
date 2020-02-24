Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFFCC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0786521556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vv9oZXb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0786521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L6C-0007hx-3O
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmt-00088z-Ij
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kms-00040k-Ct
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kms-0003za-42
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqcnW017744;
 Mon, 24 Feb 2020 20:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=0B1eKZbJOs4Nl5F0dscdR1L40vi/ljBXpJqgDQFRAwQ=;
 b=Vv9oZXb0GeHp71ZaCdHjE6yoEf/BrRA61FgRrSgIjma0ZiByv5kP6xgsh7R9icq7AMNf
 NZnTQ+DceZTYhkAXON3MVFjUVCyX1NU894ExlvgmIKqMyXvO6K4zMMaDoe6wbgWhYMUE
 /u4xAYq3wYDyiSAjSla0rSxMdI2HJSb71dMtFUIlnv9RGKFeYmzD63TPxzoFyV7v8Ykp
 auwd8lRT52wjRInBdGy77m1m2aLckkINOSqo1/4IqDLGFrh+hZBfC8MmngAh2+6dvHLA
 aU3HzKZDZqPDYlcifkEbMxS5nRgT9YC94CDrbXIhOq/lyTmCW2giA2HCwyr5bVtgc3dc cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yavxrhyky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKucBb072957;
 Mon, 24 Feb 2020 20:57:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2ybduv6dxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:04 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKv3h1028883;
 Mon, 24 Feb 2020 20:57:03 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:57:03 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 43/50] multi-process/mig: Load VMSD in the proxy object
Date: Mon, 24 Feb 2020 15:55:34 -0500
Message-Id: <728f5cdb2108ccfd0916c1efcc8c7dab99daf6ad.1582576372.git.jag.raman@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

The Proxy object loads the VMSD of remote process in source
and send it to the remote process in the destination

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h |  1 +
 2 files changed, 51 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 19f0dbb..1649f60 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -581,12 +581,62 @@ static int proxy_post_save(void *opaque)
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
+    mpqemu_msg_send(&msg, pdev->mpqemu_link->com);
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
index b42c003..01371fc 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -64,6 +64,7 @@ typedef enum {
     MMIO_RETURN,
     DEVICE_RESET,
     START_MIG_OUT,
+    START_MIG_IN,
     MAX,
 } mpqemu_cmd_t;
 
-- 
1.8.3.1


