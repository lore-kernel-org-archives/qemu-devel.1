Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC0C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C25720709
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eioyA5ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C25720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVMG0-00060h-Fb
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 16:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVMF9-0005Qi-Ue
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVMF8-0004Of-SE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:01:31 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVMF8-0004Nw-NJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:01:30 -0500
Received: by mail-oi1-x242.google.com with SMTP id y194so6640439oie.4
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 13:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SKkCEwXFwbZmbzc7S9qEOq9pI514UvvN5FVNw3ZSjB8=;
 b=eioyA5aerfLPynUJ5id/moMDEDJNUx6ic1RLp3lBPy5miJCtOvwOe6d9tZF0kjNLjs
 EUVDtPAiq4E1RDAJigZIMvLYv4o5b8AAqWjWKLu3B6pj+6tmP5x9Z6xhzTHCZIcXlYiR
 ambgLzrgIe6rOQ2r5BGkCMKPHlMZDJPmUmyni7LiSgdccZOmvG06R8r+4cyXUpdp97a+
 KomrTr0Y5uId+TUX2XBD/sz7G+hKd1fNzwMCvVjEkgwNJxU/NHhVg3agbeqt5JV4lMuH
 QX2D66MXZl0vAXJYqFzPbuHdi5k5VRzBmGDmWHiC00F8N3c17PUI5WLwYKVTOX6GK7x2
 RgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SKkCEwXFwbZmbzc7S9qEOq9pI514UvvN5FVNw3ZSjB8=;
 b=s0QuDN7wKEtRhIT+9HPaPlAmfyeuzykvvJASVFk2cJWD/HDLQyTN807cAcOHc4KewN
 VQ4mF7YesC3TLCGeiXuBDM3BGx/Lrn2zPjoP4Dkz8DzU0qcNDWlijF/n9Du8dGoF3ZC/
 7eWptSE3H/+GFKFdDUUCK9gaNIjgUvJL/Y2xdE/jj+vLW4O9U2Q6sbt2L4Wn4q/U1rEB
 MiIjkd8qhY+CkaFS0Cg1gjJA4oUk6TSmQoGP9JCkR+VCUwNjX766T2t08D8LFW0gDIZV
 WabYkwbw3I99Zz/GwFCvMVbQ0ALjoAzBEuGAr7oLaGea5Al9sW2Eomk+HrlSzIQJ71a1
 cOrg==
X-Gm-Message-State: APjAAAUdbjsr+JFKQVr78qJd8fHvXgx9XLYFoSWJKLEjNWFHguUUTulW
 Kd5M4Qhq71PakULeAd8EsqyLF2px8XpElJjNlRqvfA==
X-Google-Smtp-Source: APXvYqwBOv4jH3vGFz9Yg6lowA5by1oE1px6ORa7uSbSvTlJ9cYbfC/7JjhZd+LuLum2gtnSwGuf0G1SzDMWUvZHP7A=
X-Received: by 2002:aca:451:: with SMTP id 78mr5375158oie.170.1573765289704;
 Thu, 14 Nov 2019 13:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20191104115228.30745-1-graf@amazon.com>
 <CAFEAcA8zkR_MZ-28Nc=x4j05U9MsFYfzQtkHxTf65ZwacK020w@mail.gmail.com>
 <246a7cd4-7c39-c92e-05c3-1045bca2c114@amazon.com>
 <CAFEAcA_kwscZRqK5wTRu5WLkixGYbdV0c7mZMV6n+40DOS0-Mg@mail.gmail.com>
 <CAFEAcA8HwRNd+Mg91RJ1DpiyoNJKBWHjFT_Te16xTV5P7wV_ug@mail.gmail.com>
 <a3b96c16-4d92-87ea-32a4-f36a62cc857e@amazon.com>
In-Reply-To: <a3b96c16-4d92-87ea-32a4-f36a62cc857e@amazon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2019 21:01:18 +0000
Message-ID: <CAFEAcA8KyiSvW0c2gM3muM9i-CNSt9qjH0rTDZY8yGcKq0J+5g@mail.gmail.com>
Subject: Re: [PATCH] pl031: Expose RTCICR as proper WC register
To: Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Hendrik Borghorst <hborghor@amazon.de>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 20:45, Alexander Graf <graf@amazon.com> wrote:
> On 14.11.19 15:42, Peter Maydell wrote:
> > Is that OK?
>
> It's much better. Will you just fix it up inline for me please? :)

Sure :-)

-- PMM

