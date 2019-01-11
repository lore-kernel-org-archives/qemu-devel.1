Received: from eggs.gnu.org ([209.51.188.92]:46483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=907059760=anthony.perard@citrix.com>)
	id 1gi1G2-0002h2-Pu
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=907059760=anthony.perard@citrix.com>)
	id 1gi1G0-0005tR-5n
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:10:14 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:57209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=907059760=anthony.perard@citrix.com>)
	id 1gi1Fz-0005qo-T8
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:10:12 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Fri, 11 Jan 2019 18:09:41 +0000
Message-ID: <20190111180941.6198-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen: Fix event channel interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>, "open
	list:X86" <xen-devel@lists.xenproject.org>

Patch "xen: add event channel interface for XenDevice-s" makes use of
the type xenevtchn_port_or_error_t, but this isn't avaiable before Xen
4.7. Also the function xen_device_bind_event_channel assign the return
value of xenevtchn_bind_interdomain to channel->local_port but check the
result for error with xendev->local_port.

Fix by:
- removing local_port from struct XenDevice as it isn't use anywere.
- adding a compatibility typedef for xenevtchn_port_or_error_t for Xen
  4.6 and earlier.

As extra, replace the type of XenEventChannel->local_port by
evtchn_port_t.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c            | 12 +++++++-----
 include/hw/xen/xen-bus.h    |  1 -
 include/hw/xen/xen_common.h |  1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index f90bcf2342..3aeccec69c 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -917,7 +917,7 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
 }
 
 struct XenEventChannel {
-    unsigned int local_port;
+    evtchn_port_t local_port;
     XenEventHandler handler;
     void *opaque;
     Notifier notifier;
@@ -939,17 +939,19 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
                                                void *opaque, Error **errp)
 {
     XenEventChannel *channel = g_new0(XenEventChannel, 1);
+    xenevtchn_port_or_error_t local_port;
 
-    channel->local_port = xenevtchn_bind_interdomain(xendev->xeh,
-                                                     xendev->frontend_id,
-                                                     port);
-    if (xendev->local_port < 0) {
+    local_port = xenevtchn_bind_interdomain(xendev->xeh,
+                                            xendev->frontend_id,
+                                            port);
+    if (local_port < 0) {
         error_setg_errno(errp, errno, "xenevtchn_bind_interdomain failed");
 
         g_free(channel);
         return NULL;
     }
 
+    channel->local_port = local_port;
     channel->handler = handler;
     channel->opaque = opaque;
     channel->notifier.notify = event_notify;
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index e55a5de5f1..3183f10e3c 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -29,7 +29,6 @@ typedef struct XenDevice {
     xengnttab_handle *xgth;
     bool feature_grant_copy;
     xenevtchn_handle *xeh;
-    xenevtchn_port_or_error_t local_port;
     NotifierList event_notifiers;
 } XenDevice;
 
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 2b91d199a1..9a8155e172 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -32,6 +32,7 @@ extern xc_interface *xen_xc;
 typedef xc_interface xenforeignmemory_handle;
 typedef xc_evtchn xenevtchn_handle;
 typedef xc_gnttab xengnttab_handle;
+typedef evtchn_port_or_error_t xenevtchn_port_or_error_t;
 
 #define xenevtchn_open(l, f) xc_evtchn_open(l, f);
 #define xenevtchn_close(h) xc_evtchn_close(h)
-- 
Anthony PERARD
