Received: from eggs.gnu.org ([2001:4830:134:3::10]:50094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5i-0008Fz-7w
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5f-0004kF-JC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:26 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5f-0004kB-F0
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:23 -0400
Received: by mail-qk0-x241.google.com with SMTP id q130so10663079qka.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:28:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:20 -0300
Message-Id: <20170724182751.18261-5-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 04/35] ivshmem: fix incorrect error
 handling in ivshmem_recv_msg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

If qemu_chr_fe_read_all() returns -EINTR the do {} statement continues and the
n accumulator used to complete reads upto sizeof(msg) is decremented by 4 (the
value of EINTR on Linux).
To avoid that, use simpler if() statements and continue if EINTR occured.

hw/misc/ivshmem.c:650:14: warning: Loss of sign in implicit conversion
    } while (n < sizeof(msg));
             ^

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
get_maintainer.pl: No maintainers found!

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
