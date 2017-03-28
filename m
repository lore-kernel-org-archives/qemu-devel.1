Received: from eggs.gnu.org ([2001:4830:134:3::10]:48420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0S-0004Gz-4K
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0O-000378-S1
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:44 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csp0O-00035a-Ko
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:40 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l43so98993064wre.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:09:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 12:09:32 +0100
Message-Id: <20170328110936.24806-3-alex.bennee@linaro.org>
In-Reply-To: <20170328110936.24806-1-alex.bennee@linaro.org>
References: <20170328110936.24806-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/6] bsd-user: align use of mmap_lock to that of
 linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The introduction of stricter mmap_lock checking in translate-all broke
the BSD user build. The working mmap_lock functions were hidden behind
CONFIG_USE_NPTL which is never defined. This patch brings them inline
with linux-user.

Despite the disapearence of the comment "We aren't threadsafe to start
with..." this doesn't make bsd-user so. It will still need the rest of
the fixes that have been done in linux-user ported over.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/mmap.c | 13 +------------
 bsd-user/qemu.h |  2 --
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 1ad018a127..7f2018ede0 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -24,8 +24,7 @@
 
 //#define DEBUG_MMAP
 
-#if defined(CONFIG_USE_NPTL)
-pthread_mutex_t mmap_mutex;
+static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
 static int __thread mmap_lock_count;
 
 void mmap_lock(void)
@@ -62,16 +61,6 @@ void mmap_fork_end(int child)
     else
         pthread_mutex_unlock(&mmap_mutex);
 }
-#else
-/* We aren't threadsafe to start with, so no need to worry about locking.  */
-void mmap_lock(void)
-{
-}
-
-void mmap_unlock(void)
-{
-}
-#endif
 
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int prot)
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 2b2b9184e0..b550cee0cb 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -209,10 +209,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_addr);
 int target_msync(abi_ulong start, abi_ulong len, int flags);
 extern unsigned long last_brk;
-#if defined(CONFIG_USE_NPTL)
 void mmap_fork_start(void);
 void mmap_fork_end(int child);
-#endif
 
 /* main.c */
 extern unsigned long x86_stack_size;
-- 
2.11.0
