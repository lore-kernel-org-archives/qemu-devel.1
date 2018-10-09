Received: from eggs.gnu.org ([2001:4830:134:3::10]:49902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g9rpV-0006Lc-IF
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g9rpR-0002nn-Jx
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g9rpR-0002mH-08
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D97BD52748
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 13:13:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Oct 2018 17:12:48 +0400
Message-Id: <20181009131251.721-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181009131251.721-1-marcandre.lureau@redhat.com>
References: <20181009131251.721-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] char: add a QEMU_CHAR_FEATURE_GCONTEXT flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The feature should be set if the chardev is able to switch
GMainContext. Callers that want to put a chardev in a different thread
context can/should check this capabilities.

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
index e115166995..fa1b74e0d9 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -196,6 +196,8 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
     s->gcontext =3D context;
     if (cc->chr_update_read_handler) {
         cc->chr_update_read_handler(s);
+    } else if (s->gcontext) {
+        error_report("switching context isn't supported by this chardev"=
);
     }
 }
=20
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
2.19.0.271.gfe8321ec05
