Received: from eggs.gnu.org ([2001:4830:134:3::10]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <evgreen@chromium.org>) id 1fNoIF-0002i8-N7
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <evgreen@chromium.org>) id 1fNoIE-00066c-9f
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:44:43 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <evgreen@chromium.org>)
	id 1fNoIE-00065r-10
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:44:42 -0400
Received: by mail-pg0-x242.google.com with SMTP id c9-v6so4446080pgf.5
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 16:44:41 -0700 (PDT)
From: Evan Green <evgreen@chromium.org>
Date: Tue, 29 May 2018 16:44:09 -0700
Message-Id: <20180529234409.27023-1-evgreen@chromium.org>
Subject: [Qemu-devel] [PATCH] Fix hang with -L and symlink loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Evan Green <evgreen@chromium.org>

When using -L with Linux app emulation, there is an issue in
init_paths where Qemu will get lost exploring a directory tree
with a symlink loop in it. This causes Qemu to hang, and
eventually consume all memory in the system.

Qemu's code for pre-exploring the entire directory tree is both
error-prone and slow. Instead, this changes uses faccessat, which
both avoids the symlink loop (since the entire directory space isn't
being explored up front), and likely speeds things up a bit.

Partial credit goes to Richard Henderson, as it was only after staring
at his patch [1] that I wrote mine.

[1] https://patchwork.kernel.org/patch/9512083/

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Since the path() function returns a final path, I used a thread-local
global to contain the glued-together path. From my examination of the
callers of path(), this is sufficient. The thread-localness of it may
not actually be necessary, but it seemed safer. I can remove the __thread
attribute if desired.
---
 util/path.c | 159 ++++++++----------------------------------------------------
 1 file changed, 21 insertions(+), 138 deletions(-)

diff --git a/util/path.c b/util/path.c
index 7f9fc272fb..b9a0e8ef47 100644
--- a/util/path.c
+++ b/util/path.c
@@ -4,133 +4,13 @@
    The assumption is that this area does not change.
 */
 #include "qemu/osdep.h"
-#include <sys/param.h>
-#include <dirent.h>
+#include <limits.h>
 #include "qemu/cutils.h"
 #include "qemu/path.h"
 
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
+static const char *pathprefix;
+int pathprefixfd = -1;
+__thread char gluedpath[PATH_MAX];
 
 void init_paths(const char *prefix)
 {
@@ -150,28 +30,31 @@ void init_paths(const char *prefix)
         pstrcat(pref_buf, pref_buf_len, "/");
         pstrcat(pref_buf, pref_buf_len, prefix);
         free(cwd);
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
+        prefix = strdup(pref_buf);
+        if (!prefix) {
+            abort();
+        }
     }
+
+    pathprefix = prefix;
+    pathprefixfd = open(pathprefix, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
 }
 
 /* Look for path in emulation dir, otherwise return name. */
 const char *path(const char *name)
 {
+    const char *relname;
     /* Only do absolute paths: quick and dirty, but should mostly be OK.
        Could do relative by tracking cwd. */
-    if (!base || !name || name[0] != '/')
+    if ((pathprefixfd < 0) || !name || name[0] != '/') {
         return name;
+    }
+
+    relname = name + strspn(name, "/");
+    if (faccessat(pathprefixfd, relname, R_OK, AT_EACCESS) == 0) {
+        snprintf(gluedpath, sizeof(gluedpath), "%s%s", pathprefix, name);
+        return gluedpath;
+    }
 
-    return follow_path(base, name) ?: name;
+    return name;
 }
-- 
2.13.5
