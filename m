Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D4C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEA822253
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="MG1WgxnB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ffJGPfQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEA822253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQiXY-0004HH-TP
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 22:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kQiWL-0003qZ-PD
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 22:52:37 -0400
Received: from relay3.mymailcheap.com ([217.182.119.157]:51139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kQiWI-000071-Tv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 22:52:37 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id 1EE183F1CC;
 Fri,  9 Oct 2020 04:52:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 5AD7A2A179;
 Thu,  8 Oct 2020 22:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1602211949;
 bh=FiWI9x1THMiqZEefT8HVHjGwtHQq53HMKEpYp76Eu1w=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=MG1WgxnBHjy7kh359oTgVtknDnecjVElx1nyVug4vgyZodUXWEt7akU+xo79J9MQJ
 5MxYYaUFyk11ftrNrOYZ1DzctewJVqFjENtjChJ2n5rLL5C2O9TBLAhzPaD+fzrYqu
 Lc1OfUTeM1nNzt9Pf6o1NgGQ++dy6srLZBCci6nM=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ZbTfuVlxBtc; Thu,  8 Oct 2020 22:52:28 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Thu,  8 Oct 2020 22:52:28 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 2820D40EAD;
 Fri,  9 Oct 2020 02:52:26 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="ffJGPfQC"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [146.196.55.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id DD1BA40FEC;
 Fri,  9 Oct 2020 02:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1602211942;
 bh=FiWI9x1THMiqZEefT8HVHjGwtHQq53HMKEpYp76Eu1w=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ffJGPfQCMVMOWKdYlrYfBF7YW5yAV202DDmQ+pqY7GQai60iqQlvakICttGujwqDw
 +sd2ucxZS5riVYDi4Nn7SRCNnnCFmdZkjtjQKRWV8Er7ipGQhFhVHLudbKOye9kPmE
 asorzm6MOs5zyldDRFJW+oIJu+WdZRoJ1xaE2ZEI=
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Remove myself
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 chen huacai <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1602103041-32017-6-git-send-email-aleksandar.qemu.devel@gmail.com>
 <CABDp7VppBsH74X8rvFzYEdQ_nM7dxYndd1SSKqTpZGDNA2w86A@mail.gmail.com>
 <5a69fc78-2c9e-f8a4-7503-888e40e39bc7@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <e5d3b97a-aea2-d4a0-8760-dbbeee9ddddf@flygoat.com>
Date: Fri, 9 Oct 2020 10:52:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <5a69fc78-2c9e-f8a4-7503-888e40e39bc7@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2820D40EAD
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCPT_COUNT_SEVEN(0.00)[9];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[amsat.org,gmail.com];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=217.182.119.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay3.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 22:52:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 qemu-level <qemu-devel@nongnu.org>, hpoussin@reactos.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/10/8 18:21, Philippe Mathieu-Daudé 写道:
> On 10/8/20 9:21 AM, chen huacai wrote:
>> Hi, Aleksandar,
>>
>> On Thu, Oct 8, 2020 at 4:40 AM Aleksandar Markovic
>> <aleksandar.qemu.devel@gmail.com> wrote:
>>> I have been working on project other than QEMU for some time, and would
>>> like to devote myself to that project. It is imposible for me to find
>>> enough time to perform maintainer's duties with needed meticulousness
>>> and patience.
> Thanks Aleksandar for your contributions and keeping MIPS in good
> shape during 2 years!
>
>>> I wish prosperous future to QEMU and all colegues in QEMU community.
>> I'm very sorry to hear that. I hope you can be still here if possible...
>> I found that there are many reviewers, so, if it is a must that
>> Aleksandar will leave us, can these reviewers be maintainers?
> Thanks for volunteering! Aleksandar Rikalo hasn't sent anything
> to the list since 4 months. Is Jiaxun Yang also volunteering?

Hi all,

Thanks for the inviation.
I'm busy with real world recently (probably until Dec) so I can't 
promise anything.

But I can start with helping reviewing blocking patches.

- Jiaxun

> Regards,
>
> Phil.
>

