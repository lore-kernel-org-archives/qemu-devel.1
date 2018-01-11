Received: from eggs.gnu.org ([2001:4830:134:3::10]:51514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWM-0007Tl-PF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWM-0004Ow-17
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkWL-0004Nv-RX
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:21 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:31 +0100
Message-Id: <20180111213250.16511-33-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 32/51] docs: document schema configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index f58d62686a..479b755609 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -682,6 +682,44 @@ Example: Red Hat, Inc. controls redhat.com, and may =
therefore add a
 downstream command __com.redhat_drive-mirror.
=20
=20
+=3D=3D=3D Configuring the schema =3D=3D=3D
+
+Top-level QAPI expressions and various type expressions listed below
+can take an 'if' key.  The value must be a string or a list of
+string.  The corresponding generated code will then guard the inclusion
+of that member in the larger struct or function with #if IFCOND
+(or several #if lines for a list), where IFCOND is the value of the
+'if' key.
+
+'struct', 'enum', 'union', 'alternate', 'command' and 'event'
+top-level QAPI expressions can take an 'if' keyword like:
+
+{ 'struct': 'IfStruct', 'data': { 'foo': 'int' },
+  'if': 'defined(IFCOND)' }
+
+Where a member can normally be defined with a single string value as its
+type, it is also possible to supply a dictionary with both 'type' and
+'if' keys.
+
+{ 'struct': 'IfStruct', 'data':
+  { 'foo': 'int',
+    'bar': { 'type': 'int', 'if': 'defined(IFCOND)'} } }
+
+An enum value can be replaced by a dictionary with a 'name' and a 'if'
+key:
+
+{ 'enum': 'IfEnum', 'data':
+  [ 'foo',
+    { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
+
+Please note that you are responsible to ensure that the C code will
+compile with an arbitrary combination of conditions, since the
+generators are unable to check it at this point.
+
+The presence of 'if' keys in the schema is reflected through to the
+introspection output depending on the build configuration.
+
+
 =3D=3D Client JSON Protocol introspection =3D=3D
=20
 Clients of a Client JSON Protocol commonly need to figure out what
--=20
2.16.0.rc1.1.gef27df75a1
