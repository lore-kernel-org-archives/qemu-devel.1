Received: from eggs.gnu.org ([209.51.188.92]:56388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMO-0003MR-6E
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDML-0003IH-LP
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guDML-0002nO-AS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36571811DB
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:30:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 10:30:53 +0100
Message-Id: <20190214093053.1400-19-armbru@redhat.com>
In-Reply-To: <20190214093053.1400-1-armbru@redhat.com>
References: <20190214093053.1400-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 18/18] qapi: move RTC_CHANGE to the target
 schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

A few targets don't emit RTC_CHANGE, we could restrict the event to
the tagets that do emit it.

Note: There is a lot more of events & commands that we could restrict
to capable targets, with the cost of some additional complexity, but
the benefit of added correctness and better introspection.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr_rtc.c     |  2 +-
 hw/timer/mc146818rtc.c |  2 +-
 qapi/misc.json         | 23 -----------------------
 qapi/target.json       | 23 +++++++++++++++++++++++
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index cd049f389d..eb95a7077d 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -31,7 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ppc/spapr.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-events-target.h"
 #include "qemu/cutils.h"
=20
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns)
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index bc1862b6fc..513f105e62 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -32,7 +32,7 @@
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-target.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-events-target.h"
 #include "qapi/visitor.h"
 #include "exec/address-spaces.h"
=20
diff --git a/qapi/misc.json b/qapi/misc.json
index 98f59f828a..8b3ca4fdd3 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2876,29 +2876,6 @@
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
=20
-##
-# @RTC_CHANGE:
-#
-# Emitted when the guest changes the RTC time.
-#
-# @offset: offset between base RTC clock (as specified by -rtc base), an=
d
-#          new RTC clock value. Note that value will be different depend=
ing
-#          on clock chosen to drive RTC (specified by -rtc clock).
-#
-# Note: This event is rate-limited.
-#
-# Since: 0.13.0
-#
-# Example:
-#
-# <-   { "event": "RTC_CHANGE",
-#        "data": { "offset": 78 },
-#        "timestamp": { "seconds": 1267020223, "microseconds": 435656 } =
}
-#
-##
-{ 'event': 'RTC_CHANGE',
-  'data': { 'offset': 'int' } }
-
 ##
 # @ReplayMode:
 #
diff --git a/qapi/target.json b/qapi/target.json
index 5c41a0aee7..da7b4be51e 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -7,6 +7,29 @@
=20
 { 'include': 'misc.json' }
=20
+##
+# @RTC_CHANGE:
+#
+# Emitted when the guest changes the RTC time.
+#
+# @offset: offset between base RTC clock (as specified by -rtc base), an=
d
+#          new RTC clock value
+#
+# Note: This event is rate-limited.
+#
+# Since: 0.13.0
+#
+# Example:
+#
+# <-   { "event": "RTC_CHANGE",
+#        "data": { "offset": 78 },
+#        "timestamp": { "seconds": 1267020223, "microseconds": 435656 } =
}
+#
+##
+{ 'event': 'RTC_CHANGE',
+  'data': { 'offset': 'int' },
+  'if': 'defined(TARGET_ALPHA) || defined(TARGET_ARM) || defined(TARGET_=
HPPA) || defined(TARGET_I386) || defined(TARGET_MIPS) || defined(TARGET_M=
IPS64) || defined(TARGET_MOXIE) || defined(TARGET_PPC) || defined(TARGET_=
PPC64) || defined(TARGET_S390X) || defined(TARGET_SH4) || defined(TARGET_=
SPARC)' }
+
 ##
 # @rtc-reset-reinjection:
 #
--=20
2.17.2
