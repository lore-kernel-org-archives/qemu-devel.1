Received: from eggs.gnu.org ([2001:4830:134:3::10]:44148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSVB-0000yR-LX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSV7-0000P2-O5
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSV7-0000OM-I6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 349F8DFEF
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:06:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:06:09 +0200
Message-Id: <20180703210613.25619-11-armbru@redhat.com>
In-Reply-To: <20180703210613.25619-1-armbru@redhat.com>
References: <20180703210613.25619-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/14] qapi/events: add #if conditions to events
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

Wrap generated code with #if/#endif using an 'ifcontext' on
QAPIGenCSnippet objects.

This makes a conditional event's qapi_event_send_FOO() compile-time
conditional, but its enum QAPIEvent member remains unconditional for
now. A follow up patch "qapi-event: add 'if' condition to implicit
event enum" will improve this.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180703155648.11933-11-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/events.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 0a1afac134..764ef177ab 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -185,8 +185,10 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVi=
sitor):
         genc.add(gen_enum_lookup(self._enum_name, self._event_names))
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
-        self._genh.add(gen_event_send_decl(name, arg_type, boxed))
-        self._genc.add(gen_event_send(name, arg_type, boxed, self._enum_=
name))
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._genh.add(gen_event_send_decl(name, arg_type, boxed))
+            self._genc.add(gen_event_send(name, arg_type, boxed,
+                                          self._enum_name))
         self._event_names.append(name)
=20
=20
--=20
2.17.1
