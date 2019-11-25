Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE2C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42DE20836
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcksZTKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42DE20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44141 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEgU-0006f8-Vn
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <will@kernel.org>) id 1iZBnF-0008Ee-0E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <will@kernel.org>) id 1iZBnD-0008Sx-58
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <will@kernel.org>) id 1iZBnC-0008SS-6Y
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:40:30 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 57BA020740;
 Mon, 25 Nov 2019 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574678426;
 bh=DaD7HrU1GEmWXei6V5oHBY0lPBCv4J4j7Ett9UjykLI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YcksZTKCVcS7G348eKxQDvLgtbZCrhEdDS1jUyVkTbbH3TYa7XEVodW+t9oi40lW1
 Uut5cd20ztADFCw1oYUOUvgo8aEqWGLatBdvaJKwHRYTm46KtVW/FvwfEZl+UhaIGb
 XKI+yC0EKPOwvc8dKfT20y3/n4pMlvUt7aoFNWNQ=
Date: Mon, 25 Nov 2019 10:40:21 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] target/arm: Honor HCR_EL2.TID3 trapping requirements
Message-ID: <20191125104021.GA2583@willie-the-truck>
References: <20191123115618.29230-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123115618.29230-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 198.145.29.99
X-Mailman-Approved-At: Mon, 25 Nov 2019 08:43:30 -0500
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

On Sat, Nov 23, 2019 at 11:56:18AM +0000, Marc Zyngier wrote:
> HCR_EL2.TID3 mandates that access from EL1 to a long list of id
> registers traps to EL2, and QEMU has so far ignored this requirement.
> 
> This breaks (among other things) KVM guests that have PtrAuth enabled,
> while the hypervisor doesn't want to expose the feature to its guest.
> To achieve this, KVM traps the ID registers (ID_AA64ISAR1_EL1 in this
> case), and masks out the unsupported feature.
> 
> QEMU not honoring the trap request means that the guest observes
> that the feature is present in the HW, starts using it, and dies
> a horrible death when KVM injects an UNDEF, because the feature
> *really* isn't supported.
> 
> Do the right thing by trapping to EL2 if HCR_EL2.TID3 is set.
> 
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
> There is a number of other trap bits missing (TID[0-2], for example),
> but this at least gets a mainline Linux going with cpu=max.
> 
>  target/arm/helper.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)

I took your fixes/el2_traps branch for a spin and I no longer get an
unexpected undefined instruction trap on first access to the ptrauth key
registers during context-switch:

Tested-by: Will Deacon <will@kernel.org>

Thanks,

Will

