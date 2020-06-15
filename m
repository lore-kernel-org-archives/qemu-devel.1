Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D08C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5322D2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="coO/dolc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="FpXSwoEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5322D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklG2-0001eb-I5
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jklEz-0001BQ-8h
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:17:17 -0400
Received: from relay4.mymailcheap.com ([137.74.199.117]:56488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jklEv-000224-Vn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:17:16 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay4.mymailcheap.com (Postfix) with ESMTPS id 826823F1D0;
 Mon, 15 Jun 2020 11:17:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id B635A2A0C5;
 Mon, 15 Jun 2020 05:17:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1592212628;
 bh=CmFpA3stINX5ea2dfN1HO9PO0eI88h1bbYpEX0PaGf4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=coO/dolcNytiahoCbGoe7NDQ3ROD2IacVAZHngeg8+fgIn7mVuAY81d22RvRaoySR
 lpdj/xD2scsBabRWerr2psw4TljNvxSNfW430Ra5NNeVIcBVS6GTDLgIcOfBc5+sNP
 CEHNu2JrETBe9vZhwj8cmPEojampj0g0bFUz5fi4=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ga7_b2v7sEkE; Mon, 15 Jun 2020 05:17:07 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Mon, 15 Jun 2020 05:17:07 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 3489240EB2;
 Mon, 15 Jun 2020 09:17:04 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="FpXSwoEb"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (n219078103103.netvigator.com [219.78.103.103])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id AD82840EB2;
 Mon, 15 Jun 2020 09:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1592212615;
 bh=CmFpA3stINX5ea2dfN1HO9PO0eI88h1bbYpEX0PaGf4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=FpXSwoEbQPBrVsZYYMTCY4k+8Zxy87oMYYxtYPSh+duot0aP5Kppkgt6vJy90fd0C
 35qnJy180iKR1AyGaEFcVgdLOELMm8QJykoro5gXmVgYIqhR2r2VTN1376x2rSW1lS
 tjbi30nUZ+01ABzsZiAWmbp/dK32+aae9VUKvpgQ=
Subject: Re: [PATCH] target/mips: Fix PageMask with variable page size
To: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200614034729.3004-1-jiaxun.yang@flygoat.com>
 <CAHiYmc5haGPCxR4Nr-WmL_4PG48F+dqeJLzvVRHjcoBZKykr8Q@mail.gmail.com>
 <CAFEAcA_dBdns09k=kxpc=OqpYK3FJH=DZCx2+FgpqnKh_6Oxkg@mail.gmail.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <9a3f44fc-d279-c003-a8f6-0771e86cc3d0@flygoat.com>
Date: Mon, 15 Jun 2020 17:16:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_dBdns09k=kxpc=OqpYK3FJH=DZCx2+FgpqnKh_6Oxkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3489240EB2
X-Spamd-Result: default: False [1.40 / 10.00]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 R_SPF_SOFTFAIL(0.00)[~all]; RCPT_COUNT_FIVE(0.00)[5];
 ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[linaro.org,gmail.com];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=137.74.199.117;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay4.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 05:17:10
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
Cc: "aleksandar.rikalo@syrmia.com" <aleksandar.rikalo@syrmia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/6/15 17:13, Peter Maydell 写道:
> On Sun, 14 Jun 2020 at 22:52, Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
>> When you change machine.c the way you did it, you need to bump the version. Please see git log on machine.c for details.
> 
>>> --- a/target/mips/cpu.h
>>> +++ b/target/mips/cpu.h
>>> @@ -617,7 +617,8 @@ struct CPUMIPSState {
>>>   /*
>>>    * CP0 Register 5
>>>    */
>>> -    int32_t CP0_PageMask;
>>> +    target_ulong CP0_PageMask;
>>> +#define CP0PM_MASK 13
> 
> Does CP0_PageMask ever actually hold a value that won't fit
> in an int32_t? If not, it might be preferable to avoid changing
> its type to avoid the migration compat break, even if MIPS
> doesn't have any versioned boards where we have a strict
> don't-break-compat promise to users.

In Release2, PageMask was extended to 64bit on MIPS64 processors.

Is it necessary to follow that?

Thanks.

> 
> thanks
> -- PMM
> 

-- 
- Jiaxun

