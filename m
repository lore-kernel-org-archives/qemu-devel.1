Received: from eggs.gnu.org ([2001:4830:134:3::10]:52144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u7-0001yN-Hy
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u6-00063K-NB
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2u6-0005tQ-Da
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:23 +0800
Message-Id: <20181026141529.4305-4-famz@redhat.com>
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/9] tests/vm: Do not abuse parallelism when KVM
 is not available
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
Message-Id: <20181013004034.6968-3-f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 834bc90cc1..2bd32dc6ce 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -196,6 +196,13 @@ class BaseVM(object):
         return self._guest.qmp(*args, **kwargs)
=20
 def parse_args(vm_name):
+
+    def get_default_jobs():
+        if kvm_available():
+            return multiprocessing.cpu_count() / 2
+        else:
+            return 1
+
     parser =3D optparse.OptionParser(
         description=3D"VM test utility.  Exit codes: "
                     "0 =3D success, "
@@ -208,7 +215,7 @@ def parse_args(vm_name):
                       help=3D"image file name")
     parser.add_option("--force", "-f", action=3D"store_true",
                       help=3D"force build image even if image exists")
-    parser.add_option("--jobs", type=3Dint, default=3Dmultiprocessing.cp=
u_count() / 2,
+    parser.add_option("--jobs", type=3Dint, default=3Dget_default_jobs()=
,
                       help=3D"number of virtual CPUs")
     parser.add_option("--verbose", "-V", action=3D"store_true",
                       help=3D"Pass V=3D1 to builds within the guest")
--=20
2.17.1
