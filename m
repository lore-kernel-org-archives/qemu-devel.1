Received: from eggs.gnu.org ([2001:4830:134:3::10]:48271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIA-0004vD-74
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycI7-0007eQ-9I
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycI7-0007e2-54
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6C7176FB9
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:24 +0100
Message-Id: <20180321115211.17937-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/49] qapi/events: generate event enum in
 main module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The event generator produces an enum, and put it in the last visited
module. It fits better in the main module, since it's the set of all
visited events, from all modules.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/events.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 3dc523cf39..3e448ae523 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -180,8 +180,9 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
                              types=3Dtypes))
=20
     def visit_end(self):
-        self._genh.add(gen_enum(self._enum_name, self._event_names))
-        self._genc.add(gen_enum_lookup(self._enum_name, self._event_name=
s))
+        (genc, genh) =3D self._module[self._main_module]
+        genh.add(gen_enum(self._enum_name, self._event_names))
+        genc.add(gen_enum_lookup(self._enum_name, self._event_names))
=20
     def visit_event(self, name, info, arg_type, boxed):
         self._genh.add(gen_event_send_decl(name, arg_type, boxed))
--=20
2.16.2.521.g9aa15f885a
