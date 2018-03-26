Received: from eggs.gnu.org ([2001:4830:134:3::10]:57238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ6-0006eG-3I
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ4-000717-Dv
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:04 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SJ4-00070Z-6z
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:02 -0400
Received: by mail-wr0-x244.google.com with SMTP id z73so18974742wrb.0
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:37:02 -0700 (PDT)
Received: from 640k.lan (94-36-194-48.adsl-ull.clienti.tiscali.it.
	[94.36.194.48]) by smtp.gmail.com with ESMTPSA id
	g186sm6710105wmd.41.2018.03.26.06.36.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 26 Mar 2018 06:36:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:39 +0200
Message-Id: <1522071403-52486-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/16] chardev-socket: remove useless if
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index d057192..159e69c 100644
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
1.8.3.1
