Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVV-0004ue-2j
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVU-0006LO-4A
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:53 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVT-0006Ke-TK
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:52 -0500
Received: by mail-wr0-x243.google.com with SMTP id z12so20914668wrg.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:10 +0100
Message-Id: <1520342370-123606-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/34] chardev: fix leak in
 tcp_chr_telnet_init_io()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Need to free TCPChardevTelnetInit when session established.

Since at it, switch to use G_SOURCE_* macros.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180301084438.13594-2-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 22f6597..8401aae 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -592,19 +592,23 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
             ret = 0;
         } else {
             tcp_chr_disconnect(init->chr);
-            return FALSE;
+            goto end;
         }
     }
     init->buflen -= ret;
 
     if (init->buflen == 0) {
         tcp_chr_connect(init->chr);
-        return FALSE;
+        goto end;
     }
 
     memmove(init->buf, init->buf + ret, init->buflen);
 
-    return TRUE;
+    return G_SOURCE_CONTINUE;
+
+end:
+    g_free(init);
+    return G_SOURCE_REMOVE;
 }
 
 static void tcp_chr_telnet_init(Chardev *chr)
-- 
1.8.3.1
