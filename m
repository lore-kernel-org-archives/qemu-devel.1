Received: from eggs.gnu.org ([2001:4830:134:3::10]:60714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUg-0001ML-8d
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUf-0000pc-4G
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:30 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:40566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUe-0000ok-PS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:29 -0400
Received: by mail-wr0-x236.google.com with SMTP id m4so9588837wrb.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:28 +0100
Message-Id: <1520945798-50640-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/22] sev/i386: add command to create launch
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
Cc: Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

The KVM_SEV_LAUNCH_START command creates a new VM encryption key (VEK).
The encryption key created with the command will be used for encrypting
the bootstrap images (such as guest bios).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c        | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  2 ++
 2 files changed, 88 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index c63012a..d855dd5 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -106,6 +106,17 @@ fw_error_to_str(int code)
 }
 
 static void
+sev_set_guest_state(SevState new_state)
+{
+    assert(new_state < SEV_STATE__MAX);
+    assert(sev_state);
+
+    trace_kvm_sev_change_state(SevState_str(sev_state->state),
+                               SevState_str(new_state));
+    sev_state->state = new_state;
+}
+
+static void
 sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
 {
     int r;
@@ -406,6 +417,75 @@ sev_get_info(void)
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
+    start = g_new0(struct kvm_sev_launch_start, 1);
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
+    ret = sev_ioctl(s->sev_fd, KVM_SEV_LAUNCH_START, start, &fw_error);
+    if (ret < 0) {
+        error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        return 1;
+    }
+
+    object_property_set_int(OBJECT(sev), start->handle, "handle",
+                            &error_abort);
+    sev_set_guest_state(SEV_STATE_LAUNCH_UPDATE);
+    s->handle = start->handle;
+    s->policy = start->policy;
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
@@ -476,6 +556,12 @@ sev_guest_init(const char *id)
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
diff --git a/target/i386/trace-events b/target/i386/trace-events
index ffa3d22..9402251 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -10,3 +10,5 @@ kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
 kvm_sev_init(void) ""
 kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
 kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
+kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
+kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
-- 
1.8.3.1
