Received: from eggs.gnu.org ([209.51.188.92]:60895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBY0M-0000YS-EG
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 01:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBY0L-0005SU-Gj
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 01:00:06 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBY0J-0005Px-Hj
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 01:00:04 -0400
Received: by mail-ot1-x342.google.com with SMTP id s24so14179090otk.13
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 22:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-2-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Apr 2019 11:59:49 +0700
Message-ID: <CAFEAcA99NgExCLYzwfw1sWAmKr7PHGZSY6_+=etnV74NSjz1qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/26] tcg: Assert h2g_valid for 32-bit
 guest on 64-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 3 Apr 2019 at 10:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For this combination, we can tell whether or not the address
> being accessed is within the 4GB range that is accessible by
> the guest.  Otherwise the fault must be elsewhere in qemu,
> accessing qemu data structures.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/user-exec.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 0789984fe6..fa9380a380 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -143,6 +143,15 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>          }
>      }
>
> +    /*
> +     * For a 32-bit guest on a 64-bit host, the set of addresses that we
> +     * access on behalf of the guest is constrained.  Anything outside
> +     * that range is a bug elsewhere in QEMU.
> +     */
> +#if TARGET_LONG_BITS == 32 && HOST_LONG_BITS == 64
> +    g_assert(h2g_valid(address));
> +#endif

I'm not sure this is right. h2g_valid() will check whether the guest address is
below GUEST_ADDR_MAX. For architectures which set
TARGET_VIRT_ADDR_SPACE_BITS to something less than 32 there are
address values which aren't h2g_valid() but which we still want to cause
a guest exception rather than asserting, aren't there ?

thanks
-- PMM
