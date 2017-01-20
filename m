Received: from eggs.gnu.org ([2001:4830:134:3::10]:52965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZI9-0003lz-Q5
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZI6-0005t0-K5
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUZI6-0005sL-Dz
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:42 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:05 +0100
Message-Id: <20170120133139.31080-2-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/35] bugfix: vm halt when in reset looping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: hangaohuai <hangaohuai@huawei.com>

From: hangaohuai <hangaohuai@huawei.com>

reset mc146818rtc device when RESET event happens.

Fix the problem:
  1. Guest boot the second cpu, set CMOS_RESET_CODE 0x0a to protect selfboot;
  2. VM being reset by others, hmp_system_reset;
  3. seabios resume check the CMOS_RESET_CODE, if 0x0a, jump to the BDA
     resume execution by jump via 40h:0067h;
  4. Guest halt;

Signed-off-by: hangaohuai <hangaohuai@huawei.com>
Message-Id: <20161219060336.10176-1-hangaohuai@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index da209d0..637f872 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -946,11 +946,23 @@ static Property mc146818rtc_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void rtc_resetdev(DeviceState *d)
+{
+    RTCState *s = MC146818_RTC(d);
+
+    /* Reason: VM do suspend self will set 0xfe
+     * Reset any values other than 0xfe(Guest suspend case) */
+    if (s->cmos_data[0x0f] != 0xfe) {
+        s->cmos_data[0x0f] = 0x00;
+    }
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
2.9.3
