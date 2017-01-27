Received: from eggs.gnu.org ([2001:4830:134:3::10]:44420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1cXBNZ-0007mR-VI
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1cXBNW-0006ke-Qd
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:36:10 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1cXBNW-0006k8-Lq
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:36:06 -0500
Received: by mail-pf0-x241.google.com with SMTP id 19so19024039pfo.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 10:36:05 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 27 Jan 2017 10:31:31 -0800
Message-Id: <20170127183131.6868-1-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH] util/path: Always translate /etc/ld.so.cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Always translate /etc/ld.so.cache to point somwhere inside of guest's
filesystem tree pointed to by 'prefix'. This prevents guest's libc from
reading /etc/ld.so.cache of the host and potentialy failing. One of the
manifestation of the problem could be easily reproduced by executing and
simple application compiled for PowerPC on a x86 host using
linux-use/qemu-ppc emulation.

Anything as simple as:

	 qemu-ppc -L <prefix> <prefix>/bin/ls

should trigger the problem.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 util/path.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/util/path.c b/util/path.c
index 5479f76..cc28bff 100644
--- a/util/path.c
+++ b/util/path.c
@@ -108,8 +108,8 @@ static void set_parents(struct pathelem *child, struct pathelem *parent)
 }
 
 /* FIXME: Doesn't handle DIR/.. where DIR is not in emulated dir. */
-static const char *
-follow_path(const struct pathelem *cursor, const char *name)
+static struct pathelem *
+follow_path(struct pathelem *cursor, const char *name)
 {
     unsigned int i, namelen;
 
@@ -117,7 +117,7 @@ follow_path(const struct pathelem *cursor, const char *name)
     namelen = strcspn(name, "/");
 
     if (namelen == 0)
-        return cursor->pathname;
+        return cursor;
 
     if (strneq(name, namelen, ".."))
         return follow_path(cursor->parent, name + namelen);
@@ -133,9 +133,28 @@ follow_path(const struct pathelem *cursor, const char *name)
     return NULL;
 }
 
+
+static void append_entry(struct pathelem *cursor,
+                         const char *name, unsigned type)
+{
+    size_t i;
+    struct pathelem *parent;
+
+    parent = cursor->parent;
+
+    for (i = 0; i < parent->num_entries; i++) {
+        if (parent->entries[i] == cursor) {
+            break;
+        }
+    }
+
+    parent->entries[i] = add_entry(cursor, name, type);
+}
+
 void init_paths(const char *prefix)
 {
     char pref_buf[PATH_MAX];
+    struct pathelem *cursor;
 
     if (prefix[0] == '\0' ||
         !strcmp(prefix, "/"))
@@ -164,15 +183,41 @@ void init_paths(const char *prefix)
     } else {
         set_parents(base, base);
     }
+
+    /*
+     * libc does not necessarily handle reading host's ld.so.cache
+     * well (e.g. running PowerPC code on x86, or, very likely any
+     * mixed endian combination)
+     *
+     * So check if guest's prefix "tree" provides ld.so.cache and if
+     * not add a fake translation entry, so as to prevent guest's libc
+     * request to /etc/ld.so.cache to resolve into host's
+     * /etc/ld.so.cache
+     */
+    cursor = follow_path(base, "/etc/ld.so.cache");
+    if (!cursor) {
+        cursor = follow_path(base, "/etc/");
+        if (!cursor) {
+            cursor = follow_path(base, "/");
+            append_entry(cursor, "etc", DT_DIR);
+            cursor = follow_path(base, "/etc/");
+        }
+
+        append_entry(cursor, "ld.so.cache", DT_REG);
+    }
 }
 
 /* Look for path in emulation dir, otherwise return name. */
 const char *path(const char *name)
 {
+    struct pathelem *cursor;
+
     /* Only do absolute paths: quick and dirty, but should mostly be OK.
        Could do relative by tracking cwd. */
     if (!base || !name || name[0] != '/')
         return name;
 
-    return follow_path(base, name) ?: name;
+    cursor = follow_path(base, name);
+
+    return cursor ? cursor->pathname : name;
 }
-- 
2.9.3
