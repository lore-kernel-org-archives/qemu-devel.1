Received: from eggs.gnu.org ([2001:4830:134:3::10]:44207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq8-000537-E4
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq7-0002DN-EQ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:45 +1000
Message-Id: <20180709074350.27086-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/16] target/ppc: fix build on ppc64 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <laurent@vivier.eu>

When I try to build a ppc64 target on a ppc64 host (gcc 8.1.1), I have:

.../target/ppc/int_helper.c: In function 'helper_vinsertb':
.../target/ppc/int_helper.c:1954:32: error: array subscript 18446744073709551608 is above array bounds of 'uint8_t[16]' {aka 'unsigned char[16]'} [-Werror=array-bounds]
         memmove(&r->u8[index], &b->u8[8 - sizeof(r->element)],              \
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.../target/ppc/int_helper.c:1965:1: note: in expansion of macro 'VINSERT'

If we compare with the macro for ppc64le, we can see
sizeof(r->element[0]) should be used instead of sizeof(r->element).

And VINSERT uses only u8, u16, u32 and u64, so the maximum value
of sizeof(r->element[0]) is 8

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 03d37da79f..d52338ed71 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1951,7 +1951,7 @@ VSPLT(w, u32)
 #define VINSERT(suffix, element)                                            \
     void helper_vinsert##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t index) \
     {                                                                       \
-        memmove(&r->u8[index], &b->u8[8 - sizeof(r->element)],              \
+        memmove(&r->u8[index], &b->u8[8 - sizeof(r->element[0])],           \
                sizeof(r->element[0]));                                      \
     }
 #else
-- 
2.17.1
