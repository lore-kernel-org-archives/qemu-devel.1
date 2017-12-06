Received: from eggs.gnu.org ([2001:4830:134:3::10]:49965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfw3-0006KX-6o
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvz-0002jy-WC
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:51 -0500
Received: from mail-sn1nam01on0065.outbound.protection.outlook.com
	([104.47.32.65]:24848
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvz-0002jR-OJ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:47 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:38 -0600
Message-Id: <20171206200346.116537-16-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 15/23] sev: add command to encrypt guest
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

The KVM_SEV_LAUNCH_UPDATE_DATA command is used to encrypt a guest memory
region using the VM Encryption Key created using LAUNCH_START.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c  |  2 ++
 accel/kvm/sev.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/sev.h |  1 +
 3 files changed, 47 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 54a0fd6097fb..d35eebb97901 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1675,6 +1675,8 @@ static int kvm_init(MachineState *ms)
         if (!kvm_state->memcrypt_handle) {
             goto err;
         }
+
+        kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
     }
 
     ret = kvm_arch_init(ms, s);
diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index 74eb67526bd0..83fc950bd3ac 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -368,6 +368,37 @@ sev_launch_start(SEVState *s)
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
+    ret = sev_ioctl(KVM_SEV_LAUNCH_UPDATE_DATA, update, &fw_error);
+    if (ret) {
+        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+    DPRINTF("SEV: LAUNCH_UPDATE_DATA %#lx+%#lx\n", (unsigned long)addr, len);
+
+err:
+    g_free(update);
+    return ret;
+}
+
 void *
 sev_guest_init(const char *id)
 {
@@ -417,6 +448,19 @@ err:
     return NULL;
 }
 
+int
+sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
+{
+    SEVState *s = (SEVState *)handle;
+
+    /* if SEV is in update state then encrypt the data else do nothing */
+    if (s->cur_state == SEV_STATE_LUPDATE) {
+        return sev_launch_update_data(ptr, len);
+    }
+
+    return 0;
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 45b464cc96f5..b1ea3f805290 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -69,6 +69,7 @@ struct SEVState {
 typedef struct SEVState SEVState;
 
 void *sev_guest_init(const char *id);
+int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
 
 #endif
 
-- 
2.9.5
