Received: from eggs.gnu.org ([2001:4830:134:3::10]:50709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6c-0000wE-UD
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6c-0005cA-4i
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:41 -0300
Message-Id: <20170724182751.18261-26-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 25/35] linux-user: extract is_error()
 out of syscall.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/qemu.h    | 5 +++++
 linux-user/syscall.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4edd7d0c08..97b7cfdb63 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -614,6 +614,11 @@ static inline void *lock_user_string(abi_ulong guest_addr)
 
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
index 003943b736..fcd20fa276 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -837,11 +837,6 @@ static inline abi_long get_errno(abi_long ret)
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
2.13.3
