Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33D7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A7921582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="IcKEofQs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="H+ELrFpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A7921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiUZ-0003bC-P5
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kSiT7-00028y-1p
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:13:33 -0400
Received: from relay1.mymailcheap.com ([149.56.97.132]:57095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kSiT2-0003Gx-Tp
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:13:32 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 53D3B3F157;
 Wed, 14 Oct 2020 15:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 9820C2A7E7;
 Wed, 14 Oct 2020 17:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1602688406;
 bh=qefkU1HQS6HMFhdaIqIdU+BEqqqn9SX/5++6+N3PBHw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=IcKEofQsBTb7IHdfGlQ1yCkhMlmyJoRLrJnyhagzkTknn68M/D2VYOpVVzji6Y0ky
 FHLzO6tF0O+3LVb5YDhT8waXFbbrevwVVdXU/ZgYs71/OlTaSToG4+rwtUDBdm67gt
 qw8YvfDkTqoPsDGP+HHJ90XDxHzyBM7mKvesP6+I=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b74W0GpG187B; Wed, 14 Oct 2020 17:13:25 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS;
 Wed, 14 Oct 2020 17:13:25 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 668A341BA2;
 Wed, 14 Oct 2020 15:13:24 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="H+ELrFpk"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [146.196.55.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 100DA41BA2;
 Wed, 14 Oct 2020 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1602688396;
 bh=qefkU1HQS6HMFhdaIqIdU+BEqqqn9SX/5++6+N3PBHw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=H+ELrFpkUVUJV2Famgm4/LwOUuwSQCAIZkNJm2tOZ1l2va6tR5E76nUs0oddW63Y2
 tkycYKDL+TtQNTvfZQbCADDs9x95/HqMcEekOhL+H+Biruo4MM8NDiaTYNCvqmRQfV
 UGvA55pVVIwtKDalzIsNa5ViN7+FXNt7Xt+a1Uo8=
Subject: Re: [PATCH v2 1/4] MAINTAINERS: Put myself forward for MIPS target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201013101659.3557154-1-f4bug@amsat.org>
 <20201013101659.3557154-2-f4bug@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <da20213b-7234-a43d-e240-3a97f8c43765@flygoat.com>
Date: Wed, 14 Oct 2020 23:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201013101659.3557154-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 668A341BA2
X-Spamd-Result: default: False [-0.10 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_SPF_SOFTFAIL(0.00)[~all]; ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCPT_COUNT_SEVEN(0.00)[7];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 FREEMAIL_CC(0.00)[aurel32.net,twiddle.net,gmail.com,redhat.com,syrmia.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=149.56.97.132;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 11:13:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/10/13 18:16, Philippe Mathieu-Daudé 写道:
> To avoid the MIPS target being orphan, volunteer to keep an eye
> on it and put together pull requests.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks for stepping out!

- Jiaxun

> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 426f52c1f63..d59e5c05c10 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -221,10 +221,11 @@ F: hw/microblaze/
>   F: disas/microblaze.c
>   
>   MIPS TCG CPUs
> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>   R: Aurelien Jarno <aurelien@aurel32.net>
>   R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>   R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> -S: Orphaned
> +S: Odd Fixes
>   F: target/mips/
>   F: default-configs/*mips*
>   F: disas/*mips*
> @@ -2815,11 +2816,12 @@ F: tcg/i386/
>   F: disas/i386.c
>   
>   MIPS TCG target
> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>   R: Aurelien Jarno <aurelien@aurel32.net>
>   R: Huacai Chen <chenhc@lemote.com>
>   R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>   R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> -S: Orphaned
> +S: Odd Fixes
>   F: tcg/mips/
>   
>   PPC TCG target

