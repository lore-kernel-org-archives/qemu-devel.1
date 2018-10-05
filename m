Received: from eggs.gnu.org ([2001:4830:134:3::10]:58697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PEp-0000OG-OJ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PEm-0005sn-Gf
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g8PEm-0005rz-8Y
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:44 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  5 Oct 2018 16:29:01 +0400
Message-Id: <20181005122910.11745-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181005122910.11745-1-marcandre.lureau@redhat.com>
References: <20181005122910.11745-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 03/12] qemu-option: add help fallback to
 print the list of options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

QDev options accept 'help' (or '?', but that's problematic with shell
globbing) in the list of parameters, which is handy to list the
available options.

Unfortunately, this isn't built in QemuOpts. qemu_opts_parse_noisily()
seems to be the common path for command line options, so place a
fallback to print help, listing the available options.

This is quite handy, for example with qemu "-spice help".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/qemu-option.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 01886efe90..557b6c6626 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -486,7 +486,7 @@ int qemu_opt_unset(QemuOpts *opts, const char *name)
 }
=20
 static void opt_set(QemuOpts *opts, const char *name, char *value,
-                    bool prepend, Error **errp)
+                    bool prepend, bool *invalidp, Error **errp)
 {
     QemuOpt *opt;
     const QemuOptDesc *desc;
@@ -496,6 +496,9 @@ static void opt_set(QemuOpts *opts, const char *name,=
 char *value,
     if (!desc && !opts_accepts_any(opts)) {
         g_free(value);
         error_setg(errp, QERR_INVALID_PARAMETER, name);
+        if (invalidp) {
+            *invalidp =3D true;
+        }
         return;
     }
=20
@@ -519,7 +522,7 @@ static void opt_set(QemuOpts *opts, const char *name,=
 char *value,
 void qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
                   Error **errp)
 {
-    opt_set(opts, name, g_strdup(value), false, errp);
+    opt_set(opts, name, g_strdup(value), false, NULL, errp);
 }
=20
 void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
@@ -750,7 +753,8 @@ void qemu_opts_print(QemuOpts *opts, const char *sepa=
rator)
 }
=20
 static void opts_do_parse(QemuOpts *opts, const char *params,
-                          const char *firstname, bool prepend, Error **e=
rrp)
+                          const char *firstname, bool prepend,
+                          bool *invalidp, Error **errp)
 {
     char *option =3D NULL;
     char *value =3D NULL;
@@ -785,7 +789,7 @@ static void opts_do_parse(QemuOpts *opts, const char =
*params,
         }
         if (strcmp(option, "id") !=3D 0) {
             /* store and parse */
-            opt_set(opts, option, value, prepend, &local_err);
+            opt_set(opts, option, value, prepend, invalidp, &local_err);
             value =3D NULL;
             if (local_err) {
                 error_propagate(errp, local_err);
@@ -814,11 +818,12 @@ static void opts_do_parse(QemuOpts *opts, const cha=
r *params,
 void qemu_opts_do_parse(QemuOpts *opts, const char *params,
                        const char *firstname, Error **errp)
 {
-    opts_do_parse(opts, params, firstname, false, errp);
+    opts_do_parse(opts, params, firstname, false, NULL, errp);
 }
=20
 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
-                            bool permit_abbrev, bool defaults, Error **e=
rrp)
+                            bool permit_abbrev, bool defaults,
+                            bool *invalidp, Error **errp)
 {
     const char *firstname;
     char *id =3D NULL;
@@ -850,7 +855,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const=
 char *params,
         return NULL;
     }
=20
-    opts_do_parse(opts, params, firstname, defaults, &local_err);
+    opts_do_parse(opts, params, firstname, defaults, invalidp, &local_er=
r);
     if (local_err) {
         error_propagate(errp, local_err);
         qemu_opts_del(opts);
@@ -870,7 +875,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const=
 char *params,
 QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
                           bool permit_abbrev, Error **errp)
 {
-    return opts_parse(list, params, permit_abbrev, false, errp);
+    return opts_parse(list, params, permit_abbrev, false, NULL, errp);
 }
=20
 /**
@@ -886,10 +891,16 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *lis=
t, const char *params,
 {
     Error *err =3D NULL;
     QemuOpts *opts;
+    bool invalidp =3D false;
=20
-    opts =3D opts_parse(list, params, permit_abbrev, false, &err);
+    opts =3D opts_parse(list, params, permit_abbrev, false, &invalidp, &=
err);
     if (err) {
-        error_report_err(err);
+        if (invalidp && has_help_option(params)) {
+            qemu_opts_print_help(list);
+            error_free(err);
+        } else {
+            error_report_err(err);
+        }
     }
     return opts;
 }
@@ -899,7 +910,7 @@ void qemu_opts_set_defaults(QemuOptsList *list, const=
 char *params,
 {
     QemuOpts *opts;
=20
-    opts =3D opts_parse(list, params, permit_abbrev, true, NULL);
+    opts =3D opts_parse(list, params, permit_abbrev, true, NULL, NULL);
     assert(opts);
 }
=20
--=20
2.19.0.271.gfe8321ec05
