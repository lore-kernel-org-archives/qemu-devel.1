Received: from eggs.gnu.org ([2001:4830:134:3::10]:47331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJJ60-0000NA-08
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJJ5w-0008Vv-Rt
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:32:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJJ5w-0008VZ-K3
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:32:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3725981222
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 12:32:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
Date: Fri, 09 Jun 2017 14:32:47 +0200
In-Reply-To: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 7 Jun 2017 20:35:52 +0400")
Message-ID: <87fuf9l4sw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/43] qobject/qapi: add uint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

PATCH 01-41 look ready with minor tweaks.  I chatted with Marc-Andr=C3=A9,
and he asked me to apply them myself.  You can find the result at
https://repo.or.cz/qemu/armbru.git in branch qapi-next.  Marc-Andr=C3=A9,
please give it a quick look-over.  If it's good, I'll post a pull
request later today.

PATCH 42 is RFC.  I'd like to give PATCH 43 a bit more time on the list.

Incremental diff for your convenience:

diff --git a/blockdev.c b/blockdev.c
index 154c95d..4009dd9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -335,10 +335,9 @@ static bool parse_stats_intervals(BlockAcctStats *stat=
s, QList *intervals,
         }
=20
         case QTYPE_QNUM: {
-            int64_t length;
+            int64_t length =3D qnum_get_int(qobject_to_qnum(entry->value));
=20
-            if (qnum_get_try_int(qobject_to_qnum(entry->value), &length) &&
-                length > 0 && length <=3D UINT_MAX) {
+            if (length > 0 && length <=3D UINT_MAX) {
                 block_acct_add_interval(stats, (unsigned) length);
             } else {
                 error_setg(errp, "Invalid interval length: %" PRId64, leng=
th);
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a8f09c1..68cd653 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -71,7 +71,7 @@ static void set_enum(Object *obj, Visitor *v, const char =
*name, void *opaque,
=20
 static void set_default_value_enum(Object *obj, const Property *prop)
 {
-    object_property_set_str(obj, prop->info->enum_table[prop->defval.u],
+    object_property_set_str(obj, prop->info->enum_table[prop->defval.i],
                             prop->name, &error_abort);
 }
=20
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-=
visitor.c
index 3bcdb9a..34bab8a 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -152,6 +152,7 @@ static void test_visitor_in_uint(TestInputVisitorData *=
data,
     g_assert_cmpuint(res, =3D=3D, 18446744073709551574U);
=20
     visit_type_number(v, NULL, &dbl, &error_abort);
+    g_assert_cmpfloat(dbl, =3D=3D, 18446744073709552000.0);
 }
=20
 static void test_visitor_in_int_overflow(TestInputVisitorData *data,
@@ -161,9 +162,10 @@ static void test_visitor_in_int_overflow(TestInputVisi=
torData *data,
     Error *err =3D NULL;
     Visitor *v;
=20
-    /* this will overflow a QNUM_I64, so should be deserialized into a
+    /*
+     * This will overflow a QNUM_I64, so should be deserialized into a
      * QNUM_DOUBLE field instead, leading to an error if we pass it to
-     * visit_type_int. confirm this.
+     * visit_type_int().  Confirm this.
      */
     v =3D visitor_input_test_init(data, "%f", DBL_MAX);
=20
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-outpu=
t-visitor.c
index d23c8eb..749c540 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -609,11 +609,13 @@ static void check_native_list(QObject *qobj,
         for (i =3D 0; i < 32; i++) {
             QObject *tmp;
             QNum *qvalue;
+            uint64_t val;
=20
             tmp =3D qlist_peek(qlist);
             g_assert(tmp);
             qvalue =3D qobject_to_qnum(tmp);
-            g_assert_cmpuint(qnum_get_uint(qvalue), =3D=3D, i);
+            g_assert(qnum_get_try_uint(qvalue, &val));
+            g_assert_cmpint(val, =3D=3D, i);
             qobject_decref(qlist_pop(qlist));
         }
         break;
