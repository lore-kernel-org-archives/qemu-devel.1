Received: from eggs.gnu.org ([2001:4830:134:3::10]:54893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlg-0005jI-RG
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYle-00088a-UI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:18 -0300
Message-Id: <20170727024224.22900-14-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 13/20] syscall: fix use of
 uninitialized values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

linux-user/syscall.c:1627:35: warning: 1st function call argument is an uninitialized value
        target_saddr->sa_family = tswap16(addr->sa_family);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~
linux-user/syscall.c:1629:25: warning: The left operand of '==' is a garbage value
    if (addr->sa_family == AF_NETLINK && len >= sizeof(struct sockaddr_nl)) {
        ~~~~~~~~~~~~~~~ ^

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 71d45a9963..81f52f7483 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1622,6 +1622,7 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
     if (len == 0) {
         return 0;
     }
+    assert(addr);
 
     target_saddr = lock_user(VERIFY_WRITE, target_addr, len, 0);
     if (!target_saddr)
-- 
2.13.3
