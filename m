Received: from eggs.gnu.org ([2001:4830:134:3::10]:43494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLf-0004iC-Rw
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLc-00049l-Oc
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZLc-000497-IC
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:28 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B17BE3B470
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:45:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:43:01 +0300
Message-Id: <20161212224325.20790-31-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 30/54] char: remove chr_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Now it uses Object instance_finalize instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c           | 10 +---------
 include/sysemu/char.h |  8 --------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 5d4cb85cea..ce963d3875 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -4370,18 +4370,10 @@ void qemu_chr_fe_disconnect(CharBackend *be)
     }
 }
=20
-void qemu_chr_free(Chardev *chr)
-{
-    if (CHARDEV_GET_CLASS(chr)->chr_free) {
-        CHARDEV_GET_CLASS(chr)->chr_free(chr);
-    }
-    object_unref(OBJECT(chr));
-}
-
 void qemu_chr_delete(Chardev *chr)
 {
     QTAILQ_REMOVE(&chardevs, chr, next);
-    qemu_chr_free(chr);
+    object_unref(OBJECT(chr));
 }
=20
 ChardevInfoList *qmp_query_chardev(Error **errp)
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 1ee8aa4325..15ae33d8fd 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -184,13 +184,6 @@ Chardev *qemu_chr_new_noreplay(const char *label, co=
nst char *filename);
  */
 void qemu_chr_delete(Chardev *chr);
=20
-/**
- * @qemu_chr_free:
- *
- * Destroy a character backend.
- */
-void qemu_chr_free(Chardev *chr);
-
 /**
  * @qemu_chr_fe_set_echo:
  *
@@ -494,7 +487,6 @@ typedef struct ChardevClass {
     int (*set_msgfds)(Chardev *s, int *fds, int num);
     int (*chr_add_client)(Chardev *chr, int fd);
     int (*chr_wait_connected)(Chardev *chr, Error **errp);
-    void (*chr_free)(Chardev *chr);
     void (*chr_disconnect)(Chardev *chr);
     void (*chr_accept_input)(Chardev *chr);
     void (*chr_set_echo)(Chardev *chr, bool echo);
--=20
2.11.0
