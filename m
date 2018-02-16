Received: from eggs.gnu.org ([2001:4830:134:3::10]:51810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emfsc-0001Lv-Rl
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emfsb-0005ni-90
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emfsb-0005mv-3D
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEB1A407519B
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 13:16:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Feb 2018 13:16:07 +0000
Message-Id: <20180216131625.9639-12-dgilbert@redhat.com>
In-Reply-To: <20180216131625.9639-1-dgilbert@redhat.com>
References: <20180216131625.9639-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 11/29] vhost+postcopy: Transmit 'listen' to
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, imammedo@redhat.com, mst@redhat.com
Cc: quintela@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Notify the vhost-user client on reception of the 'postcopy-listen'
event from the source.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 19 +++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |  2 ++
 docs/interop/vhost-user.txt           |  6 ++++++
 hw/virtio/trace-events                |  3 +++
 hw/virtio/vhost-user.c                | 34 +++++++++++++++++++++++++++++=
+++++
 migration/postcopy-ram.h              |  1 +
 migration/savevm.c                    |  7 +++++++
 7 files changed, 72 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 0b563fc5ae..beec7695a8 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -98,6 +98,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_GET_CONFIG),
         REQ(VHOST_USER_SET_CONFIG),
         REQ(VHOST_USER_POSTCOPY_ADVISE),
+        REQ(VHOST_USER_POSTCOPY_LISTEN),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -933,6 +934,22 @@ out:
     return true; /* =3D send a reply */
 }
=20
+static bool
+vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
+{
+    vmsg->payload.u64 =3D -1;
+    vmsg->size =3D sizeof(vmsg->payload.u64);
+
+    if (dev->nregions) {
+        vu_panic(dev, "Regions already registered at postcopy-listen");
+        return true;
+    }
+    dev->postcopy_listening =3D true;
+
+    vmsg->flags =3D VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
+    vmsg->payload.u64 =3D 0; /* Success */
+    return true;
+}
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1006,6 +1023,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         break;
     case VHOST_USER_POSTCOPY_ADVISE:
         return vu_set_postcopy_advise(dev, vmsg);
+    case VHOST_USER_POSTCOPY_LISTEN:
+        return vu_set_postcopy_listen(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index bb33b33f3b..fcba53c3c3 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -83,6 +83,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_CONFIG =3D 24,
     VHOST_USER_SET_CONFIG =3D 25,
     VHOST_USER_POSTCOPY_ADVISE  =3D 26,
+    VHOST_USER_POSTCOPY_LISTEN  =3D 27,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -282,6 +283,7 @@ struct VuDev {
=20
     /* Postcopy data */
     int postcopy_ufd;
+    bool postcopy_listening;
 };
=20
 typedef struct VuVirtqElement {
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 621543e654..bdec9ec0e8 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -682,6 +682,12 @@ Master message types
       the slave must open a userfaultfd for later use.
       Note that at this stage the migration is still in precopy mode.
=20
+ * VHOST_USER_POSTCOPY_LISTEN
+      Id: 27
+      Master payload: N/A
+
+      Master advises slave that a transition to postcopy mode has happen=
ed.
+
 Slave message types
 -------------------
=20
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 742ff0f90b..06ec03d6e7 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -6,6 +6,9 @@ vhost_region_add_section(const char *name, uint64_t gpa, =
uint64_t size, uint64_t
 vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: =
0x%"PRIx64
 vhost_section(const char *name, int r) "%s:%d"
=20
+# hw/virtio/vhost-user.c
+vhost_user_postcopy_listen(void) ""
+
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned=
 out_num) "elem %p size %zd in_num %u out_num %u"
 virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigned in=
t idx) "vq %p elem %p len %u idx %u"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index dd4eb50668..ec6a4a82fd 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -19,6 +19,7 @@
 #include "qemu/sockets.h"
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
+#include "trace.h"
=20
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -76,6 +77,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_CONFIG =3D 24,
     VHOST_USER_SET_CONFIG =3D 25,
     VHOST_USER_POSTCOPY_ADVISE  =3D 26,
+    VHOST_USER_POSTCOPY_LISTEN  =3D 27,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -157,6 +159,8 @@ struct vhost_user {
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
+    /* True once we've entered postcopy_listen */
+    bool               postcopy_listen;
 };
=20
 static bool ioeventfd_enabled(void)
@@ -843,6 +847,33 @@ static int vhost_user_postcopy_advise(struct vhost_d=
ev *dev, Error **errp)
     return 0;
 }
=20
+/*
+ * Called at the switch to postcopy on reception of the 'listen' command=
.
+ */
+static int vhost_user_postcopy_listen(struct vhost_dev *dev, Error **err=
p)
+{
+    struct vhost_user *u =3D dev->opaque;
+    int ret;
+    VhostUserMsg msg =3D {
+        .hdr.request =3D VHOST_USER_POSTCOPY_LISTEN,
+        .hdr.flags =3D VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+    };
+    u->postcopy_listen =3D true;
+    trace_vhost_user_postcopy_listen();
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        error_setg(errp, "Failed to send postcopy_listen to vhost");
+        return -1;
+    }
+
+    ret =3D process_message_reply(dev, &msg);
+    if (ret) {
+        error_setg(errp, "Failed to receive reply to postcopy_listen");
+        return ret;
+    }
+
+    return 0;
+}
+
 static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
                                         void *opaque)
 {
@@ -865,6 +896,9 @@ static int vhost_user_postcopy_notifier(NotifierWithR=
eturn *notifier,
     case POSTCOPY_NOTIFY_INBOUND_ADVISE:
         return vhost_user_postcopy_advise(dev, pnd->errp);
=20
+    case POSTCOPY_NOTIFY_INBOUND_LISTEN:
+        return vhost_user_postcopy_listen(dev, pnd->errp);
+
     default:
         /* We ignore notifications we don't know */
         break;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 23efbdf346..dbc2ee1f2b 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -129,6 +129,7 @@ void postcopy_infrastructure_init(void);
 enum PostcopyNotifyReason {
     POSTCOPY_NOTIFY_PROBE =3D 0,
     POSTCOPY_NOTIFY_INBOUND_ADVISE,
+    POSTCOPY_NOTIFY_INBOUND_LISTEN,
 };
=20
 struct PostcopyNotifyData {
diff --git a/migration/savevm.c b/migration/savevm.c
index 9840bcaac9..fa779232cc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1614,6 +1614,8 @@ static int loadvm_postcopy_handle_listen(MigrationI=
ncomingState *mis)
 {
     PostcopyState ps =3D postcopy_state_set(POSTCOPY_INCOMING_LISTENING)=
;
     trace_loadvm_postcopy_handle_listen();
+    Error *local_err =3D NULL;
+
     if (ps !=3D POSTCOPY_INCOMING_ADVISE && ps !=3D POSTCOPY_INCOMING_DI=
SCARD) {
         error_report("CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)",=
 ps);
         return -1;
@@ -1639,6 +1641,11 @@ static int loadvm_postcopy_handle_listen(Migration=
IncomingState *mis)
         }
     }
=20
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
+
     if (mis->have_listen_thread) {
         error_report("CMD_POSTCOPY_RAM_LISTEN already has a listen threa=
d");
         return -1;
--=20
2.14.3
