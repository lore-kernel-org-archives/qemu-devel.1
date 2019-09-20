Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D706C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720A92086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAvsTBGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720A92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBN7s-0000uU-FI
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBN6t-0000QT-9J
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBN6s-0005Ht-8i
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:54:23 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:41866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBN6s-0005He-4Y
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:54:22 -0400
Received: by mail-ot1-x32d.google.com with SMTP id g13so6898855otp.8
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vTHRH4hRCWsAciZd4PGDRyDEfw25wcZqCBptlrejjRA=;
 b=ZAvsTBGm6HT4QLaS8poTzBlJBRB8ovR42pgDvx0Z+smcV8//7Q7Cu6tPVe0wkrw2ls
 H55gx2BhVK28rSqIILUxmFYkG9kyG0DGd7bDfegHfRe0DE9kVQCQsK0Ap0o4wWDnvDiN
 fkdaVktZXUOh7xntpneLfBI6a1kvx7sp49TbRiLg9r7mYBX8JMwYTGLTRiKLaVxY6kdG
 H0uUecJ9p6Yakb3fmaPoE2AfgbVbdZD0XHXEf1Lig/DIC3T3TigHoLfzOStGphoUAGq3
 NdQYYBEAjGZsA/43Lt0D6226GDXp4qVo0h8GxYFFlNgD5PhqRa62hbkl/36L69xH0OJp
 TRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vTHRH4hRCWsAciZd4PGDRyDEfw25wcZqCBptlrejjRA=;
 b=IGRcZns3lVmk8fmiaaLU/NweX8jAYfDZ9qR9DMud5qIiV+Hgm56H/pedK9boFjWaxy
 71vLOzmsfgAwLr2pHQs2FyMdG8DSXiREu+08ycGNOB3ojrtpyoNLGnFUzO7DKJnKvUS4
 MdI4rVfMx+3xifMF9Mqung4JQ7qJhzaeqNoZQHvw9ZPZMW2RrSkMkaTXUS4YQXXtBVOH
 O1K0N5XmING7nZ4ewml15a0GgaeKdyk6XoAt7QsnxzDl6QMkFOSwHYijDmp2ZRBj3GwG
 eXubi3oYsadKDcWltUjKgBLtPi5V5zZYHNU4P0Ln5nk0DPcDGNMoxIdENHFOgI+6RO2z
 EHrQ==
X-Gm-Message-State: APjAAAWMo7MY6PBH6Ypn2M32EWcjhz1376WNRtL43A29b2zTnU0PwfLZ
 z1IcVYCQhaTHtQx6g8CtRQT1AZMPVcvuy5Dd48bgA6jOAfs=
X-Google-Smtp-Source: APXvYqzK0uj03FtMD4XCVFIxZdyD6MHbbu9cz3tFgwj2fq4S/+LRCvzdnAuQhjWldwkltotD84yRlkA0YSBd/a77oPU=
X-Received: by 2002:a9d:562:: with SMTP id 89mr13121807otw.232.1569002061196; 
 Fri, 20 Sep 2019 10:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190919162658.27442-1-crosa@redhat.com>
In-Reply-To: <20190919162658.27442-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 18:54:10 +0100
Message-ID: <CAFEAcA-x8-L97nK_PVW4inw6X0fVTcg-awq4cXrbfJnWzU_Y9g@mail.gmail.com>
Subject: Re: [PULL 0/2] Python (acceptance tests) queue, 2019-09-19
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 17:27, Cleber Rosa <crosa@redhat.com> wrote:
>
> The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:
>
>   target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 471c97a6938bda16f6e10e33437d96241482f580:
>
>   BootLinuxSshTest: Only run the tests when explicitly requested (2019-09-19 09:53:39 -0400)
>
> ----------------------------------------------------------------
>
> These are simple usability fixes for running acceptance tests on
> non-x86 hosts, and were tested primarily on ppc64le.
>
> ----------------------------------------------------------------
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

