Received: from eggs.gnu.org ([2001:4830:134:3::10]:49012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Ue-0000u5-Np
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Uc-0003MJ-1X
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX1Ub-0003Lb-Qx
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27FD82D7E0
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Dec 2018 11:11:37 +0100
Message-Id: <20181212101145.3496-4-armbru@redhat.com>
In-Reply-To: <20181212101145.3496-1-armbru@redhat.com>
References: <20181212101145.3496-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/11] char: add a QEMU_CHAR_FEATURE_GCONTEXT
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

QEMU_CHAR_FEATURE_GCONTEXT declares the character device can switch
GMainContext.

Assert we don't switch context when the character device doesn't
provide this feature.  Character device users must not violate this
restriction.  In particular, user configurations that violate them
must be rejected.

Existing frontend that rely on context switching would now assert() if
the backend doesn't allow it (instead of silently producing undesired
events in the default context). Following patches improve the
situation by reporting an error earlier instead, on the frontend side.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181205203737.9011-4-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char.c         | 11 +++++++++++
 include/chardev/char.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 152dde5327..ccba36bafb 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -193,6 +193,8 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
=20
+    assert(qemu_chr_has_feature(s, QEMU_CHAR_FEATURE_GCONTEXT)
+           || !context);
     s->gcontext =3D context;
     if (cc->chr_update_read_handler) {
         cc->chr_update_read_handler(s);
@@ -240,6 +242,15 @@ static void char_init(Object *obj)
=20
     chr->logfd =3D -1;
     qemu_mutex_init(&chr->chr_write_lock);
+
+    /*
+     * Assume if chr_update_read_handler is implemented it will
+     * take the updated gcontext into account.
+     */
+    if (CHARDEV_GET_CLASS(chr)->chr_update_read_handler) {
+        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT);
+    }
+
 }
=20
 static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 7becd8c80c..014566c3de 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -47,6 +47,9 @@ typedef enum {
     QEMU_CHAR_FEATURE_FD_PASS,
     /* Whether replay or record mode is enabled */
     QEMU_CHAR_FEATURE_REPLAY,
+    /* Whether the gcontext can be changed after calling
+     * qemu_chr_be_update_read_handlers() */
+    QEMU_CHAR_FEATURE_GCONTEXT,
=20
     QEMU_CHAR_FEATURE_LAST,
 } ChardevFeature;
--=20
2.17.2
