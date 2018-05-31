Received: from eggs.gnu.org ([2001:4830:134:3::10]:38488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNi-00056J-EY
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNg-0000k1-9P
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:18 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:38598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOWNg-0000jV-3I
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:16 -0400
Received: by mail-pg0-x22a.google.com with SMTP id c9-v6so7528196pgf.5
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 15:49:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 May 2018 15:49:06 -0700
Message-Id: <20180531224911.23725-2-richard.henderson@linaro.org>
In-Reply-To: <20180531224911.23725-1-richard.henderson@linaro.org>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/6] gdbstub: Return the fd from gdbserver_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

This will allow us to protect gdbserver_fd from the guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 6081e719c5..057d0d65c5 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1890,15 +1890,16 @@ static int gdbserver_open(int port)
 int gdbserver_start(int port)
 {
     gdbserver_fd = gdbserver_open(port);
-    if (gdbserver_fd < 0)
+    if (gdbserver_fd < 0) {
         return -1;
+    }
     /* accept connections */
     if (!gdb_accept()) {
         close(gdbserver_fd);
         gdbserver_fd = -1;
         return -1;
     }
-    return 0;
+    return gdbserver_fd;
 }
 
 /* Disable gdb stub for child processes.  */
-- 
2.17.0
