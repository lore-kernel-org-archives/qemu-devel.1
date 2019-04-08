Received: from eggs.gnu.org ([209.51.188.92]:44291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5E-00025w-2W
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5D-000781-7D
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hDa5C-00077Y-RL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:31 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  8 Apr 2019 21:37:10 +0200
Message-Id: <20190408193711.32680-2-laurent@vivier.eu>
In-Reply-To: <20190408193711.32680-1-laurent@vivier.eu>
References: <20190408193711.32680-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] linux-user: assume __NR_gettid always exists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The gettid syscall was introduced in Linux 2.4.11. This is old enough
that we can assume it always exists and thus not bother with the
conditional backcompat logic.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190320161842.13908-2-berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 208fd1813d6a..11729f382cf4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -249,15 +249,7 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define TARGET_NR__llseek TARGET_NR_llseek
 #endif
 
-#ifdef __NR_gettid
 _syscall0(int, gettid)
-#else
-/* This is a replacement for the host gettid() and must return a host
-   errno. */
-static int gettid(void) {
-    return -ENOSYS;
-}
-#endif
 
 /* For the 64-bit guest on 32-bit host case we must emulate
  * getdents using getdents64, because otherwise the host
-- 
2.20.1
