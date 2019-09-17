Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7859CC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474372067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474372067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACje-0005bY-TD
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1iACYz-0006u2-Au
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1iACYx-0006ik-8e
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:32 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:59358
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1iACYx-0006h0-20
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:31 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1iACYv-0003t8-VD; Tue, 17 Sep 2019 14:26:30 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 14:26:25 +0200
Message-Id: <20190917122625.15614-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917122625.15614-1-johannes@sipsolutions.net>
References: <20190917122625.15614-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: [Qemu-devel] [PATCH 2/2] libvhost-user: implement in-band
 notifications
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
Cc: Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

Add support for VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS, but
as it's not desired by default, don't enable it unless the device
implementation opts in by returning it from its protocol features
callback.

Note that I updated vu_set_vring_err_exec(), but didn't add any
sending of the VHOST_USER_SLAVE_VRING_ERR message as there's no
write to the err_fd today either.

This also adds vu_queue_notify_sync() which can be used to force
a synchronous notification if inband notifications are supported.
Previously, I had left out the slave->master direction handling
of F_REPLY_ACK, this now adds some code to support it as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 contrib/libvhost-user/libvhost-user.c | 103 +++++++++++++++++++++++++-
 contrib/libvhost-user/libvhost-user.h |  14 ++++
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 17b7833d1f6b..1e1525c1c7de 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -136,6 +136,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_GET_INFLIGHT_FD),
         REQ(VHOST_USER_SET_INFLIGHT_FD),
         REQ(VHOST_USER_GPU_SET_SOCKET),
+        REQ(VHOST_USER_VRING_KICK),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -163,7 +164,10 @@ vu_panic(VuDev *dev, const char *msg, ...)
     dev->panic(dev, buf);
     free(buf);
 
-    /* FIXME: find a way to call virtio_error? */
+    /*
+     * FIXME:
+     * find a way to call virtio_error, or perhaps close the connection?
+     */
 }
 
 /* Translate guest physical address to our virtual address.  */
@@ -1172,6 +1176,14 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
+    /*
+     * Note that we support, but intentionally do not set,
+     * VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. This means that
+     * a device implementation can return it in its callback
+     * (get_protocol_features) if it wants to use this for
+     * simulation, but it is otherwise not desirable (if even
+     * implemented by the master.)
+     */
     uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_MQ |
                         1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
                         1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ |
@@ -1204,6 +1216,25 @@ vu_set_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     dev->protocol_features = vmsg->payload.u64;
 
+    if (vu_has_protocol_feature(dev,
+                                VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS) &&
+        (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_REQ) ||
+         !vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
+        /*
+         * The use case for using messages for kick/call is simulation, to make
+         * the kick and call synchronous. To actually get that behaviour, both
+         * of the other features are required.
+         * Theoretically, one could use only kick messages, or do them without
+         * having F_REPLY_ACK, but too many (possibly pending) messages on the
+         * socket will eventually cause the master to hang, to avoid this in
+         * scenarios where not desired enforce that the settings are in a way
+         * that actually enables the simulation case.
+         */
+        vu_panic(dev,
+                 "F_IN_BAND_NOTIFICATIONS requires F_SLAVE_REQ && F_REPLY_ACK");
+        return false;
+    }
+
     if (dev->iface->set_protocol_features) {
         dev->iface->set_protocol_features(dev, features);
     }
@@ -1464,6 +1495,34 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
     return false;
 }
 
+static bool
+vu_handle_vring_kick(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index = vmsg->payload.state.index;
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid queue index: %u", index);
+        return false;
+    }
+
+    DPRINT("Got kick message: handler:%p idx:%d\n",
+           dev->vq[index].handler, index);
+
+    if (!dev->vq[index].started) {
+        dev->vq[index].started = true;
+
+        if (dev->iface->queue_set_started) {
+            dev->iface->queue_set_started(dev, index, true);
+        }
+    }
+
+    if (dev->vq[index].handler) {
+        dev->vq[index].handler(dev, index);
+    }
+
+    return false;
+}
+
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1546,6 +1605,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_get_inflight_fd(dev, vmsg);
     case VHOST_USER_SET_INFLIGHT_FD:
         return vu_set_inflight_fd(dev, vmsg);
+    case VHOST_USER_VRING_KICK:
+        return vu_handle_vring_kick(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
@@ -2005,8 +2066,7 @@ vring_notify(VuDev *dev, VuVirtq *vq)
     return !v || vring_need_event(vring_get_used_event(vq), new, old);
 }
 
-void
-vu_queue_notify(VuDev *dev, VuVirtq *vq)
+static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
 {
     if (unlikely(dev->broken) ||
         unlikely(!vq->vring.avail)) {
@@ -2018,11 +2078,48 @@ vu_queue_notify(VuDev *dev, VuVirtq *vq)
         return;
     }
 
+    if (vq->call_fd < 0 &&
+        vu_has_protocol_feature(dev,
+                                VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS) &&
+        vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
+        VhostUserMsg vmsg = {
+            .request = VHOST_USER_SLAVE_VRING_CALL,
+            .flags = VHOST_USER_VERSION,
+            .size = sizeof(vmsg.payload.state),
+            .payload.state = {
+                .index = vq - dev->vq,
+            },
+        };
+        bool ack = sync &&
+                   vu_has_protocol_feature(dev,
+                                           VHOST_USER_PROTOCOL_F_REPLY_ACK);
+
+        if (ack) {
+            vmsg.flags |= VHOST_USER_NEED_REPLY_MASK;
+        }
+
+        vu_message_write(dev, dev->slave_fd, &vmsg);
+        if (ack) {
+            vu_message_read(dev, dev->slave_fd, &vmsg);
+        }
+        return;
+    }
+
     if (eventfd_write(vq->call_fd, 1) < 0) {
         vu_panic(dev, "Error writing eventfd: %s", strerror(errno));
     }
 }
 
+void vu_queue_notify(VuDev *dev, VuVirtq *vq)
+{
+    _vu_queue_notify(dev, vq, false);
+}
+
+void vu_queue_notify_sync(VuDev *dev, VuVirtq *vq)
+{
+    _vu_queue_notify(dev, vq, true);
+}
+
 static inline void
 vring_used_flags_set_bit(VuVirtq *vq, int mask)
 {
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 46b600799b2e..8e780444429f 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
+    VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 13,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -94,6 +95,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_INFLIGHT_FD = 31,
     VHOST_USER_SET_INFLIGHT_FD = 32,
     VHOST_USER_GPU_SET_SOCKET = 33,
+    VHOST_USER_VRING_KICK = 34,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -102,6 +104,8 @@ typedef enum VhostUserSlaveRequest {
     VHOST_USER_SLAVE_IOTLB_MSG = 1,
     VHOST_USER_SLAVE_CONFIG_CHANGE_MSG = 2,
     VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG = 3,
+    VHOST_USER_SLAVE_VRING_CALL = 4,
+    VHOST_USER_SLAVE_VRING_ERR = 5,
     VHOST_USER_SLAVE_MAX
 }  VhostUserSlaveRequest;
 
@@ -522,6 +526,16 @@ bool vu_queue_empty(VuDev *dev, VuVirtq *vq);
  */
 void vu_queue_notify(VuDev *dev, VuVirtq *vq);
 
+/**
+ * vu_queue_notify_sync:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Request to notify the queue via callfd (skipped if unnecessary)
+ * or sync message if possible.
+ */
+void vu_queue_notify_sync(VuDev *dev, VuVirtq *vq);
+
 /**
  * vu_queue_pop:
  * @dev: a VuDev context
-- 
2.20.1


