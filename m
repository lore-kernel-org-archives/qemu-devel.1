Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1F9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B412065E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B412065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jynda-0002dP-9i
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 22:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jyncv-00026P-5p; Thu, 23 Jul 2020 22:40:01 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:35357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jynct-0008FY-Ar; Thu, 23 Jul 2020 22:40:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08086676|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0425078-0.0151578-0.942334;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03293; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.I6iQOtM_1595558391; 
Received: from 30.225.208.37(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I6iQOtM_1595558391)
 by smtp.aliyun-inc.com(10.147.42.253);
 Fri, 24 Jul 2020 10:39:51 +0800
Subject: Re: [PATCH v2 2/7] target/riscv: Generalize gen_nanbox_fpr to
 gen_nanbox_s
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-3-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <cb478922-43d1-b08f-7635-1aea76d071b8@c-sky.com>
Date: Fri, 24 Jul 2020 10:39:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724002807.441147-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 22:31:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/7/24 8:28, Richard Henderson wrote:
> Do not depend on the RVD extension, take input and output via
> TCGv_i64 instead of fpu regno.  Move the function to translate.c
> so that it can be used in multiple trans_*.inc.c files.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rvf.inc.c | 16 +---------------
>   target/riscv/translate.c                | 11 +++++++++++
>   2 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
> index 3bfd8881e7..c7057482e8 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -23,20 +23,6 @@
>           return false;                       \
>   } while (0)
>   
> -/*
> - * RISC-V requires NaN-boxing of narrower width floating
> - * point values.  This applies when a 32-bit value is
> - * assigned to a 64-bit FP register.  Thus this does not
> - * apply when the RVD extension is not present.
> - */
> -static void gen_nanbox_fpr(DisasContext *ctx, int regno)
> -{
> -    if (has_ext(ctx, RVD)) {
> -        tcg_gen_ori_i64(cpu_fpr[regno], cpu_fpr[regno],
> -                        MAKE_64BIT_MASK(32, 32));
> -    }
> -}
> -
>   static bool trans_flw(DisasContext *ctx, arg_flw *a)
>   {
>       TCGv t0 = tcg_temp_new();
> @@ -46,7 +32,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>       tcg_gen_addi_tl(t0, t0, a->imm);
>   
>       tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
> -    gen_nanbox_fpr(ctx, a->rd);
> +    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>   
>       tcg_temp_free(t0);
>       mark_fs_dirty(ctx);
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9632e79cf3..12a746da97 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -90,6 +90,17 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>       return ctx->misa & ext;
>   }
>   
> +/*
> + * RISC-V requires NaN-boxing of narrower width floating point values.
> + * This applies when a 32-bit value is assigned to a 64-bit FP register.
> + * For consistency and simplicity, we nanbox results even when the RVD
> + * extension is not present.
> + */
> +static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
> +{
> +    tcg_gen_ori_i64(out, in, MAKE_64BIT_MASK(32, 32));
> +}
> +
If possible,

+static void gen_nanbox(TCGv_i64 out, TCGv_i64 in, uint32_t flen)
+{
+    tcg_gen_ori_i64(out, in, MAKE_64BIT_MASK(flen, 64 - flen));
+}
+

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei
>   static void generate_exception(DisasContext *ctx, int excp)
>   {
>       tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);


