Received: from eggs.gnu.org ([2001:4830:134:3::10]:43393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZB-00063t-IL
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZA-0006u4-H4
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMZA-0006tb-BU
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83AC910B1A2
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:07:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:06:04 +0200
Message-Id: <20170911110623.24981-32-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 31/50] docs: document schema configuration
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 0a90f2278a..24fc6f74ee 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -682,6 +682,43 @@ Example: Red Hat, Inc. controls redhat.com, and may =
therefore add a
 downstream command __com.redhat_drive-mirror.
=20
=20
+=3D=3D=3D Configuring the schema =3D=3D=3D
+
+'struct', 'enum', 'union', 'alternate', 'command' and 'event'
+top-level QAPI expressions can take a 'if' keyword like:
+
+{ 'struct': 'IfStruct', 'data': { 'foo': 'int' },
+  'if': 'defined(IF_STRUCT) && defined(FOO)' }
+
+Members can be exploded as dictionnary with 'type' & 'if' keys:
+
+{ 'struct': 'IfStruct', 'data':
+  { 'foo': 'int',
+    'bar': { 'type': 'int', 'if': 'defined(IF_STRUCT_BAR)'} } }
+
+Enum values can be exploded as dictionnary with 'name' & 'if' keys:
+
+{ 'enum': 'IfEnum', 'data':
+  [ 'foo',
+    { 'name' : 'bar', 'if': 'defined(IF_ENUM_BAR)' } ] }
+
+The C code generators will wrap the corresponding lines with #if / #endi=
f
+pre-processor conditions for a given 'if' value.
+
+Example for enum values:
+
+enum IfEnum {
+     IF_ENUM_FOO,
+#if defined(IF_ENUM_BAR)
+     IF_ENUM_BAR,
+#endif /* defined(IF_ENUM_BAR) */
+     IF_ENUM__MAX
+}
+
+Please note that you are responsbile to ensure that the C code will
+compile with an arbitrary combination of conditions, since the
+generators are unable to check it at this point.
+
 =3D=3D Client JSON Protocol introspection =3D=3D
=20
 Clients of a Client JSON Protocol commonly need to figure out what
--=20
2.14.1.146.gd35faa819
