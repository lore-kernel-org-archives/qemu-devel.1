Received: from eggs.gnu.org ([2001:4830:134:3::10]:49612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViK-00058U-J0
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViC-0001XA-IG
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fEViC-0001Us-34
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 612824270963
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:05:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  4 May 2018 10:04:54 +0200
Message-Id: <20180504080454.11014-11-armbru@redhat.com>
In-Reply-To: <20180504080454.11014-1-armbru@redhat.com>
References: <20180504080454.11014-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] qapi: deprecate CpuInfoFast.arch
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

The TARGET_BASE_ARCH values from "configure" don't all map to the
@CpuInfoArch enum constants; in particular "s390x" from the former does
not match @s390 in the latter. Clients are known to rely on the @s390
constant specifically, so we can't change it silently. Instead, deprecate
the @CpuInfoFast.@arch member (in favor of @CpuInfoFast.@target) using the
regular deprecation process.

(No deprecation reminder is added to sysemu_target_to_cpuinfo_arch(): once
@CpuInfoFast.@arch is removed, the assignment expression that calls
sysemu_target_to_cpuinfo_arch() from qmp_query_cpus_fast() will have to
disappear; in turn the static function left without callers will also
break the build, thus it'll have to go.)

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20180427192852.15013-6-lersek@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc.json | 8 ++++----
 qemu-doc.texi  | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index fa4eec7b6b..f5988cc0b5 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -558,11 +558,11 @@
 # @props: properties describing to which node/socket/core/thread
 #         virtual CPU belongs to, provided if supported by board
 #
-# @arch: base architecture of the cpu
+# @arch: base architecture of the cpu; deprecated since 2.13.0 in favor
+#        of @target
 #
-# @target: the QEMU system emulation target, which is more specific than
-#          @arch and determines which additional fields will be listed
-#          (since 2.13)
+# @target: the QEMU system emulation target, which determines which
+#          additional fields will be listed (since 2.13)
 #
 # Since: 2.12
 #
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 5813d27615..0ed0f19e6b 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2949,6 +2949,11 @@ from qcow2 images.
 
 The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
 
+@subsection query-cpus-fast "arch" output member (since 2.13.0)
+
+The ``arch'' output member of the ``query-cpus-fast'' command is
+replaced by the ``target'' output member.
+
 @section System emulator devices
 
 @subsection ivshmem (since 2.6.0)
-- 
2.13.6
