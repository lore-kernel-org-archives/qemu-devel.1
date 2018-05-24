Received: from eggs.gnu.org ([2001:4830:134:3::10]:34560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLypC-0004jB-5Y
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLyp8-0004SG-Vy
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:35:10 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLyp8-0004S1-S2
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:35:06 -0400
Received: by mail-qt0-x241.google.com with SMTP id q13-v6so4227540qtp.4
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:35:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 24 May 2018 19:34:58 -0300
Message-Id: <20180524223458.5651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] gdbstub: Prevent fd leakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

Since 2f652224f7, we now check if socket_set_nodelay() errored,
but forgot to close the socket before reporting an error.

Fixes: Coverity CID 1391290 (RESOURCE_LEAK)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub.c b/gdbstub.c
index e4ece2f5bc..9c860cd81c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1836,6 +1836,7 @@ static bool gdb_accept(void)
     /* set short latency */
     if (socket_set_nodelay(fd)) {
         perror("setsockopt");
+        close(fd);
         return false;
     }
 
-- 
2.17.0
