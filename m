Received: from eggs.gnu.org ([2001:4830:134:3::10]:60740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUh-0001Nb-6u
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUg-0000qb-30
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:31 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUf-0000pj-SO
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:30 -0400
Received: by mail-wr0-x244.google.com with SMTP id f14so22394658wre.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:29 +0100
Message-Id: <1520945798-50640-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/22] sev/i386: add command to encrypt guest
 memory region
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

The KVM_SEV_LAUNCH_UPDATE_DATA command is used to encrypt a guest memory
region using the VM Encryption Key created using LAUNCH_START.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c        | 43 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 2 files changed, 44 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d855dd5..ff98159 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -105,6 +105,13 @@ fw_error_to_str(int code)
     return sev_fw_errlist[code];
 }
 
+static bool
+sev_check_state(SevState state)
+{
+    assert(sev_state);
+    return sev_state->state == state ? true : false;
+}
+
 static void
 sev_set_guest_state(SevState new_state)
 {
@@ -486,6 +493,29 @@ sev_launch_start(SEVState *s)
     return 0;
 }
 
+static int
+sev_launch_update_data(uint8_t *addr, uint64_t len)
+{
+    int ret, fw_error;
+    struct kvm_sev_launch_update_data update;
+
+    if (!addr || !len) {
+        return 1;
+    }
+
+    update.uaddr = (__u64)addr;
+    update.len = len;
+    trace_kvm_sev_launch_update_data(addr, len);
+    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
+                    &update, &fw_error);
+    if (ret) {
+        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+    }
+
+    return ret;
+}
+
 void *
 sev_guest_init(const char *id)
 {
@@ -571,6 +601,19 @@ err:
     return NULL;
 }
 
+int
+sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
+{
+    assert(handle);
+
+    /* if SEV is in update state then encrypt the data else do nothing */
+    if (sev_check_state(SEV_STATE_LAUNCH_UPDATE)) {
+        return sev_launch_update_data(ptr, len);
+    }
+
+    return 0;
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 9402251..c0cd8e9 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -12,3 +12,4 @@ kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
+kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
-- 
1.8.3.1
