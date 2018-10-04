Received: from eggs.gnu.org ([2001:4830:134:3::10]:47095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Kt-0005yz-Lf
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Ks-0006FX-Sb
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g85Ks-0006FG-Mq
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:42 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 11:14:29 -0400
Message-Id: <20181004151429.7232-8-crosa@redhat.com>
In-Reply-To: <20181004151429.7232-1-crosa@redhat.com>
References: <20181004151429.7232-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] Acceptance Tests: change the handling of
 tests for specific archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

With the introduction of a variants file that can run the same
tests on various architectures, it makes sense to make most tests
to be reusable on those environments.  The exception should be
when a test is really testing a specific architecture feature.

With the change proposed here, on a command line such as:

  $ avocado run \
     --json-variants-load=tests/acceptance/variants/arch.json \
     -- tests/acceptance/

The boot_linux_console.py tests will appear as "CANCELED: Currently
specific to the x86_64 arch", which is as a good thing when compared
to being ignored by tags because:

 * The architecture specific parts can be addressed
 * It will be run on the matching architecture (as opposed to always
   being filtered out by the tags mechanism)
 * CANCELED tests do no influence negatively the overall job results,
   they're not considered an error or failure

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 58032f971c..2fb5da63cb 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -19,12 +19,13 @@ class BootLinuxConsole(Test):
     and the kernel command line is properly passed from QEMU to the kernel
 
     :avocado: enable
-    :avocado: tags=x86_64
     """
 
     timeout = 60
 
     def test(self):
+        if self.arch != 'x86_64':
+            self.cancel('Currently specific to the x86_64 arch')
         kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
                       'Everything/x86_64/os/images/pxeboot/vmlinuz')
         kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
-- 
2.17.1
