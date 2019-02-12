Received: from eggs.gnu.org ([209.51.188.92]:35800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtb2b-0005UT-3H
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtasS-0000nj-4U
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtasQ-0000Yl-AW
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Feb 2019 17:25:19 +0100
Message-Id: <20190212162524.31504-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190212162524.31504-1-marcandre.lureau@redhat.com>
References: <20190212162524.31504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/7] slirp: use libslirp migration code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, peter.maydell@linaro.org

slirp migration code uses QEMU vmstate so far, when building WITH_QEMU.

Introduce slirp_state_{load,save,version}() functions to move the
state saving handling to libslirp side.

So far, the bitstream compatibility should remain equal with current
QEMU, as this is effectively using the same code, with the same format
etc. When libslirp is made standalone, we will need some mechanism to
ensure bitstream compatibility regardless of the libslirp version
installed. See the FIXME note in the code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/migration/qemu-file-types.h |  2 ++
 migration/qemu-file.h               |  1 -
 slirp/libslirp.h                    |  8 +++++
 slirp/state.h                       |  9 -----
 net/slirp.c                         | 55 +++++++++++++++++++++++++++++
 slirp/slirp.c                       |  9 -----
 slirp/state.c                       | 52 ++++++++++++---------------
 7 files changed, 88 insertions(+), 48 deletions(-)

diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu=
-file-types.h
index bd6d7dd7f9..bbe04d4484 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -25,6 +25,8 @@
 #ifndef QEMU_FILE_H
 #define QEMU_FILE_H
=20
+int qemu_file_get_error(QEMUFile *f);
+
 void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size);
 void qemu_put_byte(QEMUFile *f, int v);
=20
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 2ccfcfb2a8..13baf896bd 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -149,7 +149,6 @@ void qemu_update_position(QEMUFile *f, size_t size);
 void qemu_file_reset_rate_limit(QEMUFile *f);
 void qemu_file_set_rate_limit(QEMUFile *f, int64_t new_rate);
 int64_t qemu_file_get_rate_limit(QEMUFile *f);
-int qemu_file_get_error(QEMUFile *f);
 void qemu_file_set_error(QEMUFile *f, int ret);
 int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 18c50bd7ba..7ce1e4d0d4 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -101,6 +101,14 @@ void slirp_socket_recv(Slirp *slirp, struct in_addr =
guest_addr,
                        int guest_port, const uint8_t *buf, int size);
 size_t slirp_socket_can_recv(Slirp *slirp, struct in_addr guest_addr,
                              int guest_port);
+
+void slirp_state_save(Slirp *s, SlirpWriteCb write_cb, void *opaque);
+
+int slirp_state_load(Slirp *s, int version_id,
+                     SlirpReadCb read_cb, void *opaque);
+
+int slirp_state_version(void);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/slirp/state.h b/slirp/state.h
index 154866898f..e69de29bb2 100644
--- a/slirp/state.h
+++ b/slirp/state.h
@@ -1,9 +0,0 @@
-#ifndef SLIRP_STATE_H_
-#define SLIRP_STATE_H_
-
-#include "libslirp.h"
-
-void slirp_state_register(Slirp *slirp);
-void slirp_state_unregister(Slirp *slirp);
-
-#endif /* SLIRP_STATE_H_ */
diff --git a/net/slirp.c b/net/slirp.c
index 7a16d8d615..bcd91475d2 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -44,6 +44,8 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "util.h"
+#include "migration/register.h"
+#include "migration/qemu-file-types.h"
=20
 static int get_str_sep(char *buf, int buf_size, const char **pp, int sep=
)
 {
@@ -146,6 +148,7 @@ static void net_slirp_cleanup(NetClientState *nc)
=20
     g_slist_free_full(s->fwd, slirp_free_fwd);
     main_loop_poll_remove_notifier(&s->poll_notifier);
+    unregister_savevm(NULL, "slirp", s->slirp);
     slirp_cleanup(s->slirp);
     if (s->exit_notifier.notify) {
         qemu_remove_exit_notifier(&s->exit_notifier);
@@ -303,6 +306,46 @@ static void net_slirp_poll_notify(Notifier *notifier=
, void *data)
     }
 }
=20
+static ssize_t
+net_slirp_stream_read(void *buf, size_t size, void *opaque)
+{
+    QEMUFile *f =3D opaque;
+
+    return qemu_get_buffer(f, buf, size);
+}
+
+static ssize_t
+net_slirp_stream_write(const void *buf, size_t size, void *opaque)
+{
+    QEMUFile *f =3D opaque;
+
+    qemu_put_buffer(f, buf, size);
+    if (qemu_file_get_error(f)) {
+        return -1;
+    }
+
+    return size;
+}
+
+static int net_slirp_state_load(QEMUFile *f, void *opaque, int version_i=
d)
+{
+    Slirp *slirp =3D opaque;
+
+    return slirp_state_load(slirp, version_id, net_slirp_stream_read, f)=
;
+}
+
+static void net_slirp_state_save(QEMUFile *f, void *opaque)
+{
+    Slirp *slirp =3D opaque;
+
+    slirp_state_save(slirp, net_slirp_stream_write, f);
+}
+
+static SaveVMHandlers savevm_slirp_state =3D {
+    .save_state =3D net_slirp_state_save,
+    .load_state =3D net_slirp_state_load,
+};
+
 static int net_slirp_init(NetClientState *peer, const char *model,
                           const char *name, int restricted,
                           bool ipv4, const char *vnetwork, const char *v=
host,
@@ -523,6 +566,18 @@ static int net_slirp_init(NetClientState *peer, cons=
t char *model,
                           &slirp_cb, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
=20
+    /*
+     * Make sure the current bitstream version of slirp is 4, to avoid
+     * QEMU migration incompatibilities, if upstream slirp bumped the
+     * version.
+     *
+     * FIXME: use bitfileds of features? teach libslirp to save with
+     * specific version?
+     */
+    g_assert(slirp_state_version() =3D=3D 4);
+    register_savevm_live(NULL, "slirp", 0, slirp_state_version(),
+                         &savevm_slirp_state, s->slirp);
+
     s->poll_notifier.notify =3D net_slirp_poll_notify;
     main_loop_poll_add_notifier(&s->poll_notifier);
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 55591430dc..2d8d5d34e4 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -23,9 +23,6 @@
  */
 #include "slirp.h"
=20
-#ifdef WITH_QEMU
-#include "state.h"
-#endif
=20
 #ifndef _WIN32
 #include <net/if.h>
@@ -326,9 +323,6 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
         translate_dnssearch(slirp, vdnssearch);
     }
=20
-#ifdef WITH_QEMU
-    slirp_state_register(slirp);
-#endif
     return slirp;
 }
