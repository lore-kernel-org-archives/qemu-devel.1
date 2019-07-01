Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECDBC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850DE20665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850DE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58835 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwPc-0007L0-CB
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40931)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKY-00025v-Lc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKS-0002B9-Gw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwJz-0001jT-UX; Mon, 01 Jul 2019 09:26:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16AE6811D8;
 Mon,  1 Jul 2019 13:26:05 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DF0617DDD;
 Mon,  1 Jul 2019 13:26:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:24:58 +0200
Message-Id: <20190701132516.26392-10-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 01 Jul 2019 13:26:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 09/27] target/arm: Move the DC ZVA helper
 into op_helper
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Samuel Ortiz <sameo@linux.intel.com>

Those helpers are a software implementation of the ARM v8 memory zeroing
op code. They should be moved to the op helper file, which is going to
eventually be built only when TCG is enabled.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Robert Bradford <robert.bradford@intel.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
[PMD: Rebased]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c    | 92 -----------------------------------------
 target/arm/op_helper.c | 93 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 92 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c77ed85215..a87fda9191 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13308,98 +13308,6 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr addres=
s, int size,
 #endif
 }
=20
-void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
-{
-    /*
-     * Implement DC ZVA, which zeroes a fixed-length block of memory.
-     * Note that we do not implement the (architecturally mandated)
-     * alignment fault for attempts to use this on Device memory
-     * (which matches the usual QEMU behaviour of not implementing eithe=
r
-     * alignment faults or any memory attribute handling).
-     */
-
-    ARMCPU *cpu =3D env_archcpu(env);
-    uint64_t blocklen =3D 4 << cpu->dcz_blocksize;
-    uint64_t vaddr =3D vaddr_in & ~(blocklen - 1);
-
-#ifndef CONFIG_USER_ONLY
-    {
-        /*
-         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
-         * the block size so we might have to do more than one TLB looku=
p.
-         * We know that in fact for any v8 CPU the page size is at least=
 4K
-         * and the block size must be 2K or less, but TARGET_PAGE_SIZE i=
s only
-         * 1K as an artefact of legacy v5 subpage support being present =
in the
-         * same QEMU executable. So in practice the hostaddr[] array has
-         * two entries, given the current setting of TARGET_PAGE_BITS_MI=
N.
-         */
-        int maxidx =3D DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
-        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)]=
;
-        int try, i;
-        unsigned mmu_idx =3D cpu_mmu_index(env, false);
-        TCGMemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
-
-        assert(maxidx <=3D ARRAY_SIZE(hostaddr));
-
-        for (try =3D 0; try < 2; try++) {
-
-            for (i =3D 0; i < maxidx; i++) {
-                hostaddr[i] =3D tlb_vaddr_to_host(env,
-                                                vaddr + TARGET_PAGE_SIZE=
 * i,
-                                                1, mmu_idx);
-                if (!hostaddr[i]) {
-                    break;
-                }
-            }
-            if (i =3D=3D maxidx) {
-                /*
-                 * If it's all in the TLB it's fair game for just writin=
g to;
-                 * we know we don't need to update dirty status, etc.
-                 */
-                for (i =3D 0; i < maxidx - 1; i++) {
-                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
-                }
-                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE)=
);
-                return;
-            }
-            /*
-             * OK, try a store and see if we can populate the tlb. This
-             * might cause an exception if the memory isn't writable,
-             * in which case we will longjmp out of here. We must for
-             * this purpose use the actual register value passed to us
-             * so that we get the fault address right.
-             */
-            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
-            /* Now we can populate the other TLB entries, if any */
-            for (i =3D 0; i < maxidx; i++) {
-                uint64_t va =3D vaddr + TARGET_PAGE_SIZE * i;
-                if (va !=3D (vaddr_in & TARGET_PAGE_MASK)) {
-                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
-                }
-            }
-        }
-
-        /*
-         * Slow path (probably attempt to do this to an I/O device or
-         * similar, or clearing of a block of code we have translations
-         * cached for). Just do a series of byte writes as the architect=
ure
-         * demands. It's not worth trying to use a cpu_physical_memory_m=
ap(),
-         * memset(), unmap() sequence here because:
-         *  + we'd need to account for the blocksize being larger than a=
 page
-         *  + the direct-RAM access case is almost always going to be de=
alt
-         *    with in the fastpath code above, so there's no speed benef=
it
-         *  + we would have to deal with the map returning NULL because =
the
-         *    bounce buffer was in use
-         */
-        for (i =3D 0; i < blocklen; i++) {
-            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
-        }
-    }
-#else
-    memset(g2h(vaddr), 0, blocklen);
-#endif
-}
-
 /* Note that signed overflow is undefined in C.  The following routines =
are
    careful to use unsigned types where modulo arithmetic is required.
    Failure to do so _will_ break on newer gcc.  */
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index b1952486c6..7c835d3ce7 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
@@ -1325,3 +1326,95 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t=
 x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
