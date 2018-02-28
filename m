Received: from eggs.gnu.org ([2001:4830:134:3::10]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90P-0001Pg-3r
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90L-0005tk-21
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:17 -0500
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com
	([104.47.36.51]:43970
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1er90K-0005sV-Lg
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:12 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 28 Feb 2018 15:10:18 -0600
Message-Id: <20180228211028.83970-19-brijesh.singh@amd.com>
In-Reply-To: <20180228211028.83970-1-brijesh.singh@amd.com>
References: <20180228211028.83970-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v10 18/28] sev/i386: add support to
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
 target/i386/sev-stub.c   |  5 ++++
 target/i386/sev.c        | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h   |  2 ++
 target/i386/trace-events |  1 +
 4 files changed, 71 insertions(+)

diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
index c86d8c139237..2f61c32ec975 100644
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
index a25722bdb934..a61c100ef47b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -510,6 +510,68 @@ sev_launch_update_data(uint8_t *addr, uint64_t len)
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
+    if (sev_state &&
+        sev_state->state >= SEV_STATE_LSECRET) {
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
@@ -590,6 +652,7 @@ sev_guest_init(const char *id)
     }
 
     ram_block_notifier_add(&sev_ram_notifier);
+    qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
 
     return s;
 err:
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 68019d6f39a5..2ecca66f6e64 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -42,6 +42,7 @@ extern uint64_t sev_get_me_mask(void);
 extern SevInfo *sev_get_info(void);
 extern uint32_t sev_get_cbit_position(void);
 extern uint32_t sev_get_reduced_phys_bits(void);
+extern char *sev_get_launch_measurement(void);
 
 typedef struct QSevGuestInfo QSevGuestInfo;
 typedef struct QSevGuestInfoClass QSevGuestInfoClass;
@@ -83,6 +84,7 @@ struct SEVState {
     uint32_t handle;
     int sev_fd;
     SevState state;
+    gchar *measurement;
 };
 
 typedef struct SEVState SEVState;
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
