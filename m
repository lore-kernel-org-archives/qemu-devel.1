Received: from eggs.gnu.org ([2001:4830:134:3::10]:38998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHp-0002AD-Qs
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHo-0005yc-OA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:45 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHo-0005xh-Dl
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:44 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:19:59 +0200
Message-Id: <20180604152015.13359-2-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/17] syscall: replace strcpy() by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

linux-user/syscall.c:9860:17: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
                strcpy (buf->machine, cpu_to_uname_machine(cpu_env));
                ^~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20170724182751.18261-32-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d02c16bbc6..7b9ac3b408 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10156,7 +10156,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             if (!is_error(ret)) {
                 /* Overwrite the native machine name with whatever is being
                    emulated. */
-                strcpy (buf->machine, cpu_to_uname_machine(cpu_env));
+                g_strlcpy(buf->machine, cpu_to_uname_machine(cpu_env),
+                          sizeof(buf->machine));
                 /* Allow the user to override the reported release.  */
                 if (qemu_uname_release && *qemu_uname_release) {
                     g_strlcpy(buf->release, qemu_uname_release,
-- 
2.14.3
