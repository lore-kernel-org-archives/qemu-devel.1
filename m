Received: from eggs.gnu.org ([209.51.188.92]:59935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYo-0001qs-Ih
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYm-0005Rz-Ju
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvjYm-0005PV-95
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0EAD86663
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 71F051048102
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 15:06:05 +0100
Message-Id: <20190218140607.31998-17-armbru@redhat.com>
In-Reply-To: <20190218140607.31998-1-armbru@redhat.com>
References: <20190218140607.31998-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/18] Revert "qapi-events: add 'if' condition
 to implicit event enum"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This reverts commit 7bd263490590ee6fcf34ecb6203437e22f6e5a9c.

The commit applied the events' conditions to the members of enum
QAPIEvent.  Awkward, because it renders QAPIEvent unusable in
target-independent code as soon as we make an event target-dependent.
Reverting this has the following effects:

* ui/vnc.c can remain target independent.

* monitor_qapi_event_conf[] doesn't have to muck around with #ifdef.

* query-events again doesn't reflect conditionals.  I'm going to
  deprecate it in favor of query-qmp-schema.

Another option would be to split target-dependent parts off enum
QAPIEvent into a target-dependent enum.  Doesn't seem worthwhile right
now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190214152251.2073-17-armbru@redhat.com>
---
 scripts/qapi/events.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 28bbc3745d..2067660be4 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -193,7 +193,9 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdic=
t);
             self._genc.add(gen_event_send(name, arg_type, boxed,
                                           self._event_enum_name,
                                           self._event_emit_name))
-        self._event_enum_members.append(QAPISchemaMember(name, ifcond))
+        # Note: we generate the enum member regardless of @ifcond, to
+        # keep the enumeration usable in target-independent code.
+        self._event_enum_members.append(QAPISchemaMember(name))
=20
=20
 def gen_events(schema, output_dir, prefix):
--=20
2.17.2
