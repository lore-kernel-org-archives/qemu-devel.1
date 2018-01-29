Received: from eggs.gnu.org ([2001:4830:134:3::10]:49224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRo-0005sk-I0
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRk-0003hS-Di
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:24 -0500
Received: from mail-dm3nam03on0042.outbound.protection.outlook.com
	([104.47.41.42]:46789
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1egDRk-0003gQ-6O
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:20 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 29 Jan 2018 11:41:28 -0600
Message-Id: <20180129174132.108925-20-brijesh.singh@amd.com>
In-Reply-To: <20180129174132.108925-1-brijesh.singh@amd.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 19/23] sev: Finalize the SEV guest launch
 flow
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

SEV launch flow requires us to issue LAUNCH_FINISH command before guest
is ready to run.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/sev.c        | 29 +++++++++++++++++++++++++++++
 accel/kvm/trace-events |  1 +
 2 files changed, 30 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index b78cf3144b1d..c227d7591c38 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -473,6 +473,34 @@ static Notifier sev_machine_done_notify = {
     .notify = sev_launch_get_measure,
 };
 
+static void
+sev_launch_finish(SEVState *s)
+{
+    int ret, error;
+
+    trace_kvm_sev_launch_finish();
+    ret = sev_ioctl(KVM_SEV_LAUNCH_FINISH, 0, &error);
+    if (ret) {
+        error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
+                     __func__, ret, error, fw_error_to_str(error));
+        exit(1);
+    }
+
+    sev_set_guest_state(SEV_STATE_RUNNING);
+}
+
+static void
+sev_vm_state_change(void *opaque, int running, RunState state)
+{
+    SEVState *s = opaque;
+
+    if (running) {
+        if (!sev_check_state(SEV_STATE_RUNNING)) {
+            sev_launch_finish(s);
+        }
+    }
+}
+
 void *
 sev_guest_init(const char *id)
 {
@@ -517,6 +545,7 @@ sev_guest_init(const char *id)
 
     ram_block_notifier_add(&sev_ram_notifier);
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+    qemu_add_vm_change_state_handler(sev_vm_state_change, s);
 
     sev_state = s;
 
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 51df5113ad07..05038709acfc 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -21,3 +21,4 @@ kvm_sev_change_state(char *old, char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
 kvm_sev_launch_measurement(const char *value) "data %s"
+kvm_sev_launch_finish(void) ""
-- 
2.9.5
