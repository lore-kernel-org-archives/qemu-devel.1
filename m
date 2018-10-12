Received: from eggs.gnu.org ([2001:4830:134:3::10]:33178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlEI-0005kq-FM
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlEF-00056K-U1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAlEF-00055k-MC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:55 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:12 +0200
Message-Id: <20181012002217.2864-7-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/11] chardev: Let chr_write use unsigned
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/baum.c         | 2 +-
 chardev/char-fd.c      | 2 +-
 chardev/char-mux.c     | 2 +-
 chardev/char-pty.c     | 2 +-
 chardev/char-ringbuf.c | 4 ++--
 chardev/char-socket.c  | 2 +-
 chardev/char-udp.c     | 2 +-
 chardev/char.c         | 2 +-
 chardev/msmouse.c      | 2 +-
 chardev/spice.c        | 2 +-
 chardev/testdev.c      | 2 +-
 chardev/wctablet.c     | 4 ++--
 gdbstub.c              | 2 +-
 hw/bt/hci-csr.c        | 4 ++--
 include/chardev/char.h | 2 +-
 ui/console.c           | 2 +-
 ui/gtk.c               | 2 +-
 17 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index 78b0c87625..5367d82f53 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -479,7 +479,7 @@ static int baum_eat_packet(BaumChardev *baum, const u=
int8_t *buf, int len)
 }
=20
 /* The other end is writing some data.  Store it and try to interpret */
