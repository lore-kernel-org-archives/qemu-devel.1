Received: from eggs.gnu.org ([2001:4830:134:3::10]:37200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebV06-0000fU-SP
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebV03-0001zR-Nu
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebV03-0001xP-F6
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:26:15 -0500
References: <20180110131832.16623-1-klim.kireev@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71031eb9-06a0-21fe-dd89-4b49e23b97be@redhat.com>
Date: Tue, 16 Jan 2018 18:25:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180110131832.16623-1-klim.kireev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, den@virtuozzo.com

On 10/01/2018 14:18, Klim Kireev wrote:
> The following behavior was observed for QEMU configured by libvirt
> to use guest agent as usual for the guests without virtio-serial
> driver (Windows or the guest remaining in BIOS stage).
>=20
> In QEMU on first connect to listen character device socket
> the listen socket is removed from poll just after the accept().
> virtio_serial_guest_ready() returns 0 and the descriptor
> of the connected Unix socket is removed from poll and it will
> not be present in poll() until the guest will initialize the driver
> and change the state of the serial to "guest connected".
>=20
> In libvirt connect() to guest agent is performed on restart and
> is run under VM state lock. Connect() is blocking and can
> wait forever.
> In this case libvirt can not perform ANY operation on that VM.
>=20
> The bug can be easily reproduced this way:
>=20
> Terminal 1:
> qemu-system-x86_64 -m 512 -device pci-serial,chardev=3Dserial1 -chardev=
 socket,id=3Dserial1,path=3D/tmp/console.sock,server,nowait
> (virtio-serial and isa-serial also fit)
>=20
> Terminal 2:
> minicom -D unix\#/tmp/console.sock
> (type something and pres enter)
> C-a x (to exit)
>=20
> Do 3 times:
> minicom -D unix\#/tmp/console.sock
> C-a x
>=20
> It needs 4 connections, because the first one is accepted by QEMU, then=
 two are queued by
> the kernel, and the 4th blocks.
>=20
> The problem is that QEMU doesn't add a read watcher after succesful rea=
d
> until the guest device wants to acquire recieved data, so
> I propose to install a separate pullhup watcher regardless of
> whether the device waits for data or not. After closing the connection,
> the guest has a capability to read the data within timeout.

I don't understand the timeout part.

Apart from that, maybe the bug is in io_watch_poll_prepare, which needs=20
to _always_ set up a "G_IO_ERR | G_IO_HUP | G_IO_NVAL" watch.  Only=20
G_IO_IN depends on iwp->fd_can_read(...) > 0.

So the change would start with something like this:

diff --git a/chardev/char-io.c b/chardev/char-io.c
index f81052481a..a5e65d4e7c 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -29,6 +29,7 @@ typedef struct IOWatchPoll {
=20
     QIOChannel *ioc;
     GSource *src;
+    GIOCondition cond;
=20
     IOCanReadHandler *fd_can_read;
     GSourceFunc fd_read;
@@ -41,25 +42,32 @@ static IOWatchPoll *io_watch_poll_from_source(GSource=
 *source)
     return container_of(source, IOWatchPoll, parent);
 }
=20
+static void io_watch_poll_destroy_source(IOWatchPoll *iwp)
+{
+    if (iwp->src) {
+        g_source_destroy(iwp->src);
+        g_source_unref(iwp->src);
+        iwp->src =3D NULL;
+        iwp->cond =3D 0;
+    }
+}
+
 static gboolean io_watch_poll_prepare(GSource *source,
                                       gint *timeout)
 {
     IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
     bool now_active =3D iwp->fd_can_read(iwp->opaque) > 0;
-    bool was_active =3D iwp->src !=3D NULL;
-    if (was_active =3D=3D now_active) {
-        return FALSE;
+    GIOCondition cond =3D G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+    if (now_active) {
+        cond |=3D G_IO_IN;
     }
=20
-    if (now_active) {
-        iwp->src =3D qio_channel_create_watch(
-            iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
+    if (iwp->cond !=3D cond) {
+        io_watch_poll_destroy_source(iwp);
+        iwp->cond =3D cond;
+        iwp->src =3D qio_channel_create_watch(iwp->ioc, cond);
         g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NULL)=
;
         g_source_attach(iwp->src, iwp->context);
-    } else {
-        g_source_destroy(iwp->src);
-        g_source_unref(iwp->src);
-        iwp->src =3D NULL;
     }
     return FALSE;
 }
@@ -131,11 +139,7 @@ static void io_remove_watch_poll(GSource *source)
     IOWatchPoll *iwp;
=20
     iwp =3D io_watch_poll_from_source(source);
-    if (iwp->src) {
-        g_source_destroy(iwp->src);
-        g_source_unref(iwp->src);
-        iwp->src =3D NULL;
-    }
+    io_watch_poll_destroy_source(iwp);
     g_source_destroy(&iwp->parent);
 }
=20


Thanks,

Paolo
