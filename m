Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8DFC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837382071F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837382071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iboqv-0001hX-40
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1ibopR-0000wD-C0
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1ibopP-0008G2-60
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:45:41 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:59842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1ibopO-0008FP-Vd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:45:39 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1ibopK-00047L-V0; Mon, 02 Dec 2019 17:45:34 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 3/5] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Dec 2019 16:45:34 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <0bc7c461-6b92-2782-4aec-2f649f5bc8cf@linaro.org>
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-4-maz@kernel.org>
 <0bc7c461-6b92-2782-4aec-2f649f5bc8cf@linaro.org>
Message-ID: <d2875338d734fca3e5263b94eaf52c18@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, peter.maydell@linaro.org,
 edgar.iglesias@xilinx.com
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-12-02 15:35, Richard Henderson wrote:
> On 12/1/19 12:20 PM, Marc Zyngier wrote:
>> HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
>> EL2, and HCR_EL2.TID0 does the same for reads of FPSID.
>> In order to handle this, introduce a new TCG helper function that
>> checks for these control bits before executing the VMRC instruction.
>>
>> Tested with a hacked-up version of KVM/arm64 that sets the control
>> bits for 32bit guests.
>>
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  target/arm/helper-a64.h        |  2 ++
>>  target/arm/translate-vfp.inc.c | 18 +++++++++++++++---
>>  target/arm/vfp_helper.c        | 29 +++++++++++++++++++++++++++++
>>  3 files changed, 46 insertions(+), 3 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Annoying that there's a bug in the manual -- FPSID is listed as group 
> 0 in
> plenty of places, except in the pseudo-code for Accessing the FPSID
> which uses TID3.

Are you sure? I'm looking at DDI0487E_a, and the pseudo-code for
AArch32.CheckAdvSIMDOrFPRegisterTraps has this check:

<quote>
if (tid0 == '1' && reg == '0000')                           // FPSID
   || (tid3 == '1' && reg IN {'0101', '0110', '0111'}) then  // MVFRx
     if ELUsingAArch32(EL2) then
       AArch32.SystemAccessTrap(M32_Hyp, 0x8);    // 
Exception_AdvSIMDFPAccessTrap
     else
       AArch64.AArch32SystemAccessTrap(EL2, 0x8); // 
Exception_AdvSIMDFPAccessTrap
</quote>

which seems to do the right thing. Or have you spotted a discrepancy
somewhere else (which would be oh-so-surprising...)?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

