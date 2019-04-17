Received: from eggs.gnu.org ([209.51.188.92]:51346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGdBV-0007vy-MS
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGdBT-0002ge-Ok
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:32:37 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGdBQ-0002dl-4c
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:32:33 -0400
Received: by mail-pf1-x441.google.com with SMTP id 188so11528350pfd.8
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 22:32:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Apr 2019 19:32:25 -1000
Message-Id: <20190417053225.27505-2-richard.henderson@linaro.org>
In-Reply-To: <20190417053225.27505-1-richard.henderson@linaro.org>
References: <20190417053225.27505-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/1] util/path: Do not cache all filenames at
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, evgreen@chromium.org, peter.maydell@linaro.org

If one uses -L $PATH to point to a full chroot, the startup time
is significant.  In addition, the existing probing algorithm fails
to handle symlink loops.

Instead, probe individual paths on demand.  Cache both positive
and negative results within $PATH, so that any one filename is
probed only once.

Use glib filename functions for clarity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/path.c | 211 ++++++++++++++--------------------------------------
 1 file changed, 57 insertions(+), 154 deletions(-)

diff --git a/util/path.c b/util/path.c
index 7f9fc272fb..09f75f100a 100644
--- a/util/path.c
+++ b/util/path.c
@@ -8,170 +8,73 @@
 #include <dirent.h>
 #include "qemu/cutils.h"
 #include "qemu/path.h"
+#include "qemu/thread.h"
 
