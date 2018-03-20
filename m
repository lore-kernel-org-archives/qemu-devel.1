Received: from eggs.gnu.org ([2001:4830:134:3::10]:39616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyJ2X-0005Eh-Ny
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyJ2S-0000nw-0J
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:19:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyJ2R-0000nN-S9
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:18:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81879A27E4
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 15:18:59 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-128.ams2.redhat.com
	[10.36.117.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D9D1F202322F
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 15:18:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Mar 2018 16:18:57 +0100
Message-Id: <20180320151857.26340-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] chardev-socket: remove useless if
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This trips Coverity, which believes the subsequent qio_channel_create_watch
can dereference a NULL pointer.  In reality, tcp_chr_connect's callers
all have s->ioc properly initialized, since they are all rooted at
tcp_chr_new_client.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index d057192ced..159e69c3b1 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -550,12 +550,10 @@ static void tcp_chr_connect(void *opaque)
         s->is_listen, s->is_telnet);
 
     s->connected = 1;
-    if (s->ioc) {
-        chr->gsource = io_add_watch_poll(chr, s->ioc,
-                                           tcp_chr_read_poll,
-                                           tcp_chr_read,
-                                           chr, chr->gcontext);
-    }
+    chr->gsource = io_add_watch_poll(chr, s->ioc,
+                                       tcp_chr_read_poll,
+                                       tcp_chr_read,
+                                       chr, chr->gcontext);
 
     s->hup_source = qio_channel_create_watch(s->ioc, G_IO_HUP);
     g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
-- 
2.16.2
