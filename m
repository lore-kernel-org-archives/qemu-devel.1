Received: from eggs.gnu.org ([2001:4830:134:3::10]:50562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHw-000516-KL
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHs-0008UC-Ji
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:36 -0500
Received: from mail-bl2nam02on0040.outbound.protection.outlook.com
	([104.47.38.40]:30645
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etcHs-0008TX-E5
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:32 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Mar 2018 10:50:37 -0600
Message-Id: <20180307165038.88640-28-brijesh.singh@amd.com>
In-Reply-To: <20180307165038.88640-1-brijesh.singh@amd.com>
References: <20180307165038.88640-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 27/28] sev/i386: add sev_get_capabilities()
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

The function can be used to get the current SEV capabilities.
The capabilities include platform diffie-hellman key (pdh) and certificate
chain. The key can be provided to the external entities which wants to
establish a trusted channel between SEV firmware and guest owner.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/monitor.c  | 11 +++++--
 target/i386/sev-stub.c |  5 +++
 target/i386/sev.c      | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h |  1 +
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 33e6bade693b..79fa9bd7a3e3 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -740,6 +740,13 @@ SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
 
 SevCapability *qmp_query_sev_capabilities(Error **errp)
 {
-    error_setg(errp, "SEV feature is not available");
-    return NULL;
+    SevCapability *data;
+
+    data = sev_get_capabilities();
+    if (!data) {
+        error_setg(errp, "SEV feature is not available");
+        return NULL;
+    }
+
+    return data;
 }
diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
index 2f61c32ec975..59a003a4ebe6 100644
--- a/target/i386/sev-stub.c
+++ b/target/i386/sev-stub.c
@@ -44,3 +44,8 @@ char *sev_get_launch_measurement(void)
 {
     return NULL;
 }
+
+SevCapability *sev_get_capabilities(void)
+{
+    return NULL;
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 0eb2c855bc4d..f838cf7e3720 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -422,6 +422,89 @@ sev_get_info(void)
     return info;
 }
 
+static int
+sev_get_pdh_info(int fd, guchar **pdh, size_t *pdh_len, guchar **cert_chain,
+                 size_t *cert_chain_len)
+{
+    guchar *pdh_data, *cert_chain_data;
+    struct sev_user_data_pdh_cert_export export = {};
+    int err, r;
+
+    /* query the certificate length */
+    r = sev_platform_ioctl(fd, SEV_PDH_CERT_EXPORT, &export, &err);
+    if (r < 0) {
+        if (err != SEV_RET_INVALID_LEN) {
+            error_report("failed to export PDH cert ret=%d fw_err=%d (%s)",
+                         r, err, fw_error_to_str(err));
+            return 1;
+        }
+    }
+
+    pdh_data = g_new(guchar, export.pdh_cert_len);
+    cert_chain_data = g_new(guchar, export.cert_chain_len);
+    export.pdh_cert_address = (unsigned long)pdh_data;
+    export.cert_chain_address = (unsigned long)cert_chain_data;
+
+    r = sev_platform_ioctl(fd, SEV_PDH_CERT_EXPORT, &export, &err);
+    if (r < 0) {
+        error_report("failed to export PDH cert ret=%d fw_err=%d (%s)",
+                     r, err, fw_error_to_str(err));
+        goto e_free;
+    }
+
+    *pdh = pdh_data;
+    *pdh_len = export.pdh_cert_len;
+    *cert_chain = cert_chain_data;
+    *cert_chain_len = export.cert_chain_len;
+    return 0;
+
+e_free:
+    g_free(pdh_data);
+    g_free(cert_chain_data);
+    return 1;
+}
+
+SevCapability *
+sev_get_capabilities(void)
+{
+    SevCapability *cap;
+    guchar *pdh_data, *cert_chain_data;
+    size_t pdh_len = 0, cert_chain_len = 0;
+    uint32_t ebx;
+    int fd;
+
+    fd = open(DEFAULT_SEV_DEVICE, O_RDWR);
+    if (fd < 0) {
+        error_report("%s: Failed to open %s '%s'", __func__,
+                     DEFAULT_SEV_DEVICE, strerror(errno));
+        return NULL;
+    }
+
+    if (sev_get_pdh_info(fd, &pdh_data, &pdh_len,
+                         &cert_chain_data, &cert_chain_len)) {
+        return NULL;
+    }
+
+    cap = g_new0(SevCapability, 1);
+    cap->pdh = g_base64_encode(pdh_data, pdh_len);
+    cap->cert_chain = g_base64_encode(cert_chain_data, cert_chain_len);
+
+    host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
+    cap->cbitpos = ebx & 0x3f;
+
+    /*
+     * When SEV feature is enabled, we loose one bit in guest physical
+     * addressing.
+     */
+    cap->reduced_phys_bits = 1;
+
+    g_free(pdh_data);
+    g_free(cert_chain_data);
+
+    close(fd);
+    return cap;
+}
+
 static int
 sev_read_file_base64(const char *filename, guchar **data, gsize *len)
 {
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index c21d1f31d712..cd802e4b4178 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -43,6 +43,7 @@ extern SevInfo *sev_get_info(void);
 extern uint32_t sev_get_cbit_position(void);
 extern uint32_t sev_get_reduced_phys_bits(void);
 extern char *sev_get_launch_measurement(void);
+extern SevCapability *sev_get_capabilities(void);
 
 typedef struct QSevGuestInfo QSevGuestInfo;
 typedef struct QSevGuestInfoClass QSevGuestInfoClass;
-- 
2.14.3
