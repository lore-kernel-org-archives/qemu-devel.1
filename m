Received: from eggs.gnu.org ([2001:4830:134:3::10]:50052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfw9-0006Xo-8x
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfw6-0002oV-1N
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:57 -0500
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com
	([104.47.32.64]:50906
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfw5-0002o5-RP
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:53 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:41 -0600
Message-Id: <20171206200346.116537-19-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 18/23] sev: emit the SEV_MEASUREMENT event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

During machine creation we encrypted the guest bios image, the
LAUNCH_MEASURE command can be used to retrieve the measurement of
the encrypted memory region. Emit the SEV_MEASUREMENT event so that
libvirt can grab the measurement value as soon as we are done with
creating the encrypted machine.

Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/sev.c      | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/sev.h |  1 +
 2 files changed, 59 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index 83fc950bd3ac..c0eea371fa06 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -18,6 +18,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sev.h"
 #include "sysemu/sysemu.h"
+#include "qapi-event.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
@@ -32,6 +33,7 @@
 #endif
 
 static int sev_fd;
+static SEVState *sev_state;
 
 #define SEV_FW_MAX_ERROR      0x17
 
@@ -399,6 +401,59 @@ err:
     return ret;
 }
 
+static void
+sev_launch_get_measure(Notifier *notifier, void *unused)
+{
+    int ret, error;
+    guchar *data;
+    SEVState *s = sev_state;
+    struct kvm_sev_launch_measure *measurement;
+
+    measurement = g_malloc0(sizeof(*measurement));
+    if (!measurement) {
+        return;
+    }
+
+    /* query the measurement blob length */
+    ret = sev_ioctl(KVM_SEV_LAUNCH_MEASURE, measurement, &error);
+    if (!measurement->len) {
+        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
+                     __func__, ret, error, fw_error_to_str(errno));
+        goto free_measurement;
+    }
+
+    s->cur_state = SEV_STATE_SECRET;
+
+    data = g_malloc(measurement->len);
+    if (s->measurement) {
+        goto free_data;
+    }
+
+    measurement->uaddr = (unsigned long)data;
+
+    /* get the measurement blob */
+    ret = sev_ioctl(KVM_SEV_LAUNCH_MEASURE, measurement, &error);
+    if (ret) {
+        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
+                     __func__, ret, error, fw_error_to_str(errno));
+        goto free_data;
+    }
+
+    s->measurement = g_base64_encode(data, measurement->len);
+
+    DPRINTF("SEV: MEASUREMENT: %s\n", s->measurement);
+    qapi_event_send_sev_measurement(s->measurement, &error_abort);
+
+free_data:
+    g_free(data);
+free_measurement:
+    g_free(measurement);
+}
+
+static Notifier sev_machine_done_notify = {
+    .notify = sev_launch_get_measure,
+};
+
 void *
 sev_guest_init(const char *id)
 {
@@ -441,6 +496,9 @@ sev_guest_init(const char *id)
     }
 
     ram_block_notifier_add(&sev_ram_notifier);
+    qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+
+    sev_state = s;
 
     return s;
 err:
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index b1ea3f805290..3af945935b60 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -64,6 +64,7 @@ enum {
 struct SEVState {
     QSevGuestInfo *sev_info;
     int cur_state;
+    gchar *measurement;
 };
 
 typedef struct SEVState SEVState;
-- 
2.9.5
