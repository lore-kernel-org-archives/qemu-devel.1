Received: from eggs.gnu.org ([2001:4830:134:3::10]:43523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKp-0006r5-6w
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKm-0008So-1U
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:59 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faIKl-0008SH-QC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:55 -0400
Received: by mail-wr0-x235.google.com with SMTP id k7-v6so1371274wrq.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:14:55 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:34 +0100
Message-Id: <20180703101444.23778-11-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/20] linux-user: add gcov support to
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
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

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
