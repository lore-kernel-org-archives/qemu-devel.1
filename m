Received: from eggs.gnu.org ([2001:4830:134:3::10]:36004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OX-0003NJ-W6
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OW-0000p6-Dg
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gA1OW-0000nJ-4S
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:28 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  9 Oct 2018 19:26:07 -0400
Message-Id: <20181009232607.15521-8-crosa@redhat.com>
In-Reply-To: <20181009232607.15521-1-crosa@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/7] Acceptance Tests: change the handling
 of tests for specific archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

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
index 58032f971c..ba3ac036da 100644
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
+            self.cancel('Currently specific to the x86_64 target arch')
         kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
                       'Everything/x86_64/os/images/pxeboot/vmlinuz')
         kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
-- 
2.17.1
