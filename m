Received: from eggs.gnu.org ([2001:4830:134:3::10]:44509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9fDH-00006x-MU
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 19:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9fDD-0000YZ-Kv
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 19:13:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f9fDD-0000Xo-GT
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 19:13:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6650340201A6
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 23:13:01 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat, 21 Apr 2018 01:12:44 +0200
Message-Id: <20180420231246.23130-2-lersek@redhat.com>
In-Reply-To: <20180420231246.23130-1-lersek@redhat.com>
References: <20180420231246.23130-1-lersek@redhat.com>
Subject: [Qemu-devel] [qemu RFC v3 1/3] qapi: add SysEmuTarget to
 "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: "Daniel P. Berrange" <berrange@redhat.com>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

We'll soon need an enumeration type that lists all the softmmu targets
that QEMU (the project) supports. Introduce @SysEmuTarget to
"common.json".

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: David Gibson <dgibson@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
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

 qapi/common.json | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/qapi/common.json b/qapi/common.json
index d9b14dd429f3..1fd63172754a 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -126,3 +126,22 @@
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
+# Since: 2.13
+##
+{ 'enum' : 'SysEmuTarget',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
+             'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
+             'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
+             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4',
+             'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
+             'x86_64', 'xtensa', 'xtensaeb' ] }
-- 
2.14.1.3.gb7cf6e02401b
