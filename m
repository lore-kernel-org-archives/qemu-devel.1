Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBAC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F2D2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="McQaAXUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F2D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCLcQ-0007ds-Eo
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCLbk-00079g-Be
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCLbj-0007lr-3F
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:02:32 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:42114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCLbi-0007lH-TN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:02:31 -0400
Received: by mail-ot1-x335.google.com with SMTP id 66so5661466otd.9
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FY2d6mJLuD5gztn3+vZ0Ra0brVBe+b7Jjc/m2wCcx80=;
 b=McQaAXUevkaEf4+hR3VgGaXLQ5hYORiBU0DOQyM/HB91kXcz6ohvD9jusZGq3lahMt
 hI8wU1uPQyQMichQDOdLoUDMvksYP9Y7jEjPjlCIt/HiZHniHynPZYcEv81DqDaxRLXr
 FrQwsJDXx6x3tyyiTlvu7b1xtGYlMk/BwWJ2w7a+57xHxTNy+L+NhNeM9asKXsgvadfF
 JoHqj9pgfCUWlqqMnxqtYpsvOhRJEKCeLZwEoFE0IJ/zr5DmUn6Vny/qnNbT/gpEY8SC
 MjSJNlB7VJ6OSoWLrPyoZPX2BWIk62VE9bCMNPzWpMnVCre06DgeqZi5LOMJ29EIq0Ez
 0q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FY2d6mJLuD5gztn3+vZ0Ra0brVBe+b7Jjc/m2wCcx80=;
 b=CJ/yZ5B0LHiLQftdJt+wgm9Bu9tMgFr/+1zdIekpVCFWVexw0rcgobTGr27Oo94VSE
 Lhc5L3ODK3dMG7UdzYHFXY01/7izuuXAezBwIkgAv8SGLTPTBJf6+pCGigv411R+sFoh
 5psLlG4Tvjjid3dSKFiMziwMNmrT9R1X9jKmI2YY+RjDWa09/kXOvhf1cwHIa4t2mFNa
 4WCSLyfaCq3RCMtWAcY0lQ3K5UKc+rTh92MjGW+9+ndg0tENa09faTljd2PJGtOYfJJb
 KU5I8GozxnsgTGNKBUhtrFSV3FEC2OzUQjsQXAL0HalUPwVxjFSdqJtzhkiJXr8JiN6l
 qDBQ==
X-Gm-Message-State: ANhLgQ1rsD2i8ieCUNreBxyIeaeYLIl2Xg8PlrrvMnehyXUiY0VTdfbB
 oFamu+u8DX9mOAG616Lchb82l7duWHKeawgUisV2mQ==
X-Google-Smtp-Source: ADFU+vsvjahb+GtF1Xjjk8XdcdGn9qd3c3jsBRBZVEJIDR6UBhLCp0T8pdYlRzIUpL1DBhlAWCDaOzHj3n6fe/dWrHE=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr5531926ota.221.1584010948012; 
 Thu, 12 Mar 2020 04:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200311135213.1242028-1-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 11:02:17 +0000
Message-ID: <CAFEAcA9ECCbmbEASbEm3wiORu-xcJBKsGXRDz+Kr8qJc153VMA@mail.gmail.com>
Subject: Re: [PULL 00/19] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 13:52, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit ba29883206d92a29ad5a466e679ccfc2ee6132ef:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20200310' into staging (2020-03-10 16:50:28 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-03-11
>
> for you to fetch changes up to 397f4e9d83e9c0000905f0a988ba1aeda162571c:
>
>   block/block-copy: hide structure definitions (2020-03-11 12:42:30 +0100)
>
> ----------------------------------------------------------------
> Block patches for the 5.0 softfreeze:
> - qemu-img measure for LUKS
> - Improve block-copy's performance by reducing inter-request
>   dependencies
> - Make curl's detection of accept-ranges more robust
> - Memleak fixes
> - iotest fix


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

