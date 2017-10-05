Received: from eggs.gnu.org ([2001:4830:134:3::10]:50618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BJu-0003vD-7n
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BJt-0004zk-Ja
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:56:30 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:57207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0BJt-0004zD-Ed
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:56:29 -0400
Received: by mail-qt0-x235.google.com with SMTP id 34so10174047qtb.13
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:56:29 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-19-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7ff6879-f6fd-4efe-f32c-78171462e3c4@linaro.org>
Date: Thu, 5 Oct 2017 14:56:26 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-19-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/20] target/arm: Implement BLXNS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/22/2017 11:00 AM, Peter Maydell wrote:
> +void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
> +{
...
> +    if (dest & 1) {
> +        /* target is Secure, so this is just a normal BLX,
> +         * except that the low bit doesn't indicate Thumb/not.
> +         */
> +        env->regs[14] = nextinst;
> +        env->thumb = 1;
> +        env->regs[15] = dest & ~1;
> +        return;
> +    }
...
> +    switch_v7m_security_state(env, dest & 1);
> +    env->thumb = 1;
> +    env->regs[15] = dest & ~1;

dest & 1 is known to be 0.

> +static inline void gen_blxns(DisasContext *s, int rm)
> +{
> +    TCGv_i32 var = load_reg(s, rm);
> +
> +    /* We don't need to sync condexec state, for the same reason as blxns.

s/blxns/bxns/ ?

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
