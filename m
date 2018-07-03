Received: from eggs.gnu.org ([2001:4830:134:3::10]:33278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <decatf@gmail.com>) id 1faLWE-0001C7-5M
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <decatf@gmail.com>) id 1faLWA-0001bW-50
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:38:58 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:40436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <decatf@gmail.com>) id 1faLW9-0001bI-V4
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:38:54 -0400
Received: by mail-io0-x232.google.com with SMTP id t135-v6so1732962iof.7
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 06:38:53 -0700 (PDT)
Date: Tue, 3 Jul 2018 09:38:49 -0400
From: ryang <decatf@gmail.com>
Message-ID: <20180703133849.GA11719@computer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2] module: Use QEMU_MODULE_PATH as a search
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

The current paths for modules are CONFIG_QEMU_MODDIR and paths relative
to the executable. Qemu and its modules can be installed and executed in
paths that are different from these search paths. This change allows
a search path to be specified by environment variable.

An example usage for this is postmarketOS[1]. This is a build environment
for Alpine Linux. It sets up Alpine Linux in a chroot environment.
Alpine's Qemu packages are installed in the chroot. The Alpine Linux Qemu
package is used to test compiled Alpine Linux system images. This way there
isn't a reliance on the which ever version of Qemu the host system / distro
provides.

postmarketOS executes Qemu on host system outside of the chroot
The Qemu module search path needs to point to the location of the
chroot relative to the host system.

e.g.
The root of the Alpine Linux chroot is:
~/.local/var/pmbootstrap/chroot_native/

Alpine's Qemu is installed at
~/.local/var/pmbootstrap/chroot_native/usr/bin/

The Qemu module search path needs to be:
QEMU_MODULE_PATH=~/.local/var/pmbootstrap/chroot_native/usr/lib/qemu/

[1] https://postmarketos.org/

Signed-off-by: ryang <decatf@gmail.com>
---

v2:
 - fix checkpatch errors

 util/module.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/util/module.c b/util/module.c
index c909737..9dab700 100644
--- a/util/module.c
+++ b/util/module.c
@@ -162,9 +162,10 @@ void module_load_one(const char *prefix, const char *lib_name)
 #ifdef CONFIG_MODULES
     char *fname = NULL;
     char *exec_dir;
-    char *dirs[3];
+    char *search_path;
+    char *dirs[4];
     char *module_name;
-    int i = 0;
+    int i = 0, n_dirs;
     int ret;
     static GHashTable *loaded_modules;
 
@@ -186,14 +187,19 @@ void module_load_one(const char *prefix, const char *lib_name)
     g_hash_table_insert(loaded_modules, module_name, module_name);
 
     exec_dir = qemu_get_exec_dir();
-    dirs[i++] = g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
-    dirs[i++] = g_strdup_printf("%s/..", exec_dir ? : "");
-    dirs[i++] = g_strdup_printf("%s", exec_dir ? : "");
-    assert(i == ARRAY_SIZE(dirs));
+    search_path = getenv("QEMU_MODULE_PATH");
+    if (search_path != NULL) {
+        dirs[n_dirs++] = g_strdup_printf("%s", search_path);
+    }
+    dirs[n_dirs++] = g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
+    dirs[n_dirs++] = g_strdup_printf("%s/..", exec_dir ? : "");
+    dirs[n_dirs++] = g_strdup_printf("%s", exec_dir ? : "");
+    assert(n_dirs <= ARRAY_SIZE(dirs));
+
     g_free(exec_dir);
     exec_dir = NULL;
 
-    for (i = 0; i < ARRAY_SIZE(dirs); i++) {
+    for (i = 0; i < n_dirs; i++) {
         fname = g_strdup_printf("%s/%s%s",
                 dirs[i], module_name, HOST_DSOSUF);
         ret = module_load_file(fname);
@@ -205,7 +211,7 @@ void module_load_one(const char *prefix, const char *lib_name)
         }
     }
 
-    for (i = 0; i < ARRAY_SIZE(dirs); i++) {
+    for (i = 0; i < n_dirs; i++) {
         g_free(dirs[i]);
     }
 
-- 
2.7.4
