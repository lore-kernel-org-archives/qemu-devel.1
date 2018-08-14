Received: from eggs.gnu.org ([2001:4830:134:3::10]:41212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpfGR-00028K-Kk
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpfGC-0007L0-2R
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:45:59 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fpfGB-0007JQ-Li
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:45:43 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 14 Aug 2018 21:45:19 +0200
Message-Id: <20180814194520.22458-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/2] linux-user: add pseudo /proc/cpuinfo for
 sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

SPARC libc6 debian package wants to check the cpu level to be
installed or not:

  WARNING: This machine has a SPARC V8 or earlier class processor.
  Debian lenny and later does not support such old hardware
  any longer.

To avoid this, it only needs to know if the machine type is sun4u or sun4v,
for that it reads the information from /proc/cpuinfo.

Fixes: 9a93c152fcdb4ab2cd85094487b33578fd693915
       ("linux-user: fix UNAME_MACHINE for sparc/sparc64")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dfc851cc35..5850aba5be 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7745,12 +7745,15 @@ static int is_proc_myself(const char *filename, const char *entry)
     return 0;
 }
 
-#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
+#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
+    defined(TARGET_SPARC)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) == 0;
 }
+#endif
 
+#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
 static int open_net_route(void *cpu_env, int fd)
 {
     FILE *fp;
@@ -7789,6 +7792,14 @@ static int open_net_route(void *cpu_env, int fd)
 }
 #endif
 
+#if defined(TARGET_SPARC)
+static int open_cpuinfo(void *cpu_env, int fd)
+{
+    dprintf(fd, "type\t\t: sun4u\n");
+    return 0;
+}
+#endif
+
 static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags, mode_t mode)
 {
     struct fake_open {
@@ -7804,6 +7815,9 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
         { "cmdline", open_self_cmdline, is_proc_myself },
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
         { "/proc/net/route", open_net_route, is_proc },
+#endif
+#if defined(TARGET_SPARC)
+        { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
         { NULL, NULL, NULL }
     };
-- 
2.17.1
