Received: from eggs.gnu.org ([2001:4830:134:3::10]:39246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrI7-0002Pu-4r
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrI3-0006H9-SH
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:21:03 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrI3-0006Go-MB
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:59 -0400
Received: by mail-qt0-x243.google.com with SMTP id l33-v6so4021173qta.11
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:20:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  4 Jun 2018 12:20:46 -0300
Message-Id: <20180604152047.24146-2-f4bug@amsat.org>
In-Reply-To: <20180604152047.24146-1-f4bug@amsat.org>
References: <20180604152047.24146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RESEND 1/2] linux-user: Export use is_error(),
 use it to avoid warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

This fixes:

  linux-user/flatload.c:740:9: warning: Loss of sign in implicit conversion
      if (res > (unsigned long)-4096)
          ^~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h    | 5 +++++
 linux-user/syscall.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index c55c8e294b..4eeffe3c76 100644
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
index d02c16bbc6..5e122dbdda 100644
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
2.17.1
