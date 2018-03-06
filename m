Received: from eggs.gnu.org ([2001:4830:134:3::10]:41541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5Eh-0001AP-Cz
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5Eg-0006vP-LL
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:34:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et5Eg-0006vH-GM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:34:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1627B4001416
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 05:34:02 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Mar 2018 13:33:19 +0800
Message-Id: <20180306053320.15401-9-peterx@redhat.com>
In-Reply-To: <20180306053320.15401-1-peterx@redhat.com>
References: <20180306053320.15401-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 8/9] chardev: tcp: let TLS run on chardev
 context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Now qio_channel_tls_handshake() is ready to receive the context.  Let
socket chardev use it, then the TLS handshake of chardev will always be
with the chardev's context.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 165612845a..bd40864f87 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -750,7 +750,7 @@ static void tcp_chr_tls_init(Chardev *chr)
                               tcp_chr_tls_handshake,
                               chr,
                               NULL,
-                              NULL);
+                              chr->gcontext);
 }
 
 
-- 
2.14.3
