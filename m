Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F498C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F422921744
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh2ls/oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F422921744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3EMR-0008Od-4n
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>)
 id 1k3ELa-0007jH-FJ; Wed, 05 Aug 2020 04:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>)
 id 1k3ELY-00036Z-Bc; Wed, 05 Aug 2020 04:00:26 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 215FF21744;
 Wed,  5 Aug 2020 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596614421;
 bh=Gqqsxt7Wk3H8TLkWtPc7l3IxXOMpV0vFyyx0IQsbOSI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Mh2ls/occ65GwqyP+wOPgMtCeRoo1gXC4JUtlFj1P8iaOWuaunSKv4RtXY2k1ZoaZ
 LbN1vPUydKSD28Q7uxMyIRxF48rNKmUm7m7P/GlfzZTuDrbQSwyZ5w8QywNMpe96UC
 vTbW+2MISCPRHak1hfqBpC/U7V9XHitgEMj0Wm6o=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k3ELT-00HZua-Hp; Wed, 05 Aug 2020 09:00:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Aug 2020 09:00:19 +0100
From: Marc Zyngier <maz@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 for-5.1?] target/arm: Fix Rt/Rt2 in ESR_ELx for copro
 traps from AArch32 to 64
In-Reply-To: <20200804193903.31240-1-peter.maydell@linaro.org>
References: <20200804193903.31240-1-peter.maydell@linaro.org>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <36f07426e2ed23832f9f6ca968536bb8@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, julien@bedrocksystems.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Received-SPF: pass client-ip=198.145.29.99; envelope-from=maz@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:00:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Julien Freche <julien@bedrocksystems.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2020-08-04 20:39, Peter Maydell wrote:
> When a coprocessor instruction in an  AArch32 guest traps to AArch32
> Hyp mode, the syndrome register (HSR) includes Rt and Rt2 fields
> which are simply copies of the Rt and Rt2 fields from the trapped
> instruction.  However, if the instruction is trapped from AArch32 to
> an AArch64 higher exception level, the Rt and Rt2 fields in the
> syndrome register (ESR_ELx) must be the AArch64 view of the register.
> This makes a difference if the AArch32 guest was in a mode other than
> User or System and it was using r13 or r14, or if it was in FIQ mode
> and using r8-r14.
> 
> We don't know at translate time which AArch32 CPU mode we are in, so
> we leave the values we generate in our prototype syndrome register
> value at translate time as the raw Rt/Rt2 from the instruction, and
> instead correct them to the AArch64 view when we find we need to take
> an exception from AArch32 to AArch64 with one of these syndrome
> values.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1879587
> Reported-by: Julien Freche <julien@bedrocksystems.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2: fixed the register mapping for LR (thanks to
> Julien for testing v1, diagnosing the bug in it, and suggesting
> the fix to LR handling)
> 
> Marc: Cc'd you just in case you're interested, given that I'd
> expect running Linux aarch64 KVM in QEMU emulation with a 32-bit
> guest to hit this bug...

Thanks for the heads up.

Funnily enough, KVM had the exact opposite bug until c0f0963464c2
("arm64: KVM: Fix AArch32 to AArch64 register mapping"), which was
fixed 5 years ago. We used to actively translate the register numbers
obtained from ESR_EL2, leading to all kind of bizarre bugs if trapping
from non USR/SYS modes.

         M.
-- 
Jazz is not dead. It just smells funny...

