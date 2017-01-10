Received: from eggs.gnu.org ([2001:4830:134:3::10]:47367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XI-0005K2-Us
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XF-0007qz-1P
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0XE-0007qj-Rj
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:36 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA8A081227
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:48:02 +0100
Message-Id: <20170110174810.17748-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-1-marcandre.lureau@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/20] bt: use qemu_chr_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use common allocator for CharDriverState.

Rename the now untouched parent field.

The casts added are temporary, they are replaced with QOM type-safe
macros in a later patch in this series.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/bt/hci-csr.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index bf2deb0497..e2c78b8720 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -26,9 +26,10 @@
 #include "hw/irq.h"
 #include "sysemu/bt.h"
 #include "hw/bt.h"
+#include "qapi/error.h"
=20
 struct csrhci_s {
-    CharDriverState chr;
+    CharDriverState parent;
     int enable;
     qemu_irq *pins;
     int pin_state;
@@ -78,7 +79,8 @@ enum {
=20
 static inline void csrhci_fifo_wake(struct csrhci_s *s)
 {
-    CharBackend *be =3D s->chr.be;
+    CharDriverState *chr =3D (CharDriverState *)s;
+    CharBackend *be =3D chr->be;
=20
     if (!s->enable || !s->out_len)
         return;
@@ -468,10 +470,15 @@ CharDriverState *uart_hci_init(void)
         .chr_write =3D csrhci_write,
         .chr_ioctl =3D csrhci_ioctl,
     };
-    struct csrhci_s *s =3D (struct csrhci_s *)
-            g_malloc0(sizeof(struct csrhci_s));
+    Error *err =3D NULL;
+    ChardevCommon common =3D { 0, };
+    CharDriverState *chr =3D qemu_chr_alloc(&hci_driver, &common, &err);
+    struct csrhci_s *s =3D (struct csrhci_s *)chr;
=20
-    s->chr.driver =3D &hci_driver;
+    if (err) {
+        error_report_err(err);
+        return NULL;
+    }
=20
     s->hci =3D qemu_next_hci();
     s->hci->opaque =3D s;
@@ -482,5 +489,5 @@ CharDriverState *uart_hci_init(void)
     s->pins =3D qemu_allocate_irqs(csrhci_pins, s, __csrhci_pins);
     csrhci_reset(s);
=20
-    return &s->chr;
+    return chr;
 }
--=20
2.11.0
