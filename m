Received: from eggs.gnu.org ([2001:4830:134:3::10]:45597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReA-0000Of-2b
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe6-0002x1-MP
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe6-0002vl-Dx
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:32 +0100
Message-Id: <1488702958-24336-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 01/27] qga: Fix crash on non-dictionary QMP
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

The value of key 'arguments' must be a JSON object.  qemu-ga neglects
to check, and crashes.  To reproduce, send

    { 'execute': 'guest-sync', 'arguments': [] }

to qemu-ga.

do_qmp_dispatch() uses qdict_get_qdict() to get the arguments.  When
not a JSON object, this gets a null pointer, which flows through the
generated marshalling function to qobject_input_visitor_new(), where
it fails the assertion.  qmp_dispatch_check_obj() needs to catch this
error.

QEMU isn't affected, because it runs qmp_check_input_obj() first,
which basically duplicates qmp_dispatch_check_obj()'s checks, plus the
missing one.

Fix by copying the missing one from qmp_check_input_obj() to
qmp_dispatch_check_obj().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488544368-30622-2-git-send-email-armbru@redhat.com>
---
 qapi/qmp-dispatch.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 48bec20..621922f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -47,7 +47,13 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
                 return NULL;
             }
             has_exec_key = true;
-        } else if (strcmp(arg_name, "arguments")) {
+        } else if (!strcmp(arg_name, "arguments")) {
+            if (qobject_type(arg_obj) != QTYPE_QDICT) {
+                error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
+                           "arguments", "object");
+                return NULL;
+            }
+        } else {
             error_setg(errp, QERR_QMP_EXTRA_MEMBER, arg_name);
             return NULL;
         }
-- 
2.7.4
