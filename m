Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1855C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F74D2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F74D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZC6r-00061U-L2
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 06:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iZC5x-0005Xy-2V
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iZC5v-0004y5-Ug
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:59:52 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:49759)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1iZC5v-0004wM-Np
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:59:51 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iZC5s-0007Jj-BY; Mon, 25 Nov 2019 11:59:48 +0100
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] target/arm: Honor =?UTF-8?Q?HCR=5FEL=32=2ETID=33=20tr?=
 =?UTF-8?Q?apping=20requirements?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Nov 2019 10:59:48 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <20191125104021.GA2583@willie-the-truck>
References: <20191123115618.29230-1-maz@kernel.org>
 <20191125104021.GA2583@willie-the-truck>
Message-ID: <747eccce18864c1b08b2ce4b3c16a48a@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: will@kernel.org, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, peter.maydell@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 213.251.177.50
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-11-25 10:40, Will Deacon wrote:
> On Sat, Nov 23, 2019 at 11:56:18AM +0000, Marc Zyngier wrote:
>> HCR_EL2.TID3 mandates that access from EL1 to a long list of id
>> registers traps to EL2, and QEMU has so far ignored this 
>> requirement.
>>
>> This breaks (among other things) KVM guests that have PtrAuth 
>> enabled,
>> while the hypervisor doesn't want to expose the feature to its 
>> guest.
>> To achieve this, KVM traps the ID registers (ID_AA64ISAR1_EL1 in 
>> this
>> case), and masks out the unsupported feature.
>>
>> QEMU not honoring the trap request means that the guest observes
>> that the feature is present in the HW, starts using it, and dies
>> a horrible death when KVM injects an UNDEF, because the feature
>> *really* isn't supported.
>>
>> Do the right thing by trapping to EL2 if HCR_EL2.TID3 is set.
>>
>> Reported-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>> There is a number of other trap bits missing (TID[0-2], for 
>> example),
>> but this at least gets a mainline Linux going with cpu=max.
>>
>>  target/arm/helper.c | 75 
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>
> I took your fixes/el2_traps branch for a spin and I no longer get an
> unexpected undefined instruction trap on first access to the ptrauth 
> key
> registers during context-switch:
>
> Tested-by: Will Deacon <will@kernel.org>

Thanks for that. I'll post the whole series later today, though the 
other
bits are less critical.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

