Received: from eggs.gnu.org ([2001:4830:134:3::10]:38221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZHII-0001QE-St
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZHID-00069M-3y
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:28:26 -0500
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
	<48f8ed69-5410-2f59-932c-bd4a1192dc18@ilande.co.uk>
	<939b45c1-d5fd-f513-c149-c3d02775493c@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ee46f244-a7af-20e0-b8f1-0b22190f0727@ilande.co.uk>
Date: Tue, 18 Dec 2018 15:22:41 +0000
MIME-Version: 1.0
In-Reply-To: <939b45c1-d5fd-f513-c149-c3d02775493c@linaro.org>
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

On 18/12/2018 15:07, Richard Henderson wrote:

>> This one appears to be a sign extension issue - if I make use of the same technique
>> used by the previous helper then this problem goes away. Below is my experimental
>> diff to be squashed into "target/ppc: convert vspltis[bhw] to use vector operations":
>>
>> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
>> index be638cdb1a..6cd25c8dc6 100644
>> --- a/target/ppc/translate/vmx-impl.inc.c
>> +++ b/target/ppc/translate/vmx-impl.inc.c
>> @@ -723,12 +723,12 @@ GEN_VXRFORM_DUAL(vcmpgtfp, PPC_ALTIVEC, PPC_NONE, \
>>  #define GEN_VXFORM_DUPI(name, tcg_op, opc2, opc3)                       \
>>  static void glue(gen_, name)(DisasContext *ctx)                         \
>>      {                                                                   \
>> -        int simm;                                                       \
>> +        int8_t simm; 
> 
> This shouldn't matter.
>                                                    \
>>          if (unlikely(!ctx->altivec_enabled)) {                          \
>>              gen_exception(ctx, POWERPC_EXCP_VPU);                       \
>>              return;                                                     \
>>          }                                                               \
>> -        simm = SIMM5(ctx->opcode);                                      \
>> +        simm = (int8_t)(SIMM5(ctx->opcode) << 3) >> 3;                  \
> 
> This suggests that SIMM5 should be using sextract32.

There's certainly an obvious typo here, but on its own it doesn't fix the issue:

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index b77d564a65..08eee1cd84 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -124,7 +124,7 @@ EXTRACT_SHELPER(SIMM, 0, 16);
 /* 16 bits unsigned immediate value */
 EXTRACT_HELPER(UIMM, 0, 16);
 /* 5 bits signed immediate value */
-EXTRACT_HELPER(SIMM5, 16, 5);
+EXTRACT_SHELPER(SIMM5, 16, 5);
 /* 5 bits signed immediate value */
 EXTRACT_HELPER(UIMM5, 16, 5);
 /* 4 bits unsigned immediate value */


ATB,

Mark.
