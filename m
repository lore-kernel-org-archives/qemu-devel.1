Received: from eggs.gnu.org ([2001:4830:134:3::10]:50778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8290-0002HP-K0
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f828y-00047g-Kh
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f828y-00046s-BR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:56 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 16 Apr 2018 12:17:43 +0100
Message-Id: <20180416111743.8473-4-berrange@redhat.com>
In-Reply-To: <20180416111743.8473-1-berrange@redhat.com>
References: <20180416111743.8473-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] opts: don't silently truncate long option
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The existing QemuOpts parsing code uses a fixed size 1024 byte buffer
for storing the option values. If a value exceeded this size it was
silently truncated and no error reported to the user. Long option values
is not a common scenario, but it is conceivable that they will happen.
eg if the user has a very deeply nested filesystem it would be possible
to come up with a disk path that was > 1024 bytes. Most of the time if
such data was silently truncated, the user would get an error about
opening a non-existant disk. If they're unlucky though, QEMU might use a
completely different disk image from another VM, which could be
considered a security issue. Another example program was in using the
-smbios command line arg with very large data blobs. In this case the
silent truncation will be providing semantically incorrect data to the
guest OS for SMBIOS tables.

If the operating system didn't limit the user's argv when spawning QEMU,
the code should honour whatever length arguments were given without
imposing its own length restrictions. This patch thus changes the code
to use a heap allocated buffer for storing the values during parsing,
lifting the arbitrary length restriction.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/i386/multiboot.c   |  33 +++++++++------
 include/qemu/option.h |   2 +-
 util/qemu-option.c    | 111 +++++++++++++++++++++++++++-----------------=
