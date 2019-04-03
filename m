Received: from eggs.gnu.org ([209.51.188.92]:59739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeYq-000510-Dg
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeYp-0005q2-DS
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:00:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hBeYp-0005m5-5t
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:00:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEEB3C049E22
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 11:51:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Apr 2019 13:49:55 +0200
Message-Id: <20190403114958.3705-6-quintela@redhat.com>
In-Reply-To: <20190403114958.3705-1-quintela@redhat.com>
References: <20190403114958.3705-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/8] migration-test: introduce functions to
 handle string parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index ff480e0682..65d5e256a7 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -427,6 +427,43 @@ static void migrate_set_parameter_int(QTestState *wh=
o, const char *parameter,
     migrate_check_parameter_int(who, parameter, value);
 }
=20
+static char *migrate_get_parameter_str(QTestState *who,
+                                       const char *parameter)
+{
+    QDict *rsp;
+    char *result;
+
+    rsp =3D wait_command(who, "{ 'execute': 'query-migrate-parameters' }=
");
+    result =3D g_strdup(qdict_get_str(rsp, parameter));
+    qobject_unref(rsp);
+    return result;
+}
+
+static void migrate_check_parameter_str(QTestState *who, const char *par=
ameter,
+                                        const char *value)
+{
+    char *result;
+
+    result =3D migrate_get_parameter_str(who, parameter);
+    g_assert_cmpstr(result, =3D=3D, value);
+    g_free(result);
+}
+
+__attribute__((unused))
+static void migrate_set_parameter_str(QTestState *who, const char *param=
eter,
+                                      const char *value)
+{
+    QDict *rsp;
+
+    rsp =3D qtest_qmp(who,
+                    "{ 'execute': 'migrate-set-parameters',"
+                    "'arguments': { %s: %s } }",
+                    parameter, value);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+    migrate_check_parameter_str(who, parameter, value);
+}
+
 static void migrate_pause(QTestState *who)
 {
     QDict *rsp;
--=20
2.20.1
