Received: from eggs.gnu.org ([2001:4830:134:3::10]:46937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUdw3-0007Xx-S6
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUdw0-0002bi-3s
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:38:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUdvz-0002bA-T0
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:38:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Dec 2018 00:37:33 +0400
Message-Id: <20181205203737.9011-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181205203737.9011-1-marcandre.lureau@redhat.com>
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v4 3/7] char: add a
 QEMU_CHAR_FEATURE_GCONTEXT flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

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
---
 include/chardev/char.h |  3 +++
 chardev/char.c         | 11 +++++++++++
 2 files changed, 14 insertions(+)

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
--=20
2.20.0.rc1
