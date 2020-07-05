Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CDCC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E840B20723
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="TNu4Atjb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="JkXqUURw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E840B20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5aO-0005Is-1S
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1js5Zm-0004u1-Vr
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:25:03 -0400
Received: from relay4.mymailcheap.com ([137.74.80.154]:33188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1js5Zk-0004Y9-2T
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:25:02 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay4.mymailcheap.com (Postfix) with ESMTPS id AD8DD3F1CF;
 Sun,  5 Jul 2020 16:24:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id D678B2A351;
 Sun,  5 Jul 2020 10:24:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1593959094;
 bh=NWbD0Gy155hB34exXo7mo/yU1hrNM3MfhQVLEctF24I=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=TNu4AtjbEPFdviWVBN+LBi5sdtag1YIDYdAJ/TpOQKsMOGH7Qx+wEeN/bwGlk5NYz
 ci67pPj4CgG6FC1yHBabIcQu7YrpmoU0+b1t99CkAWe6WHfsThmqNqDtJpfVKl6uCJ
 hROUXWtbpVi9MAr6PnFvt062REGnXFbdmXUtgm0E=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fz4fDH6Gv0f8; Sun,  5 Jul 2020 10:24:53 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Sun,  5 Jul 2020 10:24:53 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id C907441B3D;
 Sun,  5 Jul 2020 14:24:51 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="JkXqUURw"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (ec2-18-163-238-147.ap-east-1.compute.amazonaws.com
 [18.163.238.147])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id A340541B3D;
 Sun,  5 Jul 2020 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1593959069;
 bh=NWbD0Gy155hB34exXo7mo/yU1hrNM3MfhQVLEctF24I=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JkXqUURwS/y5MkMEaMMn+ENy+CypVUn27lYLnxRdOsqAKhRzOThk3O8p03jKW5JNk
 CZZgQqfjclC2Wr/ti6jdoxpsVhvmYbd8wjhBh41oG7q8QjIkG4Fccs9XLwx/5c6o5i
 3O4VMjPpZwh4Vijss4Fz11wp5d3DTlWRe5wH72gQ=
Subject: Re: [PATCH v2 1/1] disas: mips: Add Loongson 2F disassembler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Stefan Brankovic <stefanbrankovic96@gmail.com>, qemu-devel@nongnu.org
References: <20200703104409.6986-1-stefan.brankovic@syrmia.com>
 <20200703104409.6986-2-stefan.brankovic@syrmia.com>
 <93277e29-001d-824e-5b5e-93a928290a30@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <3482781c-d255-7cf1-72ce-9e7b0e2217b1@flygoat.com>
Date: Sun, 5 Jul 2020 22:24:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <93277e29-001d-824e-5b5e-93a928290a30@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C907441B3D
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(0.00)[~all];
 ML_SERVERS(-3.10)[213.133.102.83];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCPT_COUNT_SEVEN(0.00)[8];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[amsat.org,gmail.com,nongnu.org];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(0.00)[flygoat.com:s=default]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
 FREEMAIL_CC(0.00)[redhat.com,syrmia.com,gmail.com,lemote.com];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=137.74.80.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay4.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:24:56
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
Cc: chenhc@lemote.com, thuth@redhat.com, stefan.brankovic@syrmia.com,
 aleksandar.rikalo@syrmia.com, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/7/5 4:04, Philippe Mathieu-Daudé 写道:
> Hi Stefan,
>
> On 7/3/20 12:44 PM, Stefan Brankovic wrote:
>> Add disassembler for Loongson 2F instruction set.
>>
>> Testing is done by comparing qemu disassembly output, obtained by
>> using -d in_asm command line option, with appropriate objdump output.
>>
>> This disassembler is written as a generic disassembler that can be
>> integrated into other projects. In this case, it is integrated into
>> QEMU. One of initial key requirements was that it uses C++ as its
>> language.
> Wow, this is a huge contribution!
>
> QEMU uses the libcapstone as backend to disassemble some architectures.
> I see the project [1] do support MIPS [2], but they don't support
> neither nanoMIPS nor the Loongson 2F instruction set. As the library is
> used by other projects, it might be worthwhile have a look if your
> disassembler could fit there instead.
> Don't take this as a negative comment please, this is the opposite:
> more users would be able to use your work.
> My comment doesn't say neither that I am against your proposal. I
> wanted to be sure you are aware of the capstone engine project.

Capstone relies on an ancient version of LLVM MC, however, Loongson 
instructions
never got upstreamed in LLVM.

But... Yeah, upstream capstone looks like a better idea for the future.
> I cc'ed Jiaxun Yang who has more experience with the Loongson 2F ISA
> and might be able to test your patch.

Thanks, will do some review and test later.

>
> Regards,
>
> Phil.
>
> [1] http://www.capstone-engine.org/
> [2] http://www.capstone-engine.org/arch.html
>
>> Signed-off-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
>> ---
>>   MAINTAINERS             |    1 +
>>   configure               |    1 +
>>   disas/Makefile.objs     |    1 +
>>   disas/loongson2f.cpp    | 8154 +++++++++++++++++++++++++++++++++++++++
>>   disas/loongson2f.h      | 2562 ++++++++++++
>>   include/disas/dis-asm.h |    1 +
>>   include/exec/poison.h   |    1 +
>>   target/mips/cpu.c       |    4 +
>>   8 files changed, 10725 insertions(+)
>>   create mode 100644 disas/loongson2f.cpp
>>   create mode 100644 disas/loongson2f.h

