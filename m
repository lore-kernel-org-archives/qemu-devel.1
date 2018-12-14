Received: from eggs.gnu.org ([2001:4830:134:3::10]:37692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbBm-0000SI-PA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbBj-0002bU-KJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:18:46 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Fri, 14 Dec 2018 00:18:39 +0000
Message-ID: <66f87c98f9a2122262d7c3179052df95e42b6917.1544746653.git.alistair.francis@wdc.com>
References: <cover.1544746653.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544746653.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 2/5] RISC-V: Fix CLINT timecmp low 32-bit
 writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Michael Clark <mjc@sifive.com>

A missing shift made updates to the low order bits
of timecmp erroneously copy the old low order bits
into the high order bits of the 64-bit timecmp
register. Add the missing shift and rename timecmp
local variables to timecmp_hi and timecmp_lo.

This bug didn't show up as the low order bits are
usually written first followed by the high order
bits meaning the high order bits contained an invalid
value between the timecmp_lo and timecmp_hi update.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Co-Authored-by: Johannes Haring <johannes.haring@gmx.net>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_clint.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index 0d2fd52487..d4c159e937 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -146,15 +146,15 @@ static void sifive_clint_write(void *opaque, hwaddr a=
ddr, uint64_t value,
             error_report("clint: invalid timecmp hartid: %zu", hartid);
         } else if ((addr & 0x7) =3D=3D 0) {
             /* timecmp_lo */
-            uint64_t timecmp =3D env->timecmp;
+            uint64_t timecmp_hi =3D env->timecmp >> 32;
             sifive_clint_write_timecmp(RISCV_CPU(cpu),
-                timecmp << 32 | (value & 0xFFFFFFFF));
+                timecmp_hi << 32 | (value & 0xFFFFFFFF));
             return;
         } else if ((addr & 0x7) =3D=3D 4) {
             /* timecmp_hi */
-            uint64_t timecmp =3D env->timecmp;
+            uint64_t timecmp_lo =3D env->timecmp;
             sifive_clint_write_timecmp(RISCV_CPU(cpu),
-                value << 32 | (timecmp & 0xFFFFFFFF));
+                value << 32 | (timecmp_lo & 0xFFFFFFFF));
         } else {
             error_report("clint: invalid timecmp write: %08x", (uint32_t)a=
ddr);
         }
--=20
2.19.1
