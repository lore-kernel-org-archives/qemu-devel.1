Received: from eggs.gnu.org ([2001:4830:134:3::10]:35239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvM8-0006GL-MO
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvM3-0005my-Er
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:28 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38566)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvM3-0005mq-7M
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:23 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 24 Jan 2017 10:17:24 +0300
Message-ID: <20170124071724.4572.85855.stgit@PASHA-ISP>
In-Reply-To: <20170124071654.4572.41407.stgit@PASHA-ISP>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 05/14] apic: save apic_delivered flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch implements saving/restoring of static apic_delivered variable.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 hw/intc/apic_common.c           |   32 ++++++++++++++++++++++++++++++++
 include/hw/i386/apic_internal.h |    2 ++
 2 files changed, 34 insertions(+)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index d78c885..ac6cc67 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -384,6 +384,24 @@ static bool apic_common_sipi_needed(void *opaque)
     return s->wait_for_sipi != 0;
 }
 
+static bool apic_irq_delivered_needed(void *opaque)
+{
+    return true;
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
@@ -396,6 +414,19 @@ static const VMStateDescription vmstate_apic_common_sipi = {
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
@@ -430,6 +461,7 @@ static const VMStateDescription vmstate_apic_common = {
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
