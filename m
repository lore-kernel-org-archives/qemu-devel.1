Received: from eggs.gnu.org ([2001:4830:134:3::10]:48654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyONa-0004wu-Ue
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 17:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyONX-0007Iw-74
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 17:01:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyONX-0007Ia-1l
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 17:01:07 -0400
Date: Tue, 20 Mar 2018 23:01:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521579652-180248-4-git-send-email-mst@redhat.com>
References: <1521579652-180248-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521579652-180248-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/3] linux-headers: add kvm header for mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <jhogan@kernel.org>

kvm header for MIPS was manually excluded from auto-updates.

Update it now to 4.16-rc5.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 linux-headers/asm-mips/kvm.h | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/linux-headers/asm-mips/kvm.h b/linux-headers/asm-mips/kvm.h
index 6985eb5..edcf717 100644
--- a/linux-headers/asm-mips/kvm.h
+++ b/linux-headers/asm-mips/kvm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -19,6 +20,10 @@
  * Some parts derived from the x86 version of this file.
  */
 
+#define __KVM_HAVE_READONLY_MEM
+
+#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+
 /*
  * for KVM_GET_REGS and KVM_SET_REGS
  *
@@ -52,9 +57,14 @@ struct kvm_fpu {
  * Register set = 0: GP registers from kvm_regs (see definitions below).
  *
  * Register set = 1: CP0 registers.
- *  bits[15..8]  - Must be zero.
- *  bits[7..3]   - Register 'rd'  index.
- *  bits[2..0]   - Register 'sel' index.
+ *  bits[15..8]  - COP0 register set.
+ *
+ *  COP0 register set = 0: Main CP0 registers.
+ *   bits[7..3]   - Register 'rd'  index.
+ *   bits[2..0]   - Register 'sel' index.
+ *
+ *  COP0 register set = 1: MAARs.
+ *   bits[7..0]   - MAAR index.
  *
  * Register set = 2: KVM specific registers (see definitions below).
  *
@@ -113,6 +123,15 @@ struct kvm_fpu {
 
 
 /*
+ * KVM_REG_MIPS_CP0 - Coprocessor 0 registers.
+ */
+
+#define KVM_REG_MIPS_MAAR	(KVM_REG_MIPS_CP0 | (1 << 8))
+#define KVM_REG_MIPS_CP0_MAAR(n)	(KVM_REG_MIPS_MAAR | \
+					 KVM_REG_SIZE_U64 | (n))
+
+
+/*
  * KVM_REG_MIPS_KVM - KVM specific control registers.
  */
 
-- 
MST
