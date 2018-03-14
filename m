Received: from eggs.gnu.org ([2001:4830:134:3::10]:41772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51i-00036a-00
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51g-0004ge-LX
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew51g-0004gW-Fb
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00AF18182D16
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:57:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:56:00 +0000
Message-Id: <20180314115618.28831-12-dgilbert@redhat.com>
In-Reply-To: <20180314115618.28831-1-dgilbert@redhat.com>
References: <20180314115618.28831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 11/29] vhost+postcopy: Transmit 'listen' to
 slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Notify the vhost-user slave on reception of the 'postcopy-listen'
event from the source.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 19 +++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |  2 ++
 docs/interop/vhost-user.txt           | 11 +++++++++++
 hw/virtio/trace-events                |  3 +++
 hw/virtio/vhost-user.c                | 34 +++++++++++++++++++++++++++++=
+++++
 migration/postcopy-ram.h              |  1 +
 migration/savevm.c                    |  7 +++++++
 7 files changed, 77 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 9e31f47b7a..e53b1953df 100644
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
@@ -931,6 +932,22 @@ out:
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
@@ -1004,6 +1021,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
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
index 074b7860f6..ed505cf0c1 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -86,6 +86,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_CREATE_CRYPTO_SESSION =3D 26,
     VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
     VHOST_USER_POSTCOPY_ADVISE  =3D 28,
+    VHOST_USER_POSTCOPY_LISTEN  =3D 29,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -285,6 +286,7 @@ struct VuDev {
=20
     /* Postcopy data */
     int postcopy_ufd;
+    bool postcopy_listening;
 };
=20
 typedef struct VuVirtqElement {
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 7854e50008..0d24203d31 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -709,6 +709,17 @@ Master message types
       the slave must open a userfaultfd for later use.
       Note that at this stage the migration is still in precopy mode.
=20
+ * VHOST_USER_POSTCOPY_LISTEN
+      Id: 29
+      Master payload: N/A
+
+      Master advises slave that a transition to postcopy mode has happen=
ed.
+      The slave must ensure that shared memory is registered with userfa=
ultfd
+      to cause faulting of non-present pages.
+
+      This is always sent sometime after a VHOST_USER_POSTCOPY_ADVISE, a=
nd
+      thus only when VHOST_USER_PROTOCOL_F_PAGEFAULT is supported.
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
index ae7754f596..660183d23d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -20,6 +20,7 @@
 #include "sysemu/cryptodev.h"
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
+#include "trace.h"
=20
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -79,6 +80,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_CREATE_CRYPTO_SESSION =3D 26,
     VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
     VHOST_USER_POSTCOPY_ADVISE  =3D 28,
+    VHOST_USER_POSTCOPY_LISTEN  =3D 29,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -174,6 +176,8 @@ struct vhost_user {
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
+    /* True once we've entered postcopy_listen */
+    bool               postcopy_listen;
 };
=20
 static bool ioeventfd_enabled(void)
@@ -874,6 +878,33 @@ static int vhost_user_postcopy_advise(struct vhost_d=
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
@@ -896,6 +927,9 @@ static int vhost_user_postcopy_notifier(NotifierWithR=
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
index f21eef6702..c8ced3470b 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -131,6 +131,7 @@ void postcopy_infrastructure_init(void);
 enum PostcopyNotifyReason {
     POSTCOPY_NOTIFY_PROBE =3D 0,
     POSTCOPY_NOTIFY_INBOUND_ADVISE,
+    POSTCOPY_NOTIFY_INBOUND_LISTEN,
 };
=20
 struct PostcopyNotifyData {
diff --git a/migration/savevm.c b/migration/savevm.c
index 1f2bf12a28..305c3ceaf5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1618,6 +1618,8 @@ static int loadvm_postcopy_handle_listen(MigrationI=
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
@@ -1643,6 +1645,11 @@ static int loadvm_postcopy_handle_listen(Migration=
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
