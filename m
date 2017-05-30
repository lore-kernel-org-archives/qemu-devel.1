Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfP-0004xE-TQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfM-0007EK-3E
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:36 -0400
Received: from mail-he1eur01on0114.outbound.protection.outlook.com
	([104.47.0.114]:16853
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dFhfL-0007DL-R7
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:32 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 30 May 2017 16:57:56 +0300
Message-ID: <1496152683-102751-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 06/13] test-char: unref chardev-udp after
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

this is only not a problem if the test is last in a suite,
otherwise it makes the following main_loop() calls to fail

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 tests/test-char.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index f3b377f..d63d3d2 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -456,6 +456,8 @@ static void char_udp_test(void)
 
     close(sock);
     g_free(tmp);
+    qemu_chr_fe_deinit(&be);
+    object_unparent(OBJECT(chr));
 }
 
 static void char_file_test(void)
-- 
2.7.4
