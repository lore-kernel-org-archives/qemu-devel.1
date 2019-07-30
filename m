Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B46C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C7C20651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKnk6Iab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C7C20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsOgb-0006bK-Cp
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 05:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsOgC-00069l-0Z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsOgA-0000rc-SK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:44:23 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsOgA-0000rH-Mq
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:44:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id o101so65611576ota.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hrR+BYqvD4LedGC9eN+HGEwdHBeOn6BbH9SmblDuc6Y=;
 b=mKnk6IabvKg5uYjLvnoy1xqzMA/XVqjS+8OYrRiWM8bs+qQI7CI5vLFKPfMIochDka
 JvJXr7vzrV4NhT5MjtgzlRAmaSxWiLTIIE4U/KjwV8RQ/FnnDzPNsbX0+XIEsyZamww9
 6KmCU8Xm3XtA+O6pG//XKCcnOe9ki9gUZEypLZG7cHfBEz8qatiyOkKPbpRzjZO4cSaL
 3A5VuiFUD+UyyRxK7nw6Pq/BMMBZPbDR7PbXWCHdVP3g2FKvcILw7VcXIhy+iyaM3/ft
 FHafiPzmPbHptby8lE7eXlTlV/lCMv+Glkhc9pbY8WG/pZhUZ0Ui1idKkiWw0PJfLncj
 7yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hrR+BYqvD4LedGC9eN+HGEwdHBeOn6BbH9SmblDuc6Y=;
 b=pvJbiNxiaNcveflCSscYwe0eZD98U+WK9j33PJoWmaWOz4ntL8DIk+eiOqv7ek7IPt
 FUNCaq4tFiqV9WPq1DOdnhCr51wgBErTpsahLzlJjziJyxjnfrzYYprx957xaSq2KWTx
 a64lZIXYJnL+D2MbJ/egecAU9+IWDLB5v4/zeikGCmrkUnIhiupmI8SLrdYBMxKA8BlX
 LLNiquHypcP6st7bxDsyIddLiFZlX3WpmGDnSBtSzTlfUahnb3Rpz6KgBXw4QRFEpgy5
 HlU2yjKT2kFYDN60V4AU12s81jOgBYI7INaJXFIl80sMvT4IxHf49UrdL0AgTKrjr9bL
 pH/Q==
X-Gm-Message-State: APjAAAXljC7IPo1wvGfKXeBFtaNIu1Lrr3NzqfOOHXENm5M6KZiETJ9/
 BrlU7lm1+vOPOd8w848I6ePJgatUlwRb3hKpNOcQAg==
X-Google-Smtp-Source: APXvYqwl3kZrsVBjarPejDuQZllkMCItp0K0LTbd9Q6O7xW/g1DkQQ7usUIEYbfevlbhCrB+kDg1zVcsU02AMvaxbjU=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr3464740otk.221.1564479861129; 
 Tue, 30 Jul 2019 02:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190729211404.1533-1-mst@redhat.com>
In-Reply-To: <20190729211404.1533-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 10:44:10 +0100
Message-ID: <CAFEAcA9VaKso4okcPOy_EMRDc_CSLSOjgNJ1LfkKbfu2cW7zfg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 0/3] virtio, pc: fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 22:16, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> I'm sending this out now as these patches are ready,
> but it seems likely we'll need another patch for pci,
> and as it deals with migration compat it might be a blocker.
> Will know more tomorrow :(
>
>
> The following changes since commit fff3159900d2b95613a9cb75fc3703e67a674729:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190726' into staging (2019-07-26 16:23:07 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 22235bb609c18547cf6b215bad1f9d2ec56ad371:
>
>   pc-dimm: fix crash when invalid slot number is used (2019-07-29 16:57:27 -0400)
>
> ----------------------------------------------------------------
> virtio, pc: fixes
>
> A couple of last minute bugfixes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (2):
>       Revert "Revert "globals: Allow global properties to be optional""
>       Revert "hw: report invalid disable-legacy|modern usage for virtio-1-only devs"
>
> Igor Mammedov (1):
>       pc-dimm: fix crash when invalid slot number is used
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

