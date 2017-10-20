Received: from eggs.gnu.org ([2001:4830:134:3::10]:53007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e5bpr-000325-5X
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e5bpo-0002aC-FM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:15:55 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1508522170-22539-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <19d12a08-9ecd-8c91-4652-28773ca35d8e@twiddle.net>
Date: Fri, 20 Oct 2017 11:15:46 -0700
MIME-Version: 1.0
In-Reply-To: <1508522170-22539-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] translate.c: Fix usermode big-endian
 AArch32 LDREXD and STREXD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, christophe.lyon@linaro.org

On 10/20/2017 10:56 AM, Peter Maydell wrote:
> +        if (s->be_data) {
> +            tcg_gen_extr_i64_i32(tmp2, tmp, t64);
> +        } else {
> +            tcg_gen_extr_i64_i32(tmp, tmp2, t64);
> +        }

The test against be_data must be of the form s->be_data == MO_BE/LE.

The actual bits have MO_BSWAP non-zero, and then set MO_BE/LE to either 0 or
MO_BSWAP depending on the host endianness.


> -        gen_aa32_frob64(s, o64);
> +        if (s->be_data) {
> +            tcg_gen_rotri_i64(o64, o64, 32);
> +        }
>          tcg_gen_setcond_i64(TCG_COND_NE, o64, o64, cpu_exclusive_val);

We're not splitting o64 to parts.  Are you sure it shouldn't stay as frob?


r~
