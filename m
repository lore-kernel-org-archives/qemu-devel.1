Received: from eggs.gnu.org ([2001:4830:134:3::10]:60664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj4M-0002Sp-PS
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj4M-0004JU-1E
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:08:50 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:38787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmj4L-0004Iz-Re
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:08:49 -0400
Received: by mail-pg0-x235.google.com with SMTP id b8so12059073pgn.5
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:08:49 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-17-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <93e924b9-e8db-124b-8a17-a16f6abf5e0a@linaro.org>
Date: Tue, 29 Aug 2017 09:08:46 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-17-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/20] target/arm: Make CCR register banked
 for v8M
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

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> +        if (attrs.secure) {
> +            /* the BFHFNMIGN bit is not banked; keep that in the NS copy */
> +            int new_bfhnmign = !!(value & R_V7M_CCR_BFHFNMIGN_MASK);
> +
> +            cpu->env.v7m.ccr[M_REG_NS] = deposit32(cpu->env.v7m.ccr[M_REG_NS],
> +                                                    R_V7M_CCR_BFHFNMIGN_SHIFT,
> +                                                    R_V7M_CCR_BFHFNMIGN_LENGTH,
> +                                                    new_bfhnmign);
> +            value &= ~R_V7M_CCR_BFHFNMIGN_MASK;
> +        }

No need to extract and then redeposit, just use the mask.

    cpu->env.v7m.ccr[M_REG_NS] =
      (cpu->env.v7m.ccr[M_REG_NS] & ~R_V7M_CCR_BFHFNMIGN_MASK)
      | (value & R_V7M_CCR_BFHFNMIGN_MASK);


r~
