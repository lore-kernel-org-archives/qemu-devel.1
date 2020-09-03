Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B4C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF8E20678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF8E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxO4-00065Z-QX
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kDx79-0005To-Kk
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:49:51 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:51333)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kDx76-0005Lo-Nm
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:49:51 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 083LmfsG031912;
 Thu, 3 Sep 2020 23:48:41 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 083Lme3m026108; Thu, 3 Sep 2020 23:48:40 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 083LmeOO026106;
 Thu, 3 Sep 2020 23:48:40 +0200
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/7] net/can: Initial host SocketCan support for CAN FD.
Date: Thu,  3 Sep 2020 23:48:17 +0200
Message-Id: <5fc63b2076944a4c4cad5960f2554d18b2c910a7.1599168753.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1599168753.git.pisa@cmp.felk.cvut.cz>
References: <cover.1599168753.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 083LmfsG031912
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.098, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
 SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1599774524.20706@Zu5SyPMmS7mJ1ZHp+wlR3Q
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 17:39:24
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Marek Vasut <marex@denx.de>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Deniz Eren <deniz.eren@icloud.com>, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Ondrej Ille <ondrej.ille@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Charvat <charvj10@fel.cvut.cz>

Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Vikram Garhwal <fnu.vikram@xilinx.com>
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
index 7e90fd8a45..1547091ff4 100644
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
index b7ef63ec0e..fbc0b62ea4 100644
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
2.20.1


