Received: from eggs.gnu.org ([2001:4830:134:3::10]:55414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZNpu-0001Kp-Jn
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZNpp-0007J7-SN
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:23:02 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZNpp-0007Hg-Fn
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:22:57 -0500
Received: by mail-pg0-x242.google.com with SMTP id i196so583307pgd.0
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:22:57 -0800 (PST)
References: <20180108231048.23966-1-laurent@vivier.eu>
	<20180108231048.23966-5-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2a7c530-d34c-3bea-52ec-2cd1bd607ba3@linaro.org>
Date: Wed, 10 Jan 2018 13:22:52 -0800
MIME-Version: 1.0
In-Reply-To: <20180108231048.23966-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] target/m68k: add moves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 01/08/2018 03:10 PM, Laurent Vivier wrote:
> and introduce SFC and DFC control registers.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

The patch is correct, so

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

However...

> +void HELPER(moves_store)(CPUM68KState *env, uint32_t val,
> +                         uint32_t addr, uint32_t size)
> +{
> +    if (env->dfc & 4) { /* kernel */
> +        switch (size) {
> +        case OS_BYTE:
> +            cpu_stb_kernel_ra(env, addr, val, GETPC());

I assume that the kernel makes frequent use of moves for user access?

You might consider copying bit 2 of SFC and DFC into TB->FLAGS, if supervisor
mode.  At which point you can issue the qemu_ld/st opcodes inline to the
correct mmu_idx.


r~
