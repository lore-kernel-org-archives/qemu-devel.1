Received: from eggs.gnu.org ([2001:4830:134:3::10]:50202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0l-0003Ru-Q0
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0i-0007B9-VJ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:51 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSh0i-0007AC-MC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 12 Jun 2018 12:58:24 +0200
Message-Id: <20180612105831.25703-2-laurent@vivier.eu>
In-Reply-To: <20180612105831.25703-1-laurent@vivier.eu>
References: <20180612105831.25703-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/8] linux-user: Export use is_error(),
 use it to avoid warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This fixes:

  linux-user/flatload.c:740:9: warning: Loss of sign in implicit conversion
      if (res > (unsigned long)-4096)
          ^~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180604153722.24956-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h    | 5 +++++
 linux-user/syscall.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 6fa1e968db..793cd4df04 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -618,6 +618,11 @@ static inline void *lock_user_string(abi_ulong guest_addr)
 
 #include <pthread.h>
 
+static inline int is_error(abi_long ret)
+{
+    return (abi_ulong)ret >= (abi_ulong)(-4096);
+}
+
 /* Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
  * above, so include them last.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7b9ac3b408..2117fb13b4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -906,11 +906,6 @@ static inline abi_long get_errno(abi_long ret)
         return ret;
 }
 
-static inline int is_error(abi_long ret)
-{
-    return (abi_ulong)ret >= (abi_ulong)(-4096);
-}
-
 const char *target_strerror(int err)
 {
     if (err == TARGET_ERESTARTSYS) {
-- 
2.14.4
