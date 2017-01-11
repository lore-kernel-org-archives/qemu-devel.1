Received: from eggs.gnu.org ([2001:4830:134:3::10]:40626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMj6-0000u4-LK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMj5-0006Nz-Mz
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMj5-0006NB-Gk
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:19 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A219BC008AE5
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:31 +0100
Message-Id: <20170111172956.11255-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/40] char: remove chr_free
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

Now it uses Object instance_finalize instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/char.h |  8 --------
 qemu-char.c           | 10 +---------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index da0e7dd494..5e5594f305 100644
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
@@ -496,7 +489,6 @@ typedef struct ChardevClass {
     int (*set_msgfds)(Chardev *s, int *fds, int num);
     int (*chr_add_client)(Chardev *chr, int fd);
     int (*chr_wait_connected)(Chardev *chr, Error **errp);
-    void (*chr_free)(Chardev *chr);
     void (*chr_disconnect)(Chardev *chr);
     void (*chr_accept_input)(Chardev *chr);
     void (*chr_set_echo)(Chardev *chr, bool echo);
diff --git a/qemu-char.c b/qemu-char.c
index b106f6ef33..b6415ee333 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -4369,18 +4369,10 @@ void qemu_chr_fe_disconnect(CharBackend *be)
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
--=20
2.11.0
