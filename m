Received: from eggs.gnu.org ([2001:4830:134:3::10]:38461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBl-0001n8-SW
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBi-0001LE-LV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRXBi-0001G4-CC
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00F64C045776
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:49:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Nov 2018 07:49:30 +0100
Message-Id: <20181127064932.7299-5-kraxel@redhat.com>
In-Reply-To: <20181127064932.7299-1-kraxel@redhat.com>
References: <20181127064932.7299-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/6] audio/hda: fix guest triggerable assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

Guest writes to a readonly register trigger the assert in
intel_hda_reg_write().  Add a check and just ignore them.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1628433
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181123063957.9515-1-kraxel@redhat.com
---
 hw/audio/intel-hda.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 23a2cf6484..33e333cc26 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -23,6 +23,7 @@
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
+#include "qemu/log.h"
 #include "hw/audio/soundhw.h"
 #include "intel-hda.h"
 #include "intel-hda-defs.h"
@@ -929,6 +930,11 @@ static void intel_hda_reg_write(IntelHDAState *d, co=
nst IntelHDAReg *reg, uint32
     if (!reg) {
         return;
     }
+    if (!reg->wmask) {
+        qemu_log_mask(LOG_GUEST_ERROR, "intel-hda: write to r/o reg %s\n=
",
+                      reg->name);
+        return;
+    }
=20
     if (d->debug) {
         time_t now =3D time(NULL);
--=20
2.9.3
