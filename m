Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F783C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 05:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99BA2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 05:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99BA2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ehR-0006ny-W9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 01:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1k0egg-0006Lo-Ct
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 01:31:34 -0400
Received: from mail.ispras.ru ([83.149.199.84]:48822)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1k0ege-0001YL-3S
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 01:31:34 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id E7A9340A2041;
 Wed, 29 Jul 2020 05:31:25 +0000 (UTC)
Subject: Re: [PULL for-5.1 3/3] tcg/cpu-exec: precise single-stepping after an
 interrupt
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200717181623.2742758-1-richard.henderson@linaro.org>
 <20200717181623.2742758-4-richard.henderson@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <4aa23af2-56f3-2ba2-12f8-b36d046d5e78@ispras.ru>
Date: Wed, 29 Jul 2020 08:31:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717181623.2742758-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 01:31:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.07.2020 21:16, Richard Henderson wrote:
> When single-stepping with a debugger attached to QEMU, and when an
> interrupt is raised, the debugger misses the first instruction after
> the interrupt.
> 
> Tested-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/757702
> Message-Id: <20200717163029.2737546-1-richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 6a3d3a3cfc..66d38f9d85 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -588,7 +588,13 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>           else {
>               if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
>                   replay_interrupt();
> -                cpu->exception_index = -1;
> +                /*
> +                 * After processing the interrupt, ensure an EXCP_DEBUG is
> +                 * raised when single-stepping so that GDB doesn't miss the
> +                 * next instruction.
> +                 */
> +                cpu->exception_index =
> +                    (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
>                   *last_tb = NULL;

I just rebased my reverse debugging patches and noticed that this breaks 
the debugging in record/replay icount mode for i386.
At some points "si" in remote gdb does nothing.

This happens because of CPU_INTERRUPT_POLL. These are not real 
interrupts and converted into HW interrupt_request flags later.

Therefore we shouldn't stop when there is CPU_INTERRUPT_POLL request.

>               }
>               /* The target hook may have updated the 'cpu->interrupt_request';
> 


Pavel Dovgalyuk

