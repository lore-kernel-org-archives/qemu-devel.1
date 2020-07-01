Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0236AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23EE2073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="dUBTq/q8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="NeSsyz6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23EE2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqRfm-0005me-24
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 21:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jqRfB-0005GA-LK; Tue, 30 Jun 2020 21:35:49 -0400
Received: from relay4.mymailcheap.com ([137.74.80.154]:54897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jqRf7-0007BE-Q3; Tue, 30 Jun 2020 21:35:48 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay4.mymailcheap.com (Postfix) with ESMTPS id B3E103F162;
 Wed,  1 Jul 2020 03:35:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 7FE072A4F0;
 Wed,  1 Jul 2020 03:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1593567340;
 bh=EsOtnPFIFUTfzXmgBgIiBrtab6Je6TZbFyzHIjsjksM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=dUBTq/q8mRre6fqHHvUqdOO2oQRoipfi0ws2gpJ9spO+Ov3x1RdSFCDNkcU15pZ8q
 FuxqwHKjGFsH8IXF3AyN3bj9f8jbgM7EuCeCwNIQ2o1ml/pE4BiTtRBijNiy7vX9sn
 Wu8wcMsLeS4c5RAQ1alyA9bbp2dOl/s+Q57V2NaM=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zOIMtpCif1h8; Wed,  1 Jul 2020 03:35:38 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS;
 Wed,  1 Jul 2020 03:35:38 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id B7F6040849;
 Wed,  1 Jul 2020 01:35:36 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="NeSsyz6b"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (ec2-18-163-238-147.ap-east-1.compute.amazonaws.com
 [18.163.238.147])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9BF4D40849;
 Wed,  1 Jul 2020 01:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1593567332;
 bh=EsOtnPFIFUTfzXmgBgIiBrtab6Je6TZbFyzHIjsjksM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=NeSsyz6bQXEkrWAx0uBdQQcvTyu2V6g1cwWbRJ7GXLvlk/V5DHupSO1cUuY4bBTHH
 JVgouenZlk2jOXF1hDZpUZo22IG5HHACNoRwN5Ut+6Vjm2Ql3uhAf1MQDsViGkGzqI
 23a/MBjvo7xGrJzTnIuX9qVUs0XmI1GlFfrT/jTM=
Subject: Re: [PATCH v3 0/5] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Yunqiang Su <ysu@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20200630195723.1359-1-f4bug@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <ae19b1ce-fee9-aec8-633a-88ba155608f8@flygoat.com>
Date: Wed, 1 Jul 2020 09:35:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630195723.1359-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B7F6040849
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
 RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 FREEMAIL_CC(0.00)[gmail.com,syrmia.com,vivier.eu,redhat.com,nongnu.org];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=137.74.80.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay4.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 21:35:41
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


在 2020/7/1 3:57, Philippe Mathieu-Daudé 写道:
> Hi,
>
> This series add a new 'malta-strict' machine, that aims to properly
> model the real hardware (which is not what the current 'malta'
> machine models).


Just putting my random words here as things had became really tense..

My orginal proposal was served to some occational case.

Yunqiang said sometimes he will run memory intensives task in QEMU, and 
found 2G memory limitation had became the bottle neck of these usage. At 
that time I was trying to learn how QEMU work, so I made that patch to 
convinient him. Also submited it to upstream as I think it can 
convinient others as well.

I was thinking the fundmental reason of QEMU's extistence is to make 
people's life easier. With QEMU, one can test OS/application without own 
actaul hardware or limited by unreasonable hardware design. That's why I 
was trying to upstream that change.

If we're looking for accurate hardware emulator, probably we should ask 
for RTL code from manufactures and run it in iverilog.

Anyway, as a hobbist, I'm really graceful to what have done by 
Alexsandar in maintaining QEMU/MIPS. The future of MIPS is really 
unclear due to commerical reasons. I just don't want to see MIPS being 
threw away by the community as soon as the business collapse.

Thanks


~Jiaxun


>
> Since v2:
> - Initialize missing malta_machine_types::class_size
> - Remove RFC patch that confuses Aleksandar
> - Added examples of 'malta-strict' use
>
> $ git backport-diff -u v2
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>
> 001/5:[----] [--] 'hw/mips/malta: Trivial code movement'
> 002/5:[----] [--] 'hw/mips/malta: Register the machine as a TypeInfo'
> 003/5:[0001] [FC] 'hw/mips/malta: Introduce MaltaMachineClass::max_ramsize'
> 004/5:[----] [--] 'hw/mips/malta: Introduce the 'malta-strict' machine'
> 005/5:[----] [--] 'hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes'
>
> Philippe Mathieu-Daudé (5):
>    hw/mips/malta: Trivial code movement
>    hw/mips/malta: Register the machine as a TypeInfo
>    hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>    hw/mips/malta: Introduce the 'malta-strict' machine
>    hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
>
>   hw/mips/malta.c | 105 +++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 91 insertions(+), 14 deletions(-)
>

