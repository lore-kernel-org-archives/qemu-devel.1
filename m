Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2724EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45B420734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XchfI0Zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45B420734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisWg-0007R0-4P
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLM-0000za-Jz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLL-0008LD-8O
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGE2QqK9iMg/O+i73SSpthyfWSyKC6Ch03gh/EbHl1Y=;
 b=XchfI0Zwy3+xES2Om0kcJQOCo0RSyOG9evxLIfV6PeW5gi99WnRrckTP24zWAdIpw1MVUV
 tMTwOHsRa3H3rDt//oR+vTXEGuBNIx8104zrWAfiT1zhnMam2W2/BVvgI4t9r/m/FnFSEs
 cpV0dci7yctmC6MoLnTJDfcqQjq+En8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-UrYO830NP3mj9a_K04OUhg-1; Wed, 10 Jun 2020 00:28:00 -0400
X-MC-Unique: UrYO830NP3mj9a_K04OUhg-1
Received: by mail-wr1-f71.google.com with SMTP id m14so506249wrj.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VGE2QqK9iMg/O+i73SSpthyfWSyKC6Ch03gh/EbHl1Y=;
 b=RfGemMGpFbInH+d0ZONRoD0GH7Qw/8s0NOuycC/uL2BbFm+lqmPhkxIMPopfuwMXO4
 erHnce7e0DDgB8GggvhjkRRDxzOmvSM0lF6CxLnsazx0z/daG7S5Jtu38YHQM0nLMm1p
 I1aQHajmjkTY0rdDPo/ZV6VUeIe7tS7Nu7RJTMruNNlAxeEThbiFeeRhEticvdFPrHKx
 +/k3YcoV6Y3wC29uqlaAmZ1lVp889ZSqsoSSNQyxXVRT7pLNsc87hA9MtG9DAK9Uxjmz
 aJLrwGjF2OOSIPVqMJsahYQDXHVJ/IzDTYC/7jh/OV/9XCUUNOT6et+DvsD2o9WCuClL
 +ZmA==
X-Gm-Message-State: AOAM533ZxH1BV3BjMmd1XPOGdSl3E6xN3hW3EhFkNRPwpmpghg4MKBYb
 rI7newr3gIUYBxl2GKXFy6K2MsMK0knuKfgvJASovcFP9m8f7IiTKzFWEc8cwDM3vgGqTymVf0e
 PmXKJvcbjEBx0eKo=
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr1275270wrw.49.1591763279250;
 Tue, 09 Jun 2020 21:27:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN8OCKdLKvy8HCOVmrNlDyMBijUynjJEVGUU3gj7t63A0bvUL8JMxTI4kvPpJiB4eo4zitHw==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr1275258wrw.49.1591763278992;
 Tue, 09 Jun 2020 21:27:58 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id t189sm5231382wma.4.2020.06.09.21.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:58 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/56] Add VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
Message-ID: <20200610042613.1459309-39-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

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
Message-Id: <1588533678-23450-4-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/vhost-user.h |  1 +
 hw/virtio/vhost-user.c         | 49 ++++++++++++++++++++++++++++++++--
 docs/interop/vhost-user.rst    | 16 +++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 811e325f42..a9abca3288 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -20,6 +20,7 @@ typedef struct VhostUserHostNotifier {
 typedef struct VhostUserState {
     CharBackend *chr;
     VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
+    int memory_slots;
 } VhostUserState;
 
 bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 442b0d650a..0af593f9aa 100644
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
 
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 3b1b6602c7..b3cf5c3cb5 100644
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
 
-- 
MST


