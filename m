Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306EAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3F120707
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="pdgWBl5H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="o95deIu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3F120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluGb-0000ib-6H
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jluG1-0000IM-0e
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:07:05 -0400
Received: from relay3.mymailcheap.com ([217.182.66.161]:44634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jluFx-0002Uy-H4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:07:04 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id 39DB23F1CC;
 Thu, 18 Jun 2020 15:06:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 1937E2A8F8;
 Thu, 18 Jun 2020 15:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1592485617;
 bh=zi2h1C6ZxZzoD7n3cllbhfBhKtTXvyO/2y6JmuHnGvo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pdgWBl5HUGLpZ7ZUuZmXAkdDCdxHGnKB1/d2miLoWnmMU2KtmAkiFr66GtSRYppcp
 VtBWhPCgJZKEKTcmoghsbnUcmA8zuZHdE7yW8lc8tL708lxfN6RMBtFR8GDdCbFcKA
 i4p3XGIuND4h7VtUJ+zInOBXubrXVGnUi5sg7kf8=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CTOkohHc-etw; Thu, 18 Jun 2020 15:06:55 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS;
 Thu, 18 Jun 2020 15:06:55 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 1244941A63;
 Thu, 18 Jun 2020 13:06:55 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="o95deIu9"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (1-165-3-60.dynamic-ip.hinet.net [1.165.3.60])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id A0F1A40EB7;
 Thu, 18 Jun 2020 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1592485501;
 bh=zi2h1C6ZxZzoD7n3cllbhfBhKtTXvyO/2y6JmuHnGvo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=o95deIu9Jc4rBdhC1bL1Un/5ziCEQfiLRsTofaucvjoQLtCkYfNc5E/gdEiPVFdto
 ooUfkcRfLVkNpFClxOx4AIDk+QinfxxlkpnwemaGpoWXBO+XroddFVdAE8hElFau6z
 TdVfhWPUjTt/K+tAHVvCXj1m5/NBg+vrqrCTPm6s=
Subject: Re: [PATCH v2 0/2] target/mips: Add two groups of loongson-ext
 instructions
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200616073359.2999656-1-jiaxun.yang@flygoat.com>
 <CAHiYmc6QEU4zk=0Xa6_gs1JEV+1mGNp3oNYQ6rZoxeLF5cABBw@mail.gmail.com>
 <46907c6f-6c0f-5918-0885-a60b0114e1d1@flygoat.com>
 <CAHiYmc6CYez1Ur2atyFa66HvbHSpiDLGa-emJ8CUK=hV0kpqXQ@mail.gmail.com>
 <519e6f85-4484-fb6c-67e4-a92c99aa7093@flygoat.com>
 <CAHiYmc41rQVuv2i2r0Qgin2emtVOBi15-kx4sHjw4H5EbDeaJA@mail.gmail.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <ec27e816-0ee9-7f5e-40cc-a4a9e06c1f2a@flygoat.com>
Date: Thu, 18 Jun 2020 21:04:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc41rQVuv2i2r0Qgin2emtVOBi15-kx4sHjw4H5EbDeaJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1244941A63
X-Spamd-Result: default: False [1.40 / 10.00]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 R_SPF_SOFTFAIL(0.00)[~all:c];
 ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_NO_TLS_LAST(0.10)[];
 RECEIVED_SPAMHAUS_PBL(0.00)[1.165.3.60:received];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(0.00)[flygoat.com:s=default]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=217.182.66.161;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay3.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 09:06:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "chenhc@lemote.com" <chenhc@lemote.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/6/18 20:00, Aleksandar Markovic 写道:
> 
> 
> среда, 17. јун 2020., Jiaxun Yang <jiaxun.yang@flygoat.com 
> <mailto:jiaxun.yang@flygoat.com>> је написао/ла:
> 
> 
> 
>     在 2020/6/16 22:41, Aleksandar Markovic 写道:
> 
> 
> 
>         уторак, 16. јун 2020., Jiaxun Yang <jiaxun.yang@flygoat.com
>         <mailto:jiaxun.yang@flygoat.com> <mailto:jiaxun.yang@flygoat.com
>         <mailto:jiaxun.yang@flygoat.com>>> је написао/ла:
> 
> 
> 
>              在 2020/6/16 18:38, Aleksandar Markovic 写道:
> 
> 
> 
>                  уторак, 16. јун 2020., Jiaxun Yang
>         <jiaxun.yang@flygoat.com <mailto:jiaxun.yang@flygoat.com>
>                  <mailto:jiaxun.yang@flygoat.com
>         <mailto:jiaxun.yang@flygoat.com>>
>         <mailto:jiaxun.yang@flygoat.com <mailto:jiaxun.yang@flygoat.com>
>                  <mailto:jiaxun.yang@flygoat.com
>         <mailto:jiaxun.yang@flygoat.com>>>> је написао/ла:
> 
>                       This is the sucessor of:
>                       "Basic TCG Loongson-3A1000 Support"
> 
>                       Thanks!
> 
> 
>                  Hi, Jiaxun.
> 
>                  Thanks for providing updated version of the series.
> 
>                  I wonder, given so many "#if defined(TARGET_MIPS64)"
>         lines in
>                  this series, what would be the 32-bit processors that
>         support
>                  Loongson EXT ASE?
> 
> 
>              Loongson GS232 core which can be found in Loongson-1A/B/C
>         should
>              support it.
>              Although I have no intension to work on QEMU support of these
>              processors.
> 
> 
>         ...And, for the sake of accuracy, you nevertheless included the
>         correct implementation (for both 32-bir and 64-bit). That is
>         very good. I would do the same, if I were you.
> 
>         However, there is a problem. We can't upstream (at least not in
>         QEMU for MIPS) anything without the proper documentation.
> 
>         So, please provide the links or attach the supporting files to
>         the cover letter in v2. You already did something similar in
>         some of your previous series and patches. I am perfectly fine
>         with machine translation from Chinese.
> 
>         For example, you need to provide, among other things, docs
>         describing EXT support in GS 232 cores. We can't just make
>         assumptions, or trust your word. These sources of information
>         should be repeated for all versions (v2, v3,...) of the series,
>         in their cover letters.
> 
> 
>     I'll attach necessary information about these instructions in next
>     version, however, there is no public document avilable for GS232 core.
>     That's why I'm not intend to upstream it for now.
> 
>     Should I keep these code as is? Ot just filter all Loongson EXT out
>     for MIPS32.
> 
> 
> Sorry for late response, Jiaxun, I got carried away with other things.
> 
> I am not sure, I simply don't have access to the appropriate info. at 
> this moment, I'd say you can keep (for now) the "ifdef"-ed code for 
> handling 32-bit, since it will never be actually used.
> 
> But, how do you know the code is correct, if there is no doc? How do you 
> know about specifics of 32-bit ext? Is it just guessing, or more than 
> that? Mention the source of information in commit messages, if any. Or  > say this is just a guess.

