Received: from eggs.gnu.org ([2001:4830:134:3::10]:50847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6u-0001GD-Ej
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6t-0005r5-Ir
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:47 -0300
Message-Id: <20170724182751.18261-32-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 31/35] syscall: replace strcpy() by
 g_strlcpy()
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

linux-user/syscall.c:9860:17: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
                strcpy (buf->machine, cpu_to_uname_machine(cpu_env));
                ^~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 963b9c8f4b..847f729834 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9853,7 +9853,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
2.13.3
