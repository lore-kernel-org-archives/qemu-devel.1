Received: from eggs.gnu.org ([2001:4830:134:3::10]:46320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5eP-00085h-Vx
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5eK-0007nj-Ux
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:03:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD5eK-0007n6-Ph
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:03:12 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Apr 2018 12:03:02 +0200
Message-Id: <20180430100302.15959-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] target/i386: sev: fix memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>

Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index c01167143f..2395171acf 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -430,7 +430,8 @@ static int
 sev_get_pdh_info(int fd, guchar **pdh, size_t *pdh_len, guchar **cert_chain,
                  size_t *cert_chain_len)
 {
-    guchar *pdh_data, *cert_chain_data;
+    guchar *pdh_data = NULL;
+    guchar *cert_chain_data = NULL;
     struct sev_user_data_pdh_cert_export export = {};
     int err, r;
 
@@ -471,8 +472,9 @@ e_free:
 SevCapability *
 sev_get_capabilities(void)
 {
-    SevCapability *cap;
-    guchar *pdh_data, *cert_chain_data;
+    SevCapability *cap = NULL;
+    guchar *pdh_data = NULL;
+    guchar *cert_chain_data = NULL;
     size_t pdh_len = 0, cert_chain_len = 0;
     uint32_t ebx;
     int fd;
@@ -486,7 +488,7 @@ sev_get_capabilities(void)
 
     if (sev_get_pdh_info(fd, &pdh_data, &pdh_len,
                          &cert_chain_data, &cert_chain_len)) {
-        return NULL;
+        goto out;
     }
 
     cap = g_new0(SevCapability, 1);
@@ -502,9 +504,9 @@ sev_get_capabilities(void)
      */
     cap->reduced_phys_bits = 1;
 
+out:
     g_free(pdh_data);
     g_free(cert_chain_data);
-
     close(fd);
     return cap;
 }
@@ -530,7 +532,7 @@ sev_launch_start(SEVState *s)
 {
     gsize sz;
     int ret = 1;
-    int fw_error;
+    int fw_error, rc;
     QSevGuestInfo *sev = s->sev_info;
     struct kvm_sev_launch_start *start;
     guchar *session = NULL, *dh_cert = NULL;
@@ -543,7 +545,7 @@ sev_launch_start(SEVState *s)
                                             &error_abort);
     if (sev->session_file) {
         if (sev_read_file_base64(sev->session_file, &session, &sz) < 0) {
-            return 1;
+            goto out;
         }
         start->session_uaddr = (unsigned long)session;
         start->session_len = sz;
@@ -551,18 +553,18 @@ sev_launch_start(SEVState *s)
 
     if (sev->dh_cert_file) {
         if (sev_read_file_base64(sev->dh_cert_file, &dh_cert, &sz) < 0) {
-            return 1;
+            goto out;
         }
         start->dh_uaddr = (unsigned long)dh_cert;
         start->dh_len = sz;
     }
 
     trace_kvm_sev_launch_start(start->policy, session, dh_cert);
-    ret = sev_ioctl(s->sev_fd, KVM_SEV_LAUNCH_START, start, &fw_error);
-    if (ret < 0) {
+    rc = sev_ioctl(s->sev_fd, KVM_SEV_LAUNCH_START, start, &fw_error);
+    if (rc < 0) {
         error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
                 __func__, ret, fw_error, fw_error_to_str(fw_error));
-        return 1;
+        goto out;
     }
 
     object_property_set_int(OBJECT(sev), start->handle, "handle",
@@ -570,12 +572,13 @@ sev_launch_start(SEVState *s)
     sev_set_guest_state(SEV_STATE_LAUNCH_UPDATE);
     s->handle = start->handle;
     s->policy = start->policy;
+    ret = 0;
 
+out:
     g_free(start);
     g_free(session);
     g_free(dh_cert);
-
-    return 0;
+    return ret;
 }
 
 static int
@@ -712,7 +715,7 @@ sev_guest_init(const char *id)
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
 
-    s = g_new0(SEVState, 1);
+    sev_state = s = g_new0(SEVState, 1);
     s->sev_info = lookup_sev_guest_info(id);
     if (!s->sev_info) {
         error_report("%s: '%s' is not a valid '%s' object",
@@ -720,7 +723,6 @@ sev_guest_init(const char *id)
         goto err;
     }
 
-    sev_state = s;
     s->state = SEV_STATE_UNINIT;
 
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
-- 
2.17.0