=20
@@ -342,9 +336,6 @@ void slirp_cleanup(Slirp *slirp)
         g_free(e);
     }
=20
-#ifdef WITH_QEMU
-    slirp_state_unregister(slirp);
-#endif
     ip_cleanup(slirp);
     ip6_cleanup(slirp);
     m_cleanup(slirp);
diff --git a/slirp/state.c b/slirp/state.c
index 0e5a706e87..f5dd80cdc8 100644
--- a/slirp/state.c
+++ b/slirp/state.c
@@ -21,13 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
-#include "qemu/osdep.h"
-
 #include "slirp.h"
+#include "vmstate.h"
 #include "state.h"
-#include "migration/vmstate.h"
-#include "migration/qemu-file-types.h"
-#include "migration/register.h"
+#include "stream.h"
=20
 static int slirp_tcp_post_load(void *opaque, int version)
 {
@@ -180,7 +177,7 @@ static int slirp_socket_pre_load(void *opaque)
 #else
 /* Win uses u_long rather than uint32_t - but it's still 32bits long */
 #define VMSTATE_SIN4_ADDR(f, s, t) VMSTATE_SINGLE_TEST(f, s, t, 0, \
-                                       vmstate_info_uint32, u_long)
+                                       slirp_vmstate_info_uint32, u_long=
)
 #endif
=20
 /* The OS provided ss_family field isn't that portable; it's size
@@ -322,10 +319,13 @@ static const VMStateDescription vmstate_slirp =3D {
     }
 };
=20
-static void slirp_state_save(QEMUFile *f, void *opaque)
+void slirp_state_save(Slirp *slirp, SlirpWriteCb write_cb, void *opaque)
 {
-    Slirp *slirp =3D opaque;
     struct gfwd_list *ex_ptr;
+    SlirpOStream f =3D {
+        .write_cb =3D write_cb,
+        .opaque =3D opaque,
+    };
=20
     for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next)
         if (ex_ptr->write_cb) {
@@ -336,25 +336,29 @@ static void slirp_state_save(QEMUFile *f, void *opa=
que)
                 continue;
             }
=20
-            qemu_put_byte(f, 42);
-            vmstate_save_state(f, &vmstate_slirp_socket, so, NULL);
+            slirp_ostream_write_u8(&f, 42);
+            slirp_vmstate_save_state(&f, &vmstate_slirp_socket, so);
         }
-    qemu_put_byte(f, 0);
+    slirp_ostream_write_u8(&f, 0);
=20
-    vmstate_save_state(f, &vmstate_slirp, slirp, NULL);
+    slirp_vmstate_save_state(&f, &vmstate_slirp, slirp);
 }
=20
=20
-static int slirp_state_load(QEMUFile *f, void *opaque, int version_id)
+int slirp_state_load(Slirp *slirp, int version_id,
+                     SlirpReadCb read_cb, void *opaque)
 {
-    Slirp *slirp =3D opaque;
     struct gfwd_list *ex_ptr;
+    SlirpIStream f =3D {
+        .read_cb =3D read_cb,
+        .opaque =3D opaque,
+    };
=20
-    while (qemu_get_byte(f)) {
+    while (slirp_istream_read_u8(&f)) {
         int ret;
         struct socket *so =3D socreate(slirp);
=20
-        ret =3D vmstate_load_state(f, &vmstate_slirp_socket, so, version=
_id);
+        ret =3D slirp_vmstate_load_state(&f, &vmstate_slirp_socket, so, =
version_id);
         if (ret < 0) {
             return ret;
         }
@@ -375,20 +379,10 @@ static int slirp_state_load(QEMUFile *f, void *opaq=
ue, int version_id)
         }
     }
=20
-    return vmstate_load_state(f, &vmstate_slirp, slirp, version_id);
-}
-
-void slirp_state_register(Slirp *slirp)
-{
-    static SaveVMHandlers savevm_slirp_state =3D {
-        .save_state =3D slirp_state_save,
-        .load_state =3D slirp_state_load,
-    };
-
-    register_savevm_live(NULL, "slirp", 0, 4, &savevm_slirp_state, slirp=
);
+    return slirp_vmstate_load_state(&f, &vmstate_slirp, slirp, version_i=
d);
 }
=20
-void slirp_state_unregister(Slirp *slirp)
+int slirp_state_version(void)
 {
-    unregister_savevm(NULL, "slirp", slirp);
+    return 4;
 }
--=20
2.21.0.rc0.1.g036caf7885