-struct pathelem
-{
-    /* Name of this, eg. lib */
-    char *name;
-    /* Full path name, eg. /usr/gnemul/x86-linux/lib. */
-    char *pathname;
-    struct pathelem *parent;
-    /* Children */
-    unsigned int num_entries;
-    struct pathelem *entries[0];
-};
-
-static struct pathelem *base;
-
-/* First N chars of S1 match S2, and S2 is N chars long. */
-static int strneq(const char *s1, unsigned int n, const char *s2)
-{
-    unsigned int i;
-
-    for (i = 0; i < n; i++)
-        if (s1[i] != s2[i])
-            return 0;
-    return s2[i] == 0;
-}
-
-static struct pathelem *add_entry(struct pathelem *root, const char *name,
-                                  unsigned type);
-
-static struct pathelem *new_entry(const char *root,
-                                  struct pathelem *parent,
-                                  const char *name)
-{
-    struct pathelem *new = g_malloc(sizeof(*new));
-    new->name = g_strdup(name);
-    new->pathname = g_strdup_printf("%s/%s", root, name);
-    new->num_entries = 0;
-    return new;
-}
-
-#define streq(a,b) (strcmp((a), (b)) == 0)
-
-/* Not all systems provide this feature */
-#if defined(DT_DIR) && defined(DT_UNKNOWN) && defined(DT_LNK)
-# define dirent_type(dirent) ((dirent)->d_type)
-# define is_dir_maybe(type) \
-    ((type) == DT_DIR || (type) == DT_UNKNOWN || (type) == DT_LNK)
-#else
-# define dirent_type(dirent) (1)
-# define is_dir_maybe(type)  (type)
-#endif
-
-static struct pathelem *add_dir_maybe(struct pathelem *path)
-{
-    DIR *dir;
-
-    if ((dir = opendir(path->pathname)) != NULL) {
-        struct dirent *dirent;
-
-        while ((dirent = readdir(dir)) != NULL) {
-            if (!streq(dirent->d_name,".") && !streq(dirent->d_name,"..")){
-                path = add_entry(path, dirent->d_name, dirent_type(dirent));
-            }
-        }
-        closedir(dir);
-    }
-    return path;
-}
-
-static struct pathelem *add_entry(struct pathelem *root, const char *name,
-                                  unsigned type)
-{
-    struct pathelem **e;
-
-    root->num_entries++;
-
-    root = g_realloc(root, sizeof(*root)
-                   + sizeof(root->entries[0])*root->num_entries);
-    e = &root->entries[root->num_entries-1];
-
-    *e = new_entry(root->pathname, root, name);
-    if (is_dir_maybe(type)) {
-        *e = add_dir_maybe(*e);
-    }
-
-    return root;
-}
-
-/* This needs to be done after tree is stabilized (ie. no more reallocs!). */
-static void set_parents(struct pathelem *child, struct pathelem *parent)
-{
-    unsigned int i;
-
-    child->parent = parent;
-    for (i = 0; i < child->num_entries; i++)
-        set_parents(child->entries[i], child);
-}
-
-/* FIXME: Doesn't handle DIR/.. where DIR is not in emulated dir. */
-static const char *
-follow_path(const struct pathelem *cursor, const char *name)
-{
-    unsigned int i, namelen;
-
-    name += strspn(name, "/");
-    namelen = strcspn(name, "/");
-
-    if (namelen == 0)
-        return cursor->pathname;
-
-    if (strneq(name, namelen, ".."))
-        return follow_path(cursor->parent, name + namelen);
-
-    if (strneq(name, namelen, "."))
-        return follow_path(cursor, name + namelen);
-
-    for (i = 0; i < cursor->num_entries; i++)
-        if (strneq(name, namelen, cursor->entries[i]->name))
-            return follow_path(cursor->entries[i], name + namelen);
-
-    /* Not found */
-    return NULL;
-}
+static const char *base;
+static GHashTable *hash;
+static QemuMutex lock;
 
 void init_paths(const char *prefix)
 {
-    char pref_buf[PATH_MAX];
-
-    if (prefix[0] == '\0' ||
-        !strcmp(prefix, "/"))
+    if (prefix[0] == '\0' || !strcmp(prefix, "/")) {
         return;
-
-    if (prefix[0] != '/') {
-        char *cwd = getcwd(NULL, 0);
-        size_t pref_buf_len = sizeof(pref_buf);
-
-        if (!cwd)
-            abort();
-        pstrcpy(pref_buf, sizeof(pref_buf), cwd);
-        pstrcat(pref_buf, pref_buf_len, "/");
-        pstrcat(pref_buf, pref_buf_len, prefix);
-        free(cwd);
-    } else
-        pstrcpy(pref_buf, sizeof(pref_buf), prefix + 1);
-
-    base = new_entry("", NULL, pref_buf);
-    base = add_dir_maybe(base);
-    if (base->num_entries == 0) {
-        g_free(base->pathname);
-        g_free(base->name);
-        g_free(base);
-        base = NULL;
-    } else {
-        set_parents(base, base);
     }
+
+#if GLIB_CHECK_VERSION(2, 58, 0)
+    base = g_canonicalize_filename(prefix, NULL);
+#else
+    if (prefix[0] != '/') {
+        char *cwd = g_get_current_dir();
+        base = g_build_filename(cwd, prefix, NULL);
+        g_free(cwd);
+    } else {
+        base = g_strdup(prefix);
+    }
+#endif
+
+    hash = g_hash_table_new(g_str_hash, g_str_equal);
+    qemu_mutex_init(&lock);
 }
 
 /* Look for path in emulation dir, otherwise return name. */
 const char *path(const char *name)
 {
-    /* Only do absolute paths: quick and dirty, but should mostly be OK.
-       Could do relative by tracking cwd. */
-    if (!base || !name || name[0] != '/')
-        return name;
+    gpointer key, value;
+    char *ret;
 
-    return follow_path(base, name) ?: name;
+    /* Only do absolute paths: quick and dirty, but should mostly be OK.  */
+    if (!base || !name || name[0] != '/') {
+        return name;
+    }
+
+    qemu_mutex_lock(&lock);
+
+    /* Have we looked up this file before?  */
+    if (g_hash_table_lookup_extended(hash, name, &key, &value)) {
+        ret = value ? value : name;
+    } else {
+        char *full_name, *save_name;
+
+        save_name = g_strdup(name);
+#if GLIB_CHECK_VERSION(2, 58, 0)
+        full_name = g_canonicalize_filename(g_path_skip_root(name), base);
+#else
+        full_name = g_build_filename(base, name, NULL);
+#endif
+
+        /* Look for the path; record the result, pass or fail.  */
+        if (access(full_name, F_OK) == 0) {
+            /* Exists.  */
+            g_hash_table_insert(hash, save_name, full_name);
+            ret = full_name;
+        } else {
+            /* Does not exist.  */
+            g_free(full_name);
+            g_hash_table_insert(hash, save_name, NULL);
+            ret = name;
+        }
+    }
+
+    qemu_mutex_unlock(&lock);
+    return ret;
 }
-- 
2.17.1
