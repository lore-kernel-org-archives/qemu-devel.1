Received: from eggs.gnu.org ([2001:4830:134:3::10]:43738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK16-0003cl-1I
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK14-0002jx-2K
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZK13-0002LK-M9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53B2D58E2C
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:22:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 19:22:32 +0100
Message-Id: <20181218182234.28876-14-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-1-armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 13/15] Revert "qapi-events: add 'if'
 condition to implicit event enum"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

This reverts commit 7bd263490590ee6fcf34ecb6203437e22f6e5a9c.

The commit applied the events' conditions to the members of enum
QAPIEvent.  Awkward, because it renders QAPIEvent unusable in
target-independent code as soon as we make an event target-dependent.
Reverting this has the following effects:

* ui/vnc.c can remain target independent.

* monitor_qapi_event_conf[] doesn't have to muck around with #ifdef.

* query-events again doesn't reflect conditionals.  I'm going to
  deprecate it in favor of query-qmp-schema.

Signed-off-by: Markus Armbruster <armbru@redhat.com>

# Conflicts:
#	scripts/qapi/events.py
---
 scripts/qapi/events.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index e988e43941..c944ba90b8 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -194,7 +194,9 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdict);
             self._genc.add(gen_event_send(name, arg_type, boxed,
                                           self._event_enum_name,
                                           self._event_emit_name))
-        self._event_enum_members.append(QAPISchemaMember(name, ifcond))
+        # Note: we generate the enum member regardless of @ifcond, to
+        # keep the enumeration usable in target-independent code.
+        self._event_enum_members.append(QAPISchemaMember(name))
 
 
 def gen_events(schema, output_dir, prefix):
-- 
2.17.2
