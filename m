Received: from eggs.gnu.org ([209.51.188.92]:43475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gvgAd-0000NC-LP
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gvgAb-0006Vr-Nl
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:29:07 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gvgAZ-000635-Q3
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:29:05 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so8589403plb.5
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 02:28:19 -0800 (PST)
From: elohimes@gmail.com
Date: Mon, 18 Feb 2019 18:27:43 +0800
Message-Id: <20190218102748.2242-3-xieyongji@baidu.com>
In-Reply-To: <20190218102748.2242-1-xieyongji@baidu.com>
References: <20190218102748.2242-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v6 2/7] libvhost-user: Remove unnecessary FD
 flag check for event file descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, stefanha@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

The vu_check_queue_msg_file() has checked the FD flag. So let's
delete the redundant check after it.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 contrib/libvhost-user/libvhost-user.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 3f14b4138b..16fec3a3fd 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -907,10 +907,8 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
         dev->vq[index].kick_fd = -1;
     }
 
-    if (!(vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK)) {
-        dev->vq[index].kick_fd = vmsg->fds[0];
-        DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
-    }
+    dev->vq[index].kick_fd = vmsg->fds[0];
+    DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
 
     dev->vq[index].started = true;
     if (dev->iface->queue_set_started) {
@@ -995,9 +993,7 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
         dev->vq[index].call_fd = -1;
     }
 
-    if (!(vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK)) {
-        dev->vq[index].call_fd = vmsg->fds[0];
-    }
+    dev->vq[index].call_fd = vmsg->fds[0];
 
     DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
 
@@ -1020,9 +1016,7 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
         dev->vq[index].err_fd = -1;
     }
 
-    if (!(vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK)) {
-        dev->vq[index].err_fd = vmsg->fds[0];
-    }
+    dev->vq[index].err_fd = vmsg->fds[0];
 
     return false;
 }
-- 
2.17.1
