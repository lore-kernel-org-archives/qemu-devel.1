Received: from eggs.gnu.org ([2001:4830:134:3::10]:50810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6o-00019e-Nw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6n-0005jt-U8
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:45 -0300
Message-Id: <20170724182751.18261-30-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 29/35] syscall: fix out-of-bound
 memory access
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

linux-user/syscall.c:555:25: warning: Out of bound memory access (accessed memory precedes memory block)
    target_fd_trans[fd] = trans;
    ~~~~~~~~~~~~~~~~~~~~^~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 637270a02d..26450d235f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -544,6 +544,7 @@ static void fd_trans_register(int fd, TargetFdTrans *trans)
 {
     unsigned int oldmax;
 
+    assert(fd >= 0);
     if (fd >= target_fd_max) {
         oldmax = target_fd_max;
         target_fd_max = ((fd >> 6) + 1) << 6; /* by slice of 64 entries */
-- 
2.13.3
