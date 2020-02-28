Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A935C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B56A2469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRSQdVPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B56A2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jvm-0005Eg-Bb
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 13:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7jv8-0004mF-Rg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7jv7-0003cG-Jj
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:59:30 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:35431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7jv7-0003bS-DF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:59:29 -0500
Received: by mail-oi1-x22e.google.com with SMTP id b18so3713479oie.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=LdP7W5rvjEIfgY2UMRvfUav4jbSVwoLKEI2RTJvl8nM=;
 b=HRSQdVPC1Q+u86UcqNd+Ad0taBL3ln3LX/9g802Wm2zS9eA9uQUdN4K8TKPBBz+Zau
 ljfUMnVzKc9/0v1yUONnVJZaoOiR/KUPck17gt4g+9jwf9H3EUzKi9sf/YgvO2ton21r
 2pdDDDQ5dZ2iiAtgLzPcd0jW1XOAs0MkUihVFUKHlD448LYV9mlwemPXuMiVyHbrC7cL
 Dpk8MgNOFZfrj1mxAK/bv/KmrDly5nvUHL7SOrgIx+EPtCT7NQafiS3m+TeJwL1zP2wM
 dJgFl+Iu+kVgURP/p1ObB/mG3MiKrqYgn6qBt/9Rz4xPuyIrLh0fRDfhL0Lx+maxVvJs
 BWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=LdP7W5rvjEIfgY2UMRvfUav4jbSVwoLKEI2RTJvl8nM=;
 b=CjVbHhiKwri895dmf6Y8gCl86cv+EMrbzveb7fN1JnaWT16epFDonubshWXcWUJcQP
 MenIUwQd81qbgCvVRPCk/3tqHSVO44Gs50JhF/UUMPoFmyMQmekE5pQX98QWZoBDZO3Z
 awlktxnc+9RAwlROf4/oOKvEsM7w3fZJeikxpQPjqAbbqemiM43DhVOiRBjzyuPAgIzP
 sY8kP3hmw+nxOBtYUXfL2CPWLGCxn+cWBGYk5rD5p+KV/6i1XN4FRCYhijRdVK7sSZ2K
 YbPjUGJcWbBT6y7awdh9YV80cr9QPKRv1t4hgG8hXZcoHUcXziKk3IkdlC/vR7/1B++8
 uowQ==
X-Gm-Message-State: APjAAAUhbr6IiONLKFZ9T/m1GZW8MYneDI3aqSQ1nmaA4/aGHP8Flvv6
 Usox6oeBN303QYP903IkqvpB1kFipzNzRo9INAsKU2o9
X-Google-Smtp-Source: APXvYqxg3vOkNSfuq7pewrGiW10H6hTrsgpa5k59VmO5QHeYcU1u7UkdBJK7suh69PlG5gq0oTWGFmeDFpn0YeckmZE=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr4071799oid.98.1582912768079;
 Fri, 28 Feb 2020 09:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20200228163840.23585-1-peter.maydell@linaro.org>
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 17:59:17 +0000
Message-ID: <CAFEAcA8X7ZD4qndPC+knxyTE86Dvc4x8FcsW6a2wJK_KdXkyKA@mail.gmail.com>
Subject: Re: [PULL 00/33] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 at 16:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Another arm pullreq; nothing particularly exciting here.
>
> -- PMM
>
>
> The following changes since commit e27d5b488ef08408691bfed61f34ee2858136287:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/pull-migration-pull-request' into staging (2020-02-28 14:02:31 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200228
>
> for you to fetch changes up to 1904f9b5f1d94fe12fe021db6b504c87d684f6db:
>
>   hw/intc/arm_gic_kvm: Don't assume kernel can provide a GICv2 (2020-02-28 16:14:57 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm: Use TYPE_PL011 to create serial port
>  * target/arm: Set ID_MMFR4.HPDS for aarch64_max_initfn
>  * hw/arm/integratorcp: Map the audio codec controller
>  * GICv2: Correctly implement the limited number of priority bits
>  * target/arm: refactoring of VFP related feature checks and decode
>  * xilinx_zynq: Fix USB port instantiation
>  * acceptance tests for n800, n810, integratorcp
>  * Implement v8.3-RCPC, v8.4-RCPC, v8.3-CCIDX
>  * arm_gic_kvm: Don't assume kernel can provide a GICv2
>    (provide better error message for user error)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

