Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B7C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED942145D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED942145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strupe.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMb7f-0002zi-TX
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fredrik@strupe.net>) id 1jMb6p-0002Aa-VO
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fredrik@strupe.net>) id 1jMb6p-0002dg-0d
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:36:59 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49403)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fredrik@strupe.net>)
 id 1jMb6m-0002ZK-Dr; Thu, 09 Apr 2020 13:36:56 -0400
X-Originating-IP: 84.210.220.251
Received: from [192.168.1.123] (cm-84.210.220.251.getinternet.no
 [84.210.220.251]) (Authenticated sender: fredrik@strupe.net)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 3C98DC0004;
 Thu,  9 Apr 2020 17:36:51 +0000 (UTC)
Subject: Re: [PATCH 2/2] target/arm: Fail on invalid size for VMUL (float)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200408115953.1158-1-fredrik@strupe.net>
 <20200408115953.1158-2-fredrik@strupe.net>
 <CAFEAcA_kVi_LWFduY241vB-nZn2rG0_13Y80t3CZVO3=u_pM-A@mail.gmail.com>
From: Fredrik Strupe <fredrik@strupe.net>
Message-ID: <7f2d47a7-2df4-ec89-0e10-5f205491a5cd@strupe.net>
Date: Thu, 9 Apr 2020 19:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_kVi_LWFduY241vB-nZn2rG0_13Y80t3CZVO3=u_pM-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.70.183.198
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.04.2020 18:27, Peter Maydell wrote:
> On Wed, 8 Apr 2020 at 16:29, Fredrik Strupe <fredrik@strupe.net> wrote:
>>
>> Bit 1 of VMUL (float)'s size field encodes the opcode and must be 0,
>> with 1 making it undefined. Thus, make VMUL (float) instructions
>> with size=0b10 or size=0b11 (size >= 2) undefined.
>>
>> (U is 1 for VMUL, while it is 0 for VMLA/VMLS.)
>>
>> Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
>> ---
>>  target/arm/translate.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>
> Thanks for this patch. I'm actually in the middle of a
> refactoring of this code to use decodetree, but I'll make
> sure I check that the refactoring fixes this decode bug.
>
> Also undef-checks like this in the old neon decode structure
> should be in the switch (op) outside the loop-for-each-element:
> compare NEON_3R_FLOAT_CMP; but it's a bit moot with the
> refactoring as all that code will be deleted.
>
> thanks
> -- PMM

Alright, glad to see it being fixed.

Fredrik