+
+void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
+{
+    /*
+     * Implement DC ZVA, which zeroes a fixed-length block of memory.
+     * Note that we do not implement the (architecturally mandated)
+     * alignment fault for attempts to use this on Device memory
+     * (which matches the usual QEMU behaviour of not implementing eithe=
r
+     * alignment faults or any memory attribute handling).
+     */
+
+    ARMCPU *cpu =3D env_archcpu(env);
+    uint64_t blocklen =3D 4 << cpu->dcz_blocksize;
+    uint64_t vaddr =3D vaddr_in & ~(blocklen - 1);
+
+#ifndef CONFIG_USER_ONLY
+    {
+        /*
+         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
+         * the block size so we might have to do more than one TLB looku=
p.
+         * We know that in fact for any v8 CPU the page size is at least=
 4K
+         * and the block size must be 2K or less, but TARGET_PAGE_SIZE i=
s only
+         * 1K as an artefact of legacy v5 subpage support being present =
in the
+         * same QEMU executable. So in practice the hostaddr[] array has
+         * two entries, given the current setting of TARGET_PAGE_BITS_MI=
N.
+         */
+        int maxidx =3D DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
+        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)]=
;
+        int try, i;
+        unsigned mmu_idx =3D cpu_mmu_index(env, false);
+        TCGMemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
+
+        assert(maxidx <=3D ARRAY_SIZE(hostaddr));
+
+        for (try =3D 0; try < 2; try++) {
+
+            for (i =3D 0; i < maxidx; i++) {
+                hostaddr[i] =3D tlb_vaddr_to_host(env,
+                                                vaddr + TARGET_PAGE_SIZE=
 * i,
+                                                1, mmu_idx);
+                if (!hostaddr[i]) {
+                    break;
+                }
+            }
+            if (i =3D=3D maxidx) {
+                /*
+                 * If it's all in the TLB it's fair game for just writin=
g to;
+                 * we know we don't need to update dirty status, etc.
+                 */
+                for (i =3D 0; i < maxidx - 1; i++) {
+                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
+                }
+                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE)=
);
+                return;
+            }
+            /*
+             * OK, try a store and see if we can populate the tlb. This
+             * might cause an exception if the memory isn't writable,
+             * in which case we will longjmp out of here. We must for
+             * this purpose use the actual register value passed to us
+             * so that we get the fault address right.
+             */
+            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
+            /* Now we can populate the other TLB entries, if any */
+            for (i =3D 0; i < maxidx; i++) {
+                uint64_t va =3D vaddr + TARGET_PAGE_SIZE * i;
+                if (va !=3D (vaddr_in & TARGET_PAGE_MASK)) {
+                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
+                }
+            }
+        }
+
+        /*
+         * Slow path (probably attempt to do this to an I/O device or
+         * similar, or clearing of a block of code we have translations
+         * cached for). Just do a series of byte writes as the architect=
ure
+         * demands. It's not worth trying to use a cpu_physical_memory_m=
ap(),
+         * memset(), unmap() sequence here because:
+         *  + we'd need to account for the blocksize being larger than a=
 page
+         *  + the direct-RAM access case is almost always going to be de=
alt
+         *    with in the fastpath code above, so there's no speed benef=
it
+         *  + we would have to deal with the map returning NULL because =
the
+         *    bounce buffer was in use
+         */
+        for (i =3D 0; i < blocklen; i++) {
+            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
+        }
+    }
+#else
+    memset(g2h(vaddr), 0, blocklen);
+#endif
+}
--=20
2.20.1


