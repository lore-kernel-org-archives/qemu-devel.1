Received: from eggs.gnu.org ([2001:4830:134:3::10]:41278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qr-0001qA-9t
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qk-00052w-Fu
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40059
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qk-00052F-9s
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8WHW028678
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:37 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb5t7ca-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:37 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:36 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:13 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1490051325-3770-50-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 49/81] char: fix ctrl-a b not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

CharDriverState.be should be updated to point to the current
associated backend.

Fix the regression introduced in the "mux" chardev from commit
a4afa548fc6dd9842ed86639b4d37d4d1c4ad480.

https://bugs.launchpad.net/bugs/1654137

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170110110621.15287-1-marcandre.lureau@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-char.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 2c9940c..676944a 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -499,7 +499,7 @@ void qemu_chr_fe_printf(CharBackend *be, const char *=
fmt, ...)
=20
 static void remove_fd_in_watch(CharDriverState *chr);
 static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *con=
text);
-static void mux_set_focus(MuxDriver *d, int focus);
+static void mux_set_focus(CharDriverState *chr, int focus);
=20
 static int null_chr_write(CharDriverState *chr, const uint8_t *buf, int =
len)
 {
@@ -666,7 +666,7 @@ static int mux_proc_byte(CharDriverState *chr, MuxDri=
ver *d, int ch)
         case 'c':
             assert(d->mux_cnt > 0); /* handler registered with first fe =
*/
             /* Switch to the next registered device */
-            mux_set_focus(d, (d->focus + 1) % d->mux_cnt);
+            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
             break;
         case 't':
             d->timestamps =3D !d->timestamps;
@@ -826,8 +826,10 @@ static void mux_chr_set_handlers(CharDriverState *ch=
r, GMainContext *context)
                              context, true);
 }
=20
-static void mux_set_focus(MuxDriver *d, int focus)
+static void mux_set_focus(CharDriverState *chr, int focus)
 {
+    MuxDriver *d =3D chr->opaque;
+
     assert(focus >=3D 0);
     assert(focus < d->mux_cnt);
=20
@@ -836,6 +838,7 @@ static void mux_set_focus(MuxDriver *d, int focus)
     }
=20
     d->focus =3D focus;
+    chr->be =3D d->backends[focus];
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
=20
@@ -935,7 +938,9 @@ void qemu_chr_fe_deinit(CharBackend *b)
=20
     if (b->chr) {
         qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true);
-        b->chr->be =3D NULL;
+        if (b->chr->be =3D=3D b) {
+            b->chr->be =3D NULL;
+        }
         if (b->chr->is_mux) {
             MuxDriver *d =3D b->chr->opaque;
             d->backends[b->tag] =3D NULL;
@@ -999,7 +1004,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
     }
=20
     if (b->chr->is_mux) {
-        mux_set_focus(b->chr->opaque, b->tag);
+        mux_set_focus(b->chr, b->tag);
     }
 }
=20
--=20
2.7.4
