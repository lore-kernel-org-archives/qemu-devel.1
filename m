Received: from eggs.gnu.org ([209.51.188.92]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1K-0006Rx-Vf
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1J-0005ed-Vs
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:27 +1000
Message-Id: <20190426060627.18153-37-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/36] target/ppc: improve performance of large
 BAT invalidations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

From: Artyom Tarasenko <atar4qemu@gmail.com>

Performing a complete flush is ~ 100 times faster than flushing
256MiB of 4KiB pages. Set a limit of 1024 pages and perform a complete
flush afterwards.

This patch significantly speeds up AIX 5.1 and NetBSD-ofppc.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index d226b35739..1dbc9acb75 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1820,6 +1820,13 @@ static inline void do_invalidate_BAT(CPUPPCState *=
env, target_ulong BATu,
=20
     base =3D BATu & ~0x0001FFFF;
     end =3D base + mask + 0x00020000;
+    if (((end - base) >> TARGET_PAGE_BITS) > 1024) {
+        /* Flushing 1024 4K pages is slower than a complete flush */
+        LOG_BATS("Flush all BATs\n");
+        tlb_flush(CPU(cs));
+        LOG_BATS("Flush done\n");
+        return;
+    }
     LOG_BATS("Flush BAT from " TARGET_FMT_lx " to " TARGET_FMT_lx " ("
              TARGET_FMT_lx ")\n", base, end, mask);
     for (page =3D base; page !=3D end; page +=3D TARGET_PAGE_SIZE) {
--=20
2.20.1
