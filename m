Received: from eggs.gnu.org ([2001:4830:134:3::10]:53719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93V-00064p-3r
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93T-0000zs-V4
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fC93T-0000zf-Pu
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67E074276E3C
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 19:29:15 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 27 Apr 2018 21:28:52 +0200
Message-Id: <20180427192852.15013-6-lersek@redhat.com>
In-Reply-To: <20180427192852.15013-1-lersek@redhat.com>
References: <20180427192852.15013-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/5] qapi: deprecate CpuInfoFast.arch
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
---

Notes:
    PATCHv3:
    
    - new patch [Markus, Eric]

 qapi/misc.json | 8 ++++----
 qemu-doc.texi  | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index fa4eec7b6b63..f5988cc0b52d 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -550,27 +550,27 @@
 # Information about a virtual CPU
 #
 # @cpu-index: index of the virtual CPU
 #
 # @qom-path: path to the CPU object in the QOM tree
 #
 # @thread-id: ID of the underlying host thread
 #
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
 ##
 { 'union'         : 'CpuInfoFast',
   'base'          : { 'cpu-index'    : 'int',
                       'qom-path'     : 'str',
                       'thread-id'    : 'int',
                       '*props'       : 'CpuInstanceProperties',
                       'arch'         : 'CpuInfoArch',
                       'target'       : 'SysEmuTarget' },
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 5813d276156a..0ed0f19e6bab 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2941,22 +2941,27 @@ by the ``convert -l snapshot_param'' argument instead.
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
 
 "autoload" parameter is now ignored. All bitmaps are automatically loaded
 from qcow2 images.
 
 @subsection query-cpus (since 2.12.0)
 
 The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
 
+@subsection query-cpus-fast "arch" output member (since 2.13.0)
+
+The ``arch'' output member of the ``query-cpus-fast'' command is
+replaced by the ``target'' output member.
+
 @section System emulator devices
 
 @subsection ivshmem (since 2.6.0)
 
 The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
 or ``ivshmem-doorbell`` device types.
 
 @subsection Page size support < 4k for embedded PowerPC CPUs (since 2.12.0)
 
 qemu-system-ppcemb will be removed. qemu-system-ppc (or qemu-system-ppc64)
 should be used instead. That means that embedded 4xx PowerPC CPUs will not
-- 
2.14.1.3.gb7cf6e02401b
