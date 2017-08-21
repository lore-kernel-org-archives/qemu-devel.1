Received: from eggs.gnu.org ([2001:4830:134:3::10]:52358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=399efa679=ross.lagerwall@citrix.com>)
	id 1djnHl-0006AV-VJ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=399efa679=ross.lagerwall@citrix.com>)
	id 1djnHh-00063z-24
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:02:33 -0400
Received: from smtp.citrix.com ([66.165.176.89]:18074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=399efa679=ross.lagerwall@citrix.com>)
	id 1djnHg-00062r-Sj
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:02:28 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Mon, 21 Aug 2017 15:01:38 +0100
Message-ID: <20170821140138.27421-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen: Emit RTC_CHANGE upon TIMEOFFSET ioreq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Ross Lagerwall <ross.lagerwall@citrix.com>

When the guest writes to the RTC, Xen emulates it and broadcasts a
TIMEOFFSET ioreq. Emit an RTC_CHANGE QMP message when this happens
rather than ignoring it so that something useful can be done with the
information.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 hw/i386/xen/xen-hvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d9ccd5d..ffd20dc 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -16,6 +16,7 @@
 #include "hw/i386/apic-msidef.h"
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_backend.h"
+#include "qapi-event.h"
 #include "qmp-commands.h"
 
 #include "qemu/error-report.h"
@@ -967,6 +968,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
             handle_vmport_ioreq(state, req);
             break;
         case IOREQ_TYPE_TIMEOFFSET:
+            qapi_event_send_rtc_change((int64_t)req->data, &error_abort);
             break;
         case IOREQ_TYPE_INVALIDATE:
             xen_invalidate_map_cache();
-- 
2.9.5
