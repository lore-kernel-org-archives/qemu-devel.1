Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A52C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A27E206B7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A27E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqmYr-0005Uh-T9
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 19:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqmST-0006JH-OU
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 19:48:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqmSQ-0006CY-Vj
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 19:48:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2092576|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.00890421-0.000663144-0.990433;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03298; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---.Hw4Qdou_1593647277; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hw4Qdou_1593647277)
 by smtp.aliyun-inc.com(10.147.40.44); Thu, 02 Jul 2020 07:47:57 +0800
Subject: Re: [PATCH] tcg: Fix do_nonatomic_op_* vs signed operations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200701165646.1901320-1-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <42696c68-4216-1cd9-11f2-613231c8534e@c-sky.com>
Date: Thu, 2 Jul 2020 07:47:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200701165646.1901320-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 19:44:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair.Francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/7/2 0:56, Richard Henderson wrote:
> The smin/smax/umin/umax operations require the operands to be
> properly sign extended.  Do not drop the MO_SIGN bit from the
> load, and additionally extend the val input.
>
> Reported-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index e60b74fb82..4b8a473fad 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -3189,8 +3189,9 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
>   
>       memop = tcg_canonicalize_memop(memop, 0, 0);
>   
> -    tcg_gen_qemu_ld_i32(t1, addr, idx, memop & ~MO_SIGN);
> -    gen(t2, t1, val);
> +    tcg_gen_qemu_ld_i32(t1, addr, idx, memop);
> +    tcg_gen_ext_i32(t2, val, memop);
> +    gen(t2, t1, t2);
>       tcg_gen_qemu_st_i32(t2, addr, idx, memop);
>   
>       tcg_gen_ext_i32(ret, (new_val ? t2 : t1), memop);
> @@ -3232,8 +3233,9 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
>   
>       memop = tcg_canonicalize_memop(memop, 1, 0);
>   
> -    tcg_gen_qemu_ld_i64(t1, addr, idx, memop & ~MO_SIGN);
> -    gen(t2, t1, val);
> +    tcg_gen_qemu_ld_i64(t1, addr, idx, memop);
> +    tcg_gen_ext_i64(t2, val, memop);
> +    gen(t2, t1, t2);
>       tcg_gen_qemu_st_i64(t2, addr, idx, memop);
>   
>       tcg_gen_ext_i64(ret, (new_val ? t2 : t1), memop);

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei

