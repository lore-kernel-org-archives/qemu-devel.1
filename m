Received: from eggs.gnu.org ([2001:4830:134:3::10]:49592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViI-00053Z-8T
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViC-0001WT-F2
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fEViC-0001Ux-19
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C2B94026779
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:05:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  4 May 2018 10:04:52 +0200
Message-Id: <20180504080454.11014-9-armbru@redhat.com>
In-Reply-To: <20180504080454.11014-1-armbru@redhat.com>
References: <20180504080454.11014-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] qapi: change the type of TargetInfo.arch
 from string to enum SysEmuTarget
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

Now that we have @SysEmuTarget, it makes sense to restrict
@TargetInfo.@arch to valid sysemu targets at the schema level.

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180427192852.15013-4-lersek@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 arch_init.c    | 4 +++-
 qapi/misc.json | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch_init.c b/arch_init.c
index 6ee07478bd..9597218ced 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci.h"
 #include "hw/audio/soundhw.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/acpi.h"
@@ -112,7 +113,8 @@ TargetInfo *qmp_query_target(Error **errp)
 {
     TargetInfo *info = g_malloc0(sizeof(*info));
 
-    info->arch = g_strdup(TARGET_NAME);
+    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, -1,
+                                 &error_abort);
 
     return info;
 }
diff --git a/qapi/misc.json b/qapi/misc.json
index 104d013adb..460866cf54 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -5,6 +5,8 @@
 # = Miscellanea
 ##
 
+{ 'include': 'common.json' }
+
 ##
 # @qmp_capabilities:
 #
@@ -2449,12 +2451,12 @@
 #
 # Information describing the QEMU target.
 #
-# @arch: the target architecture (eg "x86_64", "i386", etc)
+# @arch: the target architecture
 #
 # Since: 1.2.0
 ##
 { 'struct': 'TargetInfo',
-  'data': { 'arch': 'str' } }
+  'data': { 'arch': 'SysEmuTarget' } }
 
 ##
 # @query-target:
-- 
2.13.6
