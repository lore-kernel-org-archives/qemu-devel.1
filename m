Received: from eggs.gnu.org ([2001:4830:134:3::10]:46633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjxp-0007fe-Jg
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjxo-0001dE-UJ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:51:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36620 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esjxo-0001d6-Pm
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:51:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54E1F4040858
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 06:51:12 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  5 Mar 2018 14:50:39 +0800
Message-Id: <20180305065040.10353-9-peterx@redhat.com>
In-Reply-To: <20180305065040.10353-1-peterx@redhat.com>
References: <20180305065040.10353-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 8/9] chardev: tcp: let TLS run on chardev
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
