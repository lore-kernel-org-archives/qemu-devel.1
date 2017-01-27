Received: from eggs.gnu.org ([2001:4830:134:3::10]:33346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qn-0004tH-QQ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qm-0003qG-Um
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:01 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qm-0003pi-OX
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:00 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so58370365wmr.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:15 +0100
Message-Id: <1485524749-118532-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/41] apic: save apic_delivered flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch implements saving/restoring of static apic_delivered variable.

v8: saving static variable only for one of the APICs

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20170126123429.5412.94368.stgit@PASHA-ISP>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/apic_common.c           | 33 +++++++++++++++++++++++++++++++++
 include/hw/i386/apic_internal.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 3945dfd..17df24c 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -385,6 +385,25 @@ static bool apic_common_sipi_needed(void *opaque)
     return s->wait_for_sipi != 0;
 }
 
+static bool apic_irq_delivered_needed(void *opaque)
+{
+    APICCommonState *s = APIC_COMMON(opaque);
+    return s->cpu == X86_CPU(first_cpu) && apic_irq_delivered != 0;
+}
+
+static void apic_irq_delivered_pre_save(void *opaque)
+{
+    APICCommonState *s = APIC_COMMON(opaque);
+    s->apic_irq_delivered = apic_irq_delivered;
+}
+
+static int apic_irq_delivered_post_load(void *opaque, int version_id)
+{
+    APICCommonState *s = APIC_COMMON(opaque);
+    apic_irq_delivered = s->apic_irq_delivered;
+    return 0;
+}
+
 static const VMStateDescription vmstate_apic_common_sipi = {
     .name = "apic_sipi",
     .version_id = 1,
@@ -397,6 +416,19 @@ static const VMStateDescription vmstate_apic_common_sipi = {
     }
 };
 
+static const VMStateDescription vmstate_apic_irq_delivered = {
+    .name = "apic_irq_delivered",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = apic_irq_delivered_needed,
+    .pre_save = apic_irq_delivered_pre_save,
+    .post_load = apic_irq_delivered_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT32(apic_irq_delivered, APICCommonState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_apic_common = {
     .name = "apic",
     .version_id = 3,
@@ -431,6 +463,7 @@ static const VMStateDescription vmstate_apic_common = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_apic_common_sipi,
+        &vmstate_apic_irq_delivered,
         NULL
     }
 };
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 1209eb4..20ad28c 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -189,6 +189,8 @@ struct APICCommonState {
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
     bool legacy_instance_id;
+
+    int apic_irq_delivered; /* for saving static variable */
 };
 
 typedef struct VAPICState {
-- 
1.8.3.1
