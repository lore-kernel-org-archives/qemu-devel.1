Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e094e-000197-GL
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e094Y-0001ps-PW
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:32:36 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:53993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e094Y-0001pF-Jy
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:32:30 -0400
Received: by mail-qt0-x233.google.com with SMTP id 47so26428115qts.10
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:32:30 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-9-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0136d727-d125-7eed-ca13-02011cbdf921@linaro.org>
Date: Thu, 5 Oct 2017 12:32:27 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-9-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/20] target/arm: Don't warn about
 exception return with PC low bit set for v8M
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

On 09/22/2017 10:59 AM, Peter Maydell wrote:
> +        if ((env->regs[15] & 1) && !arm_feature(env, ARM_FEATURE_V8)) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "M profile return from interrupt with misaligned "
> -                          "PC is UNPREDICTABLE\n");
> -            /* Actual hardware seems to ignore the lsbit, and there are several
> -             * RTOSes out there which incorrectly assume the r15 in the stack
> -             * frame should be a Thumb-style "lsbit indicates ARM/Thumb" value.
> -             */
> -            env->regs[15] &= ~1U;
> +                          "PC is UNPREDICTABLE on v7M\n");
>          }
> +        env->regs[15] &= ~1U;

If you're going to always test regs[15] & 1, you might as well use that and
avoid an unlikely(?) writeback.

    if (env->regs[15] & 1) {
        if (!arm_feature(env, ARM_FEATURE_V8)) {
            qemu_log_mask(...);
        }
        env->regs[15] &= ~1U;
    }

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
