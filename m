Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCEDFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215F420663
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215F420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKjmn-0007Rn-6h
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 09:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iKjlS-0006X0-RB
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iKjlR-0006nc-B0
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:54:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57102 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1iKjlR-0006PT-4G
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:54:57 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 438541A1E46;
 Wed, 16 Oct 2019 15:53:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.14.77] (rtrkw870-lin.domain.local [10.10.14.77])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 2B80A1A1D6F;
 Wed, 16 Oct 2019 15:53:51 +0200 (CEST)
Subject: Re: [PATCH v6 1/3] target/ppc: Optimize emulation of vpkpx instruction
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <1566898663-25858-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1566898663-25858-2-git-send-email-stefan.brankovic@rt-rk.com>
 <64b614b6-cb05-bd16-dd0b-1ffbdc7db94a@linaro.org>
 <bdc9fb4f-b247-5919-c691-62f46f14360f@rt-rk.com>
 <5b676467-7887-990a-bdd6-dbd6d5c4e495@linaro.org>
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <b9bc164c-e65d-8655-d41a-e3d3846ad9ef@rt-rk.com>
Date: Wed, 16 Oct 2019 15:53:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5b676467-7887-990a-bdd6-dbd6d5c4e495@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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


On 29.8.19. 17:31, Richard Henderson wrote:
> On 8/29/19 6:34 AM, Stefan Brankovic wrote:
>> Then I run my performance tests and I got following results(test is calling
>> vpkpx 100000 times):
>>
>> 1) Current helper implementation: ~ 157 ms
>>
>> 2) helper implementation you suggested: ~94 ms
>>
>> 3) tcg implementation: ~75 ms
> I assume you tested in a loop.  If you have just the one expansion, you'll not
> see the penalty for the icache expansion.  To show the other extreme, you'd
> want to test as separate sequential invocations.
Yes, testing is done in a loop.
>
> That said, I'd be more interested in a real test case that isn't just calling
> one instruction over and over.  Is there a real test case that shows vpkpx in
> the top 25 of the profile?  With more than 0.5% of runtime?
>
>
> r~

I made an experiment where I started MAC OSX 10.4 in QEMU system mode 
and I found out that vpkpx instruction is widely used to display 
different graphical elements. With that in mind, this performance 
improvement is of great importance.

Also, vpkpx instruction is often used in a loop, to process big amount 
of pixels at once. That's why testing performance of this instruction in 
a loop should give good insight of how this instruction perform overall.

Kind Regards,

Stefan


