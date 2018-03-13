Received: from eggs.gnu.org ([2001:4830:134:3::10]:60789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUj-0001Qa-Om
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUi-0000su-Ov
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:33 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUi-0000sA-ER
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:32 -0400
Received: by mail-wr0-x243.google.com with SMTP id m12so22358898wrm.13
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:31 +0100
Message-Id: <1520945798-50640-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/22] sev/i386: add support to LAUNCH_MEASURE
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev-stub.c   |  5 ++++
 target/i386/sev.c        | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h   |  2 ++
 target/i386/trace-events |  1 +
 4 files changed, 71 insertions(+)

diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
index c86d8c1..2f61c32 100644
--- a/target/i386/sev-stub.c
+++ b/target/i386/sev-stub.c
@@ -39,3 +39,8 @@ uint32_t sev_get_reduced_phys_bits(void)
 {
     return 0;
 }
+
+char *sev_get_launch_measurement(void)
+{
+    return NULL;
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index ff98159..b4346c1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -516,6 +516,68 @@ sev_launch_update_data(uint8_t *addr, uint64_t len)
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
+    if (!sev_check_state(SEV_STATE_LAUNCH_UPDATE)) {
+        return;
+    }
+
+    measurement = g_new0(struct kvm_sev_launch_measure, 1);
+
+    /* query the measurement blob length */
+    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_MEASURE,
+                    measurement, &error);
+    if (!measurement->len) {
+        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
+                     __func__, ret, error, fw_error_to_str(errno));
+        goto free_measurement;
+    }
+
+    data = g_new0(guchar, measurement->len);
+    measurement->uaddr = (unsigned long)data;
+
+    /* get the measurement blob */
+    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_MEASURE,
+                    measurement, &error);
+    if (ret) {
+        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
+                     __func__, ret, error, fw_error_to_str(errno));
+        goto free_data;
+    }
+
+    sev_set_guest_state(SEV_STATE_LAUNCH_SECRET);
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
+    if (sev_state &&
+        sev_state->state >= SEV_STATE_LAUNCH_SECRET) {
+        return g_strdup(sev_state->measurement);
+    }
+
+    return NULL;
+}
+
+static Notifier sev_machine_done_notify = {
+    .notify = sev_launch_get_measure,
+};
+
 void *
 sev_guest_init(const char *id)
 {
@@ -593,6 +655,7 @@ sev_guest_init(const char *id)
     }
 
     ram_block_notifier_add(&sev_ram_notifier);
+    qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
 
     return s;
 err:
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 924cebc..6e37077 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -37,6 +37,7 @@ extern uint64_t sev_get_me_mask(void);
 extern SevInfo *sev_get_info(void);
 extern uint32_t sev_get_cbit_position(void);
 extern uint32_t sev_get_reduced_phys_bits(void);
+extern char *sev_get_launch_measurement(void);
 
 typedef struct QSevGuestInfo QSevGuestInfo;
 typedef struct QSevGuestInfoClass QSevGuestInfoClass;
@@ -78,6 +79,7 @@ struct SEVState {
     uint32_t handle;
     int sev_fd;
     SevState state;
+    gchar *measurement;
 };
 
 typedef struct SEVState SEVState;
diff --git a/target/i386/trace-events b/target/i386/trace-events
index c0cd8e9..f7a1a1e 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -13,3 +13,4 @@ kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
+kvm_sev_launch_measurement(const char *value) "data %s"
-- 
1.8.3.1
