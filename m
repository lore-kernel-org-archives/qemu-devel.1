Received: from eggs.gnu.org ([2001:4830:134:3::10]:43828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMa4-0006qY-P2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZy-0007Ol-Oy
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMZy-0007OG-HA
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A542111A28A
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:08:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:06:18 +0200
Message-Id: <20170911110623.24981-46-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 45/50] qapi: make rtc-reset-reinjection
 depend on TARGET_I386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

Move rtc-reset-reinjection in target.json and make it conditional on
TARGET_I386.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json       | 18 ------------------
 qapi/target.json       | 19 +++++++++++++++++++
 hw/timer/mc146818rtc.c |  2 +-
 monitor.c              | 10 ----------
 4 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 42b6aebddb..5b689c71ad 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2919,24 +2919,6 @@
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
=20
-##
-# @rtc-reset-reinjection:
-#
-# This command will reset the RTC interrupt reinjection backlog.
-# Can be used if another mechanism to synchronize guest time
-# is in effect, for example QEMU guest agent's guest-set-time
-# command.
-#
-# Since: 2.1
-#
-# Example:
-#
-# -> { "execute": "rtc-reset-reinjection" }
-# <- { "return": {} }
-#
-##
-{ 'command': 'rtc-reset-reinjection' }
-
 ##
 # @RTC_CHANGE:
 #
diff --git a/qapi/target.json b/qapi/target.json
index e9644f52c2..a764377ebf 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -1,3 +1,22 @@
 # -*- Mode: Python -*-
=20
 { 'pragma': { 'unit': 'target' } }
+
+##
+# @rtc-reset-reinjection:
+#
+# This command will reset the RTC interrupt reinjection backlog.
+# Can be used if another mechanism to synchronize guest time
+# is in effect, for example QEMU guest agent's guest-set-time
+# command.
+#
+# Since: 2.1
+#
+# Example:
+#
+# -> { "execute": "rtc-reset-reinjection" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'rtc-reset-reinjection',
+  'if': 'defined(TARGET_I386)' }
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 82843ed03f..3a5ddd074a 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -31,7 +31,7 @@
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/visitor.h"
 #include "qapi-event.h"
-#include "qmp-commands.h"
+#include "target-qmp-commands.h"
=20
 #ifdef TARGET_I386
 #include "hw/i386/apic.h"
diff --git a/monitor.c b/monitor.c
index af4eaeca5e..ff93d9a9a9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -971,9 +971,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
t **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#ifndef TARGET_I386
-    qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
-#endif
 #ifndef TARGET_S390X
     qmp_unregister_command(&qmp_commands, "dump-skeys");
 #endif
@@ -4155,13 +4152,6 @@ QemuOptsList qemu_mon_opts =3D {
     },
 };
=20
-#ifndef TARGET_I386
-void qmp_rtc_reset_reinjection(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "rtc-reset-reinjection");
-}
-#endif
-
 #ifndef TARGET_S390X
 void qmp_dump_skeys(const char *filename, Error **errp)
 {
--=20
2.14.1.146.gd35faa819
