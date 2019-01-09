Received: from eggs.gnu.org ([209.51.188.92]:39075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gh5H8-0006dV-J3
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gh5Gz-0005om-IZ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:15:24 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  8 Jan 2019 22:14:52 -0600
Message-Id: <20190109041452.31240-6-eblake@redhat.com>
In-Reply-To: <20190109041452.31240-1-eblake@redhat.com>
References: <20190109041452.31240-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/5] qemu-nbd: Add --bitmap=NAME option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com

Having to fire up qemu, then use QMP commands for nbd-server-start
and nbd-server-add, just to expose a persistent dirty bitmap, is
rather tedious.  Make it possible to expose a dirty bitmap using
just qemu-nbd (of course, for now this only works when qemu-nbd is
visiting a BDS formatted as qcow2).

For now, I play it safe and only allow a bitmap to be exposed on
a read-only image.  We may relax it in the future.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.texi |  5 +++++
 qemu-nbd.c    | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 9a84e81eed9..1bf9d2bd8bf 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -45,6 +45,11 @@ auto-detecting
 Export the disk as read-only
 @item -P, --partition=3D@var{num}
 Only expose partition @var{num}
+@item -B, --bitmap=3D@var{name}
+If @var{filename} has a qcow2 persistent bitmap @var{name}, expose
+that bitmap via the ``qemu:dirty-bitmap:@var{name}'' context
+accessible through NBD_OPT_SET_META_CONTEXT.  Requires the use of
+@option{-r}.
 @item -s, --snapshot
 Use @var{filename} as an external snapshot, create a temporary
 file with backing_file=3D@var{filename}, redirect the write to
diff --git a/qemu-nbd.c b/qemu-nbd.c
index a6cc0f2553e..9781efe7a25 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -95,6 +95,7 @@ static void usage(const char *name)
 "Exposing part of the image:\n"
 "  -o, --offset=3DOFFSET       offset into the image\n"
 "  -P, --partition=3DNUM       only expose partition NUM\n"
+"  -B, --bitmap=3DNAME         expose a persistent dirty bitmap\n"
 "\n"
 "General purpose options:\n"
 "  --object type,id=3DID,...   define an object such as 'secret' for pro=
viding\n"
@@ -509,7 +510,7 @@ int main(int argc, char **argv)
     off_t fd_size;
     QemuOpts *sn_opts =3D NULL;
     const char *sn_id_or_name =3D NULL;
-    const char *sopt =3D "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:";
+    const char *sopt =3D "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:B:";
     struct option lopt[] =3D {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -519,6 +520,7 @@ int main(int argc, char **argv)
         { "offset", required_argument, NULL, 'o' },
         { "read-only", no_argument, NULL, 'r' },
         { "partition", required_argument, NULL, 'P' },
+        { "bitmap", required_argument, NULL, 'B' },
         { "connect", required_argument, NULL, 'c' },
         { "disconnect", no_argument, NULL, 'd' },
         { "snapshot", no_argument, NULL, 's' },
@@ -558,6 +560,7 @@ int main(int argc, char **argv)
     QDict *options =3D NULL;
     const char *export_name =3D ""; /* Default export name */
     const char *export_description =3D NULL;
+    const char *bitmap =3D NULL;
     const char *tlscredsid =3D NULL;
     bool imageOpts =3D false;
     bool writethrough =3D true;
@@ -695,6 +698,9 @@ int main(int argc, char **argv)
                 exit(EXIT_FAILURE);
             }
             break;
+        case 'B':
+            bitmap =3D optarg;
+            break;
         case 'k':
             sockpath =3D optarg;
             if (sockpath[0] !=3D '/') {
@@ -822,6 +828,12 @@ int main(int argc, char **argv)
         }
     }

+    if (bitmap && !(nbdflags & NBD_FLAG_READ_ONLY)) {
+        error_report("Exporting bitmap '%s' requires a readonly export",
+                     bitmap);
+        exit(EXIT_FAILURE);
+    }
+
 #if !HAVE_NBD_DEVICE
     if (disconnect || device) {
         error_report("Kernel /dev/nbdN support not available");
@@ -1015,7 +1027,7 @@ int main(int argc, char **argv)
         }
     }

-    exp =3D nbd_export_new(bs, dev_offset, fd_size, export_name, NULL, N=
ULL,
+    exp =3D nbd_export_new(bs, dev_offset, fd_size, export_name, bitmap,=
 NULL,
                          export_description, nbdflags, nbd_export_closed=
,
                          writethrough, NULL, &error_fatal);

--=20
2.20.1
