Received: from eggs.gnu.org ([2001:4830:134:3::10]:49921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfw0-0006HF-81
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvx-0002gu-1f
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:48 -0500
Received: from mail-sn1nam01on0081.outbound.protection.outlook.com
	([104.47.32.81]:20510
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvw-0002gI-Qr
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:44 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:37 -0600
Message-Id: <20171206200346.116537-15-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 14/23] sev: add command to create launch
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

The KVM_SEV_LAUNCH_START command creates a new VM encryption key (VEK).
The encryption key created with the command will be used for encrypting
the bootstrap images (such as guest bios).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/sev.c      | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/sev.h | 11 +++++++
 2 files changed, 97 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index 7b5318993969..74eb67526bd0 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -22,6 +22,15 @@
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
+#define DEBUG_SEV
+#ifdef DEBUG_SEV
+#define DPRINTF(fmt, ...) \
+    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) \
+    do { } while (0)
+#endif
+
 static int sev_fd;
 
 #define SEV_FW_MAX_ERROR      0x17
@@ -288,6 +297,77 @@ lookup_sev_guest_info(const char *id)
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
+    ret = sev_ioctl(KVM_SEV_LAUNCH_START, start, &fw_error);
+    if (ret < 0) {
+        error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        return 1;
+    }
+
+    DPRINTF("SEV: LAUNCH_START\n");
+
+    object_property_set_int(OBJECT(sev), start->handle, "handle",
+                            &error_abort);
+    s->cur_state = SEV_STATE_LUPDATE;
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
@@ -323,6 +403,12 @@ sev_guest_init(const char *id)
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
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index f85517c0b5b5..45b464cc96f5 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -51,8 +51,19 @@ struct QSevGuestInfoClass {
     ObjectClass parent_class;
 };
 
+enum {
+    SEV_STATE_INVALID = 0,
+    SEV_STATE_LUPDATE,
+    SEV_STATE_SECRET,
+    SEV_STATE_RUNNING,
+    SEV_STATE_SENDING,
+    SEV_STATE_RECEIVING,
+    SEV_STATE_MAX
+};
+
 struct SEVState {
     QSevGuestInfo *sev_info;
+    int cur_state;
 };
 
 typedef struct SEVState SEVState;
-- 
2.9.5
