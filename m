Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEDAC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547012078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="biRAhNlt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="jgeDUPmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547012078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6F6B-00013L-Jv
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 11:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6F5b-0000eA-6o
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:24:23 -0400
Received: from relay1.mymailcheap.com ([144.217.248.100]:50465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k6F5Y-0001CW-Fm
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:24:22 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 19E523F202;
 Thu, 13 Aug 2020 11:24:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 4EFAD2A51F;
 Thu, 13 Aug 2020 17:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1597332257;
 bh=LlZQR1dnOXnh4K3vcweMvUR269SQSOlbXf7u+XiU6vc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=biRAhNltqZbumYr21Ml/geucxmGchTL9inXie6c2/Lpj5F8kL470h4G1bQMssNl8l
 TshZ+a9TH2Uk1CpDnebqpdNQ55XrI6XyBGahuWZRYwdCc6EaH7ceY1OoALRMGlZsAi
 ahICiY2V6aWBnGDAIdgay3UFu2tItPbNnPndRfbY=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MQl3z4qwlKDq; Thu, 13 Aug 2020 17:24:14 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS;
 Thu, 13 Aug 2020 17:24:14 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 0AFEF4118C;
 Thu, 13 Aug 2020 15:24:11 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="jgeDUPmS"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [103.195.6.80])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id E393A4118D;
 Thu, 13 Aug 2020 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1597332224;
 bh=LlZQR1dnOXnh4K3vcweMvUR269SQSOlbXf7u+XiU6vc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jgeDUPmSVCfYe8Y02ebIoB24rODStU4iIhtEesEL/PiNCS8wICiVaJ0uJRfjJgS05
 ixdwjMM4sowsYinbE9W0uK43Ia8OtUVgcpTPlm4ixCC1o6zIQpmywnpf4p9/8jQl2J
 W1cOJsGx2wWclZGyHKf2rZ3K9gqcG2U4hACPTr4c=
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
Message-ID: <39ad849e-c1fb-5031-7a30-f920bcee4cbe@flygoat.com>
Date: Thu, 13 Aug 2020 23:23:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6cecb59e-3a78-907c-cf63-225b4efbca01@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Rspamd-Queue-Id: 0AFEF4118C
X-Spamd-Result: default: False [-0.10 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 ML_SERVERS(-3.10)[213.133.102.83]; TO_DN_ALL(0.00)[];
 DKIM_TRACE(0.00)[flygoat.com:+];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 FREEMAIL_CC(0.00)[nongnu.org,gmail.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=144.217.248.100;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 11:24:18
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
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
>>>>> Hmm, I don't think we have anything to do with Invalidate/Writeback etc.
>>>>> opcodes
>>>>> in QEMU. Why do we log this?
>>>> I'm noticed this code is run on Linux 3.3.8 (4KEc):
>>>>
>>>>      8880:       3082000f        andi    v0,a0,0xf
>>>>      8884:       10800008        beqz    a0,88a8
>>>>      8888:       00a21021        addu    v0,a1,v0
>>>>      888c:       08002227        j       889c
>>>>      8890:       00001821        move    v1,zero
>>>>      8894:       bcf90000        cache   0x19,0(a3)
>>>>      8898:       24630010        addiu   v1,v1,16
>>>>      889c:       0062302b        sltu    a2,v1,v0
>>>>      88a0:       14c0fffc        bnez    a2,8894
>>>>      88a4:       00833821        addu    a3,a0,v1
>>>>      88a8:       03e00008        jr      ra
>>>>      88ac:       00000000        nop
>>>>
>>>> Why silently ignore the opcode is not implemented instead of logging it?
>>> I think the question is whether the opcode is supposed to have
>>> some behaviour which we're not implementing, or whether "no-op"
>>> is the correct behaviour for it (which it usually is for
>>> cache invalidate type operations; compare the way the Arm
>>> cache ops like IC_IALLU are just ARM_CP_NOP ops).
>> OK now I understand better, thanks.
>>
>> I haven't found useful information about this 0x19=25 opcode value.
> Just to close this thread, some findings from last WE:
>
> - I couldn't find where Linux 3.3.8 use that op
> - I eventually figured out it comes from a kernel module called 'tiatm'.
> - This kmod is released by OpenWRT in packages named kmod-sangam-atm-annex
> - Googling for strings from the object, this file has been added in [1]
> based on the file included in [2]
> - Someone imported these files in a git repo and published
> - There is a commented reference [4] as:
>
> #define        DataCacheHitInvalidate(a)     {__asm__(" cache  17, (%0)"
> :   : "r" (a));}
> #define        DataCacheHitWriteback(a)      {__asm__(" cache  25, (%0)"
> :   : "r" (a));}
>
> - Also referenced (not commented) in [5] "Linux atm module implementation".
>
> For my use I'm happy using a trace event:
>
> -- >8 --

FYI, I took a look at MIPS M14K (interAptiv) RTL from MIPSOpen project,
HitInvalidate and HitWriteback cache Ops to L2/L3 Cache will also act
on L1 Cache. So probably that's kinda... Undocumented trick...

Thanks.

- Jiaxun

