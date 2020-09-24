Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523CFC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC55E2396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzEgqbmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC55E2396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOB0-00070n-Om
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNV3-0003TT-AP
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUq-0006IB-0i
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRtSUrgKNL0humN1k1HMbtEq084M5PqemfggdKfe0jg=;
 b=EzEgqbmNTRCQLg0QORpea36zaVyb1a6ApvOv8H1T9Ub0bjUDuX8oIqBPF0ZqGZPTfX21h9
 sgDf3XQ2hml5o1Sm+k37NQU7XjHnP1Vtj7tv/VxKQHO8faRznJpGOdgElaKIyt5vFhr7t4
 vT66kMcwvhSuQQGiXNYW9sTnGZojUIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-V3k9HwW2Nv6Qo21CaotsiA-1; Thu, 24 Sep 2020 05:24:54 -0400
X-MC-Unique: V3k9HwW2Nv6Qo21CaotsiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 657A1104D3E4;
 Thu, 24 Sep 2020 09:24:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 443AD55764;
 Thu, 24 Sep 2020 09:24:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 86/92] net/can: Initial host SocketCan support for CAN FD.
Date: Thu, 24 Sep 2020 05:23:08 -0400
Message-Id: <20200924092314.1722645-87-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Charvat <charvj10@fel.cvut.cz>

Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Vikram Garhwal <fnu.vikram@xilinx.com>
Message-Id: <41383d4eb3f35586c696a8e29c4dff4031a81338.1600069689.git.pisa@cmp.felk.cvut.cz>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/can/can_sja1000.c |  2 ++
 include/net/can_emu.h    |  8 ++++++-
 net/can/can_socketcan.c  | 47 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 299932998a..ec66d4232d 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -268,6 +268,7 @@ static void buff2frame_pel(const uint8_t *buff, qemu_can_frame *frame)
 {
     uint8_t i;
 
+    frame->flags = 0;
     frame->can_id = 0;
     if (buff[0] & 0x40) { /* RTR */
         frame->can_id = QEMU_CAN_RTR_FLAG;
@@ -303,6 +304,7 @@ static void buff2frame_bas(const uint8_t *buff, qemu_can_frame *frame)
 {
     uint8_t i;
 
+    frame->flags = 0;
     frame->can_id = ((buff[0] << 3) & (0xff << 3)) + ((buff[1] >> 5) & 0x07);
     if (buff[1] & 0x10) { /* RTR */
         frame->can_id = QEMU_CAN_RTR_FLAG;
diff --git a/include/net/can_emu.h b/include/net/can_emu.h
index 743c6647c1..cab98ee8ec 100644
--- a/include/net/can_emu.h
+++ b/include/net/can_emu.h
@@ -46,7 +46,8 @@ typedef uint32_t qemu_canid_t;
 typedef struct qemu_can_frame {
     qemu_canid_t    can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
     uint8_t         can_dlc; /* data length code: 0 .. 8 */
-    uint8_t         data[8] QEMU_ALIGNED(8);
+    uint8_t         flags;
+    uint8_t         data[64] QEMU_ALIGNED(8);
 } qemu_can_frame;
 
 /* Keep defines for QEMU separate from Linux ones for now */
@@ -58,6 +59,10 @@ typedef struct qemu_can_frame {
 #define QEMU_CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
 #define QEMU_CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
 
+#define QEMU_CAN_FRMF_BRS     0x01 /* bit rate switch (2nd bitrate for data) */
+#define QEMU_CAN_FRMF_ESI     0x02 /* error state ind. of transmitting node */
+#define QEMU_CAN_FRMF_TYPE_FD 0x10 /* internal bit ind. of CAN FD frame */
+
 /**
  * struct qemu_can_filter - CAN ID based filter in can_register().
  * @can_id:   relevant bits of CAN ID which are not masked out.
@@ -97,6 +102,7 @@ struct CanBusClientState {
     char *model;
     char *name;
     void (*destructor)(CanBusClientState *);
+    bool fd_mode;
 };
 
 #define TYPE_CAN_BUS "can-bus"
diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index ce8c2549ed..92b1f79385 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -103,6 +103,14 @@ static void can_host_socketcan_read(void *opaque)
         return;
     }
 
+    if (!ch->bus_client.fd_mode) {
+        c->buf[0].flags = 0;
+    } else {
+        if (c->bufcnt > CAN_MTU) {
+            c->buf[0].flags |= QEMU_CAN_FRMF_TYPE_FD;
+        }
+    }
+
     can_bus_client_send(&ch->bus_client, c->buf, 1);
 
     if (DEBUG_CAN) {
@@ -121,12 +129,21 @@ static ssize_t can_host_socketcan_receive(CanBusClientState *client,
     CanHostState *ch = container_of(client, CanHostState, bus_client);
     CanHostSocketCAN *c = CAN_HOST_SOCKETCAN(ch);
 
-    size_t len = sizeof(qemu_can_frame);
+    size_t len;
     int res;
 
     if (c->fd < 0) {
         return -1;
     }
+    if (frames->flags & QEMU_CAN_FRMF_TYPE_FD) {
+        if (!ch->bus_client.fd_mode) {
+            return 0;
+        }
+        len = CANFD_MTU;
+    } else {
+        len = CAN_MTU;
+
+    }
 
     res = write(c->fd, frames, len);
 
@@ -172,6 +189,8 @@ static void can_host_socketcan_connect(CanHostState *ch, Error **errp)
 {
     CanHostSocketCAN *c = CAN_HOST_SOCKETCAN(ch);
     int s; /* can raw socket */
+    int mtu;
+    int enable_canfd = 1;
     struct sockaddr_can addr;
     struct ifreq ifr;
 
@@ -185,13 +204,34 @@ static void can_host_socketcan_connect(CanHostState *ch, Error **errp)
     addr.can_family = AF_CAN;
     memset(&ifr.ifr_name, 0, sizeof(ifr.ifr_name));
     strcpy(ifr.ifr_name, c->ifname);
+    /* check if the frame fits into the CAN netdevice */
     if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
         error_setg_errno(errp, errno,
-                         "SocketCAN host interface %s not available", c->ifname);
+                         "SocketCAN host interface %s not available",
+                         c->ifname);
         goto fail;
     }
     addr.can_ifindex = ifr.ifr_ifindex;
 
+    if (ioctl(s, SIOCGIFMTU, &ifr) < 0) {
+        error_setg_errno(errp, errno,
+                         "SocketCAN host interface %s SIOCGIFMTU failed",
+                         c->ifname);
+        goto fail;
+    }
+    mtu = ifr.ifr_mtu;
+
+    if (mtu >= CANFD_MTU) {
+        /* interface is ok - try to switch the socket into CAN FD mode */
+        if (setsockopt(s, SOL_CAN_RAW, CAN_RAW_FD_FRAMES,
+                        &enable_canfd, sizeof(enable_canfd))) {
+            warn_report("SocketCAN host interface %s enabling CAN FD failed",
+                        c->ifname);
+        } else {
+            c->parent.bus_client.fd_mode = true;
+        }
+    }
+
     c->err_mask = 0xffffffff; /* Receive error frame. */
     setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
                    &c->err_mask, sizeof(c->err_mask));
@@ -232,7 +272,8 @@ static char *can_host_socketcan_get_if(Object *obj, Error **errp)
     return g_strdup(c->ifname);
 }
 
-static void can_host_socketcan_set_if(Object *obj, const char *value, Error **errp)
+static void can_host_socketcan_set_if(Object *obj, const char *value,
+                                      Error **errp)
 {
     CanHostSocketCAN *c = CAN_HOST_SOCKETCAN(obj);
     struct ifreq ifr;
-- 
2.26.2



