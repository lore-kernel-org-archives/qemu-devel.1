Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A083C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90D3207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQQR9Uhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90D3207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKg9l-0003RX-Nw
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKfy0-0008VB-SC
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:56:12 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:40145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKfxy-00020G-Uq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:56:12 -0400
Received: by mail-ej1-x643.google.com with SMTP id z22so22151742ejl.7
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qDzMZsU48zHF46VxTtsuRwuCQ4VxUHJnEhFuFIxmTqQ=;
 b=rQQR9UhkgONp3Ilw4E/qTmGjJJLy83VVTuwdW3ZjII4V3s77uNjTSToMp2x/nFSvKJ
 O7jLHldpbmR2zMPeLfTgu8Wt1YggnNhOf8OivjiI8WQcg2uOSkzb3QTC9HK8ClIwVEPo
 Mr0jxtMAy/ti+5qHyywsTVEX/Nb6d3C8vSzmsJr9bQ4vLb6WegL/4vT0nc5NgKjE2411
 JTIyIuD6mY4OEUeYQG7mEbI+yUq83zkE58FR8+4k6/G5gHm4s26Bw7YNFiQ4Yythd6PH
 fJv7nAITXomKOg0fUdcEawVp+AR8SCYLA+twrOwjetKkJr2GYCcjZj0YZcCvM9uQka59
 Tubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qDzMZsU48zHF46VxTtsuRwuCQ4VxUHJnEhFuFIxmTqQ=;
 b=gRrLJWan+6Yx4bpYHJUtN7GT96k/kLIWU8L/S2PDzOovc+aUHyxWyjXD6c4uoIpJE4
 6L8mGCE4Bv2GrGmlXOkTcOjGQQj+m7q6YpG0dGvq4Xjcaq7Kw/5qnrgD+7Ut1qcHJdLo
 jeUUGo6yzqtLuLqlf6VZL/zsy5M+q09ROM3R8qg/m5bTwBQ8J1oStX/ydxC9yPmTdbCo
 waVqx/D8DEIEMJODlFnDlq52cFcTNNidBchibXH960os3zHNIix0eHIcKTO/LmFrBe6B
 EE2AfVZ3VKQpo86GZV8j1REGA0Pzl9F1sj/jFeDDubQZ0L/M7LK+C4sQ83VxVIJEkdfU
 Me9A==
X-Gm-Message-State: AOAM530F6wBRMULPnIgbwbJR1rsricfrD+/JDgKj46VAx9qDdpg/zpDv
 44eHANRo9X2c2C9KEYz2zJFDiITgobzTZmrYj+t6eQ==
X-Google-Smtp-Source: ABdhPJy92xzykI0itopUe21t5TPKYnhUBVNkSm/cgMM2ktiTXzsOUOehGBpJBzJB2/BTcE7zFOX96ynn9ya+0cg2bEM=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr4338730ejb.4.1600772159051; 
 Tue, 22 Sep 2020 03:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200921174320.46062-1-thuth@redhat.com>
 <20200921174320.46062-8-thuth@redhat.com>
 <9bd2d32f-27eb-c32c-0e19-eb16612a9400@redhat.com>
In-Reply-To: <9bd2d32f-27eb-c32c-0e19-eb16612a9400@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 11:55:47 +0100
Message-ID: <CAFEAcA-P5gngMXmBUtOGNn=ZUN8C2dmC=5Phxs7C5fYV=Odhjw@mail.gmail.com>
Subject: Re: [PATCH 7/7] configure: Bump the minimum required Python version
 to 3.6
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 at 19:20, John Snow <jsnow@redhat.com> wrote:
>
> On 9/21/20 1:43 PM, Thomas Huth wrote:
> > All our supported build platforms have Python 3.6 or newer nowadays,
> > and there are some useful features in Python 3.6 which are not available
> > in 3.5 yet, so let's bump the minimum Python version to 3.6 now.
> >
>
> Just to add in case anyone wonders: This isn't incrementalism for
> incrementalism's sake, but the type hint annotations added in Python 3.6
> allow us to statically type the QAPI parser.
>
> We are already using (and enforcing) these annotations in iotests.py,
> and I believe adding this to QAPI will be of high value going forward.
>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   configure | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 7564479008..a3a643168e 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1965,8 +1965,8 @@ fi
> >
> >   # Note that if the Python conditional here evaluates True we will exit
> >   # with status 1 which is a shell 'false' value.
> > -if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
> > -  error_exit "Cannot use '$python', Python >= 3.5 is required." \
> > +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,6))'; then
> > +  error_exit "Cannot use '$python', Python >= 3.6 is required." \
> >         "Use --python=/path/to/python to specify a supported Python."
> >   fi
> >
> >
>
> Do we need to bump the minimum version in the Sphinx conf, too?

Yes -- the configure check only applies to python invoked
directly, not to python code invoked via Sphinx, so we
should keep both in sync.

thanks
-- PMM

