Received: from eggs.gnu.org ([2001:4830:134:3::10]:53730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93V-00065F-JK
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93U-00010O-FT
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fC93U-0000w7-AN
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E6ACEBFF7
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 19:29:10 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 27 Apr 2018 21:28:49 +0200
Message-Id: <20180427192852.15013-3-lersek@redhat.com>
In-Reply-To: <20180427192852.15013-1-lersek@redhat.com>
References: <20180427192852.15013-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/5] qapi: add SysEmuTarget to "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

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
---

Notes:
    PATCHv3:
    
    - copy the suggested (shorter) Notes: wrt. underscore use in @x86_64 to
      the schema, and move the original (longer) schema Notes: to the commit
      message [Eric]
    
    - no R-b's picked up due to the above change
    
    PATCHv2:
    
    - document the use of the underscore in @x86_64 in both the commit
      message and in the schema [Eric, Dan]
    
    - extend "polluted_words" with "i386" [Eric]
    
    - drop previous R-b's
    
    - update the CC list
    
    PATCHv1:
    
    - pick up R-b's from Markus and Kashyap, no changes
    
    RFCv3:
    
    - The patch is new in this version. [Dan, Markus]
    
    - The original idea was to call the new enum @Target; however, @Target
      generates exactly the TARGET_AARCH64, TARGET_ALPHA, TARGET_ARM, ...
      enumeration constants that conflict with the poisoned preprocessing
      macros of the same names. Hence @SysEmuTarget -- it's more accurate
      anyway, since we want it to stand for system emulation targets.
    
    - Also, we discussed defining the new type in either "common.json" or
      "misc.json". "misc.json" turned out to be a problem: "firmware.json"
      would then include "misc.json" for the new type's sake, but that
      inclusion would become the first appearance of "misc.json" -- within
      "firmware.json". That messed up the generated documentation. By adding
      the new type to "common.json", "misc.json" (see the 2nd patch) and
      "firmware.json" (see the 3rd patch) can both consume the new type
      without problems.

 qapi/common.json       | 23 +++++++++++++++++++++++
 scripts/qapi/common.py |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/qapi/common.json b/qapi/common.json
index d9b14dd429f3..c811d0498457 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -118,11 +118,34 @@
 #
 # @bar3: PCI BAR3 is used for the feature
 #
 # @bar4: PCI BAR4 is used for the feature
 #
 # @bar5: PCI BAR5 is used for the feature
 #
 # Since: 2.12
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
index 3e14bc41f2c0..a032cec37509 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1814,23 +1814,23 @@ def c_name(name, protect=True):
     # C++ ISO/IEC 14882:2003 2.11
     cpp_words = set(['bool', 'catch', 'class', 'const_cast', 'delete',
                      'dynamic_cast', 'explicit', 'false', 'friend', 'mutable',
                      'namespace', 'new', 'operator', 'private', 'protected',
                      'public', 'reinterpret_cast', 'static_cast', 'template',
                      'this', 'throw', 'true', 'try', 'typeid', 'typename',
                      'using', 'virtual', 'wchar_t',
                      # alternative representations
                      'and', 'and_eq', 'bitand', 'bitor', 'compl', 'not',
                      'not_eq', 'or', 'or_eq', 'xor', 'xor_eq'])
     # namespace pollution:
-    polluted_words = set(['unix', 'errno', 'mips', 'sparc'])
+    polluted_words = set(['unix', 'errno', 'mips', 'sparc', 'i386'])
     name = name.translate(c_name_trans)
     if protect and (name in c89_words | c99_words | c11_words | gcc_words
                     | cpp_words | polluted_words):
         return 'q_' + name
     return name
 
 eatspace = '\033EATSPACE.'
 pointer_suffix = ' *' + eatspace
 
 
 def genindent(count):
-- 
2.14.1.3.gb7cf6e02401b
