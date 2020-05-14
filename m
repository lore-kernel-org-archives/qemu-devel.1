Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910B5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 07:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6165B205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 07:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMYqfFen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6165B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ8Nz-0003Jv-HO
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 03:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxime.coquelin@redhat.com>)
 id 1jZ8NQ-0002to-RG
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:33:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26289
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <maxime.coquelin@redhat.com>)
 id 1jZ8NP-0005it-Ic
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589441633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SP2qyej28Hzp/wpt547TIDxhYswwcZdO/xm4WrMLgFQ=;
 b=gMYqfFen3nWVPy07pLT3Q5rrJYjnWbUkRaP3DLlM39KEMny5Oo3gshFAKWPyBrtOwjwYkh
 wo0WdD8QooesVJf04ZusW9XPI/cb/Nbid0Aob/LGTBwTuHeU5LkEGStmL+eA77h0QVWZbI
 V3onN3iUp4qYUoEiuocHkGRRyP4XGG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-UIMHoVm5ObK6qmtNAwBDCA-1; Thu, 14 May 2020 03:33:50 -0400
X-MC-Unique: UIMHoVm5ObK6qmtNAwBDCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76B7B80183C;
 Thu, 14 May 2020 07:33:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.110.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5163476C38;
 Thu, 14 May 2020 07:33:41 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: jasowang@redhat.com, mst@redhat.com, lulu@redhat.com, amorenoz@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] vhost-user: add support for VHOST_USER_SET_STATUS
Date: Thu, 14 May 2020 09:33:32 +0200
Message-Id: <20200514073332.1434576-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=maxime.coquelin@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: shahafs@mellanox.com, Maxime Coquelin <maxime.coquelin@redhat.com>,
 matan@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is usefull for the Vhost-user backend to know
about about the Virtio device status updates,
especially when the driver sets the DRIVER_OK bit.

With that information, no more need to do hazardous
assumptions on when the driver is done with the
device configuration.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---

This patch applies on top of Cindy's "vDPA support in qemu"
series, which introduces the .vhost_set_state vhost-backend
ops.

 docs/interop/vhost-user.rst | 12 ++++++++++++
 hw/net/vhost_net.c          | 10 +++++-----
 hw/virtio/vhost-user.c      | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 3b1b6602c7..f108de7458 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -815,6 +815,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
   #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
   #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
+  #define VHOST_USER_PROTOCOL_F_STATUS               15
 
 Master message types
 --------------------
@@ -1263,6 +1264,17 @@ Master message types
 
   The state.num field is currently reserved and must be set to 0.
 
+``VHOST_USER_SET_STATUS``
+  :id: 36
+  :equivalent ioctl: VHOST_VDPA_SET_STATUS
+  :slave payload: N/A
+  :master payload: ``u64``
+
+  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
+  successfully negotiated, this message is submitted by the master to
+  notify the backend with updated device status as defined in the Virtio
+  specification.
+
 Slave message types
 -------------------
 
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 463e333531..37f3156dbc 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -517,10 +517,10 @@ int vhost_set_state(NetClientState *nc, int state)
 {
     struct vhost_net *net = get_vhost_net(nc);
     struct vhost_dev *hdev = &net->dev;
-    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        if (hdev->vhost_ops->vhost_set_state) {
-                return hdev->vhost_ops->vhost_set_state(hdev, state);
-             }
-        }
+
+    if (hdev->vhost_ops->vhost_set_state) {
+        return hdev->vhost_ops->vhost_set_state(hdev, state);
+    }
+
     return 0;
 }
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ec21e8fbe8..b7e52d97fc 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -59,6 +59,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
     VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
+    VHOST_USER_PROTOCOL_F_STATUS = 15,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -100,6 +101,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_INFLIGHT_FD = 32,
     VHOST_USER_GPU_SET_SOCKET = 33,
     VHOST_USER_RESET_DEVICE = 34,
+    VHOST_USER_SET_STATUS = 36,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -1886,6 +1888,38 @@ static int vhost_user_set_inflight_fd(struct vhost_dev *dev,
     return 0;
 }
 
+static int vhost_user_set_state(struct vhost_dev *dev, int state)
+{
+    bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_SET_STATUS,
+        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.size = sizeof(msg.payload.u64),
+        .payload.u64 = (uint64_t)state,
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                VHOST_USER_PROTOCOL_F_STATUS)) {
+        return -1;
+    }
+
+    if (reply_supported) {
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    if (reply_supported) {
+        return process_message_reply(dev, &msg);
+    }
+
+    return 0;
+}
+
 bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
 {
     if (user->chr) {
@@ -1947,4 +1981,5 @@ const VhostOps user_ops = {
         .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
         .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
         .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
+        .vhost_set_state = vhost_user_set_state,
 };
-- 
2.25.4


