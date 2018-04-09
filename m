Received: from eggs.gnu.org ([2001:4830:134:3::10]:33577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5eyO-0005nl-F3
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5eyN-0001RS-Mh
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:09:12 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180409103834.11285-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1f4f8003-09ed-b2f7-5709-6b74c0fa2f7e@twiddle.net>
Date: Tue, 10 Apr 2018 08:09:02 +1000
MIME-Version: 1.0
In-Reply-To: <20180409103834.11285-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] target/arm: Don't corrupt
 insn_start arguments on 32-bit hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, alarson@ddci.com, qemu-stable@nongnu.org

On 04/09/2018 08:38 PM, Peter Maydell wrote:
> +#if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
>      tcg_set_insn_param(s->insn_start, 2, syn);
> +#else
> +    /* tcg_gen_insn_start has split every target_ulong argument to
> +     * op_insn_start into two 32-bit arguments, so we want the low
> +     * half of the 3rd argument, which is at index 4.
> +     */
> +    tcg_set_insn_param(s->insn_start, 4, syn);
> +#endif
>   

Ouch, good catch.

I think we should fix this in tcg_set_insn_param instead,
as several other targets are also affected by this.


r~
