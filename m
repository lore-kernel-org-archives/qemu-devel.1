Received: from eggs.gnu.org ([209.51.188.92]:55701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbju-0004hX-Bo
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbjt-0003xB-ET
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:46 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbjt-0003ow-5t
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:45 -0500
Received: by mail-pf1-x442.google.com with SMTP id r136so7200758pfc.6
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:31:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:38 +1100
Message-Id: <20190118213122.22865-5-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 05/49] linux-user: Tidy do_openat loop over
 fakes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Cleaner to use ARRAY_SIZE to loop over elements instead of
using a sentinel within the data structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-file.inc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index ffa70bbea8..f202a4c8f4 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -229,7 +229,6 @@ static abi_long do_openat(void *cpu_env, int dirfd, abi_ulong target_path,
         int (*fill)(void *cpu_env, int fd);
         int (*cmp)(const char *s1, const char *s2);
     };
-    const struct fake_open *fake_open;
     static const struct fake_open fakes[] = {
         { "maps", open_self_maps, is_proc_myself },
         { "stat", open_self_stat, is_proc_myself },
@@ -238,12 +237,12 @@ static abi_long do_openat(void *cpu_env, int dirfd, abi_ulong target_path,
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
         { "/proc/net/route", open_net_route, is_proc },
 #endif
-        { NULL, NULL, NULL }
     };
 
     char *pathname = lock_user_string(target_path);
     int flags = target_to_host_bitmask(target_flags, fcntl_flags_tbl);
     abi_long ret;
+    size_t i;
 
     if (!pathname) {
         return -TARGET_EFAULT;
@@ -257,17 +256,16 @@ static abi_long do_openat(void *cpu_env, int dirfd, abi_ulong target_path,
         goto done;
     }
 
-    for (fake_open = fakes; fake_open->filename; fake_open++) {
-        if (fake_open->cmp(pathname, fake_open->filename)) {
-            break;
-        }
-    }
-
-    if (fake_open->filename) {
+    for (i = 0; i < ARRAY_SIZE(fakes); ++i) {
+        const struct fake_open *fake_open = &fakes[i];
         const char *tmpdir;
         char filename[PATH_MAX];
         int fd;
 
+        if (!fake_open->cmp(pathname, fake_open->filename)) {
+            continue;
+        }
+
         /* create temporary file to map stat to */
         tmpdir = getenv("TMPDIR");
         if (!tmpdir) {
-- 
2.17.2
