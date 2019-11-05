Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B37C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE7721A49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE7721A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5oJ-0007rV-VW
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS5nY-0006pV-Kw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS5nX-0001YR-59
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:51:32 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:56603)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS5nW-0001YB-Sg
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:51:31 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MVMJ7-1iKZXW1RSx-00SRWq; Tue, 05 Nov 2019 21:51:25 +0100
Subject: Re: [PATCH 3/3] dp8393x: fix receiving buffer exhaustion
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org
References: <20191102171511.31881-1-laurent@vivier.eu>
 <20191102171511.31881-4-laurent@vivier.eu>
 <c98e5cee-ee05-3b2b-894b-f0c9c829f644@reactos.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8a5467d9-2fdd-b0c8-348c-f55bbf0a1a1b@vivier.eu>
Date: Tue, 5 Nov 2019 21:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c98e5cee-ee05-3b2b-894b-f0c9c829f644@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fcyiaZRveKq/H1cZv7hpIHi5T8zWdT93bpXJDW9Fw2DAD2BD1Dx
 6CLFYXkTkazzd29102Pa2RQlk2wotthNg9T3sTN7OmiNcUdMD33+JbI4VJGpTTv44qBCrSC
 bnmZSbtXqIKvBLdtf/pDw9nNOteIzbXFdMad3xy+TUcWNHVOV8nDMJfXSYbkWp23WODNMoW
 xvANvgKGaFECePNg+CqOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iCyJ2kJAucQ=:WcqSmWNbaa70cdft8oo263
 yHecOSwIuu1Mw23aAOAM4LeNQBBbbS0jVvy4gV0728x8dOcPv7M4P6rbM+6fDF20dpNIOXHPp
 bOj/yQBIF+gnAYWF9Wtu1MdA6D4ZKB3nPTaFxG0dvFO/psfnsyPcLgFJS7XU8C/RZdJ3AZuSe
 kpYlq2Qx1BoN+oe13OURRZtdNjBZGmGLUDjEsvRycFDZFHLCG9XCYzv7bRodyba+Edr+YP/oX
 LIWUYCIG8Quy+mTD4+zAJaYH21IkxhFWHyHzrbiZ0Pw0ryiKtg/5yjnSqp89Irts8PSOeMCmE
 D7exJfNdDdfoEhhyZwTIS54SzkgXbhOy7LJ1iakKPK2ZbsFAZfGvQd162JMgSbsryGlcuCoL5
 LiIbm4zilf6BWpIOiH3lf64Rh0zvydFVg8vsnwq/BA1BtARWLOfrqkLBbPIQt3ImIAODKRjOM
 2ozz2ujBPUkGoFiHp0pMv/cZmQPn6gqrQ66nLkFd7urysclX/xDBaTOtn8cJkQuke4sjzID0m
 XZl9/zKw77/Ck/VW214ZwztNJFxFXSJcyZJdkmxgm5skjNl4/wo/5FYXcFyRcZSZozGfVlaka
 gpprxknxwTjNe+z2sSOPQ6P/dwdMnWvY0kfpaae+/hffg1P6XDFWDsyLSnxHnAKjc/XQo1z51
 L+/J7g/vC66WpXjiMr1H8EC2geppwuQmZgAOqsvuMsb4FEjKdc3oxX1S/istADACo7J2bcLRX
 ZP6sdLP/K840FhDnA0uzWyrCsJiS9Fxvax18MwmwN9AoADEGhm4f8dNlyIOC/GbjJRWNv2/YU
 69hEZV/wwcgufQkMwo6XyayFax3oO4ewWjiz1NRT5w9tPFh8lrl0NnN5zbDUlces/bVUFTET4
 Xcoc1wqDLJCm51QCa1o44mBOv7txWFMrNF8xpfaXo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 05/11/2019 à 21:45, Hervé Poussineau a écrit :
> Le 02/11/2019 à 18:15, Laurent Vivier a écrit :
>> The card is not able to exit from exhaustion state, because
>> while the drive consumes the buffers, the RRP is incremented
>> (when the driver clears the ISR RBE bit), so it stays equal
>> to RWP, and while RRP == RWP, the card thinks it is always
>> in exhaustion state. So the driver consumes all the buffers,
>> but the card cannot receive new ones.
>>
>> This patch fixes the problem by not incrementing RRP when
>> the driver clears the ISR RBE bit.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   hw/net/dp8393x.c | 31 ++++++++++++++++---------------
>>   1 file changed, 16 insertions(+), 15 deletions(-)
> 
> I checked the DP83932C specification, available at
> https://www.eit.lth.se/fileadmin/eit/courses/datablad/Periphery/Communication/DP83932C.pdf
> 
> 
> In the Buffer Resources Exhausted section (page 20):
> "To continue reception after the last RBA is used, the system must supply
> additional RRA descriptor(s), update the RWP register, and clear the RBE
> bit in the ISR. The SONIC rereads the RRA after this bit is cleared."
> 
> If I understand correctly, if the OS updates first the RWP and then
> clear the RBE bit,
> then RRP should be different of RWP in dp8393x_do_read_rra() ? Or did I
> miss something?

No, I found that by debugging the problem, I didn't have the
documentation. I'll rework this patch, relying on the doc to better
understand the problem.

Thanks,
Laurent


