Received: from eggs.gnu.org ([2001:4830:134:3::10]:58566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQa-0003Xf-0O
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQY-0003Kk-Pn
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fYDQY-0003KM-In
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:18 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Jun 2018 18:35:47 +0200
Message-Id: <20180627163551.31610-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180627163551.31610-1-marcandre.lureau@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 11/15] qapi/events: add #if conditions to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Wrap generated code with #if/#endif using an 'ifcontext' on
QAPIGenCSnippet objects.

This makes a conditional event's qapi_event_send_FOO() compile-time
conditional, but its enum QAPIEvent member remains unconditional for
now. A follow up patch "qapi-event: add 'if' condition to implicit
event enum" will improve this.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
