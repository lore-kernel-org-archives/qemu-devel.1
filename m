Received: from eggs.gnu.org ([2001:4830:134:3::10]:51758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFw-00065e-T4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFs-0006z0-T5
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:32 -0500
Received: from mail-by2nam01on0079.outbound.protection.outlook.com
	([104.47.34.79]:51968
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejSFs-0006yU-Iv
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:28 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Feb 2018 10:06:31 -0600
Message-Id: <20180207160638.98872-19-brijesh.singh@amd.com>
In-Reply-To: <20180207160638.98872-1-brijesh.singh@amd.com>
References: <20180207160638.98872-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 19/26] sev: Finalize the SEV guest launch
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

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
index 8d99c6cda4d2..e422f43caa0b 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -547,6 +547,34 @@ static Notifier sev_machine_done_notify = {
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
@@ -600,6 +628,7 @@ sev_guest_init(const char *id)
     sev_active = true;
     ram_block_notifier_add(&sev_ram_notifier);
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+    qemu_add_vm_change_state_handler(sev_vm_state_change, s);
 
     sev_state = s;
 
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 19742bf9dd30..e810d75ea1b3 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -21,3 +21,4 @@ kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
 kvm_sev_launch_measurement(const char *value) "data %s"
+kvm_sev_launch_finish(void) ""
-- 
2.14.3
