Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661DBC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3464F2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGcmoxGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3464F2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOeR-000415-NE
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 11:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1irOcN-0002Vp-IW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1irOcI-0002F9-Dx
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:00:35 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1irOcI-0002CN-4C
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:00:30 -0500
Received: by mail-oi1-x243.google.com with SMTP id l136so12296164oig.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 08:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4CsJxBj3eUEhyAmr7Wi9LOOw3Osv5Si7TP1/ynZ15Eg=;
 b=MGcmoxGDN1nApcforqZSQn3ecEYeRMV3SFDIjoJ1bWSbxw4fMN0MPL8/MeZKNsxOST
 QRNArf7oM6r8e2g25Y0eELo+w8YtKBm78voYXXvrPKrybSSbBJiACYJjCWGwt3qqM2Qs
 fEMVbkNCIVwLdCIASFJoA1JW7CpLU+w5XPL+QjL9ih4/l0ZnpqDJpnVQz89Phx17DjMb
 tVUN8aEm3m5iWIMZxVVgfSzVj6hD3JhczsMQCX7crf0omv2cuaIDtuzNsp0VOq3knE6g
 QyhAvr27EDHGgOHOQ/fX6a96KGmKQjq4aWlGr88InFBdRWukeBcQm65nLlxdPZOTBZHL
 kJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4CsJxBj3eUEhyAmr7Wi9LOOw3Osv5Si7TP1/ynZ15Eg=;
 b=qOl7Zo6rCVvnhwx9v7hNNRc/FTADbVDJ810T41Fm/6O02PNLfOI0dStfPK2SdlSCl9
 lPVsgk/PjF0OWBGrDjK9/SW466+saWS2jiIec2i3aCcbfZD/rww1dLxM2mZft6wxjS+w
 a0cDoHetYuJGUCJftb5TFV9hu9oPq/049tAKSCAy9GmTtNIuwHMC1KdgrFf24t8Zh5YE
 Y8Qf3f3nLE1t4tLfp1XDlTBfHCiCYNBl9OIfVQ8JuZAo8GJYm5STGE40LghLE0zvJsZO
 bZQg4BWVlAvvzce7ugk3MkOOUaW/gMrnYFghEYR8dk3jN5s2vqVyixLfUmtotuYhrVCn
 6aEQ==
X-Gm-Message-State: APjAAAVBZe+RcuPSYwdEMdOc7VjB8E1K6CHnnv4E/od6mNVoiB7K+rAJ
 vxhPep7M2ZEScrAz4kkRgFJxI7bWiKgyraUKrACQKQ==
X-Google-Smtp-Source: APXvYqz8gQPXh9vCk179FwxJG7pDXu7NOV/F6g4OE6GfDfYRCxHc37jzb03O3HzPcIrNFOlPQWfJlYEHjO553G6YyVw=
X-Received: by 2002:aca:3182:: with SMTP id
 x124mr17880402oix.170.1579017628980; 
 Tue, 14 Jan 2020 08:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20200114093052.117848-1-stefanha@redhat.com>
In-Reply-To: <20200114093052.117848-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2020 16:00:18 +0000
Message-ID: <CAFEAcA8AQnJ4X6yankYGacD_tsTLDALpqHd_Xon7_eiyGygc-w@mail.gmail.com>
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 09:31, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit dc65a5bdc9fa543690a775b50d4ffbeb22c56d6d:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200108' into staging (2020-01-10 16:15:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 2558cb8dd4150512bc8ae6d505cdcd10d0cc46bb:
>
>   linux-aio: increasing MAX_EVENTS to a larger hardcoded value (2020-01-13 16:41:45 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Wangyong (1):
>   linux-aio: increasing MAX_EVENTS to a larger hardcoded value
>
>  block/linux-aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

