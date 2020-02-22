Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F471C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 19:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61ECA206E2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 19:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ECA206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5asQ-000156-MW
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 14:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@jedlik.phy.bme.hu>) id 1j5are-0000FY-M0
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 14:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@jedlik.phy.bme.hu>) id 1j5arZ-0001pH-Kx
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 14:55:02 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83]:38038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1j5arZ-0001fS-Eh
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 14:54:57 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 52315A00E6; Sat, 22 Feb 2020 20:45:09 +0100 (CET)
Date: Sat, 22 Feb 2020 20:45:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
Message-ID: <alpine.LMD.2.03.2002222042370.1577@eik.bme.hu>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 152.66.102.83
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, jasper.lowell@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Feb 2020, Mark Cave-Ayland wrote:
> On 21/02/2020 06:50, jasper.lowell@bt.com wrote:
>> The Linux libATA API documentation mentions that on some hardware,
>> reading the status register has the side effect of clearing the
>> interrupt condition. When emulating the generic Sun4u machine running
>> Solaris 10, the Solaris 10 CMD646 driver exits fatally because of this
>> emulated side effect. This side effect is likely to not exist on real
>> CMD646 hardware.
>>
>> Signed-off-by: Jasper Lowell <jasper.lowell@bt.com>
>> ---
>>  hw/ide/core.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 80000eb766..82fd0632ac 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -2210,7 +2210,6 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
>>          } else {
>>              ret = s->status;
>>          }
>> -        qemu_irq_lower(bus->irq);
>>          break;
>>      }
>
> I don't think that this is correct: from memory when I last looked at this, there
> were 2 IDE status registers: the one from the original specification which clears the
> IRQ upon read, and another one in subsequent revisions which allows you to read the
> value without clearing any pending IRQ. My guess would be that changing this would
> not only cause QEMU to deviate from the specification, but causes problems in other OSs.

You're right, legacy ide has two status registers as described here:

ftp://ftp.seagate.com/pub/acrobat/reference/111-1c.pdf

Now question is which of these the above is emulating? Looks like CMD646 
should not clear interrupt when reading status reg so maybe instead of 
removing this from here another change is needed to CMD646 specific read 
func to read alternate status instead of status reg?

Regards,
BALATON Zoltan

