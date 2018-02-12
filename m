Received: from eggs.gnu.org ([2001:4830:134:3::10]:56043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBe-0003Yh-89
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBb-0004Jy-4u
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:34 -0500
Received: from mail-by2nam01on0075.outbound.protection.outlook.com
	([104.47.34.75]:32863
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1elGBa-0004Hp-RG
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:31 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 12 Feb 2018 09:37:03 -0600
Message-Id: <20180212153715.87555-17-brijesh.singh@amd.com>
In-Reply-To: <20180212153715.87555-1-brijesh.singh@amd.com>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 16/28] sev/i386: add command to encrypt
 guest memory region
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

The KVM_SEV_LAUNCH_UPDATE_DATA command is used to encrypt a guest memory
region using the VM Encryption Key created using LAUNCH_START.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c      |  2 ++
 include/sysemu/sev.h     |  1 +
 stubs/sev.c              |  5 +++++
 target/i386/sev.c        | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 5 files changed, 58 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4468c8fe002c..4974c00c46fb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1679,6 +1679,8 @@ static int kvm_init(MachineState *ms)
         if (!kvm_state->memcrypt_handle) {
             goto err;
         }
+
+        kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
     }
 
     ret = kvm_arch_init(ms, s);
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 08014a9c94ff..f7af1a00c510 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -75,6 +75,7 @@ struct SEVState {
 typedef struct SEVState SEVState;
 
 void *sev_guest_init(const char *id);
+int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
 
 #endif
 
diff --git a/stubs/sev.c b/stubs/sev.c
index e3076f009a48..8725e6d4e1ec 100644
--- a/stubs/sev.c
+++ b/stubs/sev.c
@@ -15,6 +15,11 @@
 #include "qemu-common.h"
 #include "sysemu/sev.h"
 
+int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
+{
+    return 1;
+}
+
 void sev_get_current_state(char **state)
 {
 }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2ecc6a1d1ad3..4414bda25509 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -97,6 +97,12 @@ fw_error_to_str(int code)
     return sev_fw_errlist[code];
 }
 
+static bool
+sev_check_state(SevGuestState state)
+{
+    return current_sev_guest_state == state ? true : false;
+}
+
 static void
 sev_set_guest_state(SevGuestState new_state)
 {
@@ -447,6 +453,36 @@ sev_launch_start(SEVState *s)
     return 0;
 }
 
+static int
+sev_launch_update_data(uint8_t *addr, uint64_t len)
+{
+    int ret, fw_error;
+    struct kvm_sev_launch_update_data *update;
+
+    if (addr == NULL || len <= 0) {
+        return 1;
+    }
+
+    update = g_malloc0(sizeof(*update));
+    if (!update) {
+        return 1;
+    }
+
+    update->uaddr = (__u64)addr;
+    update->len = len;
+    trace_kvm_sev_launch_update_data(addr, len);
+    ret = sev_ioctl(KVM_SEV_LAUNCH_UPDATE_DATA, update, &fw_error);
+    if (ret) {
+        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+err:
+    g_free(update);
+    return ret;
+}
+
 void *
 sev_guest_init(const char *id)
 {
@@ -506,6 +542,19 @@ err:
     return NULL;
 }
 
+int
+sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
+{
+    assert(handle);
+
+    /* if SEV is in update state then encrypt the data else do nothing */
+    if (sev_check_state(SEV_STATE_LUPDATE)) {
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
index 9402251e9991..c0cd8e93217f 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -12,3 +12,4 @@ kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
+kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
-- 
2.14.3
