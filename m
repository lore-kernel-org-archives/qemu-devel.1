Received: from eggs.gnu.org ([2001:4830:134:3::10]:49173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycK3-00074U-Ft
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJz-0000NY-LW
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJz-0000NF-FX
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 074D9406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:54:23 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:52:11 +0100
Message-Id: <20180321115211.17937-50-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 49/49] RFC: make RTC_CHANGE per-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
 qapi/misc.json         | 22 ----------------------
 qapi/target.json       | 23 +++++++++++++++++++++++
 hw/ppc/spapr_rtc.c     |  2 +-
 hw/timer/mc146818rtc.c |  2 +-
 monitor.c              |  4 +++-
 5 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index e9538ecae6..6415bbb7fe 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2856,28 +2856,6 @@
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
-#          new RTC clock value
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
index 89ba4207b1..b9f6741fbf 100644
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
index a37360537e..4cb73abf4a 100644
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
index dd575ffbdf..7de7562850 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -32,7 +32,7 @@
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
 #include "qapi/target-qapi-commands.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/target-qapi-events.h"
 #include "qapi/visitor.h"
=20
 #ifdef TARGET_I386
diff --git a/monitor.c b/monitor.c
index 377ea3c98b..3c972206d9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -635,7 +635,6 @@ monitor_qapi_event_queue(unsigned event, QDict *qdict=
, Error **errp)
         .size =3D QAPI_EVENT__MAX,
         .rate =3D {
             /* Limit guest-triggerable events to 1 per second */
-            [QAPI_EVENT_RTC_CHANGE]        =3D 1000 * SCALE_MS,
             [QAPI_EVENT_WATCHDOG]          =3D 1000 * SCALE_MS,
             [QAPI_EVENT_BALLOON_CHANGE]    =3D 1000 * SCALE_MS,
             [QAPI_EVENT_QUORUM_REPORT_BAD] =3D 1000 * SCALE_MS,
@@ -680,6 +679,9 @@ target_monitor_qapi_event_queue(unsigned event, QDict=
 *qdict, Error **errp)
         .size =3D TARGET_QAPI_EVENT__MAX,
         .rate =3D {
             /* Limit guest-triggerable events to 1 per second */
+#if defined(TARGET_ALPHA) || defined(TARGET_ARM) || defined(TARGET_HPPA)=
 || defined(TARGET_I386) || defined(TARGET_MIPS) | defined(TARGET_MIPS64)=
 || defined(TARGET_MOXIE) || defined(TARGET_PPC) || defined(TARGET_PPC64)=
 || defined(TARGET_S390X) || defined(TARGET_SH4) || defined(TARGET_SPARC)
+            [TARGET_QAPI_EVENT_RTC_CHANGE] =3D 1000 * SCALE_MS,
+#endif
             [TARGET_QAPI_EVENT__MAX]       =3D 0,
         },
     };
--=20
2.16.2.521.g9aa15f885a
