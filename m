Received: from eggs.gnu.org ([2001:4830:134:3::10]:50686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6b-0000uh-DY
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6Z-0005ab-Cn
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:40 -0300
Message-Id: <20170724182751.18261-25-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 24/35] linux-user/sh4: fix incorrect
 memory write
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

not hit since 2009! :)

linux-user/elfload.c:1102:20: warning: Out of bound memory access (access exceeds upper limit of memory block)
        (*regs[i]) = tswap32(env->gregs[i]);
        ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2a902f7806..79062882ba 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1099,7 +1099,7 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
     int i;
 
     for (i = 0; i < 16; i++) {
-        (*regs[i]) = tswapreg(env->gregs[i]);
+        (*regs)[i] = tswapreg(env->gregs[i]);
     }
 
     (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
-- 
2.13.3
