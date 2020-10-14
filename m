Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7079C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D014720723
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="hsQSMBob";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="T6rMlNc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D014720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSdvg-00048D-P8
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 06:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kSduM-0003Nk-Id
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:21:22 -0400
Received: from relay1.mymailcheap.com ([144.217.248.100]:46956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kSduH-0005np-55
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:21:22 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 7987A3F1C5;
 Wed, 14 Oct 2020 10:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id BA2DA2A7D7;
 Wed, 14 Oct 2020 12:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1602670871;
 bh=UeaN1nzl6zUGv/G7CSDK+RLxzRYtapQFLLrqETJ/xoE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hsQSMBob/iQwnpcs47wKyguNf2aQ4nhnsM60Dsme344BC3rv08W3qmkSa02YMl+7r
 DSmRxDDsY+avPhZrgKXL+uP3uyT8Wq3jodafwVqnASJghzo7cRpMdT4m6y7yRKTMDc
 r6cChJ/M2qaIgI+97rXmRXHYxpJEFX7/1Sj8P2dI=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NXz4w9A3-RsA; Wed, 14 Oct 2020 12:21:08 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS;
 Wed, 14 Oct 2020 12:21:08 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 9150E41C2B;
 Wed, 14 Oct 2020 10:21:07 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="T6rMlNc6"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [146.196.55.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 04B0E41C28;
 Wed, 14 Oct 2020 10:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1602670857;
 bh=UeaN1nzl6zUGv/G7CSDK+RLxzRYtapQFLLrqETJ/xoE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=T6rMlNc6E/nfys38hgKrkoczpyRBclKupNdlB53CrtopR/qD3m24rneE/uf6wwYaq
 mBNJ8ohN5N67eg/fHuxqkD6odWSCT8K2ER7FLLaj9CWr16RrQncuwrEulgAbvgopVh
 0dS8CpYF0YkxuSGD6LmrHp8GvG6dDlQ7zx0ESzQ4=
Subject: Re: [RFC PATCH 3/3] target/mips: Make the number of TLB entries a CPU
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Victor Kamensky <kamensky@cisco.com>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <20201013132535.3599453-4-f4bug@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <39e98c46-d22d-621e-c559-a6e31c5aad6c@flygoat.com>
Date: Wed, 14 Oct 2020 18:20:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201013132535.3599453-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9150E41C2B
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCPT_COUNT_SEVEN(0.00)[9];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 FREEMAIL_CC(0.00)[gmail.com,twiddle.net,syrmia.com,aurel32.net,linuxfoundation.org];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=144.217.248.100;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 06:21:12
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/10/13 21:25, Philippe Mathieu-Daudé 写道:
> Allow changing the number of TLB entries for
> testing/tunning purpose.
>
> Example to force a 34Kf cpu with 64 TLB:
>
>    $ qemu-system-mipsel -cpu 34Kf,tlb-entries=64 ...
>
> This is helpful for developers of the Yocto Project [*]:
>
>    Yocto Project uses qemu-system-mips 34Kf cpu model, to run 32bit
>    MIPS CI loop. It was observed that in this case CI test execution
>    time was almost twice longer than 64bit MIPS variant that runs
>    under MIPS64R2-generic model. It was investigated and concluded
>    that the difference in number of TLBs 16 in 34Kf case vs 64 in
>    MIPS64R2-generic is responsible for most of CI real time execution
>    difference. Because with 16 TLBs linux user-land trashes TLB more
>    and it needs to execute more instructions in TLB refill handler
>    calls, as result it runs much longer.
>
> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html
>
> Buglink: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992
> Reported-by: Victor Kamensky <kamensky@cisco.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
Hi Philippe,

I think name can this property vtlb-entries?

MIPS R2 had introduced dual-TLB feature and the entries specified here
is the number of VTLB, while FTLB is another set of entries with fixed 
pagesize.

Although MIPS TCG haven't implemented dual-TLB but it can prevent future
confusion.

Thanks.

- Jiaxun

