Received: from eggs.gnu.org ([2001:4830:134:3::10]:36256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIs-0007XR-6d
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIo-0000x0-Ns
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:26 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 22:27:01 +0100
Message-Id: <1488317230-26248-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1488317230-26248-1-git-send-email-armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/24] test-visitor-serialization: Pass
 &error_abort to qobject_from_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

qmp_deserialize() calls qobject_from_json() ignoring errors.  It
passes the result to qobject_input_visitor_new(), which asserts it's
not null.  Therefore, we can just as well pass &error_abort to
qobject_from_json().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-visitor-serialization.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-serialization.c
index 37dff41..4d47cee 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -1037,7 +1037,7 @@ static void qmp_deserialize(void **native_out, void *datap,
     visit_complete(d->qov, &d->obj);
     obj_orig = d->obj;
     output_json = qobject_to_json(obj_orig);
-    obj = qobject_from_json(qstring_get_str(output_json), NULL);
+    obj = qobject_from_json(qstring_get_str(output_json), &error_abort);
 
     QDECREF(output_json);
     d->qiv = qobject_input_visitor_new(obj);
-- 
2.7.4
