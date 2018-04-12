Received: from eggs.gnu.org ([2001:4830:134:3::10]:39050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6dw3-0005j7-Ue
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6dw2-0007QS-0Q
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:14:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:48812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f6dw1-0007PY-KG
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:14:49 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 12 Apr 2018 23:12:27 +0800
Message-Id: <20180412151232.17506-2-tiwei.bie@intel.com>
In-Reply-To: <20180412151232.17506-1-tiwei.bie@intel.com>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v3 1/6] vhost-user: add Net prefix to internal
 state structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

We are going to introduce a shared vhost user state which
will be named as 'VhostUserState'. So add 'Net' prefix to
the existing internal state structure in the vhost-user
netdev to avoid conflict.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 net/vhost-user.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index e0f16c895b..fa28aad12d 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -20,38 +20,38 @@
 #include "qemu/option.h"
 #include "trace.h"
 
-typedef struct VhostUserState {
+typedef struct NetVhostUserState {
     NetClientState nc;
     CharBackend chr; /* only queue index 0 */
     VHostNetState *vhost_net;
     guint watch;
     uint64_t acked_features;
     bool started;
-} VhostUserState;
+} NetVhostUserState;
 
 VHostNetState *vhost_user_get_vhost_net(NetClientState *nc)
 {
-    VhostUserState *s = DO_UPCAST(VhostUserState, nc, nc);
+    NetVhostUserState *s = DO_UPCAST(NetVhostUserState, nc, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_USER);
     return s->vhost_net;
 }
 
 uint64_t vhost_user_get_acked_features(NetClientState *nc)
 {
-    VhostUserState *s = DO_UPCAST(VhostUserState, nc, nc);
+    NetVhostUserState *s = DO_UPCAST(NetVhostUserState, nc, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_USER);
     return s->acked_features;
 }
 
 static void vhost_user_stop(int queues, NetClientState *ncs[])
 {
-    VhostUserState *s;
+    NetVhostUserState *s;
     int i;
 
     for (i = 0; i < queues; i++) {
         assert(ncs[i]->info->type == NET_CLIENT_DRIVER_VHOST_USER);
 
-        s = DO_UPCAST(VhostUserState, nc, ncs[i]);
+        s = DO_UPCAST(NetVhostUserState, nc, ncs[i]);
 
         if (s->vhost_net) {
             /* save acked features */
@@ -68,7 +68,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
 {
     VhostNetOptions options;
     struct vhost_net *net = NULL;
-    VhostUserState *s;
+    NetVhostUserState *s;
     int max_queues;
     int i;
 
@@ -77,7 +77,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
     for (i = 0; i < queues; i++) {
         assert(ncs[i]->info->type == NET_CLIENT_DRIVER_VHOST_USER);
 
-        s = DO_UPCAST(VhostUserState, nc, ncs[i]);
+        s = DO_UPCAST(NetVhostUserState, nc, ncs[i]);
 
         options.net_backend = ncs[i];
         options.opaque      = be;
@@ -123,7 +123,7 @@ static ssize_t vhost_user_receive(NetClientState *nc, const uint8_t *buf,
        without GUEST_ANNOUNCE capability.
      */
     if (size == 60) {
-        VhostUserState *s = DO_UPCAST(VhostUserState, nc, nc);
+        NetVhostUserState *s = DO_UPCAST(NetVhostUserState, nc, nc);
         int r;
         static int display_rarp_failure = 1;
         char mac_addr[6];
@@ -146,7 +146,7 @@ static ssize_t vhost_user_receive(NetClientState *nc, const uint8_t *buf,
 
 static void vhost_user_cleanup(NetClientState *nc)
 {
-    VhostUserState *s = DO_UPCAST(VhostUserState, nc, nc);
+    NetVhostUserState *s = DO_UPCAST(NetVhostUserState, nc, nc);
 
     if (s->vhost_net) {
         vhost_net_cleanup(s->vhost_net);
@@ -180,7 +180,7 @@ static bool vhost_user_has_ufo(NetClientState *nc)
 
 static NetClientInfo net_vhost_user_info = {
         .type = NET_CLIENT_DRIVER_VHOST_USER,
-        .size = sizeof(VhostUserState),
+        .size = sizeof(NetVhostUserState),
         .receive = vhost_user_receive,
         .cleanup = vhost_user_cleanup,
         .has_vnet_hdr = vhost_user_has_vnet_hdr,
@@ -190,7 +190,7 @@ static NetClientInfo net_vhost_user_info = {
 static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
                                            void *opaque)
 {
-    VhostUserState *s = opaque;
+    NetVhostUserState *s = opaque;
 
     qemu_chr_fe_disconnect(&s->chr);
 
@@ -203,7 +203,7 @@ static void chr_closed_bh(void *opaque)
 {
     const char *name = opaque;
     NetClientState *ncs[MAX_QUEUE_NUM];
-    VhostUserState *s;
+    NetVhostUserState *s;
     Error *err = NULL;
     int queues;
 
@@ -212,7 +212,7 @@ static void chr_closed_bh(void *opaque)
                                           MAX_QUEUE_NUM);
     assert(queues < MAX_QUEUE_NUM);
 
-    s = DO_UPCAST(VhostUserState, nc, ncs[0]);
+    s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
 
     qmp_set_link(name, false, &err);
     vhost_user_stop(queues, ncs);
@@ -229,7 +229,7 @@ static void net_vhost_user_event(void *opaque, int event)
 {
     const char *name = opaque;
     NetClientState *ncs[MAX_QUEUE_NUM];
-    VhostUserState *s;
+    NetVhostUserState *s;
     Chardev *chr;
     Error *err = NULL;
     int queues;
@@ -239,7 +239,7 @@ static void net_vhost_user_event(void *opaque, int event)
                                           MAX_QUEUE_NUM);
     assert(queues < MAX_QUEUE_NUM);
 
-    s = DO_UPCAST(VhostUserState, nc, ncs[0]);
+    s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
     chr = qemu_chr_fe_get_driver(&s->chr);
     trace_vhost_user_event(chr->label, event);
     switch (event) {
@@ -283,7 +283,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
 {
     Error *err = NULL;
     NetClientState *nc, *nc0 = NULL;
-    VhostUserState *s;
+    NetVhostUserState *s;
     int i;
 
     assert(name);
@@ -296,7 +296,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
         nc->queue_index = i;
         if (!nc0) {
             nc0 = nc;
-            s = DO_UPCAST(VhostUserState, nc, nc);
+            s = DO_UPCAST(NetVhostUserState, nc, nc);
             if (!qemu_chr_fe_init(&s->chr, chr, &err)) {
                 error_report_err(err);
                 return -1;
@@ -305,7 +305,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
 
     }
 
-    s = DO_UPCAST(VhostUserState, nc, nc0);
+    s = DO_UPCAST(NetVhostUserState, nc, nc0);
     do {
         if (qemu_chr_fe_wait_connected(&s->chr, &err) < 0) {
             error_report_err(err);
-- 
2.11.0