------
 3 files changed, 81 insertions(+), 65 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 5bc0a2cddb..7a2953e26f 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -291,12 +291,16 @@ int load_multiboot(FWCfgState *fw_cfg,
     cmdline_len =3D strlen(kernel_filename) + 1;
     cmdline_len +=3D strlen(kernel_cmdline) + 1;
     if (initrd_filename) {
-        const char *r =3D initrd_filename;
+        const char *r =3D get_opt_value(initrd_filename, NULL);
         cmdline_len +=3D strlen(r) + 1;
         mbs.mb_mods_avail =3D 1;
-        while (*(r =3D get_opt_value(NULL, 0, r))) {
-           mbs.mb_mods_avail++;
-           r++;
+        while (1) {
+            mbs.mb_mods_avail++;
+            r =3D get_opt_value(r, NULL);
+            if (!*r) {
+                break;
+            }
+            r++;
         }
     }
=20
@@ -313,7 +317,8 @@ int load_multiboot(FWCfgState *fw_cfg,
=20
     if (initrd_filename) {
         const char *next_initrd;
-        char not_last, tmpbuf[strlen(initrd_filename) + 1];
+        char not_last;
+        char *one_file =3D NULL;
=20
         mbs.offset_mods =3D mbs.mb_buf_size;
=20
@@ -322,24 +327,26 @@ int load_multiboot(FWCfgState *fw_cfg,
             int mb_mod_length;
             uint32_t offs =3D mbs.mb_buf_size;
=20
-            next_initrd =3D get_opt_value(tmpbuf, sizeof(tmpbuf), initrd=
_filename);
+            next_initrd =3D get_opt_value(initrd_filename, &one_file);
             not_last =3D *next_initrd;
             /* if a space comes after the module filename, treat everyth=
ing
                after that as parameters */
-            hwaddr c =3D mb_add_cmdline(&mbs, tmpbuf);
-            if ((next_space =3D strchr(tmpbuf, ' ')))
+            hwaddr c =3D mb_add_cmdline(&mbs, one_file);
+            next_space =3D strchr(one_file, ' ');
+            if (next_space) {
                 *next_space =3D '\0';
-            mb_debug("multiboot loading module: %s", tmpbuf);
-            mb_mod_length =3D get_image_size(tmpbuf);
+            }
+            mb_debug("multiboot loading module: %s", one_file);
+            mb_mod_length =3D get_image_size(one_file);
             if (mb_mod_length < 0) {
-                error_report("Failed to open file '%s'", tmpbuf);
+                error_report("Failed to open file '%s'", one_file);
                 exit(1);
             }
=20
             mbs.mb_buf_size =3D TARGET_PAGE_ALIGN(mb_mod_length + mbs.mb=
_buf_size);
             mbs.mb_buf =3D g_realloc(mbs.mb_buf, mbs.mb_buf_size);
=20
-            load_image(tmpbuf, (unsigned char *)mbs.mb_buf + offs);
+            load_image(one_file, (unsigned char *)mbs.mb_buf + offs);
             mb_add_mod(&mbs, mbs.mb_buf_phys + offs,
                        mbs.mb_buf_phys + offs + mb_mod_length, c);
=20
@@ -347,6 +354,8 @@ int load_multiboot(FWCfgState *fw_cfg,
                      (char *)mbs.mb_buf + offs,
                      (char *)mbs.mb_buf + offs + mb_mod_length, c);
             initrd_filename =3D next_initrd+1;
+            g_free(one_file);
+            one_file =3D NULL;
         } while (not_last);
     }
=20
diff --git a/include/qemu/option.h b/include/qemu/option.h
index 1cfe5cbc2d..3dfb4493cc 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -28,7 +28,7 @@
=20
 #include "qemu/queue.h"
=20
-const char *get_opt_value(char *buf, int buf_size, const char *p);
+const char *get_opt_value(const char *p, char **value);
=20
 void parse_option_size(const char *name, const char *value,
                        uint64_t *ret, Error **errp);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index fa1a9f17fc..58d1c23893 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -70,25 +70,37 @@ static const char *get_opt_name(const char *p, char *=
*option, char delim)
  * delimiter is fixed to be comma which starts a new option. To specify =
an
  * option value that contains commas, double each comma.
  */
-const char *get_opt_value(char *buf, int buf_size, const char *p)
+const char *get_opt_value(const char *p, char **value)
 {
-    char *q;
+    size_t capacity =3D 0, length;
+    const char *offset;
+
+    *value =3D NULL;
+    while (1) {
+        offset =3D strchr(p, ',');
+        if (!offset) {
+            offset =3D p + strlen(p);
+        }
=20
-    q =3D buf;
-    while (*p !=3D '\0') {
-        if (*p =3D=3D ',') {
-            if (*(p + 1) !=3D ',')
-                break;
-            p++;
+        length =3D offset - p;
+        if (*offset !=3D '\0' && *(offset + 1) =3D=3D ',') {
+            length++;
+        }
+        if (value) {
+            *value =3D g_renew(char, *value, capacity + length + 1);
+            strncpy(*value + capacity, p, length);
+            (*value)[capacity + length] =3D '\0';
+        }
+        capacity +=3D length;
+        if (*offset =3D=3D '\0' ||
+            *(offset + 1) !=3D ',') {
+            break;
         }
-        if (q && (q - buf) < buf_size - 1)
-            *q++ =3D *p;
-        p++;
+
+        p +=3D (offset - p) + 2;
     }
-    if (q)
-        *q =3D '\0';
=20
-    return p;
+    return offset;
 }
=20
 static void parse_option_bool(const char *name, const char *value, bool =
*ret,
@@ -162,50 +174,43 @@ void parse_option_size(const char *name, const char=
 *value,
=20
 bool has_help_option(const char *param)
 {
-    size_t buflen =3D strlen(param) + 1;
-    char *buf =3D g_malloc(buflen);
     const char *p =3D param;
     bool result =3D false;
=20
-    while (*p) {
-        p =3D get_opt_value(buf, buflen, p);
+    while (*p && !result) {
+        char *value;
+
+        p =3D get_opt_value(p, &value);
         if (*p) {
             p++;
         }
=20
-        if (is_help_option(buf)) {
-            result =3D true;
-            goto out;
-        }
+        result =3D is_help_option(value);
+        g_free(value);
     }
=20
-out:
-    g_free(buf);
     return result;
 }
=20
-bool is_valid_option_list(const char *param)
+bool is_valid_option_list(const char *p)
 {
-    size_t buflen =3D strlen(param) + 1;
-    char *buf =3D g_malloc(buflen);
-    const char *p =3D param;
-    bool result =3D true;
+    char *value =3D NULL;
+    bool result =3D false;
=20
     while (*p) {
-        p =3D get_opt_value(buf, buflen, p);
-        if (*p && !*++p) {
-            result =3D false;
+        p =3D get_opt_value(p, &value);
+        if ((*p && !*++p) ||
+            (!*value || *value =3D=3D ',')) {
             goto out;
         }
=20
-        if (!*buf || *buf =3D=3D ',') {
-            result =3D false;
-            goto out;
-        }
+        g_free(value);
+        value =3D NULL;
     }
=20
+    result =3D true;
 out:
-    g_free(buf);
+    g_free(value);
     return result;
 }
=20
@@ -487,7 +492,7 @@ int qemu_opt_unset(QemuOpts *opts, const char *name)
     }
 }
=20
-static void opt_set(QemuOpts *opts, const char *name, const char *value,
+static void opt_set(QemuOpts *opts, const char *name, char *value,
                     bool prepend, Error **errp)
 {
     QemuOpt *opt;
@@ -496,6 +501,7 @@ static void opt_set(QemuOpts *opts, const char *name,=
 const char *value,
=20
     desc =3D find_desc_by_name(opts->list->desc, name);
     if (!desc && !opts_accepts_any(opts)) {
+        g_free(value);
         error_setg(errp, QERR_INVALID_PARAMETER, name);
         return;
     }
@@ -509,8 +515,7 @@ static void opt_set(QemuOpts *opts, const char *name,=
 const char *value,
         QTAILQ_INSERT_TAIL(&opts->head, opt, next);
     }
     opt->desc =3D desc;
-    opt->str =3D g_strdup(value);
-    assert(opt->str);
+    opt->str =3D value;
     qemu_opt_parse(opt, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -521,7 +526,7 @@ static void opt_set(QemuOpts *opts, const char *name,=
 const char *value,
 void qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
                   Error **errp)
 {
-    opt_set(opts, name, value, false, errp);
+    opt_set(opts, name, g_strdup(value), false, errp);
 }
=20
 void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
@@ -755,7 +760,7 @@ static void opts_do_parse(QemuOpts *opts, const char =
*params,
                           const char *firstname, bool prepend, Error **e=
rrp)
 {
     char *option =3D NULL;
-    char value[1024];
+    char *value =3D NULL;
     const char *p,*pe,*pc;
     Error *local_err =3D NULL;
=20
@@ -767,15 +772,15 @@ static void opts_do_parse(QemuOpts *opts, const cha=
r *params,
             if (p =3D=3D params && firstname) {
                 /* implicitly named first option */
                 option =3D g_strdup(firstname);
-                p =3D get_opt_value(value, sizeof(value), p);
+                p =3D get_opt_value(p, &value);
             } else {
                 /* option without value, probably a flag */
                 p =3D get_opt_name(p, &option, ',');
                 if (strncmp(option, "no", 2) =3D=3D 0) {
                     memmove(option, option+2, strlen(option+2)+1);
-                    pstrcpy(value, sizeof(value), "off");
+                    value =3D g_strdup("off");
                 } else {
-                    pstrcpy(value, sizeof(value), "on");
+                    value =3D g_strdup("on");
                 }
             }
         } else {
@@ -783,11 +788,12 @@ static void opts_do_parse(QemuOpts *opts, const cha=
r *params,
             p =3D get_opt_name(p, &option, '=3D');
             assert(*p =3D=3D '=3D');
             p++;
-            p =3D get_opt_value(value, sizeof(value), p);
+            p =3D get_opt_value(p, &value);
         }
         if (strcmp(option, "id") !=3D 0) {
             /* store and parse */
             opt_set(opts, option, value, prepend, &local_err);
+            value =3D NULL;
             if (local_err) {
                 error_propagate(errp, local_err);
                 goto cleanup;
@@ -797,11 +803,13 @@ static void opts_do_parse(QemuOpts *opts, const cha=
r *params,
             break;
         }
         g_free(option);
-        option =3D NULL;
+        g_free(value);
+        option =3D value =3D NULL;
     }
=20
  cleanup:
     g_free(option);
+    g_free(value);
 }
=20
 /**
@@ -820,7 +828,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const=
 char *params,
                             bool permit_abbrev, bool defaults, Error **e=
rrp)
 {
     const char *firstname;
-    char value[1024], *id =3D NULL;
+    char *id =3D NULL;
     const char *p;
     QemuOpts *opts;
     Error *local_err =3D NULL;
@@ -829,11 +837,9 @@ static QemuOpts *opts_parse(QemuOptsList *list, cons=
t char *params,
     firstname =3D permit_abbrev ? list->implied_opt_name : NULL;
=20
     if (strncmp(params, "id=3D", 3) =3D=3D 0) {
-        get_opt_value(value, sizeof(value), params+3);
-        id =3D value;
+        get_opt_value(params + 3, &id);
     } else if ((p =3D strstr(params, ",id=3D")) !=3D NULL) {
-        get_opt_value(value, sizeof(value), p+4);
-        id =3D value;
+        get_opt_value(p + 4, &id);
     }
=20
     /*
@@ -845,6 +851,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const=
 char *params,
      */
     assert(!defaults || list->merge_lists);
     opts =3D qemu_opts_create(list, id, !defaults, &local_err);
+    g_free(id);
     if (opts =3D=3D NULL) {
         error_propagate(errp, local_err);
         return NULL;
--=20
2.14.3
