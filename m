Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C337C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B8A20873
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B8A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53734 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd6X0-0004vm-9W
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 01:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51151)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tiwei.bie@intel.com>) id 1hd6W1-0004N3-1C
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tiwei.bie@intel.com>) id 1hd6W0-0006OM-0L
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:18:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:44962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tiwei.bie@intel.com>)
 id 1hd6Vw-0006EU-01; Tue, 18 Jun 2019 01:18:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2019 22:18:26 -0700
X-ExtLoop1: 1
Received: from npg-dpdk-virtio-tbie-2.sh.intel.com ([10.67.104.151])
 by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2019 22:18:25 -0700
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, marcandre.lureau@gmail.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Date: Tue, 18 Jun 2019 13:14:58 +0800
Message-Id: <20190618051458.7855-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH v2] vhost-user: fix reconnection support for
 host notifier
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
Cc: cunming.liang@intel.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to destroy the host notifiers when cleaning up
the backend. Otherwise, some resources are not released
after the connection is closed, and it may prevent the
external backend from reopening them (e.g. VFIO files)
during restart.

Fixes: 44866521bd6e ("vhost-user: support registering external host notifiers")
Cc: qemu-stable@nongnu.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
v2:
- Drop superfluous memset() (Marc-André);
- Factor the notifier code in a separate function (Marc-André);

 hw/virtio/vhost-user.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 4ca5b2551e..e27a2a4647 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -226,6 +226,20 @@ static bool ioeventfd_enabled(void)
     return !kvm_enabled() || kvm_eventfds_enabled();
 }
 
+static void
+vhost_user_host_notifiers_cleanup(VhostUserState *user)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        if (user->notifier[i].addr) {
+            object_unparent(OBJECT(&user->notifier[i].mr));
+            munmap(user->notifier[i].addr, qemu_real_host_page_size);
+            user->notifier[i].addr = NULL;
+        }
+    }
+}
+
 static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
 {
     struct vhost_user *u = dev->opaque;
@@ -1469,6 +1483,9 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
     u = dev->opaque;
+    if (dev->vq_index == 0) {
+        vhost_user_host_notifiers_cleanup(u->user);
+    }
     if (u->postcopy_notifier.notify) {
         postcopy_remove_notifier(&u->postcopy_notifier);
         u->postcopy_notifier.notify = NULL;
@@ -1898,19 +1915,10 @@ bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
 
 void vhost_user_cleanup(VhostUserState *user)
 {
-    int i;
-
     if (!user->chr) {
         return;
     }
-
-    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-        if (user->notifier[i].addr) {
-            object_unparent(OBJECT(&user->notifier[i].mr));
-            munmap(user->notifier[i].addr, qemu_real_host_page_size);
-            user->notifier[i].addr = NULL;
-        }
-    }
+    vhost_user_host_notifiers_cleanup(user);
     user->chr = NULL;
 }
 
-- 
2.17.1


