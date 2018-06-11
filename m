Received: from eggs.gnu.org ([2001:4830:134:3::10]:60699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqU-00021n-KQ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqQ-0000K2-GZ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqQ-0000Jl-8O
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:40 -0300
Message-Id: <20180611174243.31070-11-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/13] python: futurize -f
 lib2to3.fixes.fix_numliterals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Convert octal literals into the new syntax.

This is necessary for Python 3 compatibility.

Done using:

  $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_numliterals $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-11-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qom-fuse   |  6 +++---
 tests/qemu-iotests/118 | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index b00cb0a0af..e524e798fc 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -90,7 +90,7 @@ class QOMFS(Fuse):
=20
     def getattr(self, path):
         if self.is_link(path):
-            value =3D posix.stat_result((0755 | stat.S_IFLNK,
+            value =3D posix.stat_result((0o755 | stat.S_IFLNK,
                                        self.get_ino(path),
                                        0,
                                        2,
@@ -101,7 +101,7 @@ class QOMFS(Fuse):
                                        0,
                                        0))
         elif self.is_object(path):
-            value =3D posix.stat_result((0755 | stat.S_IFDIR,
+            value =3D posix.stat_result((0o755 | stat.S_IFDIR,
                                        self.get_ino(path),
                                        0,
                                        2,
@@ -112,7 +112,7 @@ class QOMFS(Fuse):
                                        0,
                                        0))
         elif self.is_property(path):
-            value =3D posix.stat_result((0644 | stat.S_IFREG,
+            value =3D posix.stat_result((0o644 | stat.S_IFREG,
                                        self.get_ino(path),
                                        0,
                                        1,
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index a0469b570e..ff3b2ae3e7 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -390,14 +390,14 @@ class TestChangeReadOnly(ChangeBaseClass):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.chmod(old_img, 0666)
-        os.chmod(new_img, 0666)
+        os.chmod(old_img, 0o666)
+        os.chmod(new_img, 0o666)
         os.remove(old_img)
         os.remove(new_img)
=20
     def test_ro_ro_retain(self):
-        os.chmod(old_img, 0444)
-        os.chmod(new_img, 0444)
+        os.chmod(old_img, 0o444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk,read-only=3Don', 'none'=
)
         self.vm.add_device('floppy,drive=3Ddrive0,id=3D%s' % self.device=
_name)
         self.vm.launch()
@@ -417,7 +417,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new=
_img)
=20
     def test_ro_rw_retain(self):
-        os.chmod(old_img, 0444)
+        os.chmod(old_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk,read-only=3Don', 'none'=
)
         self.vm.add_device('floppy,drive=3Ddrive0,id=3D%s' % self.device=
_name)
         self.vm.launch()
@@ -437,7 +437,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new=
_img)
=20
     def test_rw_ro_retain(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
         self.vm.add_device('floppy,drive=3Ddrive0,id=3D%s' % self.device=
_name)
         self.vm.launch()
@@ -459,7 +459,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old=
_img)
=20
     def test_ro_rw(self):
-        os.chmod(old_img, 0444)
+        os.chmod(old_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk,read-only=3Don', 'none'=
)
         self.vm.add_device('floppy,drive=3Ddrive0,id=3D%s' % self.device=
_name)
         self.vm.launch()
@@ -480,7 +480,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new=
_img)
=20
     def test_rw_ro(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
         self.vm.add_device('floppy,drive=3Ddrive0,id=3D%s' % self.device=
_name)
         self.vm.launch()
@@ -521,7 +521,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new=
_img)
=20
     def test_make_ro_rw(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
         self.vm.add_device('floppy,drive=3Ddrive0,id=3D%s' % self.device=
_name)
         self.vm.launch()
@@ -542,7 +542,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old=
_img)
=20
     def test_make_rw_ro_by_retain(self):
-        os.chmod(old_img, 0444)
+        os.chmod(old_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk,read-only=3Don', 'none'=
)
         self.vm.add_device('floppy,drive=3Ddrive0,id=3D%s' % self.device=
_name)
         self.vm.launch()
@@ -562,7 +562,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new=
_img)
=20
     def test_make_ro_rw_by_retain(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
         self.vm.add_device('floppy,drive=3Ddrive0,id=3D%s' % self.device=
_name)
         self.vm.launch()
@@ -582,7 +582,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old=
_img)
=20
     def test_rw_ro_cycle(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
         self.vm.add_device('floppy,drive=3Ddrive0,id=3D%s' % self.device=
_name)
         self.vm.launch()
--=20
2.18.0.rc1.1.g3f1ff2140
