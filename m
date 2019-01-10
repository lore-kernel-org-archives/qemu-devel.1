Received: from eggs.gnu.org ([209.51.188.92]:56474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrB-00050C-5R
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrA-0008Pg-1t
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:09 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 13:18:55 -0600
Message-Id: <20190110191901.5082-2-eblake@redhat.com>
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
References: <20190110191901.5082-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/6] qemu-option: Allow integer defaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lbloch@janustech.com, armbru@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org

Set the framework up for declaring integer options with an integer
default, instead of our current insane approach of requiring the
default value to be given as a string (which then has to be reparsed
at every use that wants a number).  git grep '[^.]def_value_str' says
that we have done a good job of NOT abusing the internal field
outside of the implementation in qemu-option.c; therefore, it is not
too hard to audit that all code can either handle the new integer
defaults correctly or abort because a caller violated constraints.
Sadly, we DO have a constraint that qemu_opt_get() should not be
called on an option that has an integer type, because we have no
where to stash a cached const char * result; but callers that want
an integer should be using qemu_opt_get_number() and friends
anyways.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/option.h | 12 ++++++++
 util/qemu-option.c    | 69 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index 844587cab39..46b80d5a6e1 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -46,6 +46,18 @@ typedef struct QemuOptDesc {
     const char *name;
     enum QemuOptType type;
     const char *help;
+    /*
+     * For QEMU_OPT_STRING: Leave def_value_int 0, and set def_value_str
+     * to a default value or leave NULL for no default.
+     *
+     * For other types: Initialize at most non-zero def_value_int or a
+     * parseable def_value_str for a default (must use a string for an
+     * explicit default of 0, although an implicit default generally
+     * works).  If setting def_value_int, calling qemu_opt_get() on
+     * that option will abort(); instead, call qemu_opt_get_del() or a
+     * typed getter.
+     */
+    uint64_t def_value_int;
     const char *def_value_str;
 } QemuOptDesc;

diff --git a/util/qemu-option.c b/util/qemu-option.c
index de42e2a406a..06c4e8102a8 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -321,7 +321,8 @@ const char *qemu_opt_get(QemuOpts *opts, const char *=
name)
     opt =3D qemu_opt_find(opts, name);
     if (!opt) {
         const QemuOptDesc *desc =3D find_desc_by_name(opts->list->desc, =
name);
-        if (desc && desc->def_value_str) {
+        if (desc) {
+            assert(!desc->def_value_int);
             return desc->def_value_str;
         }
     }
@@ -364,8 +365,22 @@ char *qemu_opt_get_del(QemuOpts *opts, const char *n=
ame)
     opt =3D qemu_opt_find(opts, name);
     if (!opt) {
         desc =3D find_desc_by_name(opts->list->desc, name);
-        if (desc && desc->def_value_str) {
-            str =3D g_strdup(desc->def_value_str);
+        if (desc) {
+            if (desc->def_value_str) {
+                str =3D g_strdup(desc->def_value_str);
+            } else if (desc->def_value_int) {
+                switch (desc->type) {
+                case QEMU_OPT_BOOL:
+                    str =3D g_strdup("on");
+                    break;
+                case QEMU_OPT_NUMBER:
+                case QEMU_OPT_SIZE:
+                    str =3D g_strdup_printf("%" PRId64, desc->def_value_=
int);
+                    break;
+                default:
+                    abort();
+                }
+            }
         }
         return str;
     }
@@ -400,8 +415,15 @@ static bool qemu_opt_get_bool_helper(QemuOpts *opts,=
 const char *name,
     opt =3D qemu_opt_find(opts, name);
     if (opt =3D=3D NULL) {
         const QemuOptDesc *desc =3D find_desc_by_name(opts->list->desc, =
name);
-        if (desc && desc->def_value_str) {
-            parse_option_bool(name, desc->def_value_str, &ret, &error_ab=
ort);
+        if (desc) {
+            if (desc->def_value_int) {
+                assert(desc->type !=3D QEMU_OPT_STRING);
+                return true;
+            }
+            if (desc->def_value_str) {
+                parse_option_bool(name, desc->def_value_str, &ret,
+                                  &error_abort);
+            }
         }
         return ret;
     }
@@ -436,8 +458,15 @@ static uint64_t qemu_opt_get_number_helper(QemuOpts =
*opts, const char *name,
     opt =3D qemu_opt_find(opts, name);
     if (opt =3D=3D NULL) {
         const QemuOptDesc *desc =3D find_desc_by_name(opts->list->desc, =
name);
-        if (desc && desc->def_value_str) {
-            parse_option_number(name, desc->def_value_str, &ret, &error_=
abort);
+        if (desc) {
+            if (desc->def_value_int) {
+                assert(desc->type !=3D QEMU_OPT_STRING);
+                return desc->def_value_int;
+            }
+            if (desc->def_value_str) {
+                parse_option_number(name, desc->def_value_str, &ret,
+                                    &error_abort);
+            }
         }
         return ret;
     }
@@ -473,8 +502,15 @@ static uint64_t qemu_opt_get_size_helper(QemuOpts *o=
pts, const char *name,
     opt =3D qemu_opt_find(opts, name);
     if (opt =3D=3D NULL) {
         const QemuOptDesc *desc =3D find_desc_by_name(opts->list->desc, =
name);
-        if (desc && desc->def_value_str) {
-            parse_option_size(name, desc->def_value_str, &ret, &error_ab=
ort);
+        if (desc) {
+            if (desc->def_value_int) {
+                assert(desc->type !=3D QEMU_OPT_STRING);
+                return desc->def_value_int;
+            }
+            if (desc->def_value_str) {
+                parse_option_size(name, desc->def_value_str, &ret,
+                                  &error_abort);
+            }
         }
         return ret;
     }
@@ -787,9 +823,23 @@ void qemu_opts_print(QemuOpts *opts, const char *sep=
arator)
     }
     for (; desc && desc->name; desc++) {
         const char *value;
+        char *tmp =3D NULL;
         opt =3D qemu_opt_find(opts, desc->name);

         value =3D opt ? opt->str : desc->def_value_str;
+        if (!value && desc->def_value_int) {
+            switch (desc->type) {
+            case QEMU_OPT_BOOL:
+                value =3D tmp =3D g_strdup("on");
+                break;
+            case QEMU_OPT_NUMBER:
+            case QEMU_OPT_SIZE:
+                value =3D tmp =3D g_strdup_printf("%" PRId64, desc->def_=
value_int);
+                break;
+            default:
+                abort();
+            }
+        }
         if (!value) {
             continue;
         }
@@ -803,6 +853,7 @@ void qemu_opts_print(QemuOpts *opts, const char *sepa=
rator)
             printf("%s%s=3D%s", sep, desc->name, value);
         }
         sep =3D separator;
+        g_free(tmp);
     }
 }

--=20
2.20.1
