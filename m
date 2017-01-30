Received: from eggs.gnu.org ([2001:4830:134:3::10]:37886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCBy-0003pL-0q
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCBx-0006X4-9Y
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCBx-0006Wp-3L
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:21 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40CBAC056790
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:40:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:18 +0400
Message-Id: <20170130133954.31353-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/41] mux: convert to finalize
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 6b4a299702..91ca4cb083 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -859,9 +859,9 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCond=
ition cond)
     return cc->chr_add_watch(chr, cond);
 }
=20
-static void mux_chr_free(struct Chardev *chr)
+static void char_mux_finalize(Object *obj)
 {
-    MuxChardev *d =3D MUX_CHARDEV(chr);
+    MuxChardev *d =3D MUX_CHARDEV(obj);
     int i;
=20
     for (i =3D 0; i < d->mux_cnt; i++) {
@@ -4025,7 +4025,6 @@ static void char_mux_class_init(ObjectClass *oc, vo=
id *data)
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
     cc->open =3D qemu_chr_open_mux;
-    cc->chr_free =3D mux_chr_free;
     cc->chr_write =3D mux_chr_write;
     cc->chr_accept_input =3D mux_chr_accept_input;
     cc->chr_add_watch =3D mux_chr_add_watch;
@@ -4036,6 +4035,7 @@ static const TypeInfo char_mux_type_info =3D {
     .parent =3D TYPE_CHARDEV,
     .class_init =3D char_mux_class_init,
     .instance_size =3D sizeof(MuxChardev),
+    .instance_finalize =3D char_mux_finalize,
 };
=20
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
--=20
2.11.0.295.gd7dffce1c.dirty
