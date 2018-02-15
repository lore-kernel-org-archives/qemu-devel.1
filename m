Received: from eggs.gnu.org ([2001:4830:134:3::10]:35764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLeb-0004QK-41
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLeX-0003ZM-54
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:57 -0500
Received: from mail-cys01nam02on0050.outbound.protection.outlook.com
	([104.47.37.50]:26711
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1emLeW-0003Yu-Sf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:53 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Thu, 15 Feb 2018 09:39:41 -0600
Message-Id: <20180215153955.3253-16-brijesh.singh@amd.com>
In-Reply-To: <20180215153955.3253-1-brijesh.singh@amd.com>
References: <20180215153955.3253-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 15/29] sev/i386: add command to create
 launch memory encryption context
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

The KVM_SEV_LAUNCH_START command creates a new VM encryption key (VEK).
The encryption key created with the command will be used for encrypting
the bootstrap images (such as guest bios).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/sev.c        | 91 +++++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/trace-events |  2 ++
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index de5c8d4675a6..6f767084fd57 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -29,6 +29,8 @@ static int sev_fd;
 static uint32_t x86_cbitpos;
 static uint32_t x86_reduced_phys_bits;
 
+static SevState current_sev_guest_state = SEV_STATE_UNINIT;
+
 static const char *const sev_fw_errlist[] = {
     "",
     "Platform state is invalid",
@@ -88,6 +90,16 @@ fw_error_to_str(int code)
     return sev_fw_errlist[code];
 }
 
+static void
+sev_set_guest_state(SevState new_state)
+{
+    assert(new_state < SEV_STATE__MAX);
+
+    trace_kvm_sev_change_state(SevState_str(current_sev_guest_state),
+                               SevState_str(new_state));
+    current_sev_guest_state = new_state;
+}
+
 static void
 sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
 {
@@ -365,7 +377,7 @@ sev_get_reduced_phys_bits(void)
 SevState
 sev_get_current_state(void)
 {
-    return SEV_STATE_UNINIT;
+    return current_sev_guest_state;
 }
 
 bool
@@ -384,6 +396,76 @@ sev_get_policy(uint32_t *policy)
 {
 }
 
+static int
+sev_read_file_base64(const char *filename, guchar **data, gsize *len)
+{
+    gsize sz;
+    gchar *base64;
+    GError *error = NULL;
+
+    if (!g_file_get_contents(filename, &base64, &sz, &error)) {
+        error_report("failed to read '%s' (%s)", filename, error->message);
+        return -1;
+    }
+
+    *data = g_base64_decode(base64, len);
+    return 0;
+}
+
+static int
+sev_launch_start(SEVState *s)
+{
+    gsize sz;
+    int ret = 1;
+    int fw_error;
+    QSevGuestInfo *sev = s->sev_info;
+    struct kvm_sev_launch_start *start;
+    guchar *session = NULL, *dh_cert = NULL;
+
+    start = g_malloc0(sizeof(*start));
+    if (!start) {
+        return 1;
+    }
+
+    start->handle = object_property_get_int(OBJECT(sev), "handle",
+                                            &error_abort);
+    start->policy = object_property_get_int(OBJECT(sev), "policy",
+                                            &error_abort);
+    if (sev->session_file) {
+        if (sev_read_file_base64(sev->session_file, &session, &sz) < 0) {
+            return 1;
+        }
+        start->session_uaddr = (unsigned long)session;
+        start->session_len = sz;
+    }
+
+    if (sev->dh_cert_file) {
+        if (sev_read_file_base64(sev->dh_cert_file, &dh_cert, &sz) < 0) {
+            return 1;
+        }
+        start->dh_uaddr = (unsigned long)dh_cert;
+        start->dh_len = sz;
+    }
+
+    trace_kvm_sev_launch_start(start->policy, session, dh_cert);
+    ret = sev_ioctl(KVM_SEV_LAUNCH_START, start, &fw_error);
+    if (ret < 0) {
+        error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        return 1;
+    }
+
+    object_property_set_int(OBJECT(sev), start->handle, "handle",
+                            &error_abort);
+    sev_set_guest_state(SEV_STATE_LUPDATE);
+
+    g_free(start);
+    g_free(session);
+    g_free(dh_cert);
+
+    return 0;
+}
+
 void *
 sev_guest_init(const char *id)
 {
@@ -439,6 +521,13 @@ sev_guest_init(const char *id)
         goto err;
     }
 
+    ret = sev_launch_start(s);
+    if (ret) {
+        error_report("%s: failed to create encryption context", __func__);
+        goto err;
+    }
+
+
     me_mask = (1UL << cbitpos);
     x86_reduced_phys_bits = reduced_phys_bits;
     x86_cbitpos = cbitpos;
diff --git a/target/i386/trace-events b/target/i386/trace-events
index ffa3d2250425..9402251e9991 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -10,3 +10,5 @@ kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
 kvm_sev_init(void) ""
 kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
+kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
+kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
-- 
2.14.3
