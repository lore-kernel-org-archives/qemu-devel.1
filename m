Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C027EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9577525374
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9577525374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnGiu-0000jv-Sp
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jnGhz-0007xu-NN; Mon, 22 Jun 2020 03:17:35 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47874)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jnGhx-0006lP-Et; Mon, 22 Jun 2020 03:17:35 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id B2EEB40A632F;
 Mon, 22 Jun 2020 07:17:27 +0000 (UTC)
Subject: Re: [PATCH] target/arm: Remove unnecessary gen_io_end() calls
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200619170324.12093-1-peter.maydell@linaro.org>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <879e933c-a65c-3706-afa1-5ede1acb062c@ispras.ru>
Date: Mon, 22 Jun 2020 10:17:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619170324.12093-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=dovgaluk@ispras.ru;
 helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.06.2020 20:03, Peter Maydell wrote:
> Since commit ba3e7926691ed3 it has been unnecessary for target code
> to call gen_io_end() after an IO instruction in icount mode; it is
> sufficient to call gen_io_start() before it and to force the end of
> the TB.
> 
> Many now-unnecessary calls to gen_io_end() were removed in commit
> 9e9b10c6491153b, but some were missed or accidentally added later.
> Remove unneeded calls from the arm target:
> 
>   * the call in the handling of exception-return-via-LDM is
>     unnecessary, and the code is already forcing end-of-TB
>   * the call in the VFP access check code is more complicated:
>     we weren't ending the TB, so we need to add the code to
>     force that by setting DISAS_UPDATE
>   * the doc comment for ARM_CP_IO doesn't need to mention
>     gen_io_end() any more
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

> ---
>   target/arm/cpu.h               | 2 +-
>   target/arm/translate-vfp.inc.c | 7 +++----
>   target/arm/translate.c         | 3 ---
>   3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 677584e5da0..cf66b8c7fb0 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2334,7 +2334,7 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
>    * migration or KVM state synchronization. (Typically this is for "registers"
>    * which are actually used as instructions for cache maintenance and so on.)
>    * IO indicates that this register does I/O and therefore its accesses
> - * need to be surrounded by gen_io_start()/gen_io_end(). In particular,
> + * need to be marked with gen_io_start() and also end the TB. In particular,
>    * registers which implement clocks or timers require this.
>    * RAISES_EXC is for when the read or write hook might raise an exception;
>    * the generated code will synchronize the CPU state before calling the hook
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index e1a90175983..bf31b186578 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -119,15 +119,14 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
>           if (s->v7m_lspact) {
>               /*
>                * Lazy state saving affects external memory and also the NVIC,
> -             * so we must mark it as an IO operation for icount.
> +             * so we must mark it as an IO operation for icount (and cause
> +             * this to be the last insn in the TB).
>                */
>               if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> +                s->base.is_jmp = DISAS_UPDATE;
>                   gen_io_start();
>               }
>               gen_helper_v7m_preserve_fp_state(cpu_env);
> -            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> -                gen_io_end();
> -            }
>               /*
>                * If the preserve_fp_state helper doesn't throw an exception
>                * then it will clear LSPACT; we don't need to repeat this for
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 6d18892adee..2677eaeb1e1 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8824,9 +8824,6 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
>               gen_io_start();
>           }
>           gen_helper_cpsr_write_eret(cpu_env, tmp);
> -        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> -            gen_io_end();
> -        }
>           tcg_temp_free_i32(tmp);
>           /* Must exit loop to check un-masked IRQs */
>           s->base.is_jmp = DISAS_EXIT;
> 



