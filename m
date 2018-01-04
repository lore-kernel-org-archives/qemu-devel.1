Received: from eggs.gnu.org ([2001:4830:134:3::10]:37967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX84B-0008Q0-BT
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX847-0004q1-LP
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:08:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX847-0004pG-F1
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:08:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB4428B107
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:08:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:14 +0100
Message-Id: <20180104160523.22995-10-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/18] vl: fix direct firmware directories
 leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Note that data_dir[] will now point to allocated strings.

Fixes:
Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7f1448181850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7f1446ed8f0c in g_malloc ../glib/gmem.c:94
    #2 0x7f1446ed91cf in g_malloc_n ../glib/gmem.c:331
    #3 0x7f1446ef739a in g_strsplit ../glib/gstrfuncs.c:2364
    #4 0x55cf276439d7 in main /home/elmarco/src/qq/vl.c:4311
    #5 0x7f143dfad039 in __libc_start_main (/lib64/libc.so.6+0x21039)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 vl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index d3a5c5d021..8430b0c731 100644
--- a/vl.c
+++ b/vl.c
@@ -2318,7 +2318,7 @@ static void qemu_add_data_dir(const char *path)
             return; /* duplicate */
         }
     }
-    data_dir[data_dir_idx++] =3D path;
+    data_dir[data_dir_idx++] =3D g_strdup(path);
 }
=20
 static inline bool nonempty_str(const char *str)
@@ -3079,7 +3079,7 @@ int main(int argc, char **argv, char **envp)
     Error *main_loop_err =3D NULL;
     Error *err =3D NULL;
     bool list_data_dirs =3D false;
-    char **dirs;
+    char *dir, **dirs;
     typedef struct BlockdevOptions_queue {
         BlockdevOptions *bdo;
         Location loc;
@@ -4263,9 +4263,12 @@ int main(int argc, char **argv, char **envp)
     for (i =3D 0; dirs[i] !=3D NULL; i++) {
         qemu_add_data_dir(dirs[i]);
     }
+    g_strfreev(dirs);
=20
     /* try to find datadir relative to the executable path */
-    qemu_add_data_dir(os_find_datadir());
+    dir =3D os_find_datadir();
+    qemu_add_data_dir(dir);
+    g_free(dir);
=20
     /* add the datadir specified when building */
     qemu_add_data_dir(CONFIG_QEMU_DATADIR);
--=20
2.15.1.355.g36791d7216
