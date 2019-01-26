Received: from eggs.gnu.org ([209.51.188.92]:33587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gnHpb-0004SF-Ck
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 01:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gnHpY-0001Mw-GT
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 01:52:42 -0500
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Date: Sat, 26 Jan 2019 08:52:10 +0200
Message-Id: <20190126065211.3587-1-remi@remlab.net>
In-Reply-To: <1648289.tQCHxfjYn9@basile.remlab.net>
References: <1648289.tQCHxfjYn9@basile.remlab.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv2 1/3] target/arm: fix AArch64 virtual address
 space size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>

Since QEMU does not support the ARMv8.2-LVA, Large Virtual Address,
extension (yet), the VA address space is 48-bits plus a sign bit. User
mode can only handle the positive half of the address space, so that
makes a limit of 48 bits.

(With LVA, it would be 53 and 52 bits respectively.)

The incorrectly large address space conflicts with PAuth instructions,
which bits 48-54 and 56-63 for the pointer authentication code. This
also conflicts with (as yet unsupported by QEMU) data tagging and with
the ARMv8.5-MTE extension.

Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ff81db420d..a3781600ba 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2503,7 +2503,7 @@ bool write_cpustate_to_list(ARMCPU *cpu);
=20
 #if defined(TARGET_AARCH64)
 #  define TARGET_PHYS_ADDR_SPACE_BITS 48
-#  define TARGET_VIRT_ADDR_SPACE_BITS 64
+#  define TARGET_VIRT_ADDR_SPACE_BITS 48
 #else
 #  define TARGET_PHYS_ADDR_SPACE_BITS 40
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
--=20
2.20.1
