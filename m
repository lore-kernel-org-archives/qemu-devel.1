Received: from eggs.gnu.org ([2001:4830:134:3::10]:38089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjD-0003XX-28
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsj9-0007qP-3y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsj8-0007q8-Rl
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:47 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AA1577E44
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:24 +0400
Message-Id: <20170118160332.13390-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/25] qtest: add qtest-timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This command allows to test async behavior. It is only registered when
qtest is enabled. See the schema documentation for more details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json | 22 ++++++++++++++++++++++
 qtest.c          | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 8366206415..42b2c645c5 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6033,3 +6033,25 @@
 #
 ##
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
+
+##
+# @qtest-timeout:
+#
+# @duration: the time before timeout expires (in seconds)
+#
+# Test command that replies after @duration seconds.
+#
+# Example:
+#
+# -> { "execute": "qtest-timeout",
+#      "arguments": { "duration": 5 } }
+# ... after 5s
+# <- { "return": {} }
+#
+# Note: this command is only available with a qtest machine
+#
+# Since: 2.9
+##
+{ 'command': 'qtest-timeout',
+  'data': {'duration': 'int'},
+  'gen': false } # so we can can register it manually when qtest is enab=
led
diff --git a/qtest.c b/qtest.c
index bd9d417812..9477ad64e7 100644
--- a/qtest.c
+++ b/qtest.c
@@ -31,6 +31,8 @@
 #ifdef TARGET_PPC64
 #include "hw/ppc/spapr_rtas.h"
 #endif
+#include "qapi/qmp/dispatch.h"
+#include "qapi/qobject-input-visitor.h"
=20
 #define MAX_IRQ 256
=20
@@ -658,6 +660,49 @@ static void qtest_event(void *opaque, int event)
     }
 }
=20
+static gboolean qtest_timeout_cb(void *data)
+{
+    QmpReturn *qret =3D data;
+
+    qmp_return(qret, NULL);
+
+    return FALSE;
+}
+
+static void qmp_qtest_timeout(QDict *args, QmpReturn *qret)
+{
+    Error *err =3D NULL;
+    Visitor *v;
+    int64_t duration =3D 0;
+
+    v =3D qobject_input_visitor_new(QOBJECT(args), true);
+    visit_start_struct(v, NULL, NULL, 0, &err);
+    if (err) {
+        goto out;
+    }
+
+    visit_type_int(v, "duration", &duration, &err);
+    if (!err) {
+        visit_check_struct(v, &err);
+    }
+    visit_end_struct(v, NULL);
+    if (err) {
+        goto out;
+    }
+
+    if (duration <=3D 0) {
+        qmp_return(qret, NULL);
+    } else {
+        g_timeout_add_seconds(duration, qtest_timeout_cb, qret);
+    }
+
+out:
+    if (err) {
+        qmp_return_error(qret, err);
+    }
+    visit_free(v);
+}
+
 static int qtest_init_accel(MachineState *ms)
 {
     QemuOpts *opts =3D qemu_opts_create(qemu_find_opts("icount"), NULL, =
0,
@@ -665,6 +710,9 @@ static int qtest_init_accel(MachineState *ms)
     qemu_opt_set(opts, "shift", "0", &error_abort);
     configure_icount(opts, &error_abort);
     qemu_opts_del(opts);
+
+    qmp_register_async_command("qtest-timeout", qmp_qtest_timeout,
+                               QCO_NO_OPTIONS);
     return 0;
 }
=20
--=20
2.11.0.295.gd7dffce1c
