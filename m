Received: from eggs.gnu.org ([2001:4830:134:3::10]:34081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0C14-000504-0N
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0C10-0000Rf-6w
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:41:06 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0C0z-0000P8-W8
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:41:02 -0400
Received: by mail-wm0-x22b.google.com with SMTP id q132so4180064wmd.2
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 12:41:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b7ff6879-f6fd-4efe-f32c-78171462e3c4@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-19-git-send-email-peter.maydell@linaro.org>
	<b7ff6879-f6fd-4efe-f32c-78171462e3c4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Oct 2017 20:40:40 +0100
Message-ID: <CAFEAcA8WXDCv11au1RxdP+nvNChEcWatZpDAZgwwgN7_MCq=Yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 18/20] target/arm: Implement BLXNS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 October 2017 at 19:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 09/22/2017 11:00 AM, Peter Maydell wrote:
>> +void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
>> +{
> ...
>> +    if (dest & 1) {
>> +        /* target is Secure, so this is just a normal BLX,
>> +         * except that the low bit doesn't indicate Thumb/not.
>> +         */
>> +        env->regs[14] = nextinst;
>> +        env->thumb = 1;
>> +        env->regs[15] = dest & ~1;
>> +        return;
>> +    }
> ...
>> +    switch_v7m_security_state(env, dest & 1);
>> +    env->thumb = 1;
>> +    env->regs[15] = dest & ~1;
>
> dest & 1 is known to be 0.

Yes. I liked the symmetry with the tail end of the v7m_bxns helper,
which is conceptually doing the same thing, and assumed the
compiler would be smart enough not to generate unnecessary code.

>> +static inline void gen_blxns(DisasContext *s, int rm)
>> +{
>> +    TCGv_i32 var = load_reg(s, rm);
>> +
>> +    /* We don't need to sync condexec state, for the same reason as blxns.
>
> s/blxns/bxns/ ?

Yes.

thanks
-- PMM
