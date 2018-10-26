Received: from eggs.gnu.org ([2001:4830:134:3::10]:52372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2uO-0002BR-Qt
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2uK-0006HH-BA
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2uK-0006GS-5F
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:12 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:29 +0800
Message-Id: <20181026141529.4305-10-famz@redhat.com>
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] tests/vm: Do not abuse parallelism when
 HOST != TARGET architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20181013004034.6968-9-f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 9f4794898a..5caf77d6b8 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -200,10 +200,10 @@ class BaseVM(object):
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
=20
-def parse_args(vm_name):
+def parse_args(vmcls):
=20
     def get_default_jobs():
-        if kvm_available():
+        if kvm_available(vmcls.arch):
             return multiprocessing.cpu_count() / 2
         else:
             return 1
@@ -216,7 +216,7 @@ def parse_args(vm_name):
                     "3 =3D test command failed")
     parser.add_option("--debug", "-D", action=3D"store_true",
                       help=3D"enable debug output")
-    parser.add_option("--image", "-i", default=3D"%s.img" % vm_name,
+    parser.add_option("--image", "-i", default=3D"%s.img" % vmcls.name,
                       help=3D"image file name")
     parser.add_option("--force", "-f", action=3D"store_true",
                       help=3D"force build image even if image exists")
@@ -237,7 +237,7 @@ def parse_args(vm_name):
=20
 def main(vmcls):
     try:
-        args, argv =3D parse_args(vmcls.name)
+        args, argv =3D parse_args(vmcls)
         if not argv and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
--=20
2.17.1
