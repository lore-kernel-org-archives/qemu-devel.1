Received: from eggs.gnu.org ([2001:4830:134:3::10]:46651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCKm-0007AK-VJ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCKl-0004mi-W5
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:59:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dlCKl-0004m1-QE
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:59:27 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 12:59:00 +0200
Message-Id: <20170825105913.4060-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170825105913.4060-1-marcandre.lureau@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/14] qdict: add qdict_put_null() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

A step towards completeness.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qdict.h | 4 +++-
 target/i386/cpu.c        | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

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
2.14.1.146.gd35faa819
