Received: from eggs.gnu.org ([2001:4830:134:3::10]:53685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93S-0005yd-Hz
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93Q-0000xp-UE
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fC93Q-0000xb-Oo
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55CFD427360E
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 19:29:12 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 27 Apr 2018 21:28:50 +0200
Message-Id: <20180427192852.15013-4-lersek@redhat.com>
In-Reply-To: <20180427192852.15013-1-lersek@redhat.com>
References: <20180427192852.15013-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/5] qapi: change the type of
 TargetInfo.arch from string to enum SysEmuTarget
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

Now that we have @SysEmuTarget, it makes sense to restrict
@TargetInfo.@arch to valid sysemu targets at the schema level.

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---

Notes:
    PATCHv3:
    
    - pick up Eric's R-b
    
    - no change
    
    PATCHv2:
    
    - drop naive code comment in qmp_query_target() [Markus]
    
    - pick up Markus's R-b
    
    - update CC list
    
    PATCHv1:
    
    - qmp_query_target(): pass (-1) as fallback value [Markus]
    - qmp_query_target(): catch lookup error with error_abort [Markus]
    
    RFCv3:
    
    - The patch is new in this version. [Markus]

 qapi/misc.json | 6 ++++--
 arch_init.c    | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 104d013adba6..460866cf542f 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1,18 +1,20 @@
 # -*- Mode: Python -*-
 #
 
 ##
 # = Miscellanea
 ##
 
+{ 'include': 'common.json' }
+
 ##
 # @qmp_capabilities:
 #
 # Enable QMP capabilities.
 #
 # Arguments:
 #
 # @enable:   An optional list of QMPCapability values to enable.  The
 #            client must not enable any capability that is not
 #            mentioned in the QMP greeting message.  If the field is not
 #            provided, it means no QMP capabilities will be enabled.
@@ -2441,28 +2443,28 @@
 #      ]
 #    }
 #
 ##
 { 'command': 'query-fdsets', 'returns': ['FdsetInfo'] }
 
 ##
 # @TargetInfo:
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
 #
 # Return information about the target for this QEMU
 #
 # Returns: TargetInfo
 #
 # Since: 1.2.0
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
diff --git a/arch_init.c b/arch_init.c
index 6ee07478bd11..9597218ceda3 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -21,22 +21,23 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
 #include "hw/audio/soundhw.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/acpi.h"
 #include "qemu/help_option.h"
 
 #ifdef TARGET_SPARC
 int graphic_width = 1024;
 int graphic_height = 768;
 int graphic_depth = 8;
 #else
 int graphic_width = 800;
@@ -104,15 +105,16 @@ int xen_available(void)
     return 1;
 #else
     return 0;
 #endif
 }
 
 
 TargetInfo *qmp_query_target(Error **errp)
 {
     TargetInfo *info = g_malloc0(sizeof(*info));
 
-    info->arch = g_strdup(TARGET_NAME);
+    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, -1,
+                                 &error_abort);
 
     return info;
 }
-- 
2.14.1.3.gb7cf6e02401b
