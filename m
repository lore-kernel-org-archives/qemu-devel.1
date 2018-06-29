Received: from eggs.gnu.org ([2001:4830:134:3::10]:56287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nu-0008CX-To
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nq-0006Xc-6a
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:50 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:34176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZ0Np-0006W2-VR
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:46 -0400
Received: by mail-wm0-x232.google.com with SMTP id l15-v6so2882227wmc.1
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:52:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 29 Jun 2018 21:52:21 +0100
Message-Id: <20180629205232.27190-11-alex.bennee@linaro.org>
In-Reply-To: <20180629205232.27190-1-alex.bennee@linaro.org>
References: <20180629205232.27190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/21] linux-user: add gcov support to
 preexit_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

As we don't always take the normal exit path when running a guest we
can skip the normal exit destructors where gcov normally dumps it's
info. The GCC manual suggests long running programs use __gcov_dump()
to flush out the coverage state periodically so we use that here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/exit.c | 7 +++++++
 1 file changed, 7 insertions(+)

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
