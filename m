Received: from eggs.gnu.org ([209.51.188.92]:40207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mP-0006S3-Ic
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mO-00050a-9m
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:45 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 11 Jan 2019 13:47:20 -0600
Message-Id: <20190111194720.15671-9-eblake@redhat.com>
In-Reply-To: <20190111194720.15671-1-eblake@redhat.com>
References: <20190111194720.15671-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 8/8] qemu-nbd: Add --bitmap=NAME option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Having to fire up qemu, then use QMP commands for nbd-server-start
and nbd-server-add, just to expose a persistent dirty bitmap, is
rather tedious.  Make it possible to expose a dirty bitmap using
just qemu-nbd (of course, for now this only works when qemu-nbd is
visiting a BDS formatted as qcow2).

Of course, any good feature also needs unit testing, so expand
iotest 223 to cover it.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: rebase to earlier changes
---
 qemu-nbd.texi              |  4 ++++
 qemu-nbd.c                 | 10 ++++++++--
 tests/qemu-iotests/223     | 18 +++++++++++++++++-
 tests/qemu-iotests/223.out | 12 +++++++++++-
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 9a84e81eed9..96b1546006a 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -45,6 +45,10 @@ auto-detecting
 Export the disk as read-only
 @item -P, --partition=3D@var{num}
 Only expose partition @var{num}
+@item -B, --bitmap=3D@var{name}
+If @var{filename} has a qcow2 persistent bitmap @var{name}, expose
+that bitmap via the ``qemu:dirty-bitmap:@var{name}'' context
+accessible through NBD_OPT_SET_META_CONTEXT.
 @item -s, --snapshot
 Use @var{filename} as an external snapshot, create a temporary
 file with backing_file=3D@var{filename}, redirect the write to
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 1552274c189..51b55f2e066 100644
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
@@ -1016,7 +1022,7 @@ int main(int argc, char **argv)
     }

     export =3D nbd_export_new(bs, dev_offset, fd_size, export_name,
-                            export_description, NULL, nbdflags,
+                            export_description, bitmap, nbdflags,
                             nbd_export_closed, writethrough, NULL,
                             &error_fatal);

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 0bcc98a8677..773892dbe60 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -25,6 +25,7 @@ status=3D1 # failure is the default!

 _cleanup()
 {
+    nbd_server_stop
     _cleanup_test_img
     _cleanup_qemu
     rm -f "$TEST_DIR/nbd"
@@ -35,6 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 . ./common.qemu
+. ./common.nbd

 _supported_fmt qcow2
 _supported_proto file # uses NBD as well
@@ -163,7 +165,7 @@ $QEMU_IMG map --output=3Djson --image-opts \
   "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map

 echo
-echo "=3D=3D=3D End NBD server =3D=3D=3D"
+echo "=3D=3D=3D End qemu NBD server =3D=3D=3D"
 echo

 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
@@ -176,6 +178,20 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-=
stop"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "error" # Ag=
ain
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"

+echo
+echo "=3D=3D=3D Use qemu-nbd as server =3D=3D=3D"
+echo
+
+nbd_server_start_unix_socket -r -f $IMGFMT -B b "$TEST_IMG"
+IMG=3D"driver=3Dnbd,server.type=3Dunix,server.path=3D$nbd_unix_socket"
+$QEMU_IMG map --output=3Djson --image-opts \
+  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b" | _filter_qemu_img_map
+
+nbd_server_start_unix_socket -f $IMGFMT -B b2 "$TEST_IMG"
+IMG=3D"driver=3Dnbd,server.type=3Dunix,server.path=3D$nbd_unix_socket"
+$QEMU_IMG map --output=3Djson --image-opts \
+  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index ebd3935c974..0de5240a75e 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -61,7 +61,7 @@ read 2097152/2097152 bytes at offset 2097152
 { "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": t=
rue},
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]

-=3D=3D=3D End NBD server =3D=3D=3D
+=3D=3D=3D End qemu NBD server =3D=3D=3D

 {"return": {}}
 {"return": {}}
@@ -69,4 +69,14 @@ read 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"return": {}}
+
+=3D=3D=3D Use qemu-nbd as server =3D=3D=3D
+
+[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false=
},
+{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": =
true},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]
+[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true},
+{ "start": 512, "length": 512, "depth": 0, "zero": false, "data": false}=
,
+{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": t=
rue},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]
 *** done
--=20
2.20.1
