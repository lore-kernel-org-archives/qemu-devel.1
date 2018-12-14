Received: from eggs.gnu.org ([2001:4830:134:3::10]:37730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbC0-0000bw-Jr
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbBx-0003AW-Ep
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:19:00 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Fri, 14 Dec 2018 00:18:54 +0000
Message-ID: <126c481d658afcc297317b2f6844a48ffe591de2.1544746653.git.alistair.francis@wdc.com>
References: <cover.1544746653.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544746653.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 3/5] RISC-V: Fix PLIC pending bitfield reads
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

The address calculation for the pending bitfield had
a copy paste bug. This bug went unnoticed because the Linux
PLIC driver does not read the pending bitfield, rather it
reads pending interrupt numbers from the claim register
and writes acknowledgements back to the claim register.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Reported-by: Vincent Siles <vincent.siles@ens-lyon.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 9cf9a1f986..d12ec3fc9a 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -214,7 +214,7 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr a=
ddr, unsigned size)
     } else if (addr >=3D plic->pending_base && /* 1 bit per source */
                addr < plic->pending_base + (plic->num_sources >> 3))
     {
-        uint32_t word =3D (addr - plic->priority_base) >> 2;
+        uint32_t word =3D (addr - plic->pending_base) >> 2;
         if (RISCV_DEBUG_PLIC) {
             qemu_log("plic: read pending: word=3D%d value=3D%d\n",
                 word, plic->pending[word]);
--=20
2.19.1
