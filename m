Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D33C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 02:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9DE2067B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 02:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9DE2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji7hn-0006nr-2O
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 22:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1ji7h8-0006GI-Vq; Sun, 07 Jun 2020 22:39:27 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1ji7h6-0007Vg-RS; Sun, 07 Jun 2020 22:39:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08822978|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.343959-0.00357344-0.652468;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03310; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.HjSZAfY_1591583952; 
Received: from 30.225.208.60(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HjSZAfY_1591583952)
 by smtp.aliyun-inc.com(10.147.41.121);
 Mon, 08 Jun 2020 10:39:12 +0800
Subject: Re: [PATCH v8 30/62] target/riscv: Update fp_status when float
 rounding mode changes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-31-zhiwei_liu@c-sky.com>
 <7cb2aa5d-833a-8544-dadc-5aabba06ecd2@linaro.org>
 <ca1e71cd-c290-5fb9-e9bf-026c73e06560@c-sky.com>
 <7ec3d397-bf9a-07f5-3014-4acf47a4fd6e@linaro.org>
 <ba7ef161-8bc6-516f-b5a7-8133e3a89998@c-sky.com>
 <dd721c20-fc04-49b8-0c5a-1b4761105461@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <8b1d3fb0-479a-9fa9-99cd-b71e0da275cc@c-sky.com>
Date: Mon, 8 Jun 2020 10:39:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <dd721c20-fc04-49b8-0c5a-1b4761105461@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 22:02:43
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, alistair.francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/6/5 11:30, Richard Henderson wrote:
> On 6/4/20 7:50 PM, LIU Zhiwei wrote:
>> So no scalar insns will require changes within a translation block.
> Not true -- scalar insns can encode rm into the instruction.
>
>> I think there is a error in gen_set_rm
>>
>> static void gen_set_rm(DisasContext *ctx, int rm)
>> {
>>      TCGv_i32 t0;
>>
>>      if (ctx->frm == rm) {
>>          return;
>>      }
>>      ctx->frm = rm;
>>      t0 = tcg_const_i32(rm);
>>      gen_helper_set_rounding_mode(cpu_env, t0);
>>      tcg_temp_free_i32(t0);
>> }
>>
>> I don't know why  updating ctx->frm in this function.
> This is a cache of the current rm, as most recently stored in
> env->fp_status.rounding_mode.
>
> So if we have
>
> 	fadd.s  ft0, ft0, ft0, rtz
> 	fadd.s  ft0, ft0, ft0, rtz
> 	fadd.s  ft0, ft0, ft0, rtz
>
> we will only switch to round_to_zero once.
Get it, thanks.

Maybe I should only gen_set_rm(ctx, 7) for each vector float insn.
And the csr write method for frm or fcsr will not change.

So I will remove this patch in the next patch set.

Zhiwei
>
> r~


