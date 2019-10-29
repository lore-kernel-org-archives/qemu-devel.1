Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCD5CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17762087F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17762087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQKFT-0005LV-Ua
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 19:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1iQKEO-0004MZ-T5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1iQKEN-00048H-LT
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:51:56 -0400
Received: from [192.146.154.1] (port=38169 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1iQKEN-00047A-FS
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:51:55 -0400
Received: from localhost.corp.nutanix.com (unknown [10.40.36.164])
 by mcp01.nutanix.com (Postfix) with ESMTP id 04C111009026;
 Thu, 31 Oct 2019 23:51:54 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] vhost-user: add VHOST_USER_RESET_DEVICE to reset devices
Date: Tue, 29 Oct 2019 17:38:02 -0400
Message-Id: <1572385083-5254-2-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572385083-5254-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1572385083-5254-1-git-send-email-raphael.norwitz@nutanix.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.154.1
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Vrabel <david.vrabel@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a VHOST_USER_RESET_DEVICE message which will reset the vhost user
backend. Disabling all rings, and resetting all internal state, ready
for the backend to be reinitialized.

A backend has to report it supports this features with the
VHOST_USER_PROTOCOL_F_RESET_DEVICE protocol feature bit. If it does
so, the new message is used instead of sending a RESET_OWNER which has
had inconsistent implementations.

Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 docs/interop/vhost-user.rst | 15 +++++++++++++++
 hw/virtio/vhost-user.c      |  8 +++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 7827b71..d213d4a 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -785,6 +785,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
   #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
   #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
+  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE   13
 
 Master message types
 --------------------
@@ -1190,6 +1191,20 @@ Master message types
   ancillary data. The GPU protocol is used to inform the master of
   rendering state and updates. See vhost-user-gpu.rst for details.
 
+``VHOST_USER_RESET_DEVICE``
+  :id: 34
+  :equivalent ioctl: N/A
+  :master payload: N/A
+  :slave payload: N/A
+
+  Ask the vhost user backend to disable all rings and reset all
+  internal device state to the initial state, ready to be
+  reinitialized. The backend retains ownership of the device
+  throughout the reset operation.
+
+  Only valid if the ``VHOST_USER_PROTOCOL_F_RESET_DEVICE`` protocol
+  feature is set by the backend.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 02a9b25..d27a10f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -58,6 +58,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
+    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -98,6 +99,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_INFLIGHT_FD = 31,
     VHOST_USER_SET_INFLIGHT_FD = 32,
     VHOST_USER_GPU_SET_SOCKET = 33,
+    VHOST_USER_RESET_DEVICE = 34,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -890,10 +892,14 @@ static int vhost_user_set_owner(struct vhost_dev *dev)
 static int vhost_user_reset_device(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
-        .hdr.request = VHOST_USER_RESET_OWNER,
         .hdr.flags = VHOST_USER_VERSION,
     };
 
+    msg.hdr.request = virtio_has_feature(dev->protocol_features,
+                                         VHOST_USER_PROTOCOL_F_RESET_DEVICE)
+        ? VHOST_USER_RESET_DEVICE
+        : VHOST_USER_RESET_OWNER;
+
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
         return -1;
     }
-- 
1.8.3.1