By guess and experiments on real hardware....

> 
> A short comment should be added about handling for 32-bit just before 
> the main functions that handle Loongson EXT, just like Richard did for 
> those instructions from LMMI that he could not find proper documentation.

Will do.

> 
> Also, can you mention what is achieved by having EXT in QEMU? What 
> Longson-related scenarion would work, that previously (currently) would not?
>

As most applications targeting Loongson processor including Kernel are 
compiled -march=loongson3a CFLAG, without supoorting these instructions 
these applications can never run properly.

I'll mention them in next version of cover letter. Probably tomorrow.

> Thanks for this nice series, and all valuable efforts, hopefully we will 
> resolve documentation issue in comming days or weeks.

Thanks, and wish you all health!

> 
> Aleksandar
> 
> 
> 
>     Thanks.
> 
> 
>         I salute your series, but it needs much more justification.
> 
>         Yours,
>         Aleksandar
> 
> 
>                  Thanks,
>                  Aleksandar
> 
>                       Jiaxun Yang (2):
>                          target/mips: Add loongson-ext lsdc2 group of
>         instructions
>                          target/mips: Add loongson-ext lswc2 group of
>         instrustions
> 
> 
>                  Also, a spelling mistake in the second title.
> 
> 
>              Ahh, My bad....
> 
> 
>                         target/mips/translate.c | 437
>                  ++++++++++++++++++++++++++++++++++++++++
>                         1 file changed, 437 insertions(+)
> 
>                       --     2.27.0.rc2
> 
> 
>              --     - Jiaxun
> 
> 
>     -- 
>     - Jiaxun
> 

-- 
- Jiaxun

