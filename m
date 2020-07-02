Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BBEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABADF20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="VbdHQ3Li";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="M17t+1el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABADF20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr07C-00089B-UO
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jr06b-0007c7-NQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:22:25 -0400
Received: from relay1.mymailcheap.com ([144.217.248.100]:33742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jr06Y-00018o-44
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:22:25 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 0F0E93F1C5;
 Thu,  2 Jul 2020 10:22:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id E55EC2A3B5;
 Thu,  2 Jul 2020 10:22:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1593699739;
 bh=5MfcvXb6DTvYyhLRCnJRUdq8gb9X9AYL0Y4d8rMzhaA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=VbdHQ3LivX6/Oui4J0+22a12ZB2dNJs/e+hyOuEgiN/lahQs8p8UIYnZJNn0lIZd7
 Dp0RVufxtWyVOn/OMrZ1gQZldpDqlOQP13KoOkSGfTSr3E+GXMeSXvo9qWtex1A01l
 jF5Sa+OMCUzpbqT8Sr6OtHohtZmJXVXpSeGd90D4=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r7JKi7n9yz3v; Thu,  2 Jul 2020 10:22:17 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2020 10:22:17 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id BA8EC403B3;
 Thu,  2 Jul 2020 14:22:15 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="M17t+1el"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [38.39.233.129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 2AA29403B3;
 Thu,  2 Jul 2020 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1593699623;
 bh=5MfcvXb6DTvYyhLRCnJRUdq8gb9X9AYL0Y4d8rMzhaA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=M17t+1elWu+zpqgfIm0b3M3fGrOlBrjd3W9wLHm2SH3NKzf3pBBX61+wDVrO/O1wM
 Y0RzMogzpLr+guznxTOvH5QqACSXimBt18hTDRjCLjC1QiEni7wRTGbNC2Brsb/HWG
 nr6REkvyCgFR5zSYtoON7cZwjYpgCEmDXYoita28=
Subject: Re: [PATCH 5/5] MAINTAINERS: Adjust MIPS maintainership (Add Huacai
 Chen & Jiaxun Yang)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200702133701.25237-1-f4bug@amsat.org>
 <20200702133701.25237-6-f4bug@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <27bef940-48cd-1d1b-85b8-45328baa2917@flygoat.com>
Date: Thu, 2 Jul 2020 22:20:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702133701.25237-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Rspamd-Queue-Id: BA8EC403B3
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
 ML_SERVERS(-3.10)[213.133.102.83];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 FREEMAIL_CC(0.00)[gmail.com,lemote.com,aurel32.net,debian.org,loongson.cn,alpha.franken.de,syrmia.com];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=144.217.248.100;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 10:22:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yunqiang Su <syq@debian.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Lichao Liu <liulichao@loongson.cn>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


在 2020/7/2 下午9:37, Philippe Mathieu-Daudé 写道:
> From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>
> Huacai Chen steps in as new energy [1].
>
> Aurelien Jarno comment [2]:
>
>    It happens that I known Huacai Chen from the time he was
>    upstreaming the Loongson 3 support to the kernel, I have been
>    testing and reviewing his patches. I also know Jiaxun Yang from
>    the #debian-mips IRC channel. I know that they are both very
>    competent and have a good knowledge of the open source world.
>    I therefore agree that they are good additions to maintain and/or
>    review the MIPS part of QEMU.
>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718434.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718738.html
>
> Cc: Huacai Chen <chenhc@lemote.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Message-Id: <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
> PMD: [Split patch in 3, added Aurelien comment]
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

I can help with reviewing relevant patches .

Thanks.

> ---
> Aurelien comment is probably worth an Acked-by tag.
>
> Cc: Yunqiang Su <ysu@wavecomp.com>

+ Yunqiang's Debian mailbox as he no longer works for MIPS/Wave but 
still working on Debian/MIPS.

> Cc: Lichao Liu <liulichao@loongson.cn>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>
>   MAINTAINERS | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64f54c553c..8155525077 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -213,6 +213,7 @@ F: disas/microblaze.c
>   
>   MIPS TCG CPUs
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>   R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: target/mips/
> @@ -375,6 +376,7 @@ S: Maintained
>   F: target/arm/kvm.c
>   
>   MIPS KVM CPUs
> +M: Huacai Chen <chenhc@lemote.com>
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>   S: Odd Fixes
>   F: target/mips/kvm.c
> @@ -2672,6 +2674,8 @@ F: disas/i386.c
>   
>   MIPS TCG target
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +R: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>   R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: tcg/mips/

