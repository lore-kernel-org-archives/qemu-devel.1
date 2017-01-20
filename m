Received: from eggs.gnu.org ([2001:4830:134:3::10]:53365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIQ-000423-9G
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIM-0006EQ-GR
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:02 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:21 +0100
Message-Id: <20170120133139.31080-18-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/35] pc: fix crash in rtc_set_memory() if
 initial cpu is marked as hotplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

'hotplugged' propperty is meant to be used on migration side when migrating
source with hotplugged devices.
However though it not exacly correct usage of 'hotplugged' property
it's possible to set generic hotplugged property for CPU using
 -cpu foo,hotplugged=on
or
 -global foo.hotplugged=on

in this case qemu crashes with following backtrace:

...

because pc_cpu_plug() assumes that hotplugged CPU could appear only after
rtc/fw_cfg are initialized.
Fix crash by replacing assumption with explicit checks of rtc/fw_cfg
and updating them only if they were initialized.

Cc: qemu-stable@nongnu.org
Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1483108391-199542-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 25e8586..f721fde 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1820,8 +1820,10 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
 
     /* increment the number of CPUs */
     pcms->boot_cpus++;
-    if (dev->hotplugged) {
+    if (pcms->rtc) {
         rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
+    }
+    if (pcms->fw_cfg) {
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
 
-- 
2.9.3
