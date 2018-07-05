Received: from eggs.gnu.org ([2001:4830:134:3::10]:54903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jQ-0008QY-N6
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jP-000831-2n
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6jO-00082c-Rs
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id q10-v6so1472605wrd.4
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:03:42 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:20 +0100
Message-Id: <20180705160329.30386-12-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 11/20] linux-user: add gcov support to
 preexit_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

As we don't always take the normal exit path when running a guest we
can skip the normal exit destructors where gcov normally dumps it's
info. The GCC manual suggests long running programs use __gcov_dump()
to flush out the coverage state periodically so we use that here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/linux-user/exit.c b/linux-user/exit.c
index aed8713fae..14e94e28fa 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -19,10 +19,17 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 
+#ifdef CONFIG_GCOV
+extern void __gcov_dump(void);
+#endif
+
 void preexit_cleanup(CPUArchState *env, int code)
 {
 #ifdef TARGET_GPROF
         _mcleanup();
+#endif
+#ifdef CONFIG_GCOV
+        __gcov_dump();
 #endif
         gdb_exit(env, code);
 }
-- 
2.17.1
