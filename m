Received: from eggs.gnu.org ([2001:4830:134:3::10]:52617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBq-0006lo-Qb
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBl-00007G-9P
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBk-0008WD-QP
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:21 +0200
Message-Id: <20180808120334.10970-44-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 43/56] qjson: Fix qobject_from_json() & friends
 for multiple values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

qobject_from_json() & friends use the consume_json() callback to
receive either a value or an error from the parser.

When they are fed a string that contains more than either one JSON
value or one JSON syntax error, consume_json() gets called multiple
times.

When the last call receives a value, qobject_from_json() returns that
value.  Any other values are leaked.

When any call receives an error, qobject_from_json() sets the first
error received.  Any other errors are thrown away.

When values follow errors, qobject_from_json() returns both a value
and sets an error.  That's bad.  Impact:

* block.c's parse_json_protocol() ignores and leaks the value.  It's
  used to to parse pseudo-filenames starting with "json:".  The
  pseudo-filenames can come from the user or from image meta-data such
  as a QCOW2 image's backing file name.

* vl.c's parse_display_qapi() ignores and leaks the error.  It's used
  to parse the argument of command line option -display.

* vl.c's main() case QEMU_OPTION_blockdev ignores the error and leaves
  it in @err.  main() will then pass a pointer to a non-null Error *
  to net_init_clients(), which is forbidden.  It can lead to assertion
  failure or other misbehavior.

* check-qjson.c's multiple_values() demonstrates the badness.

* The other callers are not affected since they only pass strings with
  exactly one JSON value or, in the case of negative tests, one
  error.

The impact on the _nofail() functions is relatively harmless.  They
abort when any call receives an error.  Else they return the last
value, and leak the others, if any.

Fix consume_json() as follows.  On the first call, save value and
error as before.  On subsequent calls, if any, don't save them.  If
the first call saved a value, the next call, if any, replaces the
value by an "Expecting at most one JSON value" error.  Take care not
to leak values or errors that aren't saved.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/qjson.c     | 15 ++++++++++++++-
 tests/check-qjson.c | 10 +++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/qobject/qjson.c b/qobject/qjson.c
index 7395556069..7f69036487 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -33,8 +33,21 @@ static void consume_json(void *opaque, QObject *json, Error *err)
 {
     JSONParsingState *s = opaque;
 
+    assert(!json != !err);
+    assert(!s->result || !s->err);
+
+    if (s->result) {
+        qobject_unref(s->result);
+        s->result = NULL;
+        error_setg(&s->err, "Expecting at most one JSON value");
+    }
+    if (s->err) {
+        qobject_unref(json);
+        error_free(err);
+        return;
+    }
     s->result = json;
-    error_propagate(&s->err, err);
+    s->err = err;
 }
 
 /*
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index fbb607c227..30b1b037d3 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1388,17 +1388,13 @@ static void multiple_values(void)
     Error *err = NULL;
     QObject *obj;
 
-    /* BUG this leaks the syntax tree for "false" */
     obj = qobject_from_json("false true", &err);
-    g_assert(qbool_get_bool(qobject_to(QBool, obj)));
-    g_assert(!err);
-    qobject_unref(obj);
+    error_free_or_abort(&err);
+    g_assert(obj == NULL);
 
-    /* BUG simultaneously succeeds and fails */
     obj = qobject_from_json("} true", &err);
-    g_assert(qbool_get_bool(qobject_to(QBool, obj)));
     error_free_or_abort(&err);
-    qobject_unref(obj);
+    g_assert(obj == NULL);
 }
 
 int main(int argc, char **argv)
-- 
2.17.1
