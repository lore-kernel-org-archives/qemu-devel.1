Received: from eggs.gnu.org ([209.51.188.92]:42707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGX6-0002u8-LA
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGWj-0006ho-C1
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:18:29 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:31 +0100
Message-Id: <20190220010232.18731-25-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 24/25] chardev: Let qemu_chr_fe_write[_all]
 use size_t type argument
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

All caller have been audited and call these functions with
unsigned arguments.

Most of them use a size_t argument, or directly pass sizeof().

One case is unclear: the mux_chr_write() call in chardev/char-mux.c.
There we add an assert (which will be removed in few patches) and
cast the parameter as size_t to make explicit this value is unsigned.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char-fe.c         | 4 ++--
 chardev/char-mux.c        | 3 ++-
 include/chardev/char-fe.h | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f3530a90e6..ab2a01709d 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -31,7 +31,7 @@
 #include "chardev/char-io.h"
 #include "chardev/char-mux.h"
=20
-int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
+int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, size_t len)
 {
     Chardev *s =3D be->chr;
=20
@@ -42,7 +42,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *b=
uf, int len)
     return qemu_chr_write(s, buf, len, false);
 }
=20
-int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
+int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, size_t le=
n)
 {
     Chardev *s =3D be->chr;
=20
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 23aa82125d..7a3ff21db4 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -38,7 +38,8 @@ static int mux_chr_write(Chardev *chr, const uint8_t *b=
uf, int len)
     MuxChardev *d =3D MUX_CHARDEV(chr);
     int ret;
     if (!d->timestamps) {
-        ret =3D qemu_chr_fe_write(&d->chr, buf, len);
+        assert(len >=3D 0);
+        ret =3D qemu_chr_fe_write(&d->chr, buf, (size_t)len);
     } else {
         int i;
=20
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index aa1b864ccd..5fb2c2e7ec 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -203,7 +203,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondi=
tion cond,
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
  */
-int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
+int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, size_t len);
=20
 /**
  * qemu_chr_fe_write_all:
@@ -217,7 +217,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len);
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
  */
-int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
+int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, size_t le=
n);
=20
 /**
  * qemu_chr_fe_read_all:
--=20
2.20.1
