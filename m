Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150DFC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB8A218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="urlHjnbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB8A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LEF-0005Ms-0T
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn1-0008UL-Ja
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn0-00049M-8k
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kmz-00048W-W1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqU5j017507;
 Mon, 24 Feb 2020 20:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=FTEBWYd3NkF4WCDTS27/EbKwH/jwO+R30SR6MGMPsuc=;
 b=urlHjnbcCX+++wQbiLgsYEI+U4NGu3K44Nci2gu82cG5jZboqS7sg5rVQVDThdiGeS1f
 E/Sfw66OE73VeZQ0oYYgp5KrZu4hYog2I9U+v3X1NMDdDNTW9Cj5Lhl+HAYn38bdEgav
 SPcXLDzHc9SU8HV49JQKRDY34Gr9VsCCoh8jLnDktna2MKjJ+Ep6aSuTyRuFkioZMGJm
 WJHIDz1kpBN3NHZ34+aEnlyZFYI2gvoXj0UJVisv1IPz9oybf0dRTzea/XKBDhAI8i4m
 RgZvyY2E28qE7rRmyrXAFfIlBkez4IJMktaZO6BPdl/hpcv1iw40vJLYaJc+X39u+xwk JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yavxrhyn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq54u171131;
 Mon, 24 Feb 2020 20:57:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2ybdshkswv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:12 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKvBxq028925;
 Mon, 24 Feb 2020 20:57:11 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:57:10 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 48/50] multi-process: Validate incoming commands from Proxy
Date: Mon, 24 Feb 2020 15:55:39 -0500
Message-Id: <00737a41c9bc4993ad47e5d4387ac14f1892be40.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
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

Validate the incoming commands to confirm that they would not cause any
errors in the remote process.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c    |  6 +++-
 include/io/mpqemu-link.h |  2 ++
 io/mpqemu-link.c         | 75 +++++++++++++++++++++++++++++++++++++++++++++++-
 remote/remote-main.c     |  4 +++
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 4d4eff4..7330094 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -868,7 +868,11 @@ static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
 
     mpqemu_msg_recv(&ret, mpqemu_link->mmio);
 
-    *val = ret.data1.mmio_ret.val;
+    if (!mpqemu_msg_valid(&ret)) {
+        *val = 0;
+    } else {
+        *val = ret.data1.mmio_ret.val;
+    }
 }
 
 void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 722f08c..2f44f31 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -213,4 +213,6 @@ void mpqemu_start_coms(MPQemuLinkState *s);
 uint64_t wait_for_remote(int efd);
 void notify_proxy(int fd, uint64_t val);
 
+bool mpqemu_msg_valid(MPQemuMsg *msg);
+
 #endif
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 07a9be9..298bb58 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -65,7 +65,7 @@ void mpqemu_link_finalize(MPQemuLinkState *s)
 void mpqemu_msg_send(MPQemuMsg *msg, MPQemuChannel *chan)
 {
     int rc;
-    uint8_t *data;
+    uint8_t *data = NULL;
     union {
         char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
         struct cmsghdr align;
@@ -335,3 +335,76 @@ void mpqemu_start_coms(MPQemuLinkState *s)
 
     g_main_loop_run(s->loop);
 }
+
+bool mpqemu_msg_valid(MPQemuMsg *msg)
+{
+    if (msg->cmd >= MAX) {
+        return false;
+    }
+
+    if (msg->bytestream) {
+        if (!msg->data2) {
+            return false;
+        }
+    } else {
+        if (msg->data2) {
+            return false;
+        }
+    }
+
+    /* Verify FDs. */
+    if (msg->num_fds >= REMOTE_MAX_FDS) {
+        return false;
+    }
+    if (msg->num_fds > 0) {
+        for (int i = 0; i < msg->num_fds; i++) {
+            if (fcntl(msg->fds[i], F_GETFL) == -1) {
+                return false;
+            }
+        }
+    }
+
+    /* Verify ID size. */
+    if (msg->id >= UINT64_MAX) {
+        return false;
+    }
+
+    /* Verify message specific fields. */
+    switch (msg->cmd) {
+    case SYNC_SYSMEM:
+        if (msg->num_fds == 0 || msg->bytestream != 0) {
+            return false;
+        }
+        if (msg->size != sizeof(msg->data1)) {
+            return false;
+        }
+        break;
+    case PCI_CONFIG_WRITE:
+    case PCI_CONFIG_READ:
+        if (msg->size != sizeof(struct conf_data_msg)) {
+            return false;
+        }
+        break;
+    case BAR_WRITE:
+    case BAR_READ:
+    case SET_IRQFD:
+    case MMIO_RETURN:
+    case DEVICE_RESET:
+    case RUNSTATE_SET:
+        if (msg->size != sizeof(msg->data1)) {
+            return false;
+        }
+        break;
+    case PROXY_PING:
+    case START_MIG_OUT:
+    case START_MIG_IN:
+        if (msg->size != 0) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+
+    return true;
+}
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 20d160e..c4aa3e0 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -435,6 +435,10 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
     if (msg->id > MAX_REMOTE_DEVICES) {
         error_setg(&err, "id of the device is larger than max number of "\
                          "devices per remote process.");
+    }
+
+    if (!mpqemu_msg_valid(msg)) {
+        error_setg(&err, "Message is not valid");
         goto finalize_loop;
     }
 
-- 
1.8.3.1


