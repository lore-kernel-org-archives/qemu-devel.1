Received: from eggs.gnu.org ([2001:4830:134:3::10]:45191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgK-00032h-OG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgI-0003Gs-9U
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:36 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:36371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgH-0003Gc-Ln
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:33 -0500
Received: by mail-wj0-x241.google.com with SMTP id dh1so11693389wjb.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:34:55 +0100
Message-Id: <1484163327-111841-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/33] bugfix: vm halt when in reset looping
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
1.8.3.1
