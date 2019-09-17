Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44660C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1813B214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1813B214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACat-0007lk-Ri
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1iACYX-0006Kp-8M
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1iACYW-0006XY-5f
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:05 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:59348
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1iACYV-0006XH-Vc
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:04 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1iACYU-0003sY-IQ; Tue, 17 Sep 2019 14:26:02 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 14:25:59 +0200
Message-Id: <20190917122559.15555-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: [Qemu-devel] [PATCH] libvhost-user: handle NOFD flag in
 call/kick/err better
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

The code here is odd, for example will it print out invalid
file descriptor numbers that were never sent in the message.

Clean that up a bit so it's actually possible to implement
a device that uses polling.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 contrib/libvhost-user/libvhost-user.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index f1677da21201..17b7833d1f6b 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -920,6 +920,7 @@ static bool
 vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
 {
     int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
 
     if (index >= dev->max_queues) {
         vmsg_close_fds(vmsg);
@@ -927,8 +928,12 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
         return false;
     }
 
-    if (vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK ||
-        vmsg->fd_num != 1) {
+    if (nofd) {
+        vmsg_close_fds(vmsg);
+        return true;
+    }
+
+    if (vmsg->fd_num != 1) {
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Invalid fds in request: %d", vmsg->request);
         return false;
@@ -1025,6 +1030,7 @@ static bool
 vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
 
     DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
 
@@ -1038,8 +1044,8 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
         dev->vq[index].kick_fd = -1;
     }
 
-    dev->vq[index].kick_fd = vmsg->fds[0];
-    DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
+    dev->vq[index].kick_fd = nofd ? -1 : vmsg->fds[0];
+    DPRINT("Got kick_fd: %d for vq: %d\n", dev->vq[index].kick_fd, index);
 
     dev->vq[index].started = true;
     if (dev->iface->queue_set_started) {
@@ -1116,6 +1122,7 @@ static bool
 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
 
     DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
 
@@ -1128,14 +1135,14 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
         dev->vq[index].call_fd = -1;
     }
 
-    dev->vq[index].call_fd = vmsg->fds[0];
+    dev->vq[index].call_fd = nofd ? -1 : vmsg->fds[0];
 
     /* in case of I/O hang after reconnecting */
-    if (eventfd_write(vmsg->fds[0], 1)) {
+    if (dev->vq[index].call_fd != -1 && eventfd_write(vmsg->fds[0], 1)) {
         return -1;
     }
 
-    DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
+    DPRINT("Got call_fd: %d for vq: %d\n", dev->vq[index].call_fd, index);
 
     return false;
 }
@@ -1144,6 +1151,7 @@ static bool
 vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
 
     DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
 
@@ -1156,7 +1164,7 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
         dev->vq[index].err_fd = -1;
     }
 
-    dev->vq[index].err_fd = vmsg->fds[0];
+    dev->vq[index].err_fd = nofd ? -1 : vmsg->fds[0];
 
     return false;
 }
-- 
2.20.1


