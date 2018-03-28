Received: from eggs.gnu.org ([2001:4830:134:3::10]:52867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1GkJ-00047m-5B
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1GkF-00026x-W3
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:28:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1f1GkF-00025r-SL
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:28:27 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Wed, 28 Mar 2018 21:27:59 +0200
Message-Id: <20180328192800.7138-2-maxime.coquelin@redhat.com>
In-Reply-To: <20180328192800.7138-1-maxime.coquelin@redhat.com>
References: <20180328192800.7138-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] vhost-user-blk: set config ops before
 vhost-user init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, changpeng.liu@intel.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

As soon as vhost-user init is done, the backend may send
VHOST_USER_SLAVE_CONFIG_CHANGE_MSG, so let's set the
notification callback before it.

Also, it will be used to know whether the device supports
the config feature to advertize it or not.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/block/vhost-user-blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index f840f07dfe..262baca432 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -259,6 +259,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     s->dev.vq_index = 0;
     s->dev.backend_features = 0;
 
+    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
+
     ret = vhost_dev_init(&s->dev, &s->chardev, VHOST_BACKEND_TYPE_USER, 0);
     if (ret < 0) {
         error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
@@ -277,8 +279,6 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
         s->blkcfg.num_queues = s->num_queues;
     }
 
-    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
-
     return;
 
 vhost_err:
-- 
2.14.3
