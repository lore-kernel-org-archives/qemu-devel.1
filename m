Received: from eggs.gnu.org ([209.51.188.92]:48538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJni-0008Fo-Ph
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJne-0000Dz-5M
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:46:44 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 23 Jan 2019 15:46:05 +0100
Message-Id: <20190123144610.8842-5-mreitz@redhat.com>
In-Reply-To: <20190123144610.8842-1-mreitz@redhat.com>
References: <20190123144610.8842-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/9] iotests: Fix 207 to use QMP filters for
 qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Fixes: 08fcd6111e1949f456e1b232ebeeb0cc17019a92
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/207     | 10 +++++++---
 tests/qemu-iotests/207.out |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index c617ee7453..dfd3c51bd1 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -27,12 +27,16 @@ import re
 iotests.verify_image_format(supported_fmts=3D['raw'])
 iotests.verify_protocol(supported=3D['ssh'])
=20
-def filter_hash(msg):
-    return re.sub('"hash": "[0-9a-f]+"', '"hash": HASH', msg)
+def filter_hash(qmsg):
+    def _filter(key, value):
+        if key =3D=3D 'hash' and re.match('[0-9a-f]+', value):
+            return 'HASH'
+        return value
+    return iotests.filter_qmp(qmsg, _filter)
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
-                        filters=3D[iotests.filter_testfiles, filter_hash=
])
+                        filters=3D[iotests.filter_qmp_testfiles, filter_=
hash])
=20
     if 'return' in result:
         assert result['return'] =3D=3D {}
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 45ac7c2a8f..88d2240f54 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -40,7 +40,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": HASH, "mode":=
 "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"host":=
 "127.0.0.1", "port": "22"}}, "size": 8388608}}}
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "mode=
": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"host=
": "127.0.0.1", "port": "22"}}, "size": 8388608}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -55,7 +55,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": HASH, "mode":=
 "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"host"=
: "127.0.0.1", "port": "22"}}, "size": 4194304}}}
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "mode=
": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"hos=
t": "127.0.0.1", "port": "22"}}, "size": 4194304}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
--=20
2.20.1
