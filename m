Received: from eggs.gnu.org ([2001:4830:134:3::10]:45991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1er8vk-0005ZX-Gz
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1er8vj-0000MK-Io
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:28 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1er8vj-0000KV-9W
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:27 -0500
Received: by mail-lf0-x244.google.com with SMTP id y19so5626995lfd.4
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 13:06:27 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 13:06:07 -0800
Message-Id: <20180228210616.2756-3-jcmvbkbc@gmail.com>
In-Reply-To: <20180228210616.2756-1-jcmvbkbc@gmail.com>
References: <20180228210616.2756-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 02/11] target/xtensa: mark register windows in
 the dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Add arrows that mark beginning of register windows and position of the
current window in the windowed register file.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 3ad86d4508e4..5969d7c3cd96 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1219,8 +1219,13 @@ void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
     cpu_fprintf(f, "\n");
 
     for (i = 0; i < env->config->nareg; ++i) {
-        cpu_fprintf(f, "AR%02d=%08x%c", i, env->phys_regs[i],
-                (i % 4) == 3 ? '\n' : ' ');
+        cpu_fprintf(f, "AR%02d=%08x ", i, env->phys_regs[i]);
+        if (i % 4 == 3) {
+            bool ws = (env->sregs[WINDOW_START] & (1 << (i / 4))) != 0;
+            bool cw = env->sregs[WINDOW_BASE] == i / 4;
+
+            cpu_fprintf(f, "%c%c\n", ws ? '<' : ' ', cw ? '=' : ' ');
+        }
     }
 
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
-- 
2.11.0
