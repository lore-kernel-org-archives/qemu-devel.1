Received: from eggs.gnu.org ([2001:4830:134:3::10]:47685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLnC-0006iG-Du
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLnB-0002uS-1i
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLnA-0002tx-Ov
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:23 +0200
Message-Id: <20170919165226.23022-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 24/27] vhost-user-scsi: use glib logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, changpeng.liu@intel.com, f4bug@amsat.org, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

- PLOG is unused
- code is compiled out unless debug is enabled
- logging is too verbose
- you can pipe to ts to have timestamp if needed, or use structured
  logging with more recent glib

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 77 +++++++++----------------=
------
 1 file changed, 21 insertions(+), 56 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 2e1100dea3..ff817d6643 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -18,42 +18,6 @@
=20
 #include <glib.h>
=20
-/* #define VUS_DEBUG 1 */
-
-/** Log helpers **/
-
-#define PPRE                                                          \
-    struct timespec ts;                                               \
-    char   timebuf[64];                                               \
-    struct tm tm;                                                     \
-    (void)clock_gettime(CLOCK_REALTIME, &ts);                         \
-    (void)strftime(timebuf, 64, "%Y%m%d %T", gmtime_r(&ts.tv_sec, &tm))
-
-#define PEXT(lvl, msg, ...) do {                                      \
-    PPRE;                                                             \
-    fprintf(stderr, "%s.%06ld " lvl ": %s:%s():%d: " msg "\n",        \
-            timebuf, ts.tv_nsec / 1000,                               \
-            __FILE__, __func__, __LINE__, ## __VA_ARGS__);            \
-} while (0)
-
-#define PNOR(lvl, msg, ...) do {                                      \
-    PPRE;                                                             \
-    fprintf(stderr, "%s.%06ld " lvl ": " msg "\n",                    \
-            timebuf, ts.tv_nsec / 1000, ## __VA_ARGS__);              \
-} while (0)
-
-#ifdef VUS_DEBUG
-#define PDBG(msg, ...) PEXT("DBG", msg, ## __VA_ARGS__)
-#define PERR(msg, ...) PEXT("ERR", msg, ## __VA_ARGS__)
-#define PLOG(msg, ...) PEXT("LOG", msg, ## __VA_ARGS__)
-#else
-#define PDBG(msg, ...) { }
-#define PERR(msg, ...) PNOR("ERR", msg, ## __VA_ARGS__)
-#define PLOG(msg, ...) PNOR("LOG", msg, ## __VA_ARGS__)
-#endif
-
-/** vhost-user-scsi specific definitions **/
-
 #define VUS_ISCSI_INITIATOR "iqn.2016-11.com.nutanix:vhost-user-scsi"
=20
 typedef struct VusIscsiLun {
@@ -168,27 +132,28 @@ static int vus_iscsi_add_lun(VusIscsiLun *lun, char=
 *iscsi_uri)
=20
     iscsi_ctx =3D iscsi_create_context(VUS_ISCSI_INITIATOR);
     if (!iscsi_ctx) {
-        PERR("Unable to create iSCSI context");
+        g_warning("Unable to create iSCSI context");
         return -1;
     }
=20
     iscsi_url =3D iscsi_parse_full_url(iscsi_ctx, iscsi_uri);
     if (!iscsi_url) {
-        PERR("Unable to parse iSCSI URL: %s", iscsi_get_error(iscsi_ctx)=
);
+        g_warning("Unable to parse iSCSI URL: %s", iscsi_get_error(iscsi=
_ctx));
         goto fail;
     }
=20
     iscsi_set_session_type(iscsi_ctx, ISCSI_SESSION_NORMAL);
     iscsi_set_header_digest(iscsi_ctx, ISCSI_HEADER_DIGEST_NONE_CRC32C);
     if (iscsi_full_connect_sync(iscsi_ctx, iscsi_url->portal, iscsi_url-=
>lun)) {
-        PERR("Unable to login to iSCSI portal: %s", iscsi_get_error(iscs=
i_ctx));
+        g_warning("Unable to login to iSCSI portal: %s",
+                  iscsi_get_error(iscsi_ctx));
         goto fail;
     }
=20
     lun->iscsi_ctx =3D iscsi_ctx;
     lun->iscsi_lun =3D iscsi_url->lun;
=20
-    PDBG("Context %p created for lun 0: %s", iscsi_ctx, iscsi_uri);
+    g_debug("Context %p created for lun 0: %s", iscsi_ctx, iscsi_uri);
=20
 out:
     if (iscsi_url) {
@@ -230,7 +195,7 @@ static int get_cdb_len(uint8_t *cdb)
     case 4: return 16;
     case 5: return 12;
     }
-    PERR("Unable to determine cdb len (0x%02hhX)", cdb[0] >> 5);
+    g_warning("Unable to determine cdb len (0x%02hhX)", cdb[0] >> 5);
     return -1;
 }
