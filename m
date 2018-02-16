Received: from eggs.gnu.org ([2001:4830:134:3::10]:36348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeao-0001dG-ML
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeal-0003g6-Mm
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33706 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emeal-0003eH-Cn
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:15 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Feb 2018 12:54:04 +0100
Message-Id: <20180216115410.27287-4-kraxel@redhat.com>
In-Reply-To: <20180216115410.27287-1-kraxel@redhat.com>
References: <20180216115410.27287-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/9] vnc: fix segfault in closed connection
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
Cc: Klim Kireev <klim.kireev@virtuozzo.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Klim Kireev <klim.kireev@virtuozzo.com>

On one of our client's node, due to trying to read from closed ioc,
a segmentation fault occured. Corresponding backtrace:

0  object_get_class (obj=3Dobj@entry=3D0x0)
1  qio_channel_readv_full (ioc=3D0x0, iov=3D0x7ffe55277180 ...
2  qio_channel_read (ioc=3D<optimized out> ...
3  vnc_client_read_buf (vs=3Dvs@entry=3D0x55625f3c6000, ...
4  vnc_client_read_plain (vs=3D0x55625f3c6000)
5  vnc_client_read (vs=3D0x55625f3c6000)
6  vnc_client_io (ioc=3D<optimized out>, condition=3DG_IO_IN, ...
7  g_main_dispatch (context=3D0x556251568a50)
8  g_main_context_dispatch (context=3Dcontext@entry=3D0x556251568a50)
9  glib_pollfds_poll ()
10 os_host_main_loop_wait (timeout=3D<optimized out>)
11 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0)
12 main_loop () at vl.c:1909
13 main (argc=3D<optimized out>, argv=3D<optimized out>, ...

Having analyzed the coredump, I understood that the reason is that
ioc_tag is reset on vnc_disconnect_start and ioc is cleaned
in vnc_disconnect_finish. Between these two events due to some
reasons the ioc_tag was set again and after vnc_disconnect_finish
the handler is running with freed ioc,
which led to the segmentation fault.

The patch checks vs->disconnecting in places where we call
qio_channel_add_watch and resets handler if disconnecting =3D=3D TRUE
to prevent such an occurrence.

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180207094844.21402-1-klim.kireev@virtuozzo.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc-jobs.c |  6 ++++--
 ui/vnc.c      | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index e326679dd0..868dddef4b 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -148,8 +148,10 @@ void vnc_jobs_consume_buffer(VncState *vs)
             if (vs->ioc_tag) {
                 g_source_remove(vs->ioc_tag);
             }
-            vs->ioc_tag =3D qio_channel_add_watch(
-                vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
+            if (vs->disconnecting =3D=3D FALSE) {
+                vs->ioc_tag =3D qio_channel_add_watch(
+                    vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL=
);
+            }
         }
         buffer_move(&vs->output, &vs->jobs_buffer);
=20
diff --git a/ui/vnc.c b/ui/vnc.c
index b97769aa9e..e371710f4f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1536,12 +1536,19 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNU=
SED,
     VncState *vs =3D opaque;
     if (condition & G_IO_IN) {
         if (vnc_client_read(vs) < 0) {
-            return TRUE;
+            goto end;
         }
     }
     if (condition & G_IO_OUT) {
         vnc_client_write(vs);
     }
+end:
+    if (vs->disconnecting) {
+        if (vs->ioc_tag !=3D 0) {
+            g_source_remove(vs->ioc_tag);
+        }
+        vs->ioc_tag =3D 0;
+    }
     return TRUE;
 }
=20
@@ -1630,6 +1637,12 @@ void vnc_flush(VncState *vs)
     if (vs->ioc !=3D NULL && vs->output.offset) {
         vnc_client_write_locked(vs);
     }
+    if (vs->disconnecting) {
+        if (vs->ioc_tag !=3D 0) {
+            g_source_remove(vs->ioc_tag);
+        }
+        vs->ioc_tag =3D 0;
+    }
     vnc_unlock_output(vs);
 }
=20
--=20
2.9.3
