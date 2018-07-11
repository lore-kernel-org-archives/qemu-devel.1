Received: from eggs.gnu.org ([2001:4830:134:3::10]:36097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdFx7-0001IV-H1
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdFx6-0003hk-Ix
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fdFx6-0003hc-Du
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 11 Jul 2018 22:18:26 +0800
Message-Id: <20180711141829.17406-2-famz@redhat.com>
In-Reply-To: <20180711141829.17406-1-famz@redhat.com>
References: <20180711141829.17406-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] tests: Add an option for snapshot
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
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Not using snapshot has the benefit of automatically persisting useful
test harnesses, such as docker images and ccache database. Although it
will lose some cleanness, it is imaginably useful for patchew.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3643117816..e5d6a328d5 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -216,6 +216,8 @@ def parse_args(vm_name):
                       help="build QEMU from source in guest")
     parser.add_option("--interactive", "-I", action="store_true",
                       help="Interactively run command")
+    parser.add_option("--snapshot", "-s", action="store_true",
+                      help="run tests with a snapshot")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -241,7 +243,10 @@ def main(vmcls):
                    jobs=args.jobs)]
         else:
             cmd = argv
-        vm.boot(args.image + ",snapshot=on")
+        img = args.image
+        if args.snapshot:
+            img += ",snapshot=on"
+        vm.boot(img)
         vm.wait_ssh()
     except Exception as e:
         if isinstance(e, SystemExit) and e.code == 0:
-- 
2.17.1
