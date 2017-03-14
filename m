Received: from eggs.gnu.org ([2001:4830:134:3::10]:48921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2d-0007Ro-Kd
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2c-0007AU-BA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Mar 2017 15:26:24 +1100
Message-Id: <20170314042626.20020-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170314042626.20020-1-david@gibson.dropbear.id.au>
References: <20170314042626.20020-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/4] target/ppc: fix cpu_ov setting for 32-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, pbonzini@redhat.com, aik@ozlabs.ru, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

A bug was introduced in following commit:

    dc0ad84 target/ppc: update overflow flags for add/sub

As for 32-bit ppc target extracting bit 63 for overflow is not correct.
Made it dependent on TARGET_LOG_BITS. This had broken booting MacOS
9.2.1 image

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b6abc60..f40b5a1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -818,7 +818,7 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
         if (is_isa300(ctx)) {
             tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
         }
-        tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
+        tcg_gen_extract_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1, 1);
     }
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 }
-- 
2.9.3
