Received: from eggs.gnu.org ([2001:4830:134:3::10]:39564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfx-0002DE-1b
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfv-0003Y5-N4
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1faNfv-0003Xf-JE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22B8CDFE3
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:57:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  3 Jul 2018 17:56:44 +0200
Message-Id: <20180703155648.11933-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180703155648.11933-1-marcandre.lureau@redhat.com>
References: <20180703155648.11933-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 10/14] qapi/events: add #if conditions to
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Wrap generated code with #if/#endif using an 'ifcontext' on
QAPIGenCSnippet objects.

This makes a conditional event's qapi_event_send_FOO() compile-time
conditional, but its enum QAPIEvent member remains unconditional for
now. A follow up patch "qapi-event: add 'if' condition to implicit
event enum" will improve this.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
2.18.0.rc1
