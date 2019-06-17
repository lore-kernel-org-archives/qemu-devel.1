Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26767C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22422084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22422084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqPs-0003CE-B7
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55934)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcq2B-0004wi-Of
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcq28-0006ds-SS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:42:46 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39620 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hcq27-0006QR-5s
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:42:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7A6381A20B2;
 Mon, 17 Jun 2019 13:42:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.132] (rtrkw870-lin.domain.local [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4DC731A1E67;
 Mon, 17 Jun 2019 13:42:32 +0200 (CEST)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1559816130-17113-8-git-send-email-stefan.brankovic@rt-rk.com>
 <93061f61-699f-821d-fda2-4fa287b4506b@linaro.org>
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <2629bf10-43ac-8633-b51c-d0bb7a4c1a78@rt-rk.com>
Date: Mon, 17 Jun 2019 13:42:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <93061f61-699f-821d-fda2-4fa287b4506b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: Re: [Qemu-devel] [PATCH 7/8] target/ppc: Optimize emulation of
 vclzh and vclzb instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6.6.19. 22:38, Richard Henderson wrote:
> On 6/6/19 5:15 AM, Stefan Brankovic wrote:
>> Optimize Altivec instruction vclzh (Vector Count Leading Zeros Halfword).
>> This instruction counts the number of leading zeros of each halfword element
>> in source register and places result in the appropriate halfword element of
>> destination register.
> For halfword, you're generating 32 operations.  A loop over the halfwords,
> similar to the word loop I suggested for the last patch, does not reduce this
> total, since one has to adjust the clz32 result.
>
> For byte, you're generating 64 operations.
>
> These expansions are so big that without host vector support it's probably best
> to leave them out-of-line.
>
> I can imagine a byte clz expansion like
>
> 	t0 = input >> 4;
> 	t1 = input << 4;
> 	cmp = input == 0 ? -1 : 0;
> 	input = cmp ? t1 : input;
> 	output = cmp & 4;
>
> 	t0 = input >> 6;
> 	t1 = input << 2;
> 	cmp = input == 0 ? -1 : 0;
> 	input = cmp ? t1 : input;
> 	t0 = cmp & 2;
> 	output += t0;
>
> 	t1 = input << 1;
> 	cmp = input >= 0 ? -1 : 0;
> 	output -= cmp;
>
> 	cmp = input == 0 ? -1 : 0;
> 	output -= cmp;
>
> which would expand to 20 x86_64 vector instructions.  A halfword expansion
> would require one more round and thus 25 instructions.

I based this patch on performance results and my measurements say that 
tcg implementation is still significantly superior to helper 
implementation, regardless of somewhat large number of instructions.

I can attach both performance measurements results and disassembly of 
both helper and tcg implementations, if you want me to do this.

>
> I'll also note that ARM, Power8, and S390 all support this as a native vector
> operation; only x86_64 would require the above expansion.  It probably makes
> sense to add this operation to tcg.

I agree with this, but currently we don't have this implemented in tcg, 
so I worked with what I have.

Kind Regards,

Stefan

> r~

