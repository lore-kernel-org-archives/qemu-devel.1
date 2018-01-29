Received: from eggs.gnu.org ([2001:4830:134:3::10]:49166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRi-0005mu-Qb
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRh-0003ep-H8
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:18 -0500
Received: from mail-dm3nam03on061a.outbound.protection.outlook.com
	([2a01:111:f400:fe49::61a]:43136
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1egDRh-0003e4-CA
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:17 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 29 Jan 2018 11:41:27 -0600
Message-Id: <20180129174132.108925-19-brijesh.singh@amd.com>
In-Reply-To: <20180129174132.108925-1-brijesh.singh@amd.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 18/23] sev: emit the SEV_MEASUREMENT event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>

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
 accel/kvm/sev.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 accel/kvm/trace-events |  1 +
 include/sysemu/sev.h   |  1 +
 3 files changed, 60 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index 1f757df725df..b78cf3144b1d 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -19,11 +19,13 @@
 #include "sysemu/sev.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
+#include "qapi-event.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
 static int sev_fd;
+static SEVState *sev_state;
 
 #define SEV_FW_MAX_ERROR      0x17
 
@@ -418,6 +420,59 @@ err:
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
+    sev_set_guest_state(SEV_STATE_SECRET);
+
+    /* encode the measurement value and emit the event */
+    s->measurement = g_base64_encode(data, measurement->len);
+    trace_kvm_sev_launch_measurement(s->measurement);
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
@@ -461,6 +516,9 @@ sev_guest_init(const char *id)
     }
 
     ram_block_notifier_add(&sev_ram_notifier);
+    qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+
+    sev_state = s;
 
     return s;
 err:
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index c55546f36a25..51df5113ad07 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -20,3 +20,4 @@ kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_sev_change_state(char *old, char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
+kvm_sev_launch_measurement(const char *value) "data %s"
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 839800efdbbf..572120c865ea 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -63,6 +63,7 @@ typedef enum {
 
 struct SEVState {
     QSevGuestInfo *sev_info;
+    gchar *measurement;
 };
 
 typedef struct SEVState SEVState;
-- 
2.9.5
