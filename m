Received: from eggs.gnu.org ([2001:4830:134:3::10]:35893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZHDE-0004q0-Ib
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZGyV-0002Nd-Bs
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:08:03 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZGyT-0002LV-Gc
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:07:59 -0500
Received: by mail-pl1-x642.google.com with SMTP id u6so7940413plm.8
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 07:07:57 -0800 (PST)
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
	<48f8ed69-5410-2f59-932c-bd4a1192dc18@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <939b45c1-d5fd-f513-c149-c3d02775493c@linaro.org>
Date: Tue, 18 Dec 2018 07:07:53 -0800
MIME-Version: 1.0
In-Reply-To: <48f8ed69-5410-2f59-932c-bd4a1192dc18@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/18/18 6:51 AM, Mark Cave-Ayland wrote:
> On 18/12/2018 09:49, Mark Cave-Ayland wrote:
> 
>> A quick bisection suggests that there could be 2 separate issues related to the
>> implementation of splat:
>>
>> Patch "target/ppc: convert vspltis[bhw] to use vector operations" causes a black
>> border to appear around the OS X splash screen
>> (https://www.ilande.co.uk/tmp/qemu/badapple1.png) which may suggest an
>> overflow/alignment issue.
> 
> This one appears to be a sign extension issue - if I make use of the same technique
> used by the previous helper then this problem goes away. Below is my experimental
> diff to be squashed into "target/ppc: convert vspltis[bhw] to use vector operations":
> 
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
> index be638cdb1a..6cd25c8dc6 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -723,12 +723,12 @@ GEN_VXRFORM_DUAL(vcmpgtfp, PPC_ALTIVEC, PPC_NONE, \
>  #define GEN_VXFORM_DUPI(name, tcg_op, opc2, opc3)                       \
>  static void glue(gen_, name)(DisasContext *ctx)                         \
>      {                                                                   \
> -        int simm;                                                       \
> +        int8_t simm; 

This shouldn't matter.
                                                   \
>          if (unlikely(!ctx->altivec_enabled)) {                          \
>              gen_exception(ctx, POWERPC_EXCP_VPU);                       \
>              return;                                                     \
>          }                                                               \
> -        simm = SIMM5(ctx->opcode);                                      \
> +        simm = (int8_t)(SIMM5(ctx->opcode) << 3) >> 3;                  \

This suggests that SIMM5 should be using sextract32.


r~
