Received: from eggs.gnu.org ([2001:4830:134:3::10]:47976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUJ-0002Uv-C4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUI-0001eS-2C
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUH-0001eB-P0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:31 -0400
Message-Id: <20180608174733.4936-29-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/30] ide: make ide_transfer_stop idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

There is code checking s->end_transfer_func and it was not taught about
ide_transfer_cancel.  We can just use ide_transfer_stop because
s->end_transfer_func is only ever called in the DRQ phase.

ide_transfer_cancel can then be removed, since it would just be
calling ide_transfer_halt.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180606190955.20845-6-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 54799ea6fb..9c4864ae54 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -547,10 +547,9 @@ static void ide_cmd_done(IDEState *s)
     }
 }
=20
-static void ide_transfer_halt(IDEState *s,
-                              void(*end_transfer_func)(IDEState *))
+static void ide_transfer_halt(IDEState *s)
 {
-    s->end_transfer_func =3D end_transfer_func;
+    s->end_transfer_func =3D ide_transfer_stop;
     s->data_ptr =3D s->io_buffer;
     s->data_end =3D s->io_buffer;
     s->status &=3D ~DRQ_STAT;
@@ -558,15 +557,10 @@ static void ide_transfer_halt(IDEState *s,
=20
 void ide_transfer_stop(IDEState *s)
 {
-    ide_transfer_halt(s, ide_transfer_stop);
+    ide_transfer_halt(s);
     ide_cmd_done(s);
 }
=20
-static void ide_transfer_cancel(IDEState *s)
-{
-    ide_transfer_halt(s, ide_transfer_cancel);
-}
-
 int64_t ide_get_sector(IDEState *s)
 {
     int64_t sector_num;
@@ -1361,7 +1355,7 @@ static bool cmd_nop(IDEState *s, uint8_t cmd)
 static bool cmd_device_reset(IDEState *s, uint8_t cmd)
 {
     /* Halt PIO (in the DRQ phase), then DMA */
-    ide_transfer_cancel(s);
+    ide_transfer_halt(s);
     ide_cancel_dma_sync(s);
=20
     /* Reset any PIO commands, reset signature, etc */
--=20
2.14.3