=20
@@ -252,7 +217,7 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
=20
     if (!(!req->lun[1] && req->lun[2] =3D=3D 0x40 && !req->lun[3])) {
         /* Ignore anything different than target=3D0, lun=3D0 */
-        PDBG("Ignoring unconnected lun (0x%hhX, 0x%hhX)",
+        g_debug("Ignoring unconnected lun (0x%hhX, 0x%hhX)",
              req->lun[1], req->lun[3]);
         rsp->status =3D SCSI_STATUS_CHECK_CONDITION;
         memset(rsp->sense, 0, sizeof(rsp->sense));
@@ -295,10 +260,10 @@ static int handle_cmd_sync(struct iscsi_context *ct=
x,
         task->iovector_in.niov =3D in_len;
     }
=20
-    PDBG("Sending iscsi cmd (cdb_len=3D%d, dir=3D%d, task=3D%p)",
+    g_debug("Sending iscsi cmd (cdb_len=3D%d, dir=3D%d, task=3D%p)",
          cdb_len, dir, task);
     if (!iscsi_scsi_command_sync(ctx, 0, task, NULL)) {
-        PERR("Error serving SCSI command");
+        g_warning("Error serving SCSI command");
         g_free(task);
         return -1;
     }
@@ -316,7 +281,7 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
=20
     g_free(task);
=20
-    PDBG("Filled in rsp: status=3D%hhX, resid=3D%u, response=3D%hhX, sen=
se_len=3D%u",
+    g_debug("Filled in rsp: status=3D%hhX, resid=3D%u, response=3D%hhX, =
sense_len=3D%u",
          rsp->status, rsp->resid, rsp->response, rsp->sense_len);
=20
     return 0;
@@ -332,7 +297,7 @@ static void vus_panic_cb(VuDev *vu_dev, const char *b=
uf)
=20
     vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
     if (buf) {
-        PERR("vu_panic: %s", buf);
+        g_warning("vu_panic: %s", buf);
     }
=20
     g_main_loop_quit(vdev_scsi->loop);
@@ -373,19 +338,19 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
=20
     vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
     if (idx < 0 || idx >=3D VHOST_MAX_NR_VIRTQUEUE) {
-        PERR("VQ Index out of range: %d", idx);
+        g_warning("VQ Index out of range: %d", idx);
         vus_panic_cb(vu_dev, NULL);
         return;
     }
=20
     vq =3D vu_get_queue(vu_dev, idx);
     if (!vq) {
-        PERR("Error fetching VQ (dev=3D%p, idx=3D%d)", vu_dev, idx);
+        g_warning("Error fetching VQ (dev=3D%p, idx=3D%d)", vu_dev, idx)=
;
         vus_panic_cb(vu_dev, NULL);
         return;
     }
=20
-    PDBG("Got kicked on vq[%d]@%p", idx, vq);
+    g_debug("Got kicked on vq[%d]@%p", idx, vq);
=20
     while (1) {
         VuVirtqElement *elem;
@@ -394,23 +359,23 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
=20
         elem =3D vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement));
         if (!elem) {
-            PDBG("No more elements pending on vq[%d]@%p", idx, vq);
+            g_debug("No more elements pending on vq[%d]@%p", idx, vq);
             break;
         }
-        PDBG("Popped elem@%p", elem);
+        g_debug("Popped elem@%p", elem);
=20
         assert(!(elem->out_num > 1 && elem->in_num > 1));
         assert(elem->out_num > 0 && elem->in_num > 0);
=20
         if (elem->out_sg[0].iov_len < sizeof(VirtIOSCSICmdReq)) {
-            PERR("Invalid virtio-scsi req header");
+            g_warning("Invalid virtio-scsi req header");
             vus_panic_cb(vu_dev, NULL);
             break;
         }
         req =3D (VirtIOSCSICmdReq *)elem->out_sg[0].iov_base;
=20
         if (elem->in_sg[0].iov_len < sizeof(VirtIOSCSICmdResp)) {
-            PERR("Invalid virtio-scsi rsp header");
+            g_warning("Invalid virtio-scsi rsp header");
             vus_panic_cb(vu_dev, NULL);
             break;
         }
@@ -437,7 +402,7 @@ static void vus_queue_set_started(VuDev *vu_dev, int =
idx, bool started)
     assert(vu_dev);
=20
     if (idx < 0 || idx >=3D VHOST_MAX_NR_VIRTQUEUE) {
-        PERR("VQ Index out of range: %d", idx);
+        g_warning("VQ Index out of range: %d", idx);
         vus_panic_cb(vu_dev, NULL);
         return;
     }
@@ -445,7 +410,7 @@ static void vus_queue_set_started(VuDev *vu_dev, int =
idx, bool started)
     vq =3D vu_get_queue(vu_dev, idx);
=20
     if (idx =3D=3D 0 || idx =3D=3D 1) {
-        PDBG("queue %d unimplemented", idx);
+        g_debug("queue %d unimplemented", idx);
     } else {
         vu_set_queue_handler(vu_dev, vq, started ? vus_proc_req : NULL);
     }
@@ -462,7 +427,7 @@ static gboolean vus_vhost_cb(gpointer data)
     assert(vu_dev);
=20
     if (!vu_dispatch(vu_dev) !=3D 0) {
-        PERR("Error processing vhost message");
+        g_warning("Error processing vhost message");
         vus_panic_cb(vu_dev, NULL);
         return G_SOURCE_REMOVE;
     }
--=20
2.14.1.146.gd35faa819
