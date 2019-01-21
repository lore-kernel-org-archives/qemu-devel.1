Received: from eggs.gnu.org ([209.51.188.92]:40224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO3-0001P7-T4
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO1-0005FY-Qm
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:47 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:48:53 -0600
Message-Id: <20190121224907.26634-8-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/21] qemu-nbd: Avoid strtol open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Richard W . M . Jones" <rjones@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Our copy-and-pasted open-coding of strtol handling forgot to
handle overflow conditions.  Use qemu_strto*() instead.

In the case of --partition, since we insist on a user-supplied
partition to be non-zero, we can use 0 rather than -1 for our
initial value to distinguish when a partition is not being
served, for slightly more optimal code.

The error messages for out-of-bounds values are less specific,
but should not be a terrible loss in quality.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Message-Id: <20190117193658.16413-8-eblake@redhat.com>
---
 qemu-nbd.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 598caa656b2..efca0e44a90 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -546,9 +546,8 @@ int main(int argc, char **argv)
     };
     int ch;
     int opt_ind =3D 0;
-    char *end;
     int flags =3D BDRV_O_RDWR;
-    int partition =3D -1;
+    int partition =3D 0;
     int ret =3D 0;
     bool seen_cache =3D false;
     bool seen_discard =3D false;
@@ -660,9 +659,8 @@ int main(int argc, char **argv)
             port =3D optarg;
             break;
         case 'o':
-                dev_offset =3D strtoll (optarg, &end, 0);
-            if (*end) {
-                error_report("Invalid offset `%s'", optarg);
+            if (qemu_strtou64(optarg, NULL, 0, &dev_offset) < 0) {
+                error_report("Invalid offset '%s'", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
@@ -684,13 +682,9 @@ int main(int argc, char **argv)
             flags &=3D ~BDRV_O_RDWR;
             break;
         case 'P':
-            partition =3D strtol(optarg, &end, 0);
-            if (*end) {
-                error_report("Invalid partition `%s'", optarg);
-                exit(EXIT_FAILURE);
-            }
-            if (partition < 1 || partition > 8) {
-                error_report("Invalid partition %d", partition);
+            if (qemu_strtoi(optarg, NULL, 0, &partition) < 0 ||
+                partition < 1 || partition > 8) {
+                error_report("Invalid partition '%s'", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
@@ -711,15 +705,11 @@ int main(int argc, char **argv)
             device =3D optarg;
             break;
         case 'e':
-            shared =3D strtol(optarg, &end, 0);
-            if (*end) {
+            if (qemu_strtoi(optarg, NULL, 0, &shared) < 0 ||
+                shared < 1) {
                 error_report("Invalid shared device number '%s'", optarg=
);
                 exit(EXIT_FAILURE);
             }
-            if (shared < 1) {
-                error_report("Shared device number must be greater than =
0");
-                exit(EXIT_FAILURE);
-            }
             break;
         case 'f':
             fmt =3D optarg;
@@ -1007,7 +997,7 @@ int main(int argc, char **argv)
     }
     fd_size -=3D dev_offset;

-    if (partition !=3D -1) {
+    if (partition) {
         uint64_t limit;

         if (dev_offset) {
--=20
2.20.1
