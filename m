Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17601C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 20:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D4520773
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 20:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="j+UWg71l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D4520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxcsj-0002Sf-TA
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 16:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1jxcpN-0008DS-At; Mon, 20 Jul 2020 16:56:01 -0400
Received: from smtp.duncanthrax.net ([178.63.180.169]:34396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1jxcpK-0007DK-J1; Mon, 20 Jul 2020 16:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RFfrEwtyrZce65eWqE7EXYHiuymtFH58IqpGkmPL7GE=; b=j+UWg71ln5Arc7FR/UOD/+TOVj
 f1VhTLWga8SaRbYAg8TZpvvfbUERCI54rdm6TbjwxDQ1H1URHp4i6U0gJXxZHrkA00JQYuZ88a6KN
 cuJOvzTj31UzcCGkKLyOaQwmcdTfBawXOkRFPYefagNwS61UdId3PM7B03grZavYfKGg=;
Received: from hsi-kbw-091-089-248-125.hsi2.kabel-badenwuerttemberg.de
 ([91.89.248.125] helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1jxcpF-0007MR-Rr; Mon, 20 Jul 2020 22:55:54 +0200
Date: Mon, 20 Jul 2020 22:55:48 +0200
From: svens@stackframe.org
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH for-5.1] target/hppa: Free some temps in do_sub
Message-ID: <20200720205548.GB4591@t470p.stackframe.org>
References: <20200720174039.517902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720174039.517902-1-richard.henderson@linaro.org>
Received-SPF: none client-ip=178.63.180.169; envelope-from=svens@stackframe.org;
 helo=smtp.duncanthrax.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 16:55:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: deller@gmx.de, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Mon, Jul 20, 2020 at 10:40:39AM -0700, Richard Henderson wrote:
> Two temps allocated but not freed.  Do enough subtractions
> within a single TB and one can run out of temps entirely.
> 
> Cc: qemu-stable@nongnu.org
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880287
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 52d7bea1ea..4bd22d4820 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1294,6 +1294,8 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
>      save_or_nullify(ctx, cpu_psw_cb_msb, cb_msb);
>      save_gpr(ctx, rt, dest);
>      tcg_temp_free(dest);
> +    tcg_temp_free(cb);
> +    tcg_temp_free(cb_msb);
>  
>      /* Install the new nullification.  */
>      cond_free(&ctx->null_cond);
> -- 
> 2.25.1
> 

Tested-by: Sven Schnelle <svens@stackframe.org>

Regards
Sven

