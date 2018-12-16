Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX7c-0001wn-3o
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX7Y-0005ZB-Ci
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:10:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gYX7W-0005XY-L4
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:10:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A22A9C05D3ED
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 14:10:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Dec 2018 18:09:02 +0400
Message-Id: <20181216140902.23986-14-marcandre.lureau@redhat.com>
In-Reply-To: <20181216140902.23986-1-marcandre.lureau@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/13] qapi: move RTC_CHANGE to the target
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
Cc: armbru@redhat.com

A few targets don't emit RTC_CHANGE, we could restrict the event to
the tagets that do emit it.

Note: There is a lot more of events & commands that we could restrict
to capable targets, with the cost of some additional complexity, but
the benefit of added correctness and better introspection.

Note2: The rate limite could perhaps be part of the schema, and the
common event emitter code, to simplify the need of custom and #ifdef
code in the monitor.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/misc.json         | 23 -----------------------
 qapi/target.json       | 23 +++++++++++++++++++++++
 hw/ppc/spapr_rtc.c     |  2 +-
 hw/timer/mc146818rtc.c |  2 +-
 monitor.c              |  8 +++++++-
 5 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 7d620b2d7b..aa97344c20 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2807,29 +2807,6 @@
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
index c75af005c9..039f539fcf 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -9,6 +9,29 @@
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
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index cd049f389d..ce00d96865 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -31,7 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ppc/spapr.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/target-qapi-events.h"
 #include "qemu/cutils.h"
=20
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns)
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index a27b389f8e..8e7ac3034e 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -32,7 +32,7 @@
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
 #include "qapi/target-qapi-commands.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/target-qapi-events.h"
 #include "qapi/visitor.h"
 #include "exec/address-spaces.h"
=20
diff --git a/monitor.c b/monitor.c
index 780247ab64..f7abb18084 100644
--- a/monitor.c
+++ b/monitor.c
@@ -674,7 +674,6 @@ monitor_qapi_event_queue(unsigned event, QDict *qdict=
)
         .size =3D QAPI_EVENT__MAX,
         .rate =3D {
             /* Limit guest-triggerable events to 1 per second */
-            [QAPI_EVENT_RTC_CHANGE]        =3D 1000 * SCALE_MS,
             [QAPI_EVENT_WATCHDOG]          =3D 1000 * SCALE_MS,
             [QAPI_EVENT_BALLOON_CHANGE]    =3D 1000 * SCALE_MS,
             [QAPI_EVENT_QUORUM_REPORT_BAD] =3D 1000 * SCALE_MS,
@@ -718,6 +717,13 @@ target_monitor_qapi_event_queue(unsigned event, QDic=
t *qdict)
     static MonitorEventRateLimit limiter =3D {
         .size =3D TARGET_QAPI_EVENT__MAX,
         .rate =3D {
+            /* Limit guest-triggerable events to 1 per second */
+#if defined(TARGET_ALPHA) || defined(TARGET_ARM) || defined(TARGET_HPPA)=
 || \
+    defined(TARGET_I386) || defined(TARGET_MIPS) | defined(TARGET_MIPS64=
) || \
+    defined(TARGET_MOXIE) || defined(TARGET_PPC) || defined(TARGET_PPC64=
) || \
+    defined(TARGET_S390X) || defined(TARGET_SH4) || defined(TARGET_SPARC=
)
+            [TARGET_QAPI_EVENT_RTC_CHANGE] =3D 1000 * SCALE_MS,
+#endif
             [TARGET_QAPI_EVENT__MAX]       =3D 0,
         },
     };
--=20
2.20.0
