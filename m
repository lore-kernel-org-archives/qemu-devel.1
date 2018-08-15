Received: from eggs.gnu.org ([2001:4830:134:3::10]:56951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFP-0007AF-PL
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFO-0001CZ-Ql
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFK-00016C-Hj
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:39 +0800
Message-Id: <20180815031248.14908-9-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/17] tests: Add an option for snapshot
 (default: off)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Not using snapshot has the benefit of automatically persisting useful
test harnesses, such as docker images and ccache database. Although it
will lose some cleanness, it is imaginably useful for patchew.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180712012829.20231-2-famz@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index d80cc8ab85..1f1579dc9a 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -217,6 +217,8 @@ def parse_args(vm_name):
                       help=3D"build QEMU from source in guest")
     parser.add_option("--interactive", "-I", action=3D"store_true",
                       help=3D"Interactively run command")
+    parser.add_option("--snapshot", "-s", action=3D"store_true",
+                      help=3D"run tests with a snapshot")
     parser.disable_interspersed_args()
     return parser.parse_args()
=20
@@ -242,7 +244,10 @@ def main(vmcls):
                    jobs=3Dargs.jobs)]
         else:
             cmd =3D argv
-        vm.boot(args.image + ",snapshot=3Don")
+        img =3D args.image
+        if args.snapshot:
+            img +=3D ",snapshot=3Don"
+        vm.boot(img)
         vm.wait_ssh()
     except Exception as e:
         if isinstance(e, SystemExit) and e.code =3D=3D 0:
--=20
2.17.1
