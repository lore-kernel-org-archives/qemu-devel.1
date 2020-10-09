Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D5BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FD6215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2TX8s9cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FD6215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvrr-0003tO-Lk
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>)
 id 1kQvQn-0002lK-Lr; Fri, 09 Oct 2020 12:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>)
 id 1kQvQi-00069n-Ls; Fri, 09 Oct 2020 12:39:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC3B92227F;
 Fri,  9 Oct 2020 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602261577;
 bh=BijnUXUSrlZuxdom+hiKK3koCT7tWTVCca3CcvH/Y0c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=2TX8s9cwrskazcYgdvvXIEk1DLTJqwZr1JhsmophCYTijzvSx5vfJ956ZuvG0j/0y
 LkVpYsTvQWy9p8LqAvnwiWhJHqVuPnPTbaatggXKqw4ECGfnPbTrldxaspcthIYvmh
 zVcJhlBlRNyDxbLvYNji6aYWjH9iiSw3rR6xXRPo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kQvQd-0014Lz-Rd; Fri, 09 Oct 2020 17:39:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Oct 2020 17:39:35 +0100
From: Marc Zyngier <maz@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/intc/arm_gicv3_cpuif: Make GIC maintenance interrupts
 work
In-Reply-To: <20201009153904.28529-1-peter.maydell@linaro.org>
References: <20201009153904.28529-1-peter.maydell@linaro.org>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <849e61faa6da0bdc21845f0e95a516e5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, josemartins90@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Received-SPF: pass client-ip=198.145.29.99; envelope-from=maz@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 12:39:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Jose Martins <josemartins90@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2020-10-09 16:39, Peter Maydell wrote:
> In gicv3_init_cpuif() we copy the ARMCPU gicv3_maintenance_interrupt
> into the GICv3CPUState struct's maintenance_irq field.  This will
> only work if the board happens to have already wired up the CPU
> maintenance IRQ before the GIC was realized.  Unfortunately this is
> not the case for the 'virt' board, and so the value that gets copied
> is NULL (since a qemu_irq is really a pointer to an IRQState struct
> under the hood).  The effect is that the CPU interface code never
> actually raises the maintenance interrupt line.
> 
> Instead, since the GICv3CPUState has a pointer to the CPUState, make
> the dereference at the point where we want to raise the interrupt, to
> avoid an implicit requirement on board code to wire things up in a
> particular order.
> 
> Reported-by: Jose Martins <josemartins90@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> 
> QEMU's implementation here is a bit odd because we've put all the
> logic into the "GIC" device where in real hardware it's split between
> a GIC device and the CPU interface part in the CPU.  If we had
> arranged it in that way then we wouldn't have this odd bit of code
> where the GIC device needs to raise an IRQ line that belongs to the
> CPU.
> 
> Not sure why we've never noticed this bug previously with KVM as a
> guest, you'd think we'd have spotted "maintenance interrupts just
> don't work"...

That's because the maintenance interrupt is only used in KVM to trigger
an exit if nothing else causes one, and we end-up suppressing the cause
of the maintenance interrupt (by turning the VGIC off) before actually
coming to a point where we'd handle it.

The lack of MI would at worse delay the injection of new virtual 
interrupts,
not something you'd notice unless you start looking very closely at the
delivery latency.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

