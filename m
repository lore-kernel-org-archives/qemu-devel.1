Received: from eggs.gnu.org ([2001:4830:134:3::10]:41374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt7-00036o-4z
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt3-0001Ry-Su
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:13 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:56240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAt3-0001Qt-IM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:09 -0400
Received: by mail-wm0-x229.google.com with SMTP id a8so21229655wmg.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:32 +0200
Message-Id: <1525817687-34620-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/30] opts: don't silently truncate long option
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

From: Daniel P. Berrangé <berrange@redhat.com>

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

Signed-off-by: Daniel P. BerrangÃ© <berrange@redhat.com>
Message-Id: <20180416111743.8473-4-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/multiboot.c   |  33 +++++++++------
 include/qemu/option.h |   2 +-
 util/qemu-option.c    | 111 +++++++++++++++++++++++++++-----------------------
 3 files changed, 81 insertions(+), 65 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 5bc0a2c..7a2953e 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -291,12 +291,16 @@ int load_multiboot(FWCfgState *fw_cfg,
     cmdline_len = strlen(kernel_filename) + 1;
     cmdline_len += strlen(kernel_cmdline) + 1;
     if (initrd_filename) {
-        const char *r = initrd_filename;
+        const char *r = get_opt_value(initrd_filename, NULL);
         cmdline_len += strlen(r) + 1;
         mbs.mb_mods_avail = 1;
-        while (*(r = get_opt_value(NULL, 0, r))) {
-           mbs.mb_mods_avail++;
-           r++;
+        while (1) {
+            mbs.mb_mods_avail++;
+            r = get_opt_value(r, NULL);
+            if (!*r) {
+                break;
+            }
+            r++;
         }
     }
 
@@ -313,7 +317,8 @@ int load_multiboot(FWCfgState *fw_cfg,
 
     if (initrd_filename) {
         const char *next_initrd;
-        char not_last, tmpbuf[strlen(initrd_filename) + 1];
+        char not_last;
+        char *one_file = NULL;
 
         mbs.offset_mods = mbs.mb_buf_size;
 
@@ -322,24 +327,26 @@ int load_multiboot(FWCfgState *fw_cfg,
             int mb_mod_length;
             uint32_t offs = mbs.mb_buf_size;
 
-            next_initrd = get_opt_value(tmpbuf, sizeof(tmpbuf), initrd_filename);
+            next_initrd = get_opt_value(initrd_filename, &one_file);
             not_last = *next_initrd;
             /* if a space comes after the module filename, treat everything
                after that as parameters */
-            hwaddr c = mb_add_cmdline(&mbs, tmpbuf);
-            if ((next_space = strchr(tmpbuf, ' ')))
+            hwaddr c = mb_add_cmdline(&mbs, one_file);
+            next_space = strchr(one_file, ' ');
+            if (next_space) {
                 *next_space = '\0';
-            mb_debug("multiboot loading module: %s", tmpbuf);
-            mb_mod_length = get_image_size(tmpbuf);
+            }
+            mb_debug("multiboot loading module: %s", one_file);
+            mb_mod_length = get_image_size(one_file);
             if (mb_mod_length < 0) {
-                error_report("Failed to open file '%s'", tmpbuf);
+                error_report("Failed to open file '%s'", one_file);
                 exit(1);
             }
 
             mbs.mb_buf_size = TARGET_PAGE_ALIGN(mb_mod_length + mbs.mb_buf_size);
             mbs.mb_buf = g_realloc(mbs.mb_buf, mbs.mb_buf_size);
 
-            load_image(tmpbuf, (unsigned char *)mbs.mb_buf + offs);
+            load_image(one_file, (unsigned char *)mbs.mb_buf + offs);
             mb_add_mod(&mbs, mbs.mb_buf_phys + offs,
                        mbs.mb_buf_phys + offs + mb_mod_length, c);
 
@@ -347,6 +354,8 @@ int load_multiboot(FWCfgState *fw_cfg,
                      (char *)mbs.mb_buf + offs,
                      (char *)mbs.mb_buf + offs + mb_mod_length, c);
             initrd_filename = next_initrd+1;
+            g_free(one_file);
+            one_file = NULL;
         } while (not_last);
     }
 
diff --git a/include/qemu/option.h b/include/qemu/option.h
index 1cfe5cb..3dfb449 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -28,7 +28,7 @@
 
 #include "qemu/queue.h"
 
-const char *get_opt_value(char *buf, int buf_size, const char *p);
+const char *get_opt_value(const char *p, char **value);
 
 void parse_option_size(const char *name, const char *value,
                        uint64_t *ret, Error **errp);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index fa1a9f1..58d1c23 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -70,25 +70,37 @@ static const char *get_opt_name(const char *p, char **option, char delim)
  * delimiter is fixed to be comma which starts a new option. To specify an
  * option value that contains commas, double each comma.
  */
-const char *get_opt_value(char *buf, int buf_size, const char *p)
+const char *get_opt_value(const char *p, char **value)
 {
-    char *q;
+    size_t capacity = 0, length;
+    const char *offset;
+
+    *value = NULL;
+    while (1) {
+        offset = strchr(p, ',');
+        if (!offset) {
+            offset = p + strlen(p);
+        }
 
-    q = buf;
-    while (*p != '\0') {
-        if (*p == ',') {
-            if (*(p + 1) != ',')
-                break;
-            p++;
+        length = offset - p;
+        if (*offset != '\0' && *(offset + 1) == ',') {
+            length++;
+        }
+        if (value) {
+            *value = g_renew(char, *value, capacity + length + 1);
+            strncpy(*value + capacity, p, length);
+            (*value)[capacity + length] = '\0';
+        }
+        capacity += length;
+        if (*offset == '\0' ||
+            *(offset + 1) != ',') {
+            break;
         }
-        if (q && (q - buf) < buf_size - 1)
-            *q++ = *p;
-        p++;
+
+        p += (offset - p) + 2;
     }
-    if (q)
-        *q = '\0';
 
-    return p;
+    return offset;
 }
 
 static void parse_option_bool(const char *name, const char *value, bool *ret,
@@ -162,50 +174,43 @@ void parse_option_size(const char *name, const char *value,
 
 bool has_help_option(const char *param)
 {
-    size_t buflen = strlen(param) + 1;
-    char *buf = g_malloc(buflen);
     const char *p = param;
     bool result = false;
 
-    while (*p) {
-        p = get_opt_value(buf, buflen, p);
+    while (*p && !result) {
+        char *value;
+
+        p = get_opt_value(p, &value);
         if (*p) {
             p++;
         }
 
-        if (is_help_option(buf)) {
-            result = true;
-            goto out;
-        }
+        result = is_help_option(value);
+        g_free(value);
     }
 
-out:
-    g_free(buf);
     return result;
 }
 
-bool is_valid_option_list(const char *param)
+bool is_valid_option_list(const char *p)
 {
-    size_t buflen = strlen(param) + 1;
-    char *buf = g_malloc(buflen);
-    const char *p = param;
-    bool result = true;
+    char *value = NULL;
+    bool result = false;
 
     while (*p) {
-        p = get_opt_value(buf, buflen, p);
-        if (*p && !*++p) {
-            result = false;
+        p = get_opt_value(p, &value);
+        if ((*p && !*++p) ||
+            (!*value || *value == ',')) {
             goto out;
         }
 
-        if (!*buf || *buf == ',') {
-            result = false;
-            goto out;
-        }
+        g_free(value);
+        value = NULL;
     }
 
+    result = true;
 out:
-    g_free(buf);
+    g_free(value);
     return result;
 }
 
@@ -487,7 +492,7 @@ int qemu_opt_unset(QemuOpts *opts, const char *name)
     }
 }
 
-static void opt_set(QemuOpts *opts, const char *name, const char *value,
+static void opt_set(QemuOpts *opts, const char *name, char *value,
                     bool prepend, Error **errp)
 {
     QemuOpt *opt;
@@ -496,6 +501,7 @@ static void opt_set(QemuOpts *opts, const char *name, const char *value,
 
     desc = find_desc_by_name(opts->list->desc, name);
     if (!desc && !opts_accepts_any(opts)) {
+        g_free(value);
         error_setg(errp, QERR_INVALID_PARAMETER, name);
         return;
     }
@@ -509,8 +515,7 @@ static void opt_set(QemuOpts *opts, const char *name, const char *value,
         QTAILQ_INSERT_TAIL(&opts->head, opt, next);
     }
     opt->desc = desc;
-    opt->str = g_strdup(value);
-    assert(opt->str);
+    opt->str = value;
     qemu_opt_parse(opt, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -521,7 +526,7 @@ static void opt_set(QemuOpts *opts, const char *name, const char *value,
 void qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
                   Error **errp)
 {
-    opt_set(opts, name, value, false, errp);
+    opt_set(opts, name, g_strdup(value), false, errp);
 }
 
 void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
@@ -755,7 +760,7 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname, bool prepend, Error **errp)
 {
     char *option = NULL;
-    char value[1024];
+    char *value = NULL;
     const char *p,*pe,*pc;
     Error *local_err = NULL;
 
@@ -767,15 +772,15 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
             if (p == params && firstname) {
                 /* implicitly named first option */
                 option = g_strdup(firstname);
-                p = get_opt_value(value, sizeof(value), p);
+                p = get_opt_value(p, &value);
             } else {
                 /* option without value, probably a flag */
                 p = get_opt_name(p, &option, ',');
                 if (strncmp(option, "no", 2) == 0) {
                     memmove(option, option+2, strlen(option+2)+1);
-                    pstrcpy(value, sizeof(value), "off");
+                    value = g_strdup("off");
                 } else {
-                    pstrcpy(value, sizeof(value), "on");
+                    value = g_strdup("on");
                 }
             }
         } else {
@@ -783,11 +788,12 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
             p = get_opt_name(p, &option, '=');
             assert(*p == '=');
             p++;
-            p = get_opt_value(value, sizeof(value), p);
+            p = get_opt_value(p, &value);
         }
         if (strcmp(option, "id") != 0) {
             /* store and parse */
             opt_set(opts, option, value, prepend, &local_err);
+            value = NULL;
             if (local_err) {
                 error_propagate(errp, local_err);
                 goto cleanup;
@@ -797,11 +803,13 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
             break;
         }
         g_free(option);
-        option = NULL;
+        g_free(value);
+        option = value = NULL;
     }
 
  cleanup:
     g_free(option);
+    g_free(value);
 }
 
 /**
@@ -820,7 +828,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
                             bool permit_abbrev, bool defaults, Error **errp)
 {
     const char *firstname;
-    char value[1024], *id = NULL;
+    char *id = NULL;
     const char *p;
     QemuOpts *opts;
     Error *local_err = NULL;
@@ -829,11 +837,9 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
     firstname = permit_abbrev ? list->implied_opt_name : NULL;
 
     if (strncmp(params, "id=", 3) == 0) {
-        get_opt_value(value, sizeof(value), params+3);
-        id = value;
+        get_opt_value(params + 3, &id);
     } else if ((p = strstr(params, ",id=")) != NULL) {
-        get_opt_value(value, sizeof(value), p+4);
-        id = value;
+        get_opt_value(p + 4, &id);
     }
 
     /*
@@ -845,6 +851,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
      */
     assert(!defaults || list->merge_lists);
     opts = qemu_opts_create(list, id, !defaults, &local_err);
+    g_free(id);
     if (opts == NULL) {
         error_propagate(errp, local_err);
         return NULL;
-- 
1.8.3.1