-static int baum_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t baum_chr_write(Chardev *chr, const uint8_t *buf, size_t le=
n)
 {
     BaumChardev *baum =3D BAUM_CHARDEV(chr);
     int tocopy, cur, eaten, orig_len =3D len;
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 2421d8e216..bb426fa4b1 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -32,7 +32,7 @@
 #include "chardev/char-io.h"
=20
 /* Called with chr_write_lock held.  */
-static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t fd_chr_write(Chardev *chr, const uint8_t *buf, size_t len)
 {
     FDChardev *s =3D FD_CHARDEV(chr);
=20
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6055e76293..3ca732d3a8 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -33,7 +33,7 @@
 /* MUX driver for serial I/O splitting */
=20
 /* Called with chr_write_lock held.  */
-static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t mux_chr_write(Chardev *chr, const uint8_t *buf, size_t len=
)
 {
     MuxChardev *d =3D MUX_CHARDEV(chr);
     int ret;
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 626ca30cb3..a2b78b44d8 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -125,7 +125,7 @@ static void pty_chr_update_read_handler(Chardev *chr)
 }
=20
 /* Called with chr_write_lock held.  */
-static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t char_pty_chr_write(Chardev *chr, const uint8_t *buf, size_=
t len)
 {
     PtyChardev *s =3D PTY_CHARDEV(chr);
=20
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 87832e2792..b805a585e3 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -49,12 +49,12 @@ static size_t ringbuf_count(const Chardev *chr)
     return d->prod - d->cons;
 }
=20
-static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t ringbuf_chr_write(Chardev *chr, const uint8_t *buf, size_t=
 len)
 {
     RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
     int i;
=20
-    if (!buf || (len < 0)) {
+    if (!buf) {
         return -1;
     }
=20
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 7e627b243e..7c7fb06d48 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -124,7 +124,7 @@ static gboolean tcp_chr_read_poll(void *opaque);
 static void tcp_chr_disconnect(Chardev *chr);
=20
 /* Called with chr_write_lock held.  */
-static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t tcp_chr_write(Chardev *chr, const uint8_t *buf, size_t len=
)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index b6e399e983..577d049d78 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -45,7 +45,7 @@ typedef struct {
 #define UDP_CHARDEV(obj) OBJECT_CHECK(UdpChardev, (obj), TYPE_CHARDEV_UD=
P)
=20
 /* Called with chr_write_lock held.  */
-static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t udp_chr_write(Chardev *chr, const uint8_t *buf, size_t len=
)
 {
     UdpChardev *s =3D UDP_CHARDEV(chr);
=20
diff --git a/chardev/char.c b/chardev/char.c
index 952f9c9bcc..608c2569f4 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -245,7 +245,7 @@ static void char_init(Object *obj)
     qemu_mutex_init(&chr->chr_write_lock);
 }
=20
-static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t null_chr_write(Chardev *chr, const uint8_t *buf, size_t le=
n)
 {
     return len;
 }
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index 0ffd137ce8..0aad738cae 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -133,7 +133,7 @@ static void msmouse_input_sync(DeviceState *dev)
     msmouse_chr_accept_input(chr);
 }
=20
-static int msmouse_chr_write(struct Chardev *s, const uint8_t *buf, int =
len)
+static size_t msmouse_chr_write(struct Chardev *s, const uint8_t *buf, s=
ize_t len)
 {
     /* Ignore writes to mouse port */
     return len;
diff --git a/chardev/spice.c b/chardev/spice.c
index e66e3ad568..a9e7b4e374 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -193,7 +193,7 @@ static GSource *spice_chr_add_watch(Chardev *chr, GIO=
Condition cond)
     return (GSource *)src;
 }
=20
-static int spice_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t spice_chr_write(Chardev *chr, const uint8_t *buf, size_t l=
en)
 {
     SpiceChardev *s =3D SPICE_CHARDEV(chr);
     int read_bytes;
diff --git a/chardev/testdev.c b/chardev/testdev.c
index 031e9a23e8..6ebaf5fdaf 100644
--- a/chardev/testdev.c
+++ b/chardev/testdev.c
@@ -82,7 +82,7 @@ static int testdev_eat_packet(TestdevChardev *testdev)
 }
=20
 /* The other end is writing some data.  Store it and try to interpret */
-static int testdev_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t testdev_chr_write(Chardev *chr, const uint8_t *buf, size_t=
 len)
 {
     TestdevChardev *testdev =3D TESTDEV_CHARDEV(chr);
     int tocopy, eaten, orig_len =3D len;
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 969d014574..52acbdb609 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -203,8 +203,8 @@ static void wctablet_chr_accept_input(Chardev *chr)
     }
 }
=20
-static int wctablet_chr_write(struct Chardev *chr,
-                              const uint8_t *buf, int len)
+static size_t wctablet_chr_write(struct Chardev *chr,
+                              const uint8_t *buf, size_t len)
 {
     TabletChardev *tablet =3D WCTABLET_CHARDEV(chr);
     unsigned int i, clen;
diff --git a/gdbstub.c b/gdbstub.c
index c8478de8f5..bbbb1cfcc1 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1955,7 +1955,7 @@ static void gdb_monitor_output(GDBState *s, const c=
har *msg, int len)
     put_packet(s, buf);
 }
=20
-static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t gdb_monitor_write(Chardev *chr, const uint8_t *buf, size_t=
 len)
 {
     const char *p =3D (const char *)buf;
     int max_sz;
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 0341ded50c..21ac388675 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -314,8 +314,8 @@ static void csrhci_ready_for_next_inpkt(struct csrhci=
_s *s)
     s->in_hdr =3D INT_MAX;
 }
=20
-static int csrhci_write(struct Chardev *chr,
-                const uint8_t *buf, int len)
+static size_t csrhci_write(struct Chardev *chr,
+                const uint8_t *buf, size_t len)
 {
     struct csrhci_s *s =3D (struct csrhci_s *)chr;
     int total =3D 0;
diff --git a/include/chardev/char.h b/include/chardev/char.h
index ef4509bfa3..091a514022 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -250,7 +250,7 @@ typedef struct ChardevClass {
     void (*open)(Chardev *chr, ChardevBackend *backend,
                  bool *be_opened, Error **errp);
=20
-    int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
+    size_t (*chr_write)(Chardev *s, const uint8_t *buf, size_t len);
     size_t (*chr_sync_read)(Chardev *s, const uint8_t *buf, size_t len);
     GSource *(*chr_add_watch)(Chardev *s, GIOCondition cond);
     void (*chr_update_read_handler)(Chardev *s);
diff --git a/ui/console.c b/ui/console.c
index 3a285bae00..5fed0504f4 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1080,7 +1080,7 @@ typedef struct VCChardev {
 #define TYPE_CHARDEV_VC "chardev-vc"
 #define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC)
=20
-static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t vc_chr_write(Chardev *chr, const uint8_t *buf, size_t len)
 {
     VCChardev *drv =3D VC_CHARDEV(chr);
     QemuConsole *s =3D drv->console;
diff --git a/ui/gtk.c b/ui/gtk.c
index 3ddb5fe162..7990b58833 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1842,7 +1842,7 @@ static void gd_vc_adjustment_changed(GtkAdjustment =
*adjustment, void *opaque)
     }
 }
=20
-static int gd_vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t gd_vc_chr_write(Chardev *chr, const uint8_t *buf, size_t l=
en)
 {
     VCChardev *vcd =3D VC_CHARDEV(chr);
     VirtualConsole *vc =3D vcd->console;
--=20
2.17.1
