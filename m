Received: from eggs.gnu.org ([2001:4830:134:3::10]:40013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle08-0007oU-8s
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle05-0001F1-66
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle04-0001Eb-WF
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C4FB401CB8A
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:06 +0200
Message-Id: <20180803173614.12358-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/10] char/spice: discard write() if backend
 is disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Most chardev backend handle write() as discarded data if underlying
system is disconnected. For unknown historical reasons, the Spice
backend has "reliable" write. It will wait until the client end is
reconnected to accept further write().

Let's review Spice chardev usage and handling of a disconnected
client:

 * spice vdagent
   The agent will reopen the virtio port on disconnect.

 * usb redirection
   A disconnect creates a device disconnection.

 * smartcard emulation
   Data is discarded in passthru_apdu_from_guest()

 * spice webdavd
   The daemon will restart the service, and reopen the virtio port.

 * spice ports (serial console, qemu monitor..)
   Depends on the associated device or usage.

   - 16550A serial does nothing special, and may block guest on write

   - QMP/HMP monitor have some CLOSED event handling, but want to
     flush the write, which will finish when a new client connects.

For all these use cases, it is better to discard pending write when
the client is disconnected, and expect the device/agent to behave
correctly on CHR_EVENT_CLOSED (to stop reading and writing from
chardev).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/spice.c      | 6 ++++++
 chardev/trace-events | 1 +
 2 files changed, 7 insertions(+)

diff --git a/chardev/spice.c b/chardev/spice.c
index fe06034d7f..6ad95ffe62 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -212,6 +212,12 @@ static int spice_chr_write(Chardev *chr, const uint8=
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
2.18.0.547.g1d89318c48
