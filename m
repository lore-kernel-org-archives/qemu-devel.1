Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04971C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B8C20771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="elzuZAOW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="elxEpcqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B8C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Axf-0004zf-2Q
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6Ax3-0004aP-Fu
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:59:17 -0400
Received: from relay2.mymailcheap.com ([217.182.113.132]:42961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6Ax0-0001M6-DS
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:59:16 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay2.mymailcheap.com (Postfix) with ESMTPS id 7D4613EDEC;
 Thu, 13 Aug 2020 12:59:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 5FD3E2A51F;
 Thu, 13 Aug 2020 12:59:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1597316351;
 bh=8VUjeQQn3cjEp6znsX4Za57R9MW/6boSVRk6IkBIpIA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=elzuZAOWWgiaeIn/NqSwh9BQ74D6tj1JuxoF3QjTuO2p2vkcdwfWx8/2RHVdWS92v
 cNeBgeS468OtEVXwiiUuq3J83iF9geyLgO3QpUe4+ZDXmipiP6br5Ie5n/5ADv5BVV
 Mp17IHbZc+HiB00AvvzhIQQCgxnzyeTyApIJ2k0w=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hIJ9mSTLD9GN; Thu, 13 Aug 2020 12:59:09 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS;
 Thu, 13 Aug 2020 12:59:09 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id E6D8C41184;
 Thu, 13 Aug 2020 10:59:08 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="elxEpcqr"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [103.195.6.80])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id AFB5841184;
 Thu, 13 Aug 2020 10:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1597316342;
 bh=8VUjeQQn3cjEp6znsX4Za57R9MW/6boSVRk6IkBIpIA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=elxEpcqr4SZ8X0Rs0ij1dddKje/OmYx3rU8hq5z/w/CkkZsO9b6YMaet0N7T0WDDl
 qUfFMfKlNeRRNoPx3Z93LuxEh0ZQ24hl26tDozlrmGu9xoXuGYheKCtb8hLXCsVTX2
 Ma+k3KP2/N6ODqdQBJrHGNT9Xkhp1/USmS4epbHA=
Subject: Re: [PATCH-for-5.2] target/mips: Report unimplemented cache()
 operations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200806122612.17167-1-f4bug@amsat.org>
 <e55da0ff-e88c-f2f4-0430-32255f7e58fe@flygoat.com>
 <ec0ff553-a5e7-6c93-5ab3-093721b044a6@amsat.org>
 <CAFEAcA8iXXW=eD+w-UdPqdjtbfc45Qu+DyfZBmaVe0TgMt_jmg@mail.gmail.com>
 <a620f323-e42a-e75e-0491-228c480fa55b@amsat.org>
 <6cecb59e-3a78-907c-cf63-225b4efbca01@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <f092c34a-9b13-3263-5bcc-811ffef6d36e@flygoat.com>
Date: Thu, 13 Aug 2020 18:58:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6cecb59e-3a78-907c-cf63-225b4efbca01@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Rspamd-Queue-Id: E6D8C41184
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 ML_SERVERS(-3.10)[148.251.23.173]; TO_DN_ALL(0.00)[];
 DKIM_TRACE(0.00)[flygoat.com:+]; RCPT_COUNT_SEVEN(0.00)[7];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 FREEMAIL_CC(0.00)[linaro.org,lemote.com,syrmia.com,nongnu.org,aurel32.net,gmail.com];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=217.182.113.132;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay2.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:59:11
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/8/11 上午1:21, Philippe Mathieu-Daudé 写道:
> On 8/6/20 11:37 PM, Philippe Mathieu-Daudé wrote:
>> On 8/6/20 10:51 PM, Peter Maydell wrote:
>>> On Thu, 6 Aug 2020 at 21:31, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> On 8/6/20 8:01 PM, Jiaxun Yang wrote:
>>>>> 在 2020/8/6 下午8:26, Philippe Mathieu-Daudé 写道:
>>>>>> We only implement the Index[Store/Load]Tag from the 'cache' opcode.
>>>>>> Instead of ignoring the other cache operations, report them as
>>>>>> unimplemented.
[...]
>> On a r10k core it is listed as 'Hit Writeback Invalidate (D)' but here
>> this is a 4kEc. The address used is a SRAM shared with a embedded DSP
>> on the same SoC. From a RevEng PoV it is helpful to see there is a such
>> cache access, as I can separate better the peripheral involved.
>> I'm happy using a trace event instead.
>>
>> Jiaxun, can you list me the list of opcodes QEMU can safely ignore from
>> the TCG emulation PoV? That way we can comment them in the code such:
Hi Phil,

I believe we have nothing to do with all VA Hit based invalidate, 
writeback, fetch and lock,
According to MD00086-2B-MIPS32BIS-AFP, the Code (Bit[20:18]) should be
0b100 (Hit Inavlidate), 0b101(Hit Fill), 0b110 (Hit FB), 0b111 (Fetch 
and Lock).

I'm unsure about what applications expected from Index based ops, so 
we'd better keep a
log for them. What I can say is Linux rarely use Index based ops.

Thanks.

- Jiaxun

