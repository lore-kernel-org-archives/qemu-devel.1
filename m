Received: from eggs.gnu.org ([2001:4830:134:3::10]:49924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci5Pa-0003ZW-Fg
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci5PZ-0007cX-2m
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:27:18 -0500
Received: from hera.aquilenet.fr ([2a01:474::1]:56808)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci5PY-0007cO-PT
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:27:17 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 26 Feb 2017 21:27:06 +0100
Message-Id: <20170226202709.2114-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170226202709.2114-1-samuel.thibault@ens-lyon.org>
References: <20170226202709.2114-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 2/5] slirp: VMStatify sbuf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Convert the sbuf structure to a VMStateDescription.
Note this uses the VMSTATE_WITH_TMP mechanism to calculate
and reload the offsets based on the pointers.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/sbuf.h  |   4 +-
 slirp/slirp.c | 116 ++++++++++++++++++++++++++++++++++++++--------------------
 2 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/slirp/sbuf.h b/slirp/sbuf.h
index efcec39a6b..a722ecb629 100644
--- a/slirp/sbuf.h
+++ b/slirp/sbuf.h
@@ -12,8 +12,8 @@
 #define sbspace(sb) ((sb)->sb_datalen - (sb)->sb_cc)
 
 struct sbuf {
-	u_int	sb_cc;		/* actual chars in buffer */
-	u_int	sb_datalen;	/* Length of data  */
+	uint32_t sb_cc;		/* actual chars in buffer */
+	uint32_t sb_datalen;	/* Length of data  */
 	char	*sb_wptr;	/* write pointer. points to where the next
 				 * bytes should be written in the sbuf */
 	char	*sb_rptr;	/* read pointer. points to where the next
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 276d8cb486..178c2b6d14 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1185,19 +1185,72 @@ static const VMStateDescription vmstate_slirp_tcp = {
     }
 };
 
-static void slirp_sbuf_save(QEMUFile *f, struct sbuf *sbuf)
+/* The sbuf has a pair of pointers that are migrated as offsets;
+ * we calculate the offsets and restore the pointers using
+ * pre_save/post_load on a tmp structure.
+ */
+struct sbuf_tmp {
+    struct sbuf *parent;
+    uint32_t roff, woff;
+};
+
+static void sbuf_tmp_pre_save(void *opaque)
+{
+    struct sbuf_tmp *tmp = opaque;
+    tmp->woff = tmp->parent->sb_wptr - tmp->parent->sb_data;
+    tmp->roff = tmp->parent->sb_rptr - tmp->parent->sb_data;
+}
+
+static int sbuf_tmp_post_load(void *opaque, int version)
 {
-    uint32_t off;
-
-    qemu_put_be32(f, sbuf->sb_cc);
-    qemu_put_be32(f, sbuf->sb_datalen);
-    off = (uint32_t)(sbuf->sb_wptr - sbuf->sb_data);
-    qemu_put_sbe32(f, off);
-    off = (uint32_t)(sbuf->sb_rptr - sbuf->sb_data);
-    qemu_put_sbe32(f, off);
-    qemu_put_buffer(f, (unsigned char*)sbuf->sb_data, sbuf->sb_datalen);
+    struct sbuf_tmp *tmp = opaque;
+    uint32_t requested_len = tmp->parent->sb_datalen;
+
+    /* Allocate the buffer space used by the field after the tmp */
+    sbreserve(tmp->parent, tmp->parent->sb_datalen);
+
+    if (tmp->parent->sb_datalen != requested_len) {
+        return -ENOMEM;
+    }
+    if (tmp->woff >= requested_len ||
+        tmp->roff >= requested_len) {
+        error_report("invalid sbuf offsets r/w=%u/%u len=%u",
+                     tmp->roff, tmp->woff, requested_len);
+        return -EINVAL;
+    }
+
+    tmp->parent->sb_wptr = tmp->parent->sb_data + tmp->woff;
+    tmp->parent->sb_rptr = tmp->parent->sb_data + tmp->roff;
+
+    return 0;
 }
 
+
+static const VMStateDescription vmstate_slirp_sbuf_tmp = {
+    .name = "slirp-sbuf-tmp",
+    .post_load = sbuf_tmp_post_load,
+    .pre_save  = sbuf_tmp_pre_save,
+    .version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(woff, struct sbuf_tmp),
+        VMSTATE_UINT32(roff, struct sbuf_tmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_slirp_sbuf = {
+    .name = "slirp-sbuf",
+    .version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(sb_cc, struct sbuf),
+        VMSTATE_UINT32(sb_datalen, struct sbuf),
+        VMSTATE_WITH_TMP(struct sbuf, struct sbuf_tmp, vmstate_slirp_sbuf_tmp),
+        VMSTATE_VBUFFER_UINT32(sb_data, struct sbuf, 0, NULL, sb_datalen),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+
 static void slirp_socket_save(QEMUFile *f, struct socket *so)
 {
     qemu_put_be32(f, so->so_urgc);
@@ -1225,8 +1278,9 @@ static void slirp_socket_save(QEMUFile *f, struct socket *so)
     qemu_put_byte(f, so->so_emu);
     qemu_put_byte(f, so->so_type);
     qemu_put_be32(f, so->so_state);
-    slirp_sbuf_save(f, &so->so_rcv);
-    slirp_sbuf_save(f, &so->so_snd);
+    /* TODO: Build vmstate at this level */
+    vmstate_save_state(f, &vmstate_slirp_sbuf, &so->so_rcv, 0);
+    vmstate_save_state(f, &vmstate_slirp_sbuf, &so->so_snd, 0);
     vmstate_save_state(f, &vmstate_slirp_tcp, so->so_tcpcb, 0);
 }
 
@@ -1263,31 +1317,9 @@ static void slirp_state_save(QEMUFile *f, void *opaque)
     slirp_bootp_save(f, slirp);
 }
 
-static int slirp_sbuf_load(QEMUFile *f, struct sbuf *sbuf)
-{
-    uint32_t off, sb_cc, sb_datalen;
-
-    sb_cc = qemu_get_be32(f);
-    sb_datalen = qemu_get_be32(f);
-
-    sbreserve(sbuf, sb_datalen);
-
-    if (sbuf->sb_datalen != sb_datalen)
-        return -ENOMEM;
-
-    sbuf->sb_cc = sb_cc;
-
-    off = qemu_get_sbe32(f);
-    sbuf->sb_wptr = sbuf->sb_data + off;
-    off = qemu_get_sbe32(f);
-    sbuf->sb_rptr = sbuf->sb_data + off;
-    qemu_get_buffer(f, (unsigned char*)sbuf->sb_data, sbuf->sb_datalen);
-
-    return 0;
-}
-
 static int slirp_socket_load(QEMUFile *f, struct socket *so, int version_id)
 {
+    int ret = 0;
     if (tcp_attach(so) < 0)
         return -ENOMEM;
 
@@ -1324,11 +1356,15 @@ static int slirp_socket_load(QEMUFile *f, struct socket *so, int version_id)
     so->so_emu = qemu_get_byte(f);
     so->so_type = qemu_get_byte(f);
     so->so_state = qemu_get_be32(f);
-    if (slirp_sbuf_load(f, &so->so_rcv) < 0)
-        return -ENOMEM;
-    if (slirp_sbuf_load(f, &so->so_snd) < 0)
-        return -ENOMEM;
-    return vmstate_load_state(f, &vmstate_slirp_tcp, so->so_tcpcb, 0);
+    /* TODO: VMState at this level */
+    ret = vmstate_load_state(f, &vmstate_slirp_sbuf, &so->so_rcv, 0);
+    if (!ret) {
+        ret = vmstate_load_state(f, &vmstate_slirp_sbuf, &so->so_snd, 0);
+    }
+    if (!ret) {
+        ret = vmstate_load_state(f, &vmstate_slirp_tcp, so->so_tcpcb, 0);
+    }
+    return ret;
 }
 
 static void slirp_bootp_load(QEMUFile *f, Slirp *slirp)
-- 
2.11.0
