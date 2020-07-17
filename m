Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E4C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFEE206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="FP7Kyjx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFEE206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUkP-00051h-PX
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jwUhf-0003be-6a
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:03:23 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:59244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jwUhc-0007Ua-Uk
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:03:22 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 1EB282000A;
 Fri, 17 Jul 2020 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1595008998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+8gkbfjc0KHg0vfr8L6V61Tdiud8G8eV8p46iaQA8Y=;
 b=FP7Kyjx3naw/VaJnMvkMQrsq7rH9Dm489eST0Ymng2KNsyzfVYB16cj2WgI3O8NYHGTUh2
 pv1OHQWrwQD/sqRUYPJUHxh9iaV/vqrkvYCJC2ZlQRISEf00uqzR5NQZUcjb/XsNU1CAGR
 Yrdpw3ao6+PUyHowIALghchAmeh3TW8=
Subject: Re: [PATCH] tcg/cpu-exec: precise single-stepping after an interrupt
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200717163029.2737546-1-richard.henderson@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <a244cd56-5d12-6254-ee29-135106378052@greensocs.com>
Date: Fri, 17 Jul 2020 20:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717163029.2737546-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 14:03:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 6:30 PM, Richard Henderson wrote:
> When single-stepping with a debugger attached to QEMU, and when an
> interrupt is raised, the debugger misses the first instruction after
> the interrupt.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/757702
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Tested-by: Luc Michel <luc.michel@greensocs.com>

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
>               }
>               /* The target hook may have updated the 'cpu->interrupt_request';
> 

