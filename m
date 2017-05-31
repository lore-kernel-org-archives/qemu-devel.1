Received: from eggs.gnu.org ([2001:4830:134:3::10]:32863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG77S-0002M5-6Y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG77P-0000dU-0Q
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG77O-0000d2-Ok
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97A058124B
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:09:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-98.ams2.redhat.com
	[10.36.116.98])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6499762923
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:09:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 May 2017 19:09:04 +0200
Message-Id: <1496250547-20701-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1496250547-20701-1-git-send-email-armbru@redhat.com>
References: <1496250547-20701-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] qobject-input-visitor: Reject non-finite
 numbers with keyval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The QObject input visitor can produce only finite numbers when its
input comes out of the JSON parser, because the the JSON parser
implements RFC 7159, which provides no syntax for infinity and NaN.

However, it can produce infinity and NaN when its input comes out of
keyval_parse(), because we parse with strtod() then.

The keyval variant should not be able to express things the JSON
variant can't.  Rejecting non-finite numbers there is the conservative
fix.  It's also minimally invasive.

We could instead extend our JSON dialect to provide for infinity and
NaN.  Not today.

Note that the JSON formatter can emit non-finite numbers (marked FIXME
in commit 6e8e5cb).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1495471335-23707-2-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qobject-input-visitor.c       | 3 ++-
 tests/test-qobject-input-visitor.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index d0f0002..eac40f6 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -13,6 +13,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include <math.h>
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor-impl.h"
@@ -568,7 +569,7 @@ static void qobject_input_type_number_keyval(Visitor =
*v, const char *name,
=20
     errno =3D 0;
     *obj =3D strtod(str, &endp);
-    if (errno || endp =3D=3D str || *endp) {
+    if (errno || endp =3D=3D str || *endp || !isfinite(*obj)) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "number");
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index f965743..e2aabbe 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -278,11 +278,17 @@ static void test_visitor_in_number_str_keyval(TestI=
nputVisitorData *data,
 {
     double res =3D 0, value =3D 3.14;
     Visitor *v;
+    Error *err =3D NULL;
=20
     v =3D visitor_input_test_init_full(data, true, "\"3.14\"");
=20
     visit_type_number(v, NULL, &res, &error_abort);
     g_assert_cmpfloat(res, =3D=3D, value);
+
+    v =3D visitor_input_test_init_full(data, true, "\"inf\"");
+
+    visit_type_number(v, NULL, &res, &err);
+    error_free_or_abort(&err);
 }
=20
 static void test_visitor_in_number_str_fail(TestInputVisitorData *data,
--=20
2.7.4
