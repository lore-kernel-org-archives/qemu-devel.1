Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB0AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FA220768
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="sl10MkYa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="WGdvP5DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FA220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Pmj-0000Sn-AT
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 22:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6Pm3-0008Gc-Ih
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 22:48:55 -0400
Received: from relay1.mymailcheap.com ([144.217.248.102]:39247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6Pm1-0006fl-W5
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 22:48:55 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 4081D3F1C5;
 Thu, 13 Aug 2020 22:48:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 84D4C2A905;
 Fri, 14 Aug 2020 04:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1597373332;
 bh=0HpiYhq13dNmLirOCmor6J+3rL1Hnxcogfb2/MMcDic=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=sl10MkYao2uk0w1TgZ52iLAZ/wX+1TUw1VG4no/NWIHpUT6yw2kWo9iQHyVbDf9bb
 BD+1Je5uwjSAu/WipmB3sagWjYR3yHrndu3/Je2FcltYaO9YxL/ytIG3l6eBW+Buxl
 jn1zbZiGUxNwYc1SiSIk+uQAAUPZllgFzgv20S7s=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZs9TaBfXrAq; Fri, 14 Aug 2020 04:48:51 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS;
 Fri, 14 Aug 2020 04:48:51 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 0253540855;
 Fri, 14 Aug 2020 02:48:50 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="WGdvP5DR"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [103.195.6.80])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9BCCC40855;
 Fri, 14 Aug 2020 02:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1597373325;
 bh=0HpiYhq13dNmLirOCmor6J+3rL1Hnxcogfb2/MMcDic=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=WGdvP5DR1tzRCueTZp/Re57PUbBQg6YvV6jISXOTBz16nKNvONLX1l7RsKjqsUS03
 CAKeC3AC8pDinXdow7QXh8jm4gnCayrHJpXKi+AoQ2OGALA12YMoEolBMA6W4svW7J
 X9Zbu1vPXgeGtRyoPkVmBFRDAQyH0t8qKFFHpBok=
Subject: Re: [PATCH 2/2] target/mips: Add definition of Loongson-3A3000 CPU
To: Kaige Li <likaige@loongson.cn>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <1597311707-27565-1-git-send-email-likaige@loongson.cn>
 <1597311707-27565-2-git-send-email-likaige@loongson.cn>
 <7772e88a-1f48-29ef-0004-e6eaa4eb5b60@flygoat.com>
 <6c22034f-6bae-22f8-be52-74e00438c3b3@loongson.cn>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <5ccb1a7e-f56e-0d0e-ee40-3bff1b1ad4c6@flygoat.com>
Date: Fri, 14 Aug 2020 10:48:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6c22034f-6bae-22f8-be52-74e00438c3b3@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Rspamd-Queue-Id: 0253540855
X-Spamd-Result: default: False [1.40 / 10.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all:c];
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/8/14 上午10:43, Kaige Li 写道:
> On 08/13/2020 06:37 PM, Jiaxun Yang wrote:
>
>>
>>
>> 在 2020/8/13 下午5:41, Kaige Li 写道:
>>> Add definition of the Loongson-3A3000 processor in QEMU.
>>
>> Hi Kaige,
>>
>> We're not defining Loongson-3A3000 in QEMU because we have
>> some features like Loongson-EXT2, VTLB not available currently, I'd
>> prefer define it after we add these features to TCG.
>>
>> Loongson-3A4000's define is a exception to support KVM.
> Ok, I see. This will be defined later, right?
Yes..

If you're willing to help I'd suggest you to take a look at how to implement
Loongson SPW (LDPTE LDDIR etc) in QEMU.


Thanks.

- Jiaxun

>
> Thanks.
> Kaige.
>>
>> Thanks.
>>
>> - Jiaxun

