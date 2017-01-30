Received: from eggs.gnu.org ([2001:4830:134:3::10]:37820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCBn-0003dy-Ew
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCBk-0006R0-Bz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCBk-0006QO-5g
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:08 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 528D6C04B92C
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:40:08 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:15 +0400
Message-Id: <20170130133954.31353-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/41] spice-qemu-char: convert to finalize
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
 spice-qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index dd97c17fca..3902202a35 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -210,9 +210,9 @@ static int spice_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
     return read_bytes;
 }
=20
-static void spice_chr_free(struct Chardev *chr)
+static void char_spice_finalize(Object *obj)
 {
-    SpiceChardev *s =3D SPICE_CHARDEV(chr);
+    SpiceChardev *s =3D SPICE_CHARDEV(obj);
=20
     vmc_unregister_interface(s);
     QLIST_REMOVE(s, next);
@@ -365,13 +365,13 @@ static void char_spice_class_init(ObjectClass *oc, =
void *data)
     cc->chr_write =3D spice_chr_write;
     cc->chr_add_watch =3D spice_chr_add_watch;
     cc->chr_accept_input =3D spice_chr_accept_input;
-    cc->chr_free =3D spice_chr_free;
 }
=20
 static const TypeInfo char_spice_type_info =3D {
     .name =3D TYPE_CHARDEV_SPICE,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(SpiceChardev),
+    .instance_finalize =3D char_spice_finalize,
     .class_init =3D char_spice_class_init,
     .abstract =3D true,
 };
--=20
2.11.0.295.gd7dffce1c.dirty
