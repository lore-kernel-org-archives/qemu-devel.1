Received: from eggs.gnu.org ([209.51.188.92]:57659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54W-0003pG-51
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54V-0005Os-7e
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:57 -0600
Message-Id: <20190114162605.5330-13-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/20] qemu-nbd: Rename 'exp' variable clashing
 with math::exp() symbol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The use of a variable named 'exp' prevents includes to import <math.h>.

Rename it to avoid:

  qemu-nbd.c:64:19: error: =E2=80=98exp=E2=80=99 redeclared as different =
kind of symbol
   static NBDExport *exp;
                     ^~~
  In file included from /usr/include/features.h:428,
                   from /usr/include/bits/libc-header-start.h:33,
                   from /usr/include/stdint.h:26,
                   from /usr/lib/gcc/x86_64-redhat-linux/8/include/stdint=
.h:9,
                   from /source/qemu/include/qemu/osdep.h:80,
                   from /source/qemu/qemu-nbd.c:19:
  /usr/include/bits/mathcalls.h:95:1: note: previous declaration of =E2=80=
=98exp=E2=80=99 was here
    __MATHCALL_VEC (exp,, (_Mdouble_ __x));
    ^~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190111163519.11457-1-philmd@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 2807e132396..6ca02b6d87b 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -61,7 +61,7 @@

 #define MBR_SIZE 512

-static NBDExport *exp;
+static NBDExport *export;
 static int verbose;
 static char *srcpath;
 static SocketAddress *saddr;
@@ -335,7 +335,7 @@ static int nbd_can_accept(void)
     return state =3D=3D RUNNING && nb_fds < shared;
 }

-static void nbd_export_closed(NBDExport *exp)
+static void nbd_export_closed(NBDExport *export)
 {
     assert(state =3D=3D TERMINATING);
     state =3D TERMINATED;
@@ -1015,10 +1015,11 @@ int main(int argc, char **argv)
         }
     }

-    exp =3D nbd_export_new(bs, dev_offset, fd_size, nbdflags, nbd_export=
_closed,
-                         writethrough, NULL, &error_fatal);
-    nbd_export_set_name(exp, export_name);
-    nbd_export_set_description(exp, export_description);
+    export =3D nbd_export_new(bs, dev_offset, fd_size, nbdflags,
+                            nbd_export_closed, writethrough,
+                            NULL, &error_fatal);
+    nbd_export_set_name(export, export_name);
+    nbd_export_set_description(export, export_description);

     if (device) {
 #if HAVE_NBD_DEVICE
@@ -1055,9 +1056,9 @@ int main(int argc, char **argv)
         main_loop_wait(false);
         if (state =3D=3D TERMINATE) {
             state =3D TERMINATING;
-            nbd_export_close(exp);
-            nbd_export_put(exp);
-            exp =3D NULL;
+            nbd_export_close(export);
+            nbd_export_put(export);
+            export =3D NULL;
         }
     } while (state !=3D TERMINATED);

--=20
2.20.1
