Received: from eggs.gnu.org ([2001:4830:134:3::10]:33278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Up-0001V7-Gs
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uo-0000H7-49
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Un-0000GQ-Sw
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:42 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:56:57 +0100
Message-Id: <1489582656-31133-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-2.9 08/47] tests/qapi-schema: Cover
 empty union base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

The new test case shows off qapi.py choking on an empty union base.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include                  |  1 +
 tests/qapi-schema/union-base-empty.err  | 10 ++++++++++
 tests/qapi-schema/union-base-empty.exit |  1 +
 tests/qapi-schema/union-base-empty.json |  9 +++++++++
 tests/qapi-schema/union-base-empty.out  |  0
 5 files changed, 21 insertions(+)
 create mode 100644 tests/qapi-schema/union-base-empty.err
 create mode 100644 tests/qapi-schema/union-base-empty.exit
 create mode 100644 tests/qapi-schema/union-base-empty.json
 create mode 100644 tests/qapi-schema/union-base-empty.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 16e0a9f..3e640a8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -476,6 +476,7 @@ qapi-schema +=3D unclosed-list.json
 qapi-schema +=3D unclosed-object.json
 qapi-schema +=3D unclosed-string.json
 qapi-schema +=3D unicode-str.json
+qapi-schema +=3D union-base-empty.json
 qapi-schema +=3D union-base-no-discriminator.json
 qapi-schema +=3D union-branch-case.json
 qapi-schema +=3D union-clash-branches.json
diff --git a/tests/qapi-schema/union-base-empty.err b/tests/qapi-schema/u=
nion-base-empty.err
new file mode 100644
index 0000000..26bfa07
--- /dev/null
+++ b/tests/qapi-schema/union-base-empty.err
@@ -0,0 +1,10 @@
+Traceback (most recent call last):
+  File "tests/qapi-schema/test-qapi.py", line 56, in <module>
+    schema =3D QAPISchema(sys.argv[1])
+  File "scripts/qapi.py", line 1487, in __init__
+    self.exprs =3D check_exprs(parser.exprs)
+  File "scripts/qapi.py", line 921, in check_exprs
+    check_union(expr, info)
+  File "scripts/qapi.py", line 738, in check_union
+    assert base_members
+AssertionError
diff --git a/tests/qapi-schema/union-base-empty.exit b/tests/qapi-schema/=
union-base-empty.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/union-base-empty.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/union-base-empty.json b/tests/qapi-schema/=
union-base-empty.json
new file mode 100644
index 0000000..d1843d3
--- /dev/null
+++ b/tests/qapi-schema/union-base-empty.json
@@ -0,0 +1,9 @@
+# Flat union with empty base and therefore without discriminator
+
+{ 'struct': 'Empty', 'data': { } }
+
+{ 'union': 'TestUnion',
+  'base': 'Empty',
+  'discriminator': 'type',
+  'data': { 'value1': 'int',
+            'value2': 'str' } }
diff --git a/tests/qapi-schema/union-base-empty.out b/tests/qapi-schema/u=
nion-base-empty.out
new file mode 100644
index 0000000..e69de29
--=20
2.7.4
