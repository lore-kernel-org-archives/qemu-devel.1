Received: from eggs.gnu.org ([2001:4830:134:3::10]:51318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZGif-0003Wo-9w
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZGie-0007yh-2B
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:51:37 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
Message-ID: <48f8ed69-5410-2f59-932c-bd4a1192dc18@ilande.co.uk>
Date: Tue, 18 Dec 2018 14:51:01 +0000
MIME-Version: 1.0
In-Reply-To: <2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/34] tcg, target/ppc vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 18/12/2018 09:49, Mark Cave-Ayland wrote:

> A quick bisection suggests that there could be 2 separate issues related to the
> implementation of splat:
> 
> Patch "target/ppc: convert vspltis[bhw] to use vector operations" causes a black
> border to appear around the OS X splash screen
> (https://www.ilande.co.uk/tmp/qemu/badapple1.png) which may suggest an
> overflow/alignment issue.

This one appears to be a sign extension issue - if I make use of the same technique
used by the previous helper then this problem goes away. Below is my experimental
diff to be squashed into "target/ppc: convert vspltis[bhw] to use vector operations":

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index be638cdb1a..6cd25c8dc6 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -723,12 +723,12 @@ GEN_VXRFORM_DUAL(vcmpgtfp, PPC_ALTIVEC, PPC_NONE, \
 #define GEN_VXFORM_DUPI(name, tcg_op, opc2, opc3)                       \
 static void glue(gen_, name)(DisasContext *ctx)                         \
     {                                                                   \
-        int simm;                                                       \
+        int8_t simm;                                                    \
         if (unlikely(!ctx->altivec_enabled)) {                          \
             gen_exception(ctx, POWERPC_EXCP_VPU);                       \
             return;                                                     \
         }                                                               \
-        simm = SIMM5(ctx->opcode);                                      \
+        simm = (int8_t)(SIMM5(ctx->opcode) << 3) >> 3;                  \
         tcg_op(avr64_offset(rD(ctx->opcode), true), 16, 16, simm);      \
     }


ATB,

Mark.
