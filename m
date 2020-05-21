Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EB4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965402070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="ovSTwAoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965402070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbdLK-00052q-CQ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdJr-000363-Lg
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:35 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:57783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdJq-0001G4-KB
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=ZExuQRUr3IfyDBsu2fewl5RpWLDXO6Mcu5FYonSolU4=;
 b=ovSTwAoC7Pbum0VhXLsosLagnirghaXl+1bFMqfvo08webl/5Tbt61WdUOKVoiY6KGL4
 TkbHtg1wKYH05NH/yDrySrDgHZ1vLNOfZArvFOKTmU1bz7mJ2+zwDCvVBhqR1ryfXicYLk
 Udsyzswab98YZBEPmdic2wnz4fA9DZg3g=
Received: by filterdrecv-p3iad2-8ddf98858-285bn with SMTP id
 filterdrecv-p3iad2-8ddf98858-285bn-19-5EC60AF0-9D
 2020-05-21 05:00:32.541578376 +0000 UTC m=+4852389.140011353
Received: from localhost.localdomain.com (unknown)
 by ismtpd0026p1las1.sendgrid.net (SG) with ESMTP
 id qqFVVg5fQIOLH_Q8J_9LNQ Thu, 21 May 2020 05:00:32.330 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v4 03/10] Add VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
Date: Thu, 21 May 2020 05:00:32 +0000 (UTC)
Message-Id: <1588533678-23450-4-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zQR6zJKBAnoY4dgBZ?=
 =?us-ascii?Q?oMs7vnpLZSNKyf9svFr6cbVutTy38BAHmZK3qcL?=
 =?us-ascii?Q?yVAyoIPVwqgdXluK8TiMhkiCRq+RunkB=2Fb6GWqW?=
 =?us-ascii?Q?FhiatODs6iPtuHP0TDx7zeo=2F8BbWRNbTIvJwIKz?=
 =?us-ascii?Q?HrpVEruTlU=2Fy3zaF98OuEnyOeMyGDw4PJMGhqOp?=
 =?us-ascii?Q?wzY39bcnOISW9vJ6pMxnw=3D=3D?=
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:00:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>, raphael.s.norwitz@gmail.com,
 marcandre.lureau@gmail.com, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change introduces a new feature to the vhost-user protocol allowing
a backend device to specify the maximum number of ram slots it supports.

At this point, the value returned by the backend will be capped at the
maximum number of ram slots which can be supported by vhost-user, which
is currently set to 8 because of underlying protocol limitations.

The returned value will be stored inside the VhostUserState struct so
that on device reconnect we can verify that the ram slot limitation
has not decreased since the last time the device connected.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
---
 docs/interop/vhost-user.rst    | 16 ++++++++++++++
 hw/virtio/vhost-user.c         | 49 ++++++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/vhost-user.h |  1 +
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 3b1b660..b3cf5c3 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -815,6 +815,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
   #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
   #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
+  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
 
 Master message types
 --------------------
@@ -1263,6 +1264,21 @@ Master message types
 
   The state.num field is currently reserved and must be set to 0.
 
+``VHOST_USER_GET_MAX_MEM_SLOTS``
+  :id: 36
+  :equivalent ioctl: N/A
+  :slave payload: u64
+
+  When the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol
+  feature has been successfully negotiated, this message is submitted
+  by master to the slave. The slave should return the message with a
+  u64 payload containing the maximum number of memory slots for
+  QEMU to expose to the guest. At this point, the value returned
+  by the backend will be capped at the maximum number of ram slots
+  which can be supported by vhost-user. Currently that limit is set
+  at VHOST_USER_MAX_RAM_SLOTS = 8 because of underlying protocol
+  limitations.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 442b0d6..0af593f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -59,6 +59,8 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
     VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
+    /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
+    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -100,6 +102,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_INFLIGHT_FD = 32,
     VHOST_USER_GPU_SET_SOCKET = 33,
     VHOST_USER_RESET_DEVICE = 34,
+    /* Message number 35 reserved for VHOST_USER_VRING_KICK. */
+    VHOST_USER_GET_MAX_MEM_SLOTS = 36,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -895,6 +899,23 @@ static int vhost_user_set_owner(struct vhost_dev *dev)
     return 0;
 }
 
+static int vhost_user_get_max_memslots(struct vhost_dev *dev,
+                                       uint64_t *max_memslots)
+{
+    uint64_t backend_max_memslots;
+    int err;
+
+    err = vhost_user_get_u64(dev, VHOST_USER_GET_MAX_MEM_SLOTS,
+                             &backend_max_memslots);
+    if (err < 0) {
+        return err;
+    }
+
+    *max_memslots = backend_max_memslots;
+
+    return 0;
+}
+
 static int vhost_user_reset_device(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
@@ -1392,7 +1413,7 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
 
 static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
 {
-    uint64_t features, protocol_features;
+    uint64_t features, protocol_features, ram_slots;
     struct vhost_user *u;
     int err;
 
@@ -1454,6 +1475,27 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
                          "slave-req protocol features.");
             return -1;
         }
+
+        /* get max memory regions if backend supports configurable RAM slots */
+        if (!virtio_has_feature(dev->protocol_features,
+                                VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
+            u->user->memory_slots = VHOST_MEMORY_MAX_NREGIONS;
+        } else {
+            err = vhost_user_get_max_memslots(dev, &ram_slots);
+            if (err < 0) {
+                return err;
+            }
+
+            if (ram_slots < u->user->memory_slots) {
+                error_report("The backend specified a max ram slots limit "
+                             "of %lu, when the prior validated limit was %d. "
+                             "This limit should never decrease.", ram_slots,
+                             u->user->memory_slots);
+                return -1;
+            }
+
+            u->user->memory_slots = MIN(ram_slots, VHOST_MEMORY_MAX_NREGIONS);
+        }
     }
 
     if (dev->migration_blocker == NULL &&
@@ -1519,7 +1561,9 @@ static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
 
 static int vhost_user_memslots_limit(struct vhost_dev *dev)
 {
-    return VHOST_MEMORY_MAX_NREGIONS;
+    struct vhost_user *u = dev->opaque;
+
+    return u->user->memory_slots;
 }
 
 static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
@@ -1904,6 +1948,7 @@ bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
         return false;
     }
     user->chr = chr;
+    user->memory_slots = 0;
     return true;
 }
 
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 811e325..a9abca3 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -20,6 +20,7 @@ typedef struct VhostUserHostNotifier {
 typedef struct VhostUserState {
     CharBackend *chr;
     VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
+    int memory_slots;
 } VhostUserState;
 
 bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp);
-- 
1.8.3.1


