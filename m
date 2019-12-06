Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF12C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3055D20706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3055D20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idElY-0000S5-V0
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1idENl-0000dh-Nc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1idENk-0000Sg-G4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:14:57 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:43437)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1idENk-0000NI-8b
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:14:56 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1idENg-0004EG-0L; Fri, 06 Dec 2019 15:14:52 +0100
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 3/5] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Dec 2019 14:14:51 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <CAFEAcA_YGBXY4X5KYE_xny1bYtP1fKefT+VubmNYbe8TxdwBOw@mail.gmail.com>
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-4-maz@kernel.org>
 <CAFEAcA_YGBXY4X5KYE_xny1bYtP1fKefT+VubmNYbe8TxdwBOw@mail.gmail.com>
Message-ID: <eecc1855c043f690bc48cfaaeae442a4@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, richard.henderson@linaro.org,
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
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-12-06 14:08, Peter Maydell wrote:
> On Sun, 1 Dec 2019 at 12:20, Marc Zyngier <maz@kernel.org> wrote:
>>
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
>>
>> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
>> index a915c1247f..0af44dc814 100644
>> --- a/target/arm/helper-a64.h
>> +++ b/target/arm/helper-a64.h
>> @@ -102,3 +102,5 @@ DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, 
>> env, i64, i64)
>>  DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
>>  DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
>>  DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
>> +
>> +DEF_HELPER_3(check_hcr_el2_trap, void, env, i32, i32)
>
> This has to be in helper.h, not helper-a64.h, otherwise
> the arm-softmmu target won't build. helper-a64.h is for
> helper functions which only exist in the aarch64 binary.

Ah, fair enough. I guess I should build all targets rather than
limit myself to aarch64...

I'll fix that and repost the series, having hopefully addressed
Richard's comments.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

