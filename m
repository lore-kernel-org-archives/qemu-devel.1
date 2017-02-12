Received: from eggs.gnu.org ([2001:4830:134:3::10]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj8g-0007j0-19
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj8e-0007VW-Nq
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:42 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:39:28 +0100
Message-Id: <20170212013929.6793-3-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/21] qemu-img: Use qemu_strtoul() rather than
 raw strtoul()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Some of the argument parsing in qemu-img uses strtoul() to parse
integer arguments.  This is tricky to get correct and in fact the
code does not get it right, because it assigns the result of
strtoul() to an 'int' variable and then tries to check for > INT_MAX.
Coverity correctly complains that the comparison is always false.

Rewrite to use qemu_strtoul(), which has a saner convention for
reporting conversion failures.

(Fixes CID 1356421, CID 1356422, CID 1356423.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1486744104-15590-2-git-send-email-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 933876cfe1..38266e56b0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3623,24 +3623,24 @@ static int img_bench(int argc, char **argv)
             break;
         case 'c':
         {
-            char *end;
-            errno =3D 0;
-            count =3D strtoul(optarg, &end, 0);
-            if (errno || *end || count > INT_MAX) {
+            unsigned long res;
+
+            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX=
) {
                 error_report("Invalid request count specified");
                 return 1;
             }
+            count =3D res;
             break;
         }
         case 'd':
         {
-            char *end;
-            errno =3D 0;
-            depth =3D strtoul(optarg, &end, 0);
-            if (errno || *end || depth > INT_MAX) {
+            unsigned long res;
+
+            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX=
) {
                 error_report("Invalid queue depth specified");
                 return 1;
             }
+            depth =3D res;
             break;
         }
         case 'f':
@@ -3707,24 +3707,24 @@ static int img_bench(int argc, char **argv)
             break;
         case OPTION_PATTERN:
         {
-            char *end;
-            errno =3D 0;
-            pattern =3D strtoul(optarg, &end, 0);
-            if (errno || *end || pattern > 0xff) {
+            unsigned long res;
+
+            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > 0xff) {
                 error_report("Invalid pattern byte specified");
                 return 1;
             }
+            pattern =3D res;
             break;
         }
         case OPTION_FLUSH_INTERVAL:
         {
-            char *end;
-            errno =3D 0;
-            flush_interval =3D strtoul(optarg, &end, 0);
-            if (errno || *end || flush_interval > INT_MAX) {
+            unsigned long res;
+
+            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX=
) {
                 error_report("Invalid flush interval specified");
                 return 1;
             }
+            flush_interval =3D res;
             break;
         }
         case OPTION_NO_DRAIN:
--=20
2.11.0
