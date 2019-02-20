Received: from eggs.gnu.org ([209.51.188.92]:41603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGQx-0006Ll-JH
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGQn-00055g-93
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:12:17 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:32 +0100
Message-Id: <20190220010232.18731-26-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 25/25] chardev: Let qemu_chr_write[_all] use
 size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

We now know all callers use a size_t argument. We can
convert qemu_chr_write() and qemu_chr_write_all() to
use a size_t argument.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char.c          | 8 ++++----
 include/chardev/char.h  | 2 +-
 include/sysemu/replay.h | 2 +-
 replay/replay-char.c    | 2 +-
 stubs/replay.c          | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 3149cd3ba9..8f1f56a802 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -99,8 +99,8 @@ static void qemu_chr_write_log(Chardev *s, const uint8_=
t *buf, size_t len)
 }
=20
 static int qemu_chr_write_buffer(Chardev *s,
-                                 const uint8_t *buf, int len,
-                                 int *offset, bool write_all)
+                                 const uint8_t *buf, size_t len,
+                                 size_t *offset, bool write_all)
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
     int res =3D 0;
@@ -132,9 +132,9 @@ static int qemu_chr_write_buffer(Chardev *s,
     return res;
 }
=20
-int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_a=
ll)
+int qemu_chr_write(Chardev *s, const uint8_t *buf, size_t len, bool writ=
e_all)
 {
-    int offset =3D 0;
+    size_t offset =3D 0;
     int res;
=20
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 0341dd1ba2..2e3b5a15ca 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -221,7 +221,7 @@ void qemu_chr_set_feature(Chardev *chr,
                           ChardevFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon);
-int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_a=
ll);
+int qemu_chr_write(Chardev *s, const uint8_t *buf, size_t len, bool writ=
e_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true=
)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
=20
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3a7c58e423..334944715d 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -158,7 +158,7 @@ void replay_chr_be_write(struct Chardev *s, uint8_t *=
buf, int len);
 /*! Writes char write return value to the replay log. */
 void replay_char_write_event_save(int res, int offset);
 /*! Reads char write return value from the replay log. */
-void replay_char_write_event_load(int *res, int *offset);
+void replay_char_write_event_load(int *res, size_t *offset);
 /*! Reads information about read_all character event. */
 int replay_char_read_all_load(uint8_t *buf);
 /*! Writes character read_all error code into the replay log. */
diff --git a/replay/replay-char.c b/replay/replay-char.c
index 736cc8c2e6..f0308578eb 100644
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -104,7 +104,7 @@ void replay_char_write_event_save(int res, int offset=
)
     replay_put_dword(offset);
 }
=20
-void replay_char_write_event_load(int *res, int *offset)
+void replay_char_write_event_load(int *res, size_t *offset)
 {
     g_assert(replay_mutex_locked());
=20
diff --git a/stubs/replay.c b/stubs/replay.c
index 4ac607895d..cf584d3191 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -44,7 +44,7 @@ void replay_char_write_event_save(int res, int offset)
     abort();
 }
=20
-void replay_char_write_event_load(int *res, int *offset)
+void replay_char_write_event_load(int *res, size_t *offset)
 {
     abort();
 }
--=20
2.20.1
