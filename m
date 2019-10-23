Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B0CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796DE21906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHe5zfTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796DE21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFwO-0005Sh-1T
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNFue-0004JA-Sv
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNFud-00072j-Kv
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:38:52 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNFud-00070o-F0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:38:51 -0400
Received: by mail-ot1-x341.google.com with SMTP id 60so17248564otu.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 05:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=oDYgoZDmDppPYehkm5+0JwhEyXj0b0nG8wIDLW33I4U=;
 b=GHe5zfTgZ3RlldE9jn8BrAKhwQzc2eS+4xuO08FWG+I7tFs7VTbZUTC2B3ARIFqOvZ
 F+F7qRoCbCn5QTeNl5SuywgFM+Aq28zjzg2iAjePfvjJ2qjFByZojJ9D2eMWlghP2IaZ
 85qRedz1zrjLRJvsVP+RP5zXbIdfEOo4RB5p9s2T6tbvYkTprsU9lrb/3h9mJgU9o0tG
 iW1INthHSkkXLUH2W11WfS11faakbQHIQjNv28axfRVqTBTCk/MR3VSSpitXW8ZVU+V8
 oGeN2PWPf/L7/FU1HL8uhNM7jVu3XspDLwW0ERy+mSOS8FpKEB9txLoNLho1aVwLH4bY
 n04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=oDYgoZDmDppPYehkm5+0JwhEyXj0b0nG8wIDLW33I4U=;
 b=n/Rp725tW/qSJilOvAKZVLpX0drex3JMBKU0aCBSensSyWAcxPUtJcu3gte4AFq7TZ
 5mgae0UR9yWtsyGd/lXrigf90sI92yGp4V8e2MxwNWLqOVJ4PAgtp/OyA5YTN3L4fyEC
 eYfJVz3+FeBm4qYZaCxQomJ3LUrmL+08at7ZKG/BtAbLx+ZVL2ZUuPNOTZEGhRxPrg69
 CvIS7DExC/6gc9NR1XAfEPQvfLPv0iDYU6xgnYyZ7uNoG4umhiWDd5atSB34F1+UqxVW
 L2YXzCgRVfd8hBePVlA5OlRe8hyUsjnxGwVHhQiBZlGk4EF+jTIxyWfsZ+jvOaxjt9bD
 37wA==
X-Gm-Message-State: APjAAAW7gsS9Jm9UDWPCZlBW60LSFq9WrvmBcf4ktQAWzghjoKfWUzc2
 B75rc5QNek6nbvxSvawgUt64F9U2K2NUUkcdymnBu8fu
X-Google-Smtp-Source: APXvYqxe92nPCGg1OXgDgvDcJmohgrOYzNiLpFUYHd/CIvJpEb70OMjvDa7svYhXsASbCLdQX65jGmYpGvSOwOEA7AQ=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr7242661otg.91.1571834329680;
 Wed, 23 Oct 2019 05:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191022164518.6933-1-peter.maydell@linaro.org>
In-Reply-To: <20191022164518.6933-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Oct 2019 13:38:38 +0100
Message-ID: <CAFEAcA8ShDW=XNZ2ZVNEbwnqgVYi3+xub2Tm0w0BLYu6o81xrw@mail.gmail.com>
Subject: Re: [PULL v3 00/18] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Tue, 22 Oct 2019 at 17:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Changes v2->v3:
> dropped the aspeed new board patch as it fails in
> tests/qom-test on OSX (intermittently).
>
> thanks
> -- PMM
>
> The following changes since commit f9bec781379dd7ccf9d01b4b6a79a9ec82c192e5:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20191022' into staging (2019-10-22 13:45:09 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191022-2
>
> for you to fetch changes up to 90600829b3355b8d27b791b893095c18f529aec3:
>
>   hw/arm/digic4: Inline digic4_board_setup_ram() function (2019-10-22 17:44:01 +0100)
>
> ----------------------------------------------------------------
>  * Fix sign-extension for SMLAL* instructions
>  * Various ptimer device conversions to new transaction API
>  * Add a dummy Samsung SDHCI controller model to exynos4 boards
>  * Minor refactorings of RAM creation for some arm boards
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

