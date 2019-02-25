Received: from eggs.gnu.org ([209.51.188.92]:37040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4G-0008Ev-63
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4E-0000eO-Rn
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:50 +0100
Message-Id: <20190225152053.15976-9-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/71] qemu-img: fix error reporting for -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Error reporting for user_creatable_add_opts_foreach was changed so that
it no longer called 'error_report_err' in:

  commit 7e1e0c11127bde81cff260fc6859690435c509d6
  Author: Markus Armbruster <armbru@redhat.com>
  Date:   Wed Oct 17 10:26:43 2018 +0200

    qom: Clean up error reporting in user_creatable_add_opts_foreach()

Some callers were updated to pass in "&error_fatal" but all the ones in
qemu-img were left passing NULL. As a result all errors went to
/dev/null instead of being reported to the user.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9737b815e4..eb5045c742 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -503,7 +503,7 @@ static int img_create(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         goto fail;
     }
=20
@@ -753,7 +753,7 @@ static int img_check(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -966,7 +966,7 @@ static int img_commit(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -1349,7 +1349,7 @@ static int img_compare(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         ret =3D 2;
         goto out4;
     }
@@ -2159,7 +2159,7 @@ static int img_convert(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         goto fail_getopt;
     }
=20
@@ -2713,7 +2713,7 @@ static int img_info(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -2932,7 +2932,7 @@ static int img_map(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -3081,7 +3081,7 @@ static int img_snapshot(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -3248,7 +3248,7 @@ static int img_rebase(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -3628,7 +3628,7 @@ static int img_resize(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -3872,7 +3872,7 @@ static int img_amend(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         ret =3D -1;
         goto out_no_progress;
     }
@@ -4516,7 +4516,7 @@ static int img_dd(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         ret =3D -1;
         goto out;
     }
@@ -4793,7 +4793,7 @@ static int img_measure(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         goto out;
     }
=20
--=20
2.20.1
