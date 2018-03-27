Received: from eggs.gnu.org ([2001:4830:134:3::10]:49229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcN-0007Tp-L8
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcM-0004yo-E6
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcM-0004yd-6W
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:30 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:09 -0500
Message-Id: <20180327143014.1767669-10-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/14] tests: add oob-test for qapi-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Peter Xu <peterx@redhat.com>

It simply tests the new OOB capability, and make sure the QAPISchema can
parse it correctly.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180326063901.27425-7-peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/test-qmp-cmds.c                   | 4 ++++
 tests/Makefile.include                  | 1 +
 tests/qapi-schema/oob-test.err          | 1 +
 tests/qapi-schema/oob-test.exit         | 1 +
 tests/qapi-schema/oob-test.json         | 2 ++
 tests/qapi-schema/oob-test.out          | 0
 tests/qapi-schema/qapi-schema-test.json | 3 +++
 tests/qapi-schema/qapi-schema-test.out  | 2 ++
 8 files changed, 14 insertions(+)
 create mode 100644 tests/qapi-schema/oob-test.err
 create mode 100644 tests/qapi-schema/oob-test.exit
 create mode 100644 tests/qapi-schema/oob-test.json
 create mode 100644 tests/qapi-schema/oob-test.out

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 93fbbb1b733..db690cc5ae2 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -16,6 +16,10 @@ void qmp_user_def_cmd(Error **errp)
 {
 }

+void qmp_an_oob_command(Error **errp)
+{
+}
+
 Empty2 *qmp_user_def_cmd0(Error **errp)
 {
     return g_new0(Empty2, 1);
diff --git a/tests/Makefile.include b/tests/Makefile.include
index eb218a9539d..3b9a5e31a2c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -523,6 +523,7 @@ qapi-schema +=3D missing-comma-object.json
 qapi-schema +=3D missing-type.json
 qapi-schema +=3D nested-struct-data.json
 qapi-schema +=3D non-objects.json
+qapi-schema +=3D oob-test.json
 qapi-schema +=3D pragma-doc-required-crap.json
 qapi-schema +=3D pragma-extra-junk.json
 qapi-schema +=3D pragma-name-case-whitelist-crap.json
diff --git a/tests/qapi-schema/oob-test.err b/tests/qapi-schema/oob-test.=
err
new file mode 100644
index 00000000000..35b60f74800
--- /dev/null
+++ b/tests/qapi-schema/oob-test.err
@@ -0,0 +1 @@
+tests/qapi-schema/oob-test.json:2: 'allow-oob' of command 'oob-command-1=
' should only use true value
diff --git a/tests/qapi-schema/oob-test.exit b/tests/qapi-schema/oob-test=
.exit
new file mode 100644
index 00000000000..d00491fd7e5
--- /dev/null
+++ b/tests/qapi-schema/oob-test.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/oob-test.json b/tests/qapi-schema/oob-test=
.json
new file mode 100644
index 00000000000..da9635920fb
--- /dev/null
+++ b/tests/qapi-schema/oob-test.json
@@ -0,0 +1,2 @@
+# Check against oob illegal value
+{ 'command': 'oob-command-1', 'allow-oob': 'some-string' }
diff --git a/tests/qapi-schema/oob-test.out b/tests/qapi-schema/oob-test.=
out
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index c72dbd80509..06e30f452ea 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -139,6 +139,9 @@
 { 'command': 'boxed-struct', 'boxed': true, 'data': 'UserDefZero' }
 { 'command': 'boxed-union', 'data': 'UserDefNativeListUnion', 'boxed': t=
rue }

+# Smoke test on Out-Of-Band
+{ 'command': 'an-oob-command', 'allow-oob': true }
+
 # For testing integer range flattening in opts-visitor. The following sc=
hema
 # corresponds to the option format:
 #
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 4f43370017c..467577d770b 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -166,6 +166,8 @@ command boxed-struct UserDefZero -> None
    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse
 command boxed-union UserDefNativeListUnion -> None
    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse
+command an-oob-command None -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DTrue
 object UserDefOptions
     member i64: intList optional=3DTrue
     member u64: uint64List optional=3DTrue
--=20
2.14.3
