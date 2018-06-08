Received: from eggs.gnu.org ([2001:4830:134:3::10]:47996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUJ-0002VV-Pv
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUI-0001eY-1a
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUH-0001e2-IC
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:30 -0400
Message-Id: <20180608174733.4936-28-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/30] ide: call ide_cmd_done from
 ide_transfer_stop
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

The code can simply be moved to the sole caller that has notify =3D=3D tr=
ue.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180606190955.20845-5-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 1a6cb337bf..54799ea6fb 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -548,26 +548,23 @@ static void ide_cmd_done(IDEState *s)
 }
=20
 static void ide_transfer_halt(IDEState *s,
-                              void(*end_transfer_func)(IDEState *),
-                              bool notify)
+                              void(*end_transfer_func)(IDEState *))
 {
     s->end_transfer_func =3D end_transfer_func;
     s->data_ptr =3D s->io_buffer;
     s->data_end =3D s->io_buffer;
     s->status &=3D ~DRQ_STAT;
-    if (notify) {
-        ide_cmd_done(s);
-    }
 }
=20
 void ide_transfer_stop(IDEState *s)
 {
-    ide_transfer_halt(s, ide_transfer_stop, true);
+    ide_transfer_halt(s, ide_transfer_stop);
+    ide_cmd_done(s);
 }
=20
 static void ide_transfer_cancel(IDEState *s)
 {
-    ide_transfer_halt(s, ide_transfer_cancel, false);
+    ide_transfer_halt(s, ide_transfer_cancel);
 }
=20
 int64_t ide_get_sector(IDEState *s)
--=20
2.14.3
