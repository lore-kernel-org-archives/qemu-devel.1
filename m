Received: from eggs.gnu.org ([2001:4830:134:3::10]:50789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6m-00016u-1Y
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6l-0005hu-4a
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:32 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6l-0005hj-0t
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:31 -0400
Received: by mail-qk0-x243.google.com with SMTP id q130so10666159qka.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:29:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:44 -0300
Message-Id: <20170724182751.18261-29-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 28/35] syscall: check dup/dup2/dup3()
 errors, return EBADFD/EINVAL if required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Linux dup(2) manpage:

ERRORS
  EBADF
    newfd is out of the allowed range for file descriptors (like negative)
  EINVAL (dup3())
    oldfd was equal to newfd

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/syscall.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e79b5baec4..637270a02d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8336,9 +8336,13 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
     case TARGET_NR_dup:
-        ret = get_errno(dup(arg1));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, ret);
+        if (arg1 < 0) {
+            ret = -TARGET_EBADFD;
+        } else {
+            ret = get_errno(dup(arg1));
+            if (ret >= 0) {
+                fd_trans_dup(arg1, ret);
+            }
         }
         break;
 #ifdef TARGET_NR_pipe
@@ -8436,17 +8440,27 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_dup2
     case TARGET_NR_dup2:
-        ret = get_errno(dup2(arg1, arg2));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, arg2);
+        if (arg1 < 0 || arg2 < 0) {
+            ret = -TARGET_EBADFD;
+        } else {
+            ret = get_errno(dup2(arg1, arg2));
+            if (ret >= 0) {
+                fd_trans_dup(arg1, arg2);
+            }
         }
         break;
 #endif
 #if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
     case TARGET_NR_dup3:
-        ret = get_errno(dup3(arg1, arg2, arg3));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, arg2);
+        if (arg1 < 0 || arg2 < 0) {
+            ret = -TARGET_EBADFD;
+        } else if (arg1 == arg2) {
+            ret = -TARGET_EINVAL;
+        } else {
+            ret = get_errno(dup3(arg1, arg2, arg3));
+            if (ret >= 0) {
+                fd_trans_dup(arg1, arg2);
+            }
         }
         break;
 #endif
-- 
2.13.3
