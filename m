Received: from eggs.gnu.org ([2001:4830:134:3::10]:37588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAih-0005Aq-9C
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAig-0004hg-AK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:23 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAif-0004gU-Vw
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:22 -0400
Received: by mail-wr0-x241.google.com with SMTP id u48so3841190wrf.4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:39 +0200
Message-Id: <1506035800-30509-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/32] chardev: use per-dev context for
 io_add_watch_poll
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

It was only passed in by chr_update_read_handlers().  However when
reconnect, we'll lose that context information.  So if a chardev was
running on another context (rather than the default context, the NULL
pointer), it'll switch back to the default context if reconnection
happens.  But, it should really stick to the old context.

Convert all the callers of io_add_watch_poll() to use the internally
cached gcontext.  Then the context should be able to survive even after
reconnections.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1505975754-21555-4-git-send-email-peterx@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-fd.c     | 2 +-
 chardev/char-pty.c    | 2 +-
 chardev/char-socket.c | 4 ++--
 chardev/char-udp.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 6a62a54..09fbb07 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -94,7 +94,7 @@ static void fd_chr_update_read_handler(Chardev *chr,
         chr->gsource = io_add_watch_poll(chr, s->ioc_in,
                                            fd_chr_read_poll,
                                            fd_chr_read, chr,
-                                           context);
+                                           chr->gcontext);
     }
 }
 
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index e5d20a0..d239c04 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -219,7 +219,7 @@ static void pty_chr_state(Chardev *chr, int connected)
             chr->gsource = io_add_watch_poll(chr, s->ioc,
                                                pty_chr_read_poll,
                                                pty_chr_read,
-                                               chr, NULL);
+                                               chr, chr->gcontext);
         }
     }
 }
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1ae730a..ee71cbe 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -516,7 +516,7 @@ static void tcp_chr_connect(void *opaque)
         chr->gsource = io_add_watch_poll(chr, s->ioc,
                                            tcp_chr_read_poll,
                                            tcp_chr_read,
-                                           chr, NULL);
+                                           chr, chr->gcontext);
     }
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
@@ -535,7 +535,7 @@ static void tcp_chr_update_read_handler(Chardev *chr,
         chr->gsource = io_add_watch_poll(chr, s->ioc,
                                            tcp_chr_read_poll,
                                            tcp_chr_read, chr,
-                                           context);
+                                           chr->gcontext);
     }
 }
 
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 4ee11d3..106dee1 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -110,7 +110,7 @@ static void udp_chr_update_read_handler(Chardev *chr,
         chr->gsource = io_add_watch_poll(chr, s->ioc,
                                            udp_chr_read_poll,
                                            udp_chr_read, chr,
-                                           context);
+                                           chr->gcontext);
     }
 }
 
-- 
1.8.3.1
