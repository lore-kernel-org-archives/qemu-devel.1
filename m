Received: from eggs.gnu.org ([2001:4830:134:3::10]:37466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCYfK-0001Mc-4v
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 19:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCYfF-0007i5-6A
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 19:22:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCYfE-0007aR-4O
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 19:22:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FA59CD185
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 23:22:11 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
Date: Tue, 16 Oct 2018 19:22:01 -0400
Message-Id: <20181016232201.16829-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

The host arch name is not always the target arch name, so it's
necessary to have a mapping.

The configure scripts contains what is the authoritative and failproof
mapping, but, reusing it is not straightforward, so it's replicated in
the acceptance tests supporting code.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 configure                                 |  2 ++
 tests/acceptance/avocado_qemu/__init__.py | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/configure b/configure
index 8af2be959f..e029b756d4 100755
--- a/configure
+++ b/configure
@@ -6992,6 +6992,8 @@ TARGET_ARCH="$target_name"
 TARGET_BASE_ARCH=""
 TARGET_ABI_DIR=""
 
+# When updating target_name => TARGET_ARCH, please also update the
+# HOST_TARGET_ARCH mapping in tests/acceptance/avocado_qemu/__init__.py
 case "$target_name" in
   i386)
     mttcg="yes"
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 1e54fd5932..d9bc4736ec 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -19,6 +19,28 @@ sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
 
 from qemu import QEMUMachine
 
+
+#: Mapping of host arch names to target arch names.  It's expected that the
+#: arch identification on the host, using os.uname()[4], would return the
+#: key (LHS).  The QEMU target name, and consequently the target binary, would
+#: be based on the name on the value (RHS).
+HOST_TARGET_ARCH = {
+    'armeb': 'arm',
+    'aarch64_be': 'aarch64',
+    'microblazeel': 'microblaze',
+    'mipsel': 'mips',
+    'mipsn32el' : 'mips64',
+    'mips64el': 'mips64',
+    'or1k': 'openrisc',
+    'ppc64le': 'ppc64',
+    'ppc64abi32': 'ppc64',
+    'riscv64': 'riscv',
+    'sh4eb': 'sh4',
+    'sparc32plus': 'sparc64',
+    'xtensaeb': 'xtensa'
+    }
+
+
 def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
 
@@ -29,6 +51,7 @@ def pick_default_qemu_bin():
     directory or in the source tree root directory.
     """
     arch = os.uname()[4]
+    arch = HOST_TARGET_ARCH.get(arch, arch)
     qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
                                           "qemu-system-%s" % arch)
     if is_readable_executable_file(qemu_bin_relative_path):
-- 
2.17.1
