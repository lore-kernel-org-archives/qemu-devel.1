Received: from eggs.gnu.org ([2001:4830:134:3::10]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duv5z-0006o8-IT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duv5w-0001GZ-DL
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:36:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duv5w-0001G4-5s
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:36:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AEAA12987B
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:36:19 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 21 Sep 2017 14:35:53 +0800
Message-Id: <1505975754-21555-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1505975754-21555-1-git-send-email-peterx@redhat.com>
References: <1505975754-21555-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] chardev: use per-dev context for
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It was only passed in by chr_update_read_handlers().  However when
reconnect, we'll lose that context information.  So if a chardev was
running on another context (rather than the default context, the NULL
pointer), it'll switch back to the default context if reconnection
happens.  But, it should really stick to the old context.

Convert all the callers of io_add_watch_poll() to use the internally
cached gcontext.  Then the context should be able to survive even after
reconnections.

Signed-off-by: Peter Xu <peterx@redhat.com>
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
2.7.4
