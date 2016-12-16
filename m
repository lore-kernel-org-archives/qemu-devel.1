Received: from eggs.gnu.org ([2001:4830:134:3::10]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cHnoA-0007pE-Dj
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cHno7-0000ar-9c
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:24:02 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:41351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cHno6-0000U1-Sv
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:23:59 -0500
From: hangaohuai <hangaohuai@huawei.com>
Date: Fri, 16 Dec 2016 16:23:22 +0800
Message-ID: <20161216082322.14160-1-hangaohuai@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] bugfix: vm halt when in reset looping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, arei.gonglei@huawei.com, hangaohuai@huawei.com

reset mc146818rtc device when RESET event happens.

Fix the problem:
  1. Guest boot the second cpu, set CMOS_RESET_CODE 0x0a to protect selfboot;
  2. VM being reset by others, hmp_system_reset;
  3. seabios resume check the CMOS_RESET_CODE, if 0x0a, jump to the BDA
     resume execution by jump via 40h:0067h;
  4. Guest halt;

Signed-off-by: hangaohuai <hangaohuai@huawei.com>
---
 hw/timer/mc146818rtc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index da209d0..341b233 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -946,11 +946,22 @@ static Property mc146818rtc_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void rtc_resetdev(DeviceState *d)
+{
+    RTCState *s = MC146818_RTC(d);
+
+    /* Reason: VM do suspend self will set 0xfe
+     * Only handle the VM boot case */
+    if (s->cmos_data[0x0f] == 0x0a)
+        s->cmos_data[0x0f] = 0x00;
+}
+
 static void rtc_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = rtc_realizefn;
+    dc->reset = rtc_resetdev;
     dc->vmsd = &vmstate_rtc;
     dc->props = mc146818rtc_properties;
     /* Reason: needs to be wired up by rtc_init() */
-- 
1.8.3.1
