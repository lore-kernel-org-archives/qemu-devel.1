Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04614C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C682C20675
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="vWRI7ZZA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="BYU95YOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C682C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Pix-0006pG-3V
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 22:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6Pi8-0006Af-Mv
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 22:44:53 -0400
Received: from relay1.mymailcheap.com ([144.217.248.102]:60328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6Pi4-0005DM-Mq
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 22:44:52 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 402AF3F202;
 Thu, 13 Aug 2020 22:44:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 752532A51F;
 Fri, 14 Aug 2020 04:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1597373083;
 bh=JZETTbGItmiky6LT8qjopU8YBjmP0Wo/Ydy1DNWDF/Y=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=vWRI7ZZAc/6s95kn/YMJ4pKb3gY/q4EshW+FMr4azhlwzNOlnBbfckpfZSGSqqMRP
 zArP6IoASjC1pt5C9+2yr33FUGl9HADL8Mr1zW79sJ401a7y5j8pzQKjhE5qAUtvNI
 oTp1ZBrozsCEqy//D8AHx1SQv8RoYu5HW4aimnLw=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DIn0M1S3EtKu; Fri, 14 Aug 2020 04:44:42 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS;
 Fri, 14 Aug 2020 04:44:41 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id CC1C040855;
 Fri, 14 Aug 2020 02:44:40 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="BYU95YOw"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [103.195.6.80])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 94B8A40855;
 Fri, 14 Aug 2020 02:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1597373064;
 bh=JZETTbGItmiky6LT8qjopU8YBjmP0Wo/Ydy1DNWDF/Y=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=BYU95YOwWnynZnbpqZTKIWg+QBSQ3+iq6P9UcfuAel+hHWQL/dZIpRE1YbEkPPPnW
 uPj4lusRB2PewEG5d19VAzAUDMpMZx9e5AVoOVQ67anrpZ4Tuh7PGr1eWY8zp/9Tg3
 0dQHZYmXuEC0gOULbDW/n5ClItd2dUgqZCogrnpE=
Subject: Re: [RFC PATCH v2 2/3] target/mips/op_helper: Document
 Invalidate/Writeback opcodes as no-op
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200813181527.22551-1-f4bug@amsat.org>
 <20200813181527.22551-3-f4bug@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <f9102a09-0cbd-1555-c1e4-33410d8a3856@flygoat.com>
Date: Fri, 14 Aug 2020 10:44:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813181527.22551-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Rspamd-Queue-Id: CC1C040855
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 RCPT_COUNT_FIVE(0.00)[6];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
 ML_SERVERS(-3.10)[213.133.102.83];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 FREEMAIL_CC(0.00)[gmail.com,syrmia.com,aurel32.net,linaro.org];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=144.217.248.102;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 22:44:44
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/8/14 上午2:15, Philippe Mathieu-Daudé 写道:
> QEMU does not model caches, so there is not much to do with the
> Invalidate/Writeback opcodes. Make it explicit adding a comment.
>
> Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks~

> ---
>   target/mips/op_helper.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 92c399d8d4..2496d1dd71 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1578,16 +1578,19 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
>       target_ulong index = addr & 0x1fffffff;
>   
>       switch (cache_operation) {
> -    case 0b010:
> -        /* Index Store Tag */
> +    case 0b010: /* Index Store Tag */
>           memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,
>                                        MO_64, MEMTXATTRS_UNSPECIFIED);
>           break;
> -    case 0b001:
> -        /* Index Load Tag */
> +    case 0b001: /* Index Load Tag */
>           memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
>                                       MO_64, MEMTXATTRS_UNSPECIFIED);
>           break;
> +    case 0b000: /* Index Invalidate */
> +    case 0b100: /* Hit Invalidate */
> +    case 0b110: /* Hit Writeback */
> +        /* no-op */
> +        break;
>       default:
>           break;
>       }

