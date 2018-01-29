Received: from eggs.gnu.org ([2001:4830:134:3::10]:49146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRg-0005k3-Dp
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRb-0003Zy-Gm
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:16 -0500
Received: from mail-dm3nam03on0059.outbound.protection.outlook.com
	([104.47.41.59]:40630
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1egDRb-0003Zf-A4
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:11 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 29 Jan 2018 11:41:23 -0600
Message-Id: <20180129174132.108925-15-brijesh.singh@amd.com>
In-Reply-To: <20180129174132.108925-1-brijesh.singh@amd.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 14/23] sev: add command to create launch
 memory encryption context
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

The KVM_SEV_LAUNCH_START command creates a new VM encryption key (VEK).
The encryption key created with the command will be used for encrypting
the bootstrap images (such as guest bios).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/sev.c        | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++
 accel/kvm/trace-events |  2 ++
 include/sysemu/sev.h   | 10 ++++++
 3 files changed, 109 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index 5ae37caeb361..eea07ac9642f 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -27,6 +27,17 @@ static int sev_fd;
 
 #define SEV_FW_MAX_ERROR      0x17
 
+static SevGuestState current_sev_guest_state = SEV_STATE_UNINIT;
+
+static char sev_state_str[SEV_STATE_MAX][10] = {
+    "uninit",
+    "lupdate",
+    "secret",
+    "running",
+    "supdate",
+    "rupdate",
+};
+
 static char sev_fw_errlist[SEV_FW_MAX_ERROR][100] = {
     "",
     "Platform state is invalid",
@@ -85,6 +96,16 @@ fw_error_to_str(int code)
 }
 
 static void
+sev_set_guest_state(SevGuestState new_state)
+{
+    assert(new_state < SEV_STATE_MAX);
+
+    trace_kvm_sev_change_state(sev_state_str[current_sev_guest_state],
+                               sev_state_str[new_state]);
+    current_sev_guest_state = new_state;
+}
+
+static void
 sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
 {
     int r;
@@ -291,6 +312,76 @@ lookup_sev_guest_info(const char *id)
     return info;
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
@@ -327,6 +418,12 @@ sev_guest_init(const char *id)
         goto err;
     }
 
+    ret = sev_launch_start(s);
+    if (ret) {
+        error_report("%s: failed to create encryption context", __func__);
+        goto err;
+    }
+
     ram_block_notifier_add(&sev_ram_notifier);
 
     return s;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 364c84bd7a73..a4ea1c382ec2 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -17,3 +17,5 @@ kvm_irqchip_release_virq(int virq) "virq %d"
 kvm_sev_init(void) ""
 kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
+kvm_sev_change_state(char *old, char *new) "%s -> %s"
+kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 6aec25bc05e5..392b21fafbd3 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -51,6 +51,16 @@ struct QSevGuestInfoClass {
     ObjectClass parent_class;
 };
 
+typedef enum {
+    SEV_STATE_UNINIT = 0,
+    SEV_STATE_LUPDATE,
+    SEV_STATE_SECRET,
+    SEV_STATE_RUNNING,
+    SEV_STATE_SUPDATE,
+    SEV_STATE_RUPDATE,
+    SEV_STATE_MAX
+} SevGuestState;
+
 struct SEVState {
     QSevGuestInfo *sev_info;
 };
-- 
2.9.5
