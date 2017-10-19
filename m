Received: from eggs.gnu.org ([2001:4830:134:3::10]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5CG1-00079X-0X
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5CG0-0007tF-4j
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:57:13 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:51267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5CFz-0007sh-Sk
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:57:12 -0400
Received: by mail-wr0-x244.google.com with SMTP id j14so8639855wre.8
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 07:57:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710181439060.27209@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710181439060.27209@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 15:56:49 +0100
Message-ID: <CAFEAcA_v=UsQ4hfn2oVLt3MPU3yJUnHLfzZHrdkstQ0VVgSDbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Julien Grall <julien.grall@linaro.org>

On 18 October 2017 at 23:03, Stefano Stabellini <sstabellini@kernel.org> wrote:
> WFI/E are 4 bytes long: set ARM_EL_IL_SHIFT in the syndrome.
>
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 1f6efef..cf8c966 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -398,6 +398,7 @@ static inline uint32_t syn_breakpoint(int same_el)
>  static inline uint32_t syn_wfx(int cv, int cond, int ti)
>  {
>      return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
> +           (1 << ARM_EL_IL_SHIFT) |
>             (cv << 24) | (cond << 20) | ti;
>  }

Hmm. What we do now is definitely wrong, but WFI and WFE can be 2 bytes:
there is a T1 Thumb encoding that is 2 bytes.

HELPER(wfi) doesn't get that right, though:
    if (target_el) {
        env->pc -= 4;
        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0), target_el);
    }

So I think that HELPER(wfi) needs to be passed an extra
parameter is_16bit, which it can then use both in its adjustment
of env->pc and to pass as an extra parameter to syn_wfx(),
which is then syn_wfx(int cv, int cond, int ti, bool is_16bit).

(In theory HELPER(wfe) should also be passed is_16bit, but
since it doesn't currently ever raise an exception it
doesn't matter.)

thanks
-- PMM
