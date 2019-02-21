Received: from eggs.gnu.org ([209.51.188.92]:34668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCG-0001wx-LE
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCE-0006nn-8U
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmCC-0006lz-Bg
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D877F5AFE3
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:07:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:06:54 +0100
Message-Id: <20190221110703.5775-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190221110703.5775-1-marcandre.lureau@redhat.com>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/11] char/spice: discard write() if
 backend is disconnected
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

Most chardev backend handle write() as discarded data if underlying
system is disconnected. For unknown historical reasons, the Spice
backend has "reliable" write: it will wait until the client end is
reconnected to do further successful write().

To decide whether it make sense to wait until the client is
reconnected (or queue the writes), let's review Spice chardev usage
and handling of a disconnected client:

 * spice vdagent
   The agents reopen the virtio port on disconnect. In qemu side,
   virtio_serial_close() will also discard pending data.

 * usb redirection
   A disconnect creates a device disconnection.

 * smartcard emulation
   Data is discarded in passthru_apdu_from_guest().

   (Spice doesn't explicitly open the smartcard char device until
   upcoming 0.14.2, commit 69a5cfc74131ec0459f2eb5a231139f5a69a8037)

 * spice webdavd
   The daemon will restart the service, and reopen the virtio port.

 * spice ports (serial console, qemu monitor..)
   Depends on the associated device or usage.

   - serial, may be throttled or discarded on write, depending on
     device

   - QMP/HMP monitor have some CLOSED event handling, but want to
     flush the write, which will finish when a new client connects.

On disconnect/reconnect, the client starts with fresh sessions. If it
is a seamless migration, the client disconnects after the source
migrated. The handling of source disconnect in qemu is thus irrelevant
for the Spice session migration.

For all these use cases, it is better to discard writes when the
client is disconnected, and require the vm-side device/agent to behave
correctly on CHR_EVENT_CLOSED, to stop reading and writing from
the spice chardev.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
---
 chardev/spice.c      | 12 ++++++++++++
 chardev/trace-events |  1 +
 2 files changed, 13 insertions(+)

diff --git a/chardev/spice.c b/chardev/spice.c
index c2baeb5461..c68e60115b 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -208,6 +208,12 @@ static int spice_chr_write(Chardev *chr, const uint8=
_t *buf, int len)
     int read_bytes;
=20
     assert(s->datalen =3D=3D 0);
+
+    if (!chr->be_open) {
+        trace_spice_chr_discard_write(len);
+        return len;
+    }
+
     s->datapos =3D buf;
     s->datalen =3D len;
     spice_server_char_device_wakeup(&s->sin);
@@ -300,6 +306,12 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
     }
=20
     *be_opened =3D false;
+#if SPICE_SERVER_VERSION < 0x000e02
+    /* Spice < 0.14.2 doesn't explicitly open smartcard chardev */
+    if (strcmp(type, "smartcard") =3D=3D 0) {
+        *be_opened =3D true;
+    }
+#endif
     chr_open(chr, type);
 }
=20
diff --git a/chardev/trace-events b/chardev/trace-events
index d0e5f3bbc1..b8a7596344 100644
--- a/chardev/trace-events
+++ b/chardev/trace-events
@@ -10,6 +10,7 @@ wct_cmd_other(const char *cmd) "%s"
 wct_speed(int speed) "%d"
=20
 # chardev/spice.c
+spice_chr_discard_write(int len) "spice chr write discarded %d"
 spice_vmc_write(ssize_t out, int len) "spice wrote %zd of requested %d"
 spice_vmc_read(int bytes, int len) "spice read %d of requested %d"
 spice_vmc_register_interface(void *scd) "spice vmc registered interface =
%p"
--=20
2.21.0.rc1
