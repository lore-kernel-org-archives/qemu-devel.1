Received: from eggs.gnu.org ([2001:4830:134:3::10]:35800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLeh-0004Y9-HG
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLed-0003bA-IP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:41:03 -0500
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com
	([104.47.37.69]:31616
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1emLed-0003aw-9Y
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:59 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Thu, 15 Feb 2018 09:39:44 -0600
Message-Id: <20180215153955.3253-19-brijesh.singh@amd.com>
In-Reply-To: <20180215153955.3253-1-brijesh.singh@amd.com>
References: <20180215153955.3253-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 18/29] sev/i386: add support to
 LAUNCH_MEASURE command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

During machine creation we encrypted the guest bios image, the
LAUNCH_MEASURE command can be used to retrieve the measurement of
the encrypted memory region. This measurement is a signature of
the memory contents that can be sent to the guest owner as an
attestation that the memory was encrypted correctly by the firmware.
VM management tools like libvirt can query the measurement using
query-sev-launch-measure QMP command.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 include/sysemu/sev.h     |  2 ++
 stubs/sev.c              |  5 ++++
 target/i386/sev.c        | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 4 files changed, 76 insertions(+)

diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index c16102b05ec4..ad4a1f1338ec 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -33,6 +33,7 @@ extern void sev_get_fw_version(uint8_t *major, uint8_t *minor, uint8_t *build);
 extern void sev_get_policy(uint32_t *policy);
 extern uint32_t sev_get_cbit_position(void);
 extern uint32_t sev_get_reduced_phys_bits(void);
+extern char *sev_get_launch_measurement(void);
 
 typedef struct QSevGuestInfo QSevGuestInfo;
 typedef struct QSevGuestInfoClass QSevGuestInfoClass;
@@ -64,6 +65,7 @@ struct QSevGuestInfoClass {
 
 struct SEVState {
     QSevGuestInfo *sev_info;
+    gchar *measurement;
 };
 
 typedef struct SEVState SEVState;
diff --git a/stubs/sev.c b/stubs/sev.c
index 74182bb545e2..5420ada7fd6e 100644
--- a/stubs/sev.c
+++ b/stubs/sev.c
@@ -57,3 +57,8 @@ void sev_get_fw_version(uint8_t *major, uint8_t *minor, uint8_t *build)
 void sev_get_policy(uint32_t *policy)
 {
 }
+
+char *sev_get_launch_measurement(void)
+{
+    return NULL;
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 04a64b5bc61d..401b2a33d7cc 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -19,6 +19,7 @@
 #include "sysemu/sev.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
+#include "qapi-event.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
@@ -28,6 +29,7 @@ static bool sev_active;
 static int sev_fd;
 static uint32_t x86_cbitpos;
 static uint32_t x86_reduced_phys_bits;
+static SEVState *sev_state;
 
 static SevState current_sev_guest_state = SEV_STATE_UNINIT;
 
@@ -502,6 +504,69 @@ err:
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
+    if (!sev_check_state(SEV_STATE_LUPDATE)) {
+        return;
+    }
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
+    sev_set_guest_state(SEV_STATE_LSECRET);
+
+    /* encode the measurement value and emit the event */
+    s->measurement = g_base64_encode(data, measurement->len);
+    trace_kvm_sev_launch_measurement(s->measurement);
+
+free_data:
+    g_free(data);
+free_measurement:
+    g_free(measurement);
+}
+
+char *
+sev_get_launch_measurement(void)
+{
+    return current_sev_guest_state >= SEV_STATE_LSECRET ?
+            g_strdup(sev_state->measurement) : NULL;
+}
+
+static Notifier sev_machine_done_notify = {
+    .notify = sev_launch_get_measure,
+};
+
 void *
 sev_guest_init(const char *id)
 {
@@ -569,6 +634,9 @@ sev_guest_init(const char *id)
     x86_cbitpos = cbitpos;
     sev_active = true;
     ram_block_notifier_add(&sev_ram_notifier);
+    qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+
+    sev_state = s;
 
     return s;
 err:
diff --git a/target/i386/trace-events b/target/i386/trace-events
index c0cd8e93217f..f7a1a1e6b85c 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -13,3 +13,4 @@ kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
+kvm_sev_launch_measurement(const char *value) "data %s"
-- 
2.14.3
