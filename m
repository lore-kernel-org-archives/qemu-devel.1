Received: from eggs.gnu.org ([2001:4830:134:3::10]:60599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUd-0001Iy-AB
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUb-0000l4-5m
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:27 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUa-0000kG-SX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:25 -0400
Received: by mail-wr0-x243.google.com with SMTP id r8so7235216wrg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:25 +0100
Message-Id: <1520945798-50640-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/22] include: add psp-sev.h header file
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

The header file provide the ioctl command and structure to communicate
with /dev/sev device.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 linux-headers/linux/psp-sev.h   | 142 ++++++++++++++++++++++++++++++++++++++++
 scripts/update-linux-headers.sh |   2 +-
 2 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 linux-headers/linux/psp-sev.h

diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
new file mode 100644
index 0000000..33e2474
--- /dev/null
+++ b/linux-headers/linux/psp-sev.h
@@ -0,0 +1,142 @@
+/*
+ * Userspace interface for AMD Secure Encrypted Virtualization (SEV)
+ * platform management commands.
+ *
+ * Copyright (C) 2016-2017 Advanced Micro Devices, Inc.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * SEV spec 0.14 is available at:
+ * http://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PSP_SEV_USER_H__
+#define __PSP_SEV_USER_H__
+
+#include <linux/types.h>
+
+/**
+ * SEV platform commands
+ */
+enum {
+	SEV_FACTORY_RESET = 0,
+	SEV_PLATFORM_STATUS,
+	SEV_PEK_GEN,
+	SEV_PEK_CSR,
+	SEV_PDH_GEN,
+	SEV_PDH_CERT_EXPORT,
+	SEV_PEK_CERT_IMPORT,
+
+	SEV_MAX,
+};
+
+/**
+ * SEV Firmware status code
+ */
+typedef enum {
+	SEV_RET_SUCCESS = 0,
+	SEV_RET_INVALID_PLATFORM_STATE,
+	SEV_RET_INVALID_GUEST_STATE,
+	SEV_RET_INAVLID_CONFIG,
+	SEV_RET_INVALID_LEN,
+	SEV_RET_ALREADY_OWNED,
+	SEV_RET_INVALID_CERTIFICATE,
+	SEV_RET_POLICY_FAILURE,
+	SEV_RET_INACTIVE,
+	SEV_RET_INVALID_ADDRESS,
+	SEV_RET_BAD_SIGNATURE,
+	SEV_RET_BAD_MEASUREMENT,
+	SEV_RET_ASID_OWNED,
+	SEV_RET_INVALID_ASID,
+	SEV_RET_WBINVD_REQUIRED,
+	SEV_RET_DFFLUSH_REQUIRED,
+	SEV_RET_INVALID_GUEST,
+	SEV_RET_INVALID_COMMAND,
+	SEV_RET_ACTIVE,
+	SEV_RET_HWSEV_RET_PLATFORM,
+	SEV_RET_HWSEV_RET_UNSAFE,
+	SEV_RET_UNSUPPORTED,
+	SEV_RET_MAX,
+} sev_ret_code;
+
+/**
+ * struct sev_user_data_status - PLATFORM_STATUS command parameters
+ *
+ * @major: major API version
+ * @minor: minor API version
+ * @state: platform state
+ * @flags: platform config flags
+ * @build: firmware build id for API version
+ * @guest_count: number of active guests
+ */
+struct sev_user_data_status {
+	__u8 api_major;				/* Out */
+	__u8 api_minor;				/* Out */
+	__u8 state;				/* Out */
+	__u32 flags;				/* Out */
+	__u8 build;				/* Out */
+	__u32 guest_count;			/* Out */
+} __attribute__((packed));
+
+/**
+ * struct sev_user_data_pek_csr - PEK_CSR command parameters
+ *
+ * @address: PEK certificate chain
+ * @length: length of certificate
+ */
+struct sev_user_data_pek_csr {
+	__u64 address;				/* In */
+	__u32 length;				/* In/Out */
+} __attribute__((packed));
+
+/**
+ * struct sev_user_data_cert_import - PEK_CERT_IMPORT command parameters
+ *
+ * @pek_address: PEK certificate chain
+ * @pek_len: length of PEK certificate
+ * @oca_address: OCA certificate chain
+ * @oca_len: length of OCA certificate
+ */
+struct sev_user_data_pek_cert_import {
+	__u64 pek_cert_address;			/* In */
+	__u32 pek_cert_len;			/* In */
+	__u64 oca_cert_address;			/* In */
+	__u32 oca_cert_len;			/* In */
+} __attribute__((packed));
+
+/**
+ * struct sev_user_data_pdh_cert_export - PDH_CERT_EXPORT command parameters
+ *
+ * @pdh_address: PDH certificate address
+ * @pdh_len: length of PDH certificate
+ * @cert_chain_address: PDH certificate chain
+ * @cert_chain_len: length of PDH certificate chain
+ */
+struct sev_user_data_pdh_cert_export {
+	__u64 pdh_cert_address;			/* In */
+	__u32 pdh_cert_len;			/* In/Out */
+	__u64 cert_chain_address;		/* In */
+	__u32 cert_chain_len;			/* In/Out */
+} __attribute__((packed));
+
+/**
+ * struct sev_issue_cmd - SEV ioctl parameters
+ *
+ * @cmd: SEV commands to execute
+ * @opaque: pointer to the command structure
+ * @error: SEV FW return code on failure
+ */
+struct sev_issue_cmd {
+	__u32 cmd;				/* In */
+	__u64 data;				/* In */
+	__u32 error;				/* Out */
+} __attribute__((packed));
+
+#define SEV_IOC_TYPE		'S'
+#define SEV_ISSUE_CMD	_IOWR(SEV_IOC_TYPE, 0x0, struct sev_issue_cmd)
+
+#endif /* __PSP_USER_SEV_H */
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 9767172..e152417 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -121,7 +121,7 @@ done
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in kvm.h kvm_para.h vfio.h vfio_ccw.h vhost.h \
-              psci.h userfaultfd.h; do
+              psci.h psp-sev.h userfaultfd.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
 rm -rf "$output/linux-headers/asm-generic"
-- 
1.8.3.1
