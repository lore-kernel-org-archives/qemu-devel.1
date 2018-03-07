Received: from eggs.gnu.org ([2001:4830:134:3::10]:50303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHg-0004ix-3I
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHc-0008HO-3s
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:20 -0500
Received: from mail-by2nam03on0062.outbound.protection.outlook.com
	([104.47.42.62]:59840
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etcHb-0008Fi-PO
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:16 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Mar 2018 10:50:20 -0600
Message-Id: <20180307165038.88640-11-brijesh.singh@amd.com>
In-Reply-To: <20180307165038.88640-1-brijesh.singh@amd.com>
References: <20180307165038.88640-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 10/28] include: add psp-sev.h header file
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

The header file provide the ioctl command and structure to communicate
with /dev/sev device.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 linux-headers/linux/psp-sev.h | 142 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 linux-headers/linux/psp-sev.h

diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
new file mode 100644
index 000000000000..33e247471ae0
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
-- 
2.14.3
