Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82B0C3B186
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8793F20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X59qJxK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8793F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sr8-0001H1-N0
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 09:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1sqX-0000rI-Hw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1sqW-0002WB-8e
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:18:33 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1sqW-0002VL-2j
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:18:32 -0500
Received: by mail-oi1-x242.google.com with SMTP id a22so2097731oid.13
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 06:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9TeF7/wkgvfx216bl/Yc48i/KrxAIKEbnbocCyyeNws=;
 b=X59qJxK2JkzfBJT3b1UHJS9nTgLnofEcd1E9+ehM4ZoaVuNhbqHYwAv1otl/pIg8qP
 MaspW/PUoGUrNKEKDrGrIRF5Z5xwAMraQGN8plMTVGWtUczytb/3qa54/1+owBOf/BZF
 tQzFptcAPck1L6AvNlwfyp4NR32ucFPykOgfb7F7Uyy5zAkIXNWbUVW9T6zmEnOO4BHn
 F8eTnrFDJVS4XjtLeYrIQPAyr6VAGaQ8G3UHqzPM/Xkm8Z3NBTAe9/wLDXDw7hTIbzaU
 FuaN0b+85EBEjWAlpxbxespm55dWlFgJbTjShrmXycopYYWc9Y91SIYVu8skOVBUw0LD
 FE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9TeF7/wkgvfx216bl/Yc48i/KrxAIKEbnbocCyyeNws=;
 b=BkUN6xdwutA6B1yGp2DRQZhgD3qSqn9pYqLUda8MdJIZiHmoF7Cc4lK/VLr2oSyZqP
 V581SoOSm41+OFTkzPsE30o8EVaRZms7VJnZ1w/n/IpTCWUQIgCQXmUxoMm1nPjKKbRb
 QpqMJmcKgZI97w/pqaVL8z7XgZZsjVmzV5uPc4FMf/3ehtzna0atdZ9m1/tPNTPzMcbG
 s7sj43Fv/ntQKzDf8uBMZvIYnOkhPnXj7McNfY0v58wUCpc+kqZJeI+FXlQWBodqREt8
 VqcN0Gip8ScElO+0w3cuY6MUDZfShRKl0eZzTTYnMVaR7/xE4+VFQX02gVfs/FG2Frl4
 Gh8A==
X-Gm-Message-State: APjAAAXE+n4cYaT19UlEigr74Bb1SpTvgpmxgv550wXT45Uu6our8V+0
 msW+qS7LFnDqMIOy1xBNchEqZOUGYAnUKFLNjg97ig==
X-Google-Smtp-Source: APXvYqxWr6iSWry3/14BzW8/bXWNHqDdlJU3yKLvHeVVSQFJqCLafJGYlazJgcJ8a7gXmEWKc/sNdDw0+UA0cOLhyKI=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr6134045oic.48.1581517110962; 
 Wed, 12 Feb 2020 06:18:30 -0800 (PST)
MIME-Version: 1.0
References: <1908428819.7192207.1581512184275.JavaMail.zimbra@redhat.com>
 <1608747495.7195569.1581513386780.JavaMail.zimbra@redhat.com>
In-Reply-To: <1608747495.7195569.1581513386780.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Feb 2020 14:18:19 +0000
Message-ID: <CAFEAcA-F-F1C4si7OXNkMnzE+9DHXtNnvCYv1eTx-nEpb4_OZw@mail.gmail.com>
Subject: Re: [PATCH] docs: Fix virtiofsd.1 location
To: Miroslav Rezanina <mrezanin@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Feb 2020 at 13:16, Miroslav Rezanina <mrezanin@redhat.com> wrote:
>
> Patch 6a7e2bbee5 docs: add virtiofsd(1) man page introduced new man
> page virtiofsd.1. Unfortunately, wrong file location is used as
> source for install command. This cause installation of docs fail.
>
> Fixing wrong location so installation is successful.
>
> Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I noticed this in review of v1 of the patch
https://patchew.org/QEMU/20200127162514.56784-1-stefanha@redhat.com/
but missed that it hadn't been fixed in v2/v3.

thanks
-- PMM

