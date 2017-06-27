Received: from eggs.gnu.org ([2001:4830:134:3::10]:40896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPhFd-0000Z8-Oy
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPhFd-00013K-4D
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:33:17 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838531005.6497.12362377034456580175.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c43f4c84-debd-ffbe-7d48-97c74a0b8bd0@twiddle.net>
Date: Mon, 26 Jun 2017 20:33:08 -0700
MIME-Version: 1.0
In-Reply-To: <149838531005.6497.12362377034456580175.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 21/26] target: [tcg,
 arm] Port to insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/25/2017 03:08 AM, Lluís Vilanova wrote:
> +static void arm_trblock_insn_start(DisasContextBase *db, CPUState *cpu)
> +{
> +    DisasContext *dc = container_of(db, DisasContext, base);
> +
> +    dc->insn_start_idx = tcg_op_buf_count();
> +    tcg_gen_insn_start(dc->pc,
> +                       (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
> +                       0);
> +
> +#ifdef CONFIG_USER_ONLY
> +    /* Intercept jump to the magic kernel page.  */
> +    if (dc->pc >= 0xffff0000) {
> +        /* We always get here via a jump, so know we are not in a
> +           conditional execution block.  */
> +        gen_exception_internal(EXCP_KERNEL_TRAP);
> +        dc->is_jmp = DJ_EXC;
> +    }
> +#endif
> +}

I think this DJ_EXC block is better placed at the start of disas_insn.

It is, however, the answer to one of my questions re patch 4/26.


r~
