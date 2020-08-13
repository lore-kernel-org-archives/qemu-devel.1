Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342CB20771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="cPfgugGS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="g1lw3leL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342CB20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Afr-0005vO-Fk
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6AcI-0000kQ-E5
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:37:50 -0400
Received: from relay3.mymailcheap.com ([217.182.119.155]:43144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6AcE-0007RU-FC
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:37:49 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id 2F3583F15F;
 Thu, 13 Aug 2020 12:37:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 549F02A0F5;
 Thu, 13 Aug 2020 06:37:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1597315062;
 bh=ha+w40Y1MRYmDuCm5TaDdA0ESuZlYJUgJ7J0M1MavJc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cPfgugGS2y6JIUF/v8pWtDjoDevp3Rq8j6q4pfflJUPjwkwNuo88UL5eRHdf7YpJu
 NsX1sgYMWd0pL1q2lPPQTr+dtDMEHmJ1+ZTiZWrUi1MwS/ZPE0UTG14ZYQWmtMXWzm
 9tJx+rfHY+tFsgTqPNPvAJlVbBsuU6QqO9TXy2EI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RkdjlC17vZHj; Thu, 13 Aug 2020 06:37:39 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Thu, 13 Aug 2020 06:37:39 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 1B1C741184;
 Thu, 13 Aug 2020 10:37:35 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="g1lw3leL"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [103.195.6.80])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 8C3F841184;
 Thu, 13 Aug 2020 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1597315039;
 bh=ha+w40Y1MRYmDuCm5TaDdA0ESuZlYJUgJ7J0M1MavJc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=g1lw3leLGksM7dAb3xHC4ovA0XSRIpMs3DccGzsc8qOD12vFoftWX0Z6HcJSiI5e9
 8rk6nPnsDsX39amSI4Bh694tnRugWD+HZHLVP/FuwgD7cihO4YPjvtjXURujI2NWun
 nGYpFasW1ggtASD7vqf/Jfc822Yt+q4UfAZRMxyA=
Subject: Re: [PATCH 2/2] target/mips: Add definition of Loongson-3A3000 CPU
To: Kaige Li <likaige@loongson.cn>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <1597311707-27565-1-git-send-email-likaige@loongson.cn>
 <1597311707-27565-2-git-send-email-likaige@loongson.cn>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <7772e88a-1f48-29ef-0004-e6eaa4eb5b60@flygoat.com>
Date: Thu, 13 Aug 2020 18:37:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597311707-27565-2-git-send-email-likaige@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Rspamd-Queue-Id: 1B1C741184
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 RCPT_COUNT_FIVE(0.00)[5]; ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[loongson.cn,gmail.com,aurel32.net,syrmia.com];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=217.182.119.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay3.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:37:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MIME_CHARSET_FARAWAY=2.45,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



ÔÚ 2020/8/13 ÏÂÎç5:41, Kaige Li Ð´µÀ:
> Add definition of the Loongson-3A3000 processor in QEMU.

Hi Kaige,

We're not defining Loongson-3A3000 in QEMU because we have
some features like Loongson-EXT2, VTLB not available currently, I'd
prefer define it after we add these features to TCG.

Loongson-3A4000's define is a exception to support KVM.

Thanks.

- Jiaxun

>
> Signed-off-by: Kaige Li <likaige@loongson.cn>
> ---
>   target/mips/translate_init.inc.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
> index 0740819..2e98aff 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -829,6 +829,30 @@ const mips_def_t mips_defs[] = {
>           .PABITS = 48,
>           .insn_flags = CPU_LOONGSON3A,
>           .mmu_type = MMU_TYPE_R4000,
> +   },
> +   {
> +        .name = "Loongson-3A3000",
> +        .CP0_PRid = 0x14630d,
> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
> +                       (MMU_TYPE_R4000 << CP0C0_MT),
> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
> +                       (2 << CP0C1_IS) | (5 << CP0C1_IL) | (3 << CP0C1_IA) |
> +                       (2 << CP0C1_DS) | (5 << CP0C1_DL) | (3 << CP0C1_DA) |
> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
> +        .CP0_Config2 = MIPS_CONFIG2 | (5 << CP0C2_SS) | (5 << CP0C2_SL) |
> +                       (15 << CP0C2_SA),
> +        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA),
> +        .SYNCI_Step = 16,
> +        .CCRes = 2,
> +        .CP0_Status_rw_bitmask = 0x7DDBFFFF,
> +        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64),
> +        .CP1_fcr31 = 0,
> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
> +        .SEGBITS = 48,
> +        .PABITS = 48,
> +        .insn_flags = CPU_LOONGSON3A,
> +        .mmu_type = MMU_TYPE_R4000,
>       },
>       {
>           .name = "Loongson-3A4000",

