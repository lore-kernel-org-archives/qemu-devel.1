Received: from eggs.gnu.org ([2001:4830:134:3::10]:53527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe61-00005w-Uc
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe61-0000x7-3a
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:54:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:32805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhe60-0000wf-Sw
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:54:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id r5-v6so805339pgv.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:54:04 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-29-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a3014ac-88e6-c99a-fe4d-5274d2f4f7f2@linaro.org>
Date: Mon, 23 Jul 2018 09:54:00 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-29-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 28/40] target/mips: Adjust
 exception_resume_pc() for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:55 AM, Stefan Markovic wrote:
> From: James Hogan <james.hogan@mips.com>
> 
> We shouldn't set the ISA bit in CP0_EPC for nanoMIPS.
> 
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index dc8f2a5..fb47018 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -656,7 +656,8 @@ target_ulong exception_resume_pc (CPUMIPSState *env)
>      target_ulong bad_pc;
>      target_ulong isa_mode;
>  
> -    isa_mode = !!(env->hflags & MIPS_HFLAG_M16);
> +    isa_mode = env->hflags & MIPS_HFLAG_M16 &&
> +                !(env->insn_flags & ISA_NANOMIPS32);

Is there a compelling reason to have MIPS_HFLAG_M16 *set* for ISA_NANOMIPS?

This seems like the 6th or 7th patch that works around M16.  If M16 were always
unset for nanomips, it would have avoided a lot of extra effort, it would seem.
 In addition, looking at the fully patched tree and grepping for HFLAG_M16,
there appear to be further uses that have been missed for the extra NANOMIPS check.


r~
