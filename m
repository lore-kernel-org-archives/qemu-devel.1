Received: from eggs.gnu.org ([2001:4830:134:3::10]:53950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1cHTrE-0002Ij-6Q
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1cHTrA-0007dj-BH
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:05:52 -0500
From: Natanael Copa <ncopa@alpinelinux.org>
Date: Thu, 15 Dec 2016 12:04:59 +0100
Message-Id: <20161215110459.27985-1-ncopa@alpinelinux.org>
Subject: [Qemu-devel] [PATCH] linux-user: fix build with musl on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-trivial@nongnu.org, Natanael Copa <ncopa@alpinelinux.org>

Use the standard uint64_t instead of internal __u64.

This fixes compiler error with musl libc on aarch64:
.../qemu-2.7.0/linux-user/host/aarch64/hostdep.h:28:5:
error: unknown type name '__u64'
     __u64 *pcreg = &uc->uc_mcontext.pc;
     ^~~~~

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
 linux-user/host/aarch64/hostdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/host/aarch64/hostdep.h b/linux-user/host/aarch64/hostdep.h
index 64f75cef49..6fd6e36b2a 100644
--- a/linux-user/host/aarch64/hostdep.h
+++ b/linux-user/host/aarch64/hostdep.h
@@ -25,7 +25,7 @@ extern char safe_syscall_end[];
 static inline void rewind_if_in_safe_syscall(void *puc)
 {
     struct ucontext *uc = puc;
-    __u64 *pcreg = &uc->uc_mcontext.pc;
+    uint64_t *pcreg = &uc->uc_mcontext.pc;
 
     if (*pcreg > (uintptr_t)safe_syscall_start
         && *pcreg < (uintptr_t)safe_syscall_end) {
-- 
2.11.0
