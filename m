Received: from eggs.gnu.org ([2001:4830:134:3::10]:39810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zD-00022H-9I
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zC-0000Yo-JO
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zC-0000YQ-Ci
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id i8-v6so13695801wmg.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 17:40:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 02:40:33 +0200
Message-Id: <20181013004034.6968-9-f4bug@amsat.org>
In-Reply-To: <20181013004034.6968-1-f4bug@amsat.org>
References: <20181013004034.6968-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 8/8] tests/vm: Do not abuse parallelism when
 HOST != TARGET architecture
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
 tests/vm/basevm.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 9f4794898a..5caf77d6b8 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -200,10 +200,10 @@ class BaseVM(object):
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
 
-def parse_args(vm_name):
+def parse_args(vmcls):
 
     def get_default_jobs():
-        if kvm_available():
+        if kvm_available(vmcls.arch):
             return multiprocessing.cpu_count() / 2
         else:
             return 1
@@ -216,7 +216,7 @@ def parse_args(vm_name):
                     "3 = test command failed")
     parser.add_option("--debug", "-D", action="store_true",
                       help="enable debug output")
-    parser.add_option("--image", "-i", default="%s.img" % vm_name,
+    parser.add_option("--image", "-i", default="%s.img" % vmcls.name,
                       help="image file name")
     parser.add_option("--force", "-f", action="store_true",
                       help="force build image even if image exists")
@@ -237,7 +237,7 @@ def parse_args(vm_name):
 
 def main(vmcls):
     try:
-        args, argv = parse_args(vmcls.name)
+        args, argv = parse_args(vmcls)
         if not argv and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
-- 
2.19.1
