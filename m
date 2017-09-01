Received: from eggs.gnu.org ([2001:4830:134:3::10]:51401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1J-0006aq-Df
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1E-0001ce-PN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1E-0001c7-Di
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 532F4C047B74
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:15 +0200
Message-Id: <20170901153758.8628-5-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 04/47] qdict: Add qdict_put_null() helper,
 and put it to use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170825105913.4060-2-marcandre.lureau@redhat.com>
[Update to qobject.cocci squashed in, commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qdict.h         | 4 +++-
 scripts/coccinelle/qobject.cocci | 3 +++
 target/i386/cpu.c                | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 363e431106..6588c7f0c8 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -53,13 +53,15 @@ void qdict_destroy_obj(QObject *obj);
 #define qdict_put(qdict, key, obj) \
         qdict_put_obj(qdict, key, QOBJECT(obj))
=20
-/* Helpers for int, bool, and string */
+/* Helpers for int, bool, null, and string */
 #define qdict_put_int(qdict, key, value) \
         qdict_put(qdict, key, qnum_from_int(value))
 #define qdict_put_bool(qdict, key, value) \
         qdict_put(qdict, key, qbool_from_bool(value))
 #define qdict_put_str(qdict, key, value) \
         qdict_put(qdict, key, qstring_from_str(value))
+#define qdict_put_null(qdict, key) \
+        qdict_put(qdict, key, qnull())
=20
 /* High level helpers */
 double qdict_get_double(const QDict *qdict, const char *key);
diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobjec=
t.cocci
index c518caf7b1..1120eb1a42 100644
--- a/scripts/coccinelle/qobject.cocci
+++ b/scripts/coccinelle/qobject.cocci
@@ -20,6 +20,9 @@ expression Obj, Key, E;
 |
 - qdict_put(Obj, Key, qstring_from_str(E));
 + qdict_put_str(Obj, Key, E);
+|
+- qdict_put(Obj, Key, qnull());
++ qdict_put_null(Obj, Key);
 )
=20
 // Use QList macros where they make sense
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ddc45abd70..bec2009a9c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2454,7 +2454,7 @@ static QDict *x86_cpu_static_props(void)
=20
     d =3D qdict_new();
     for (i =3D 0; props[i]; i++) {
-        qdict_put(d, props[i], qnull());
+        qdict_put_null(d, props[i]);
     }
=20
     for (w =3D 0; w < FEATURE_WORDS; w++) {
@@ -2464,7 +2464,7 @@ static QDict *x86_cpu_static_props(void)
             if (!fi->feat_names[bit]) {
                 continue;
             }
-            qdict_put(d, fi->feat_names[bit], qnull());
+            qdict_put_null(d, fi->feat_names[bit]);
         }
     }
=20
--=20
2.13.5
