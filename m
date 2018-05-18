Received: from eggs.gnu.org ([2001:4830:134:3::10]:46800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fJePn-0007GF-Ap
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fJePm-0003Vd-5K
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:23:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fJePm-0003VM-0G
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:23:18 -0400
From: marcandre.lureau@redhat.com
Date: Fri, 18 May 2018 14:23:02 +0200
Message-Id: <20180518122304.31020-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180518122304.31020-1-marcandre.lureau@redhat.com>
References: <20180518122304.31020-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/4] OvmfPkg/IndustryStandard: add QemuTpm.h
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Add some common macros and type definitions corresponding to the QEMU
TPM interface.

Contributed-under: TianoCore Contribution Agreement 1.1
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
---
 OvmfPkg/Include/IndustryStandard/QemuTpm.h | 69 ++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/OvmfPkg/Include/IndustryStandard/QemuTpm.h b/OvmfPkg/Include=
/IndustryStandard/QemuTpm.h
new file mode 100644
index 000000000000..a342cbc347f1
--- /dev/null
+++ b/OvmfPkg/Include/IndustryStandard/QemuTpm.h
@@ -0,0 +1,69 @@
+/** @file
+  Macro and type definitions corresponding to the QEMU TPM interface.
+
+  Refer to "docs/specs/tpm.txt" in the QEMU source directory.
+
+  Copyright (C) 2018, Red Hat, Inc.
+  Copyright (c) 2018, IBM Corporation. All rights reserved.<BR>
+
+  This program and the accompanying materials are licensed and made avai=
lable
+  under the terms and conditions of the BSD License which accompanies th=
is
+  distribution. The full text of the license may be found at
+  http://opensource.org/licenses/bsd-license.php
+
+  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
+  WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+**/
+
+#ifndef __QEMU_TPM_H__
+#define __QEMU_TPM_H__
+
+#include <Base.h>
+
+//
+// whether function is blocked by BIOS settings; bits 0, 1, 2
+//
+#define QEMU_TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
+#define QEMU_TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
+#define QEMU_TPM_PPI_FUNC_BLOCKED             (2 << 0)
+#define QEMU_TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
+#define QEMU_TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
+#define QEMU_TPM_PPI_FUNC_MASK                (7 << 0)
+
+//
+// The following structure is shared between firmware and ACPI.
+//
+#pragma pack (1)
+typedef struct {
+  UINT8  Func[256];           // func
+  UINT8  In;                  // ppin
+  UINT32 Ip;                  // ppip
+  UINT32 Response;            // pprp
+  UINT32 Request;             // pprq
+  UINT32 RequestParameter;    // pprm
+  UINT32 LastRequest;         // lppr
+  UINT32 FRet;                // fret
+  UINT8  Res1[0x40];          // res1
+  UINT8  NextStep;            // next_step
+} QEMU_TPM_PPI;
+#pragma pack ()
+
+//
+// The following structure is for the fw_cfg etc/tpm/config file.
+//
+#pragma pack (1)
+typedef struct {
+  UINT32 PpiAddress;
+  UINT8  TpmVersion;
+  UINT8  PpiVersion;
+} QEMU_FWCFG_TPM_CONFIG;
+#pragma pack ()
+
+#define QEMU_TPM_VERSION_UNSPEC    0
+#define QEMU_TPM_VERSION_1_2       1
+#define QEMU_TPM_VERSION_2         2
+
+#define QEMU_TPM_PPI_VERSION_NONE  0
+#define QEMU_TPM_PPI_VERSION_1_30  1
+
+#endif
--=20
2.17.0.253.g3dd125b46d
