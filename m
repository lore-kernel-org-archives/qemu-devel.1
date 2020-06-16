Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C73C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 11:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAD1207DD
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 11:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="QsIhnY1r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="EsRokgFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAD1207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl9uR-0000ME-4Z
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 07:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jl9tc-00088Q-GA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 07:36:52 -0400
Received: from relay2.mymailcheap.com ([151.80.165.199]:38986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jl9ta-0004Fo-Aw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 07:36:52 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay2.mymailcheap.com (Postfix) with ESMTPS id 144213E94C;
 Tue, 16 Jun 2020 13:36:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 423AB2A3B1;
 Tue, 16 Jun 2020 07:36:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1592307405;
 bh=OQt+1WNKwBfKE4iSWGidfAkOK5XQFBrHRjKpgMjVWYI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QsIhnY1rLEmOy4enCq1W3QXwNJ70sT0pI4zpvCC2C9xNMLydj30oUi7Q8akWnYcka
 QmkLiUwl67uOaNT5t6k3+aYAKiKyHSfF3+LLQHvu5DiiAuFAmb1pdjH8uznrAKPpmr
 QQyaumbCQ5NRYnHNW2f7le3+v2P4A25CPbbePMXg=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZbcitS_6_S3T; Tue, 16 Jun 2020 07:36:44 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Tue, 16 Jun 2020 07:36:43 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 2BEC8403EF;
 Tue, 16 Jun 2020 11:36:42 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="EsRokgFq"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [192.227.170.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9843D403D9;
 Tue, 16 Jun 2020 11:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1592307375;
 bh=OQt+1WNKwBfKE4iSWGidfAkOK5XQFBrHRjKpgMjVWYI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=EsRokgFqdZIXHC3bvrMMXlB4kVHuRBY4JBIILZAeczcGm+bIT38E52M8E5RLCtedo
 EveG38RsfeWcgWhZIZLBlG4eCzxwTUh3/k3RSV7rhEhjDY9CVU6982RZ/ZcsiFgF0J
 c7hObKwejVoeRuDrVxcp0WH4e1Z4xg69UOZV6Lgc=
Subject: Re: [PATCH v2 0/2] target/mips: Add two groups of loongson-ext
 instructions
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200616073359.2999656-1-jiaxun.yang@flygoat.com>
 <CAHiYmc6QEU4zk=0Xa6_gs1JEV+1mGNp3oNYQ6rZoxeLF5cABBw@mail.gmail.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <46907c6f-6c0f-5918-0885-a60b0114e1d1@flygoat.com>
Date: Tue, 16 Jun 2020 19:36:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6QEU4zk=0Xa6_gs1JEV+1mGNp3oNYQ6rZoxeLF5cABBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2BEC8403EF
X-Spamd-Result: default: False [1.40 / 10.00]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 R_SPF_SOFTFAIL(0.00)[~all]; ML_SERVERS(-3.10)[213.133.102.83];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(0.00)[flygoat.com:s=default]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=151.80.165.199;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay2.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 07:36:46
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
Cc: "chenhc@lemote.com" <chenhc@lemote.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/6/16 18:38, Aleksandar Markovic 写道:
> 
> 
> уторак, 16. јун 2020., Jiaxun Yang <jiaxun.yang@flygoat.com 
> <mailto:jiaxun.yang@flygoat.com>> је написао/ла:
> 
>     This is the sucessor of:
>     "Basic TCG Loongson-3A1000 Support"
> 
>     Thanks!
> 
> 
> Hi, Jiaxun.
> 
> Thanks for providing updated version of the series.
> 
> I wonder, given so many "#if defined(TARGET_MIPS64)" lines in this 
> series, what would be the 32-bit processors that support Loongson EXT ASE?

Loongson GS232 core which can be found in Loongson-1A/B/C should support it.
Although I have no intension to work on QEMU support of these processors.

> 
> Thanks,
> Aleksandar
> 
>     Jiaxun Yang (2):
>        target/mips: Add loongson-ext lsdc2 group of instructions
>        target/mips: Add loongson-ext lswc2 group of instrustions
> 
> 
> Also, a spelling mistake in the second title.

Ahh, My bad....

> 
>       target/mips/translate.c | 437 ++++++++++++++++++++++++++++++++++++++++
>       1 file changed, 437 insertions(+)
> 
>     -- 
>     2.27.0.rc2
> 

-- 
- Jiaxun

