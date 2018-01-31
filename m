Received: from eggs.gnu.org ([2001:4830:134:3::10]:55466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1egsF8-0003tN-0i
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1egsEy-0001ld-F2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:16:01 -0500
Received: from mail-eopbgr00097.outbound.protection.outlook.com
	([40.107.0.97]:21051
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1egsEy-0001km-5l
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:15:52 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Wed, 31 Jan 2018 16:15:37 +0300
Message-Id: <20180131131537.31642-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] vnc: fix segfault in closed connection
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On one of our client's node, due to trying to read from closed ioc,
a segmentation fault occured. Corresponding backtrace:

0  object_get_class (obj=obj@entry=0x0)
1  qio_channel_readv_full (ioc=0x0, iov=0x7ffe55277180 ...
2  qio_channel_read (ioc=<optimized out> ...
3  vnc_client_read_buf (vs=vs@entry=0x55625f3c6000, ...
4  vnc_client_read_plain (vs=0x55625f3c6000)
5  vnc_client_read (vs=0x55625f3c6000)
6  vnc_client_io (ioc=<optimized out>, condition=G_IO_IN, ...
7  g_main_dispatch (context=0x556251568a50)
8  g_main_context_dispatch (context=context@entry=0x556251568a50)
9  glib_pollfds_poll ()
10 os_host_main_loop_wait (timeout=<optimized out>)
11 main_loop_wait (nonblocking=nonblocking@entry=0)
12 main_loop () at vl.c:1909
13 main (argc=<optimized out>, argv=<optimized out>, ...

Having analyzed the coredump, I understood that the reason is that
ioc_tag is reset on vnc_disconnect_start and ioc is cleaned
in vnc_disconnect_finish. Between these two events due to some
reasons the ioc_tag was set again and after vnc_disconnect_finish
the handler is running with freed ioc,
which led to the segmentation fault.

I suggest to check ioc_tag in vnc_disconnect_finish to prevent such
an occurrence.

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
---
Changelog:
v2: Apply the backtrace

 ui/vnc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 33b087221f..b8bf0180cb 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1270,6 +1270,10 @@ void vnc_disconnect_finish(VncState *vs)
     }
     g_free(vs->lossy_rect);
 
+    if (vs->ioc_tag) {
+        g_source_remove(vs->ioc_tag);
+        vs->ioc_tag = 0;
+    }
     object_unref(OBJECT(vs->ioc));
     vs->ioc = NULL;
     object_unref(OBJECT(vs->sioc));
-- 
2.14.3
