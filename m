Received: from eggs.gnu.org ([2001:4830:134:3::10]:39709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z6-0001wX-3f
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z5-0000Ur-Bz
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:48 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z5-0000UU-4r
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id z25-v6so19032611wmf.1
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 17:40:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 02:40:27 +0200
Message-Id: <20181013004034.6968-3-f4bug@amsat.org>
In-Reply-To: <20181013004034.6968-1-f4bug@amsat.org>
References: <20181013004034.6968-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/8] tests/vm: Do not abuse parallelism when
 KVM is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Use default args.jobs
v2: Add get_default_jobs (Fam suggestion)
---
 tests/vm/basevm.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 834bc90cc1..2bd32dc6ce 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -196,6 +196,13 @@ class BaseVM(object):
         return self._guest.qmp(*args, **kwargs)
 
 def parse_args(vm_name):
+
+    def get_default_jobs():
+        if kvm_available():
+            return multiprocessing.cpu_count() / 2
+        else:
+            return 1
+
     parser = optparse.OptionParser(
         description="VM test utility.  Exit codes: "
                     "0 = success, "
@@ -208,7 +215,7 @@ def parse_args(vm_name):
                       help="image file name")
     parser.add_option("--force", "-f", action="store_true",
                       help="force build image even if image exists")
-    parser.add_option("--jobs", type=int, default=multiprocessing.cpu_count() / 2,
+    parser.add_option("--jobs", type=int, default=get_default_jobs(),
                       help="number of virtual CPUs")
     parser.add_option("--verbose", "-V", action="store_true",
                       help="Pass V=1 to builds within the guest")
-- 
2.19.1
