Received: from eggs.gnu.org ([2001:4830:134:3::10]:41018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qk-0001ig-Sy
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qe-0004wn-R2
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45136
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qe-0004vq-K7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8pVY008175
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29afu7a82v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:31 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:31 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:04 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-41-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 40/81] pc: fix crash in rtc_set_memory() if
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
Cc: qemu-stable@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
(cherry picked from commit 26ef65beab852caf2b1ef4976e3473f2d525164d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a9e64a8..02cc5a2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1818,8 +1818,10 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
 
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
2.7.4
