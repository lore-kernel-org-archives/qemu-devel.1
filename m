Received: from eggs.gnu.org ([2001:4830:134:3::10]:49587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViH-000524-Hp
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViC-0001Wi-GO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fEViC-0001Ut-3I
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44CD14270961
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:05:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  4 May 2018 10:04:51 +0200
Message-Id: <20180504080454.11014-8-armbru@redhat.com>
In-Reply-To: <20180504080454.11014-1-armbru@redhat.com>
References: <20180504080454.11014-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] qapi: add SysEmuTarget to "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

We'll soon need an enumeration type that lists all the softmmu targets
that QEMU (the project) supports. Introduce @SysEmuTarget to
"common.json".

The enum constant @x86_64 doesn't match the QAPI convention of preferring
hyphen ("-") over underscore ("_"). This is intentional; the @SysEmuTarget
constants are supposed to produce QEMU executable names when stringified
and appended to the "qemu-system-" prefix. Put differently, the
replacement text of the TARGET_NAME preprocessor macro must be possible to
look up in the list of (stringified) enum constants.

Like other enum types, @SysEmuTarget too can be used for discriminator
fields in unions. For the @i386 constant, a C-language union member called
"i386" would be generated. On mingw build hosts, "i386" is a macro
however. Add "i386" to "polluted_words" at once.

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20180427192852.15013-3-lersek@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/common.json       | 23 +++++++++++++++++++++++
 scripts/qapi/common.py |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/qapi/common.json b/qapi/common.json
index d9b14dd429..c811d04984 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -126,3 +126,26 @@
 ##
 { 'enum': 'OffAutoPCIBAR',
   'data': [ 'off', 'auto', 'bar0', 'bar1', 'bar2', 'bar3', 'bar4', 'bar5' ] }
+
+##
+# @SysEmuTarget:
+#
+# The comprehensive enumeration of QEMU system emulation ("softmmu")
+# targets. Run "./configure --help" in the project root directory, and
+# look for the *-softmmu targets near the "--target-list" option. The
+# individual target constants are not documented here, for the time
+# being.
+#
+# Notes: The resulting QMP strings can be appended to the "qemu-system-"
+#        prefix to produce the corresponding QEMU executable name. This
+#        is true even for "qemu-system-x86_64".
+#
+# Since: 2.13
+##
+{ 'enum' : 'SysEmuTarget',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
+             'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
+             'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
+             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4',
+             'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
+             'x86_64', 'xtensa', 'xtensaeb' ] }
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3e14bc41f2..a032cec375 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1822,7 +1822,7 @@ def c_name(name, protect=True):
                      'and', 'and_eq', 'bitand', 'bitor', 'compl', 'not',
                      'not_eq', 'or', 'or_eq', 'xor', 'xor_eq'])
     # namespace pollution:
-    polluted_words = set(['unix', 'errno', 'mips', 'sparc'])
+    polluted_words = set(['unix', 'errno', 'mips', 'sparc', 'i386'])
     name = name.translate(c_name_trans)
     if protect and (name in c89_words | c99_words | c11_words | gcc_words
                     | cpp_words | polluted_words):
-- 
2.13.6
