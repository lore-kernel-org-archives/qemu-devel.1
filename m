Received: from eggs.gnu.org ([2001:4830:134:3::10]:54400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYl9-0005En-Ec
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYl8-0007gC-PM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:42:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:08 -0300
Message-Id: <20170727024224.22900-4-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 03/20] ivshmem: fix incorrect error
 handling in ivshmem_recv_msg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Screwed up in commit 3a55fc0f, v2.6.0.

If qemu_chr_fe_read_all() returns -EINTR the do {} statement continues and the
n accumulator used to complete reads upto sizeof(msg) is decremented by 4 (the
value of EINTR on Linux).
To avoid that, use simpler if() statements and continue if EINTR occured.

hw/misc/ivshmem.c:650:14: warning: Loss of sign in implicit conversion
    } while (n < sizeof(msg));
             ^

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/ivshmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index a58f9ee579..47a015f072 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -642,7 +642,10 @@ static int64_t ivshmem_recv_msg(IVShmemState *s, int *pfd, Error **errp)
     do {
         ret = qemu_chr_fe_read_all(&s->server_chr, (uint8_t *)&msg + n,
                                    sizeof(msg) - n);
-        if (ret < 0 && ret != -EINTR) {
+        if (ret < 0) {
+            if (ret == -EINTR) {
+                continue;
+            }
             error_setg_errno(errp, -ret, "read from server failed");
             return INT64_MIN;
         }
-- 
2.13.3
