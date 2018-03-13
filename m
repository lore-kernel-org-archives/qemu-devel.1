Received: from eggs.gnu.org ([2001:4830:134:3::10]:60869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUn-0001Us-Ou
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUj-0000ta-SQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:37 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:40559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUj-0000t5-LK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:33 -0400
Received: by mail-wr0-x22d.google.com with SMTP id m4so9589645wrb.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:32 +0100
Message-Id: <1520945798-50640-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/22] sev/i386: finalize the SEV guest launch
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
Cc: Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

SEV launch flow requires us to issue LAUNCH_FINISH command before guest
is ready to run.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c        | 29 +++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 2 files changed, 30 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b4346c1..bb85d94 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -578,6 +578,34 @@ static Notifier sev_machine_done_notify = {
     .notify = sev_launch_get_measure,
 };
 
+static void
+sev_launch_finish(SEVState *s)
+{
+    int ret, error;
+
+    trace_kvm_sev_launch_finish();
+    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
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
@@ -656,6 +684,7 @@ sev_guest_init(const char *id)
 
     ram_block_notifier_add(&sev_ram_notifier);
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+    qemu_add_vm_change_state_handler(sev_vm_state_change, s);
 
     return s;
 err:
diff --git a/target/i386/trace-events b/target/i386/trace-events
index f7a1a1e..b1fbde6 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -14,3 +14,4 @@ kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
 kvm_sev_launch_measurement(const char *value) "data %s"
+kvm_sev_launch_finish(void) ""
-- 
1.8.3.1
