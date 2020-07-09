Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4514C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB64A2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB64A2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysgo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtVUH-0000Bf-UL
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 08:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vav@sysgo.com>)
 id 1jtVTR-0007un-GV; Thu, 09 Jul 2020 08:16:21 -0400
Received: from mail.sysgo.com ([176.9.12.79]:41314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vav@sysgo.com>)
 id 1jtVTN-0001YP-Cl; Thu, 09 Jul 2020 08:16:19 -0400
Subject: Re: [PATCH] hw/timer/a9gtimer: Clear pending interrupt, after the
 clear of Event flag
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200610084551.28222-1-vav@sysgo.com>
 <CAFEAcA9uF01LnFy6o4Yy=aeuy9ixyGWZFVGtR66ah3w1458O5g@mail.gmail.com>
 <583c6e8e-fe52-881d-1a61-f02ce7b16d23@sysgo.com>
 <CAFEAcA8XLnUWQP9BgYfN_Q5Kg8nEMfEynFiRMx8NOS2roE+V1A@mail.gmail.com>
From: =?UTF-8?Q?V=c3=a1clav_Vanc?= <vav@sysgo.com>
Message-ID: <a9279c39-9e5e-0cb2-c4fc-474b108c04ce@sysgo.com>
Date: Thu, 9 Jul 2020 14:16:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XLnUWQP9BgYfN_Q5Kg8nEMfEynFiRMx8NOS2roE+V1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=176.9.12.79; envelope-from=vav@sysgo.com;
 helo=mail.sysgo.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 08:16:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: "open list:ARM cores" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/26/20 4:46 PM, Peter Maydell wrote:
> On Tue, 16 Jun 2020 at 08:04, Václav Vanc <vav@sysgo.com> wrote:
>>
>> On 6/15/20 1:04 PM, Peter Maydell wrote:
>> We must distinguish between two cases:
>> 1, Auto-increment is disabled.
>> I just run some test on SABRE Lite (i.MX6) board.
>> I had auto-increment disabled, I verified, that GIC is configured for
>> Edge interrupts. Once count went past the compare value I got the
>> interrupt. I did not touch Timer registers, just signal EOI to GIC and
>> surprisingly, I got a another interrupt. If I stopped the timer
>> interrupts stopped coming (Status was still set to 1).
>>
>>   From this behavior I assume, that every time the Timer is incremented
>> (and Timer value is past the compare value) an EDGE interrupt (that
>> means actual X->0->1 transition) is asserted. This is really interesting
>> from HW point of view. This would mean, that a9_gtimer_update function
>> should generate the pulse and not level on compare event.
> 
> That's interesting. Which version of the Cortex-A9 does this
> board have? The TRM documents that the comparator behaviour
> changed in r2p0...
> 
> thanks
> -- PMM
> 

It is "SABRE Lite (i.MX6)" board with Cortex-A9 r2p10.
Behavior is also the same for "Xilinx Zynq-7000 SoC ZC702 Evaluation 
Kit" with Cortex-A9 r3p0.

Unfortunately I do not have any board with older revision of Cortex-A9.

Best Regards,
Ing. Václav Vanc
Project Engineer

SYSGO s.r.o.
Embedding Innovations
Research and Development Center Prague
Zeleny pruh 1560/99 I CZ-14000 Praha 4
Phone: +420 222138 828, +49 6136 9948 828
Fax: +420 244911174
E-mail: vaclav.vanc@sysgo.com
_________________________________________________________________________________

Web: https://www.sysgo.com
Blog: https://www.sysgo.com/blog
Events: https://www.sysgo.com/events
Newsletter: https://www.sysgo.com/newsletter
_________________________________________________________________________________

Handelsregister/Commercial Registry: HRB Mainz 90 HRB 48884
Geschäftsführung/Managing Directors: Etienne Butery (CEO), Kai Sablotny 
(COO)
USt-Id-Nr./VAT-Id-No.: DE 149062328

The protection of your personal data is important to us. Under the 
following link you can see the information in accordance with article 13 
GDPR: https://www.sysgo.com/privacy_policy

