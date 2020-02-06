Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535CE20659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5MWPE9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535CE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfV2-00051d-Ie
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izfUG-0004XA-GG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izfUF-0002YV-5v
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:38:24 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izfUE-0002SI-Lk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:38:22 -0500
Received: by mail-oi1-x244.google.com with SMTP id v19so4218811oic.12
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Elc63CM5Vb4Y9yF9EUmTLHq3nAiBa73bS9eCY3SxQxk=;
 b=h5MWPE9sbHD6iljnomThMAddOaOL20gV6hTi7JGBIAYLfihAcghvpf/hIJOTN8ED87
 00iuQK7NYWgCkbIHHlv+3yr2KhR72cz+denEBB1oEOSI+Vi2NKrF8waXHWPvxfraFKkl
 MoyxbB/fnBkIqyTFA4fTRzPtCfhqaOvR5hlbAimM5I0dqBPzTOqQnGQFYrFvNFaejSvl
 9EsBKwDHtXdu1QFbJJp68SsfPvLsaKJXUBdE2A+YgxKmwsWZGew9nAhintF1hZjB9OVR
 SydJ4MC2o8lhtI8xeNUPMLAyw0AeBbB8tvLP/c2jVXM0hPlM+p2kS/wgQGYHoKoA1/nP
 2y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Elc63CM5Vb4Y9yF9EUmTLHq3nAiBa73bS9eCY3SxQxk=;
 b=pJWwy8BN6Unpp946YIX24uPoq0NiAtGzTcglSzzRzm+MaDuQBzzfcC440j7Ba/IXdE
 ze5WH5FC6qlWPRW6rnbVe225Wgr2l/xW0I4y/yrQ6DADF1K133fHRW07jmu6VsGjITMF
 csk+JOKqZfj6uPnqjX+Iet84BnbE6Jvbn0lkOMCopxWWkRqi/3A12Mnkl77UwBXhIAie
 sc59ZPBPIlHWWz7TfP+RMDy0prCsaqGnTsBJyR7jf0JAfOQLg5iBzrywijGgO/Qt7Axo
 5ZeELN8k/gcsa7ZnOgcDYB3cTAWq4SyJVSHn9QSDZTlQaR2qP8Jr6F2Rzooyfnc5LrAk
 4PFg==
X-Gm-Message-State: APjAAAXp+N4I9hYpOMzouvH0BJTA3SmK5bWhySWbeGPdFBAY76FTN1Uy
 8aGK8W7wSRzniF3rP0VvYHVviSR8ifAMhkNHFa79XQ==
X-Google-Smtp-Source: APXvYqyc1SZPTxv8vl5GB6tlaND8GqRa/yRr6q7YQCIW4u0RmOxGytFZ1ONh4Bmz7AGORLcltuyZUpj438nhP08/FY4=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr6657702oid.98.1580989099638;
 Thu, 06 Feb 2020 03:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20200123064525.6935-1-thuth@redhat.com>
In-Reply-To: <20200123064525.6935-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2020 11:38:08 +0000
Message-ID: <CAFEAcA-Tx69KM4dg2GLNhd-Uf=SNrY4oq2+g6twyJMZE_tWx0w@mail.gmail.com>
Subject: Re: [PATCH] hw/bt: Remove empty Kconfig file
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 06:46, Thomas Huth <thuth@redhat.com> wrote:
>
> While removing the bluetooth code some weeks ago, I had to leave the
> hw/bt/Kconfig file around. Otherwise some of the builds would have been
> broken since the generated dependency files tried to include it before
> they were rebuilt. Meanwhile, all those dependency files should have
> been updated, so we can remove the empty Kconfig file now, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

I ran this through my usual buildtests and they were all fine.

Tested-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

