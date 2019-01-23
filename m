Received: from eggs.gnu.org ([209.51.188.92]:50230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmS5O-0003ur-4k
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmS5K-0002pg-OW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:37:31 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:37107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmS5D-0002ac-99
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:37:26 -0500
Received: by mail-pl1-x62c.google.com with SMTP id b5so1950728plr.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 15:37:20 -0800 (PST)
References: <20190123213227.17077-1-aaron@os.amperecomputing.com>
	<20190123213227.17077-2-aaron@os.amperecomputing.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7794239c-7850-1bb6-cbcb-b648533d9036@linaro.org>
Date: Wed, 23 Jan 2019 15:37:16 -0800
MIME-Version: 1.0
In-Reply-To: <20190123213227.17077-2-aaron@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 1/2] target/arm: Send interrupts on PMU
 counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 1/23/19 1:32 PM, Aaron Lindsay OS wrote:
> +        uint64_t overflow_mask = env->cp15.c9_pmcr & PMCRLC ? \
> +                                 INT64_MIN : INT32_MIN;

With type promotion, this is the same as writing

    ? 0x8000000000000000ull : 0xffffffff80000000ull

which is probably not what you were intending.

Perhaps just ? 1ull << 63 : 1ull << 31 is better?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
