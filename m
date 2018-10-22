Received: from eggs.gnu.org ([2001:4830:134:3::10]:38017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPk-0002LS-PU
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPi-00032v-Ql
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gEZPg-0002vb-6r
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE0361B9A
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 Oct 2018 14:33:45 +0200
Message-Id: <20181022123413.28044-13-armbru@redhat.com>
In-Reply-To: <20181022123413.28044-1-armbru@redhat.com>
References: <20181022123413.28044-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/40] ioapic: Fix error handling in realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  ioapic_realize() does that, and then exit()s.
Currently mostly harmless, as the device cannot be hot-plugged.

Fixes: 20fd4b7b6d9282fe0cb83601f1821f31bd257458
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181017082702.5581-11-armbru@redhat.com>
---
 hw/intc/ioapic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index b6896ac4ce..4e529729b4 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -21,7 +21,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
@@ -393,9 +393,9 @@ static void ioapic_realize(DeviceState *dev, Error **=
errp)
     IOAPICCommonState *s =3D IOAPIC_COMMON(dev);
=20
     if (s->version !=3D 0x11 && s->version !=3D 0x20) {
-        error_report("IOAPIC only supports version 0x11 or 0x20 "
-                     "(default: 0x%x).", IOAPIC_VER_DEF);
-        exit(1);
+        error_setg(errp, "IOAPIC only supports version 0x11 or 0x20 "
+                   "(default: 0x%x).", IOAPIC_VER_DEF);
+        return;
     }
=20
     memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
--=20
2.17.2
