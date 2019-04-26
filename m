Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C990C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D69206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D69206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuQb-0007Uf-FC
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:33:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1hJuCt-0001pU-AY
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1hJuCj-0007zh-4i
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:19:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:61552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>)
	id 1hJuCh-0007lI-4z; Fri, 26 Apr 2019 02:19:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 23:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,396,1549958400"; d="scan'208";a="143760228"
Received: from npg_dpdk_virtio_tbie_2.sh.intel.com ([10.67.104.173])
	by fmsmga008.fm.intel.com with ESMTP; 25 Apr 2019 23:19:10 -0700
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 14:18:15 +0800
Message-Id: <20190426061815.6384-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: [Qemu-devel] [PATCH] vhost-user: fix reconnection support for host
 notifier
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: cunming.liang@intel.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426061815.P1ivty7sLaY5MK-MoQ04_Ts4ZfwGGgMLbizbkyurXMA@z>

We need to destroy the host notifiers when cleaning up
the backend. Otherwise, some resources are not released
after the connection is closed, and it may prevent the
external backend from reopening them (e.g. VFIO files)
during restart.

Fixes: 44866521bd6e ("vhost-user: support registering external host notifiers")
Cc: qemu-stable@nongnu.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/virtio/vhost-user.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 553319c7ac..56656629c0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1454,10 +1454,24 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
 static int vhost_user_backend_cleanup(struct vhost_dev *dev)
 {
     struct vhost_user *u;
+    VhostUserState *user;
+    int i;
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
     u = dev->opaque;
+
+    if (dev->vq_index == 0) {
+        user = u->user;
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            if (user->notifier[i].addr) {
+                object_unparent(OBJECT(&user->notifier[i].mr));
+                munmap(user->notifier[i].addr, qemu_real_host_page_size);
+                user->notifier[i].addr = NULL;
+            }
+        }
+    }
+
     if (u->postcopy_notifier.notify) {
         postcopy_remove_notifier(&u->postcopy_notifier);
         u->postcopy_notifier.notify = NULL;
@@ -1881,6 +1895,8 @@ bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
         error_setg(errp, "Cannot initialize vhost-user state");
         return false;
     }
+
+    memset(user, 0, sizeof(*user));
     user->chr = chr;
     return true;
 }
-- 
2.17.1


