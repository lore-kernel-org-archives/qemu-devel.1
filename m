Received: from eggs.gnu.org ([2001:4830:134:3::10]:35952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerY-0001Gf-Kd
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerX-0004or-GQ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcerX-0004oO-AF
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:59 -0400
Date: Wed, 2 Aug 2017 00:37:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501623438-31419-9-git-send-email-mst@redhat.com>
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501623438-31419-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/10] vhost-user: fix watcher need be removed
 when vhost-user hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yunjian Wang <wangyunjian@huawei.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Yunjian Wang <wangyunjian@huawei.com>

"nc" is freed after hotplug vhost-user, but the watcher is not removed.
The QEMU crash when the watcher access the "nc" when socket disconnects.

    Program received signal SIGSEGV, Segmentation fault.
    #0  object_get_class (obj=3Dobj@entry=3D0x2) at qom/object.c:750
    #1  0x00007f9bb4180da1 in qemu_chr_fe_disconnect (be=3D<optimized out=
>) at chardev/char-fe.c:372
    #2  0x00007f9bb40d1100 in net_vhost_user_watch (chan=3D<optimized out=
>, cond=3D<optimized out>, opaque=3D<optimized out>) at net/vhost-user.c:=
188
    #3  0x00007f9baf97f99a in g_main_context_dispatch () from /usr/lib64/=
libglib-2.0.so.0
    #4  0x00007f9bb41d7ebc in glib_pollfds_poll () at util/main-loop.c:21=
3
    #5  os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-l=
oop.c:261
    #6  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at util/main=
-loop.c:515
    #7  0x00007f9bb3e266a7 in main_loop () at vl.c:1917
    #8  main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<opt=
imized out>) at vl.c:4786

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 36f32a2..c23927c 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -151,6 +151,10 @@ static void vhost_user_cleanup(NetClientState *nc)
         s->vhost_net =3D NULL;
     }
     if (nc->queue_index =3D=3D 0) {
+        if (s->watch) {
+            g_source_remove(s->watch);
+            s->watch =3D 0;
+        }
         qemu_chr_fe_deinit(&s->chr, true);
     }
=20
--=20
MST
