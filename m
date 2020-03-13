Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD2C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963C2206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rr17rRGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963C2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkp2-0004o5-Px
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkoC-0003Vc-6m
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkoB-0001Z0-7u
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:57:04 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCkoB-0001V8-2I
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:57:03 -0400
Received: by mail-ot1-x342.google.com with SMTP id a6so10111491otb.10
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IJdvUzrHteMZEgl+DI2/aeVxkxT8DVzhpeHskrvxYmI=;
 b=rr17rRGHTIdqPqzJdC6LBx6rh0fatux6j+fISDvsoGAcqPCRn1ph7zUbJvVda2r2g7
 jtykAiXC1ZGEEVxgNxjwaJb8tv8fOPgYfd1YkHQrEgUua/Li+Z0uk/KVMlGPBx6FcWop
 lPVI7rwBwuMHq8TXtGAjfPeIaI/iGrfrofPjcyGSZm3o9PY5jtxzadOeaUZ4fcyENXg5
 4G4Esk8VZK4pHgsW6QvTWAfXAjWRZoG2S9ezJta0JxjzNbgcUvJXwPLnXkEil0oDkiLt
 RG2bJqL8dwld4q1n42HtPsbfJJjE6Cj4UUSJ358K6mQgfic7f7ZxHm5ifKJHPJgpgkDF
 L0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IJdvUzrHteMZEgl+DI2/aeVxkxT8DVzhpeHskrvxYmI=;
 b=W/fXIGTu4xUeJPqJZ3/qUiA4iZZJ9PDla7/kUsjyekc4mdqsDTnzPspCJ6/4GmxWOH
 0sjc2E+P7u16+nmcwovapzveummnwHN9xcpsXoU34rkMGWx3oVHY1nFMEd+tDvXmkaRo
 adzcKvJpMCc09ygYjoxckNqBuKuAuHjApC1SraMIWPR4xZBZSyK6gPrJtGnoWx+O2uNV
 hIqj0s00oARGsUaP8R123R7JGJ1Hu1JiydV1Thhw2gcKI3+1iVTajfYlpJyNx8UWPonn
 /Rldz2KY2EW7QTQD3P6By+WBzmDx2nYhggtN8JyMJYXNJTy6TjVdAPPrv4hDK4SlpPAt
 +NLg==
X-Gm-Message-State: ANhLgQ2BWLVbR55baqtWmT6FubP0VnB/qIRoCLv5yWIisXs7EZi8YEhP
 KHWhUi9L0CmmhkipdkXRkWcPxlvqYaAKeo/fd35U7w==
X-Google-Smtp-Source: ADFU+vveKe3bx6W0gi+EWRB7MSkoA0uLeD8mArWYugSSzyuF6p6KeoWVdAwgQNbLR9vGpLWlpt710YAVmCY3dlHPEiU=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr11182576otl.135.1584107822319; 
 Fri, 13 Mar 2020 06:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-5-crosa@redhat.com>
In-Reply-To: <20200312193616.438922-5-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 13:56:51 +0000
Message-ID: <CAFEAcA-=3-AFUec1tMTFgXyHGscC-PF_+XEBTbujCsLB043MEw@mail.gmail.com>
Subject: Re: [PATCH 4/5] GitLab Gating CI: introduce pipeline-status contrib
 script
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 19:37, Cleber Rosa <crosa@redhat.com> wrote:
>
> This script is intended to be used right after a push to a branch.
>
> By default, it will look for the pipeline associated with the commit
> that is the HEAD of the *local* staging branch.  It can be used as a
> one time check, or with the `--wait` option to wait until the pipeline
> completes.
>
> If the pipeline is successful, then a merge of the staging branch into
> the master branch should be the next step.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  contrib/ci/scripts/gitlab-pipeline-status | 148 ++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100755 contrib/ci/scripts/gitlab-pipeline-status
>
> diff --git a/contrib/ci/scripts/gitlab-pipeline-status b/contrib/ci/scripts/gitlab-pipeline-status
> new file mode 100755
> index 0000000000..83d412daec
> --- /dev/null
> +++ b/contrib/ci/scripts/gitlab-pipeline-status
> @@ -0,0 +1,148 @@
> +#!/usr/bin/env python3
> +
> +"""
> +Checks the GitLab pipeline status for a given commit commit
> +"""

All new files, and particularly new scripts and source
files, should have the usual copyright-and-license
comment at the top, please.

thanks
-- PMM

