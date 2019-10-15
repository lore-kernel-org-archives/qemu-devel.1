Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609BC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 13:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5313C21848
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 13:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxkaGmNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5313C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNJf-0003F2-DF
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 09:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKNIu-0002iL-F4
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKNIt-0004x3-3l
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:56:00 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKNIs-0004ws-UO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:55:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id g13so16956564otp.8
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Eif0tSdjmj2Yq1mv1zEmYTveCsypKcSd8eRBDyEVPj8=;
 b=JxkaGmNKxNh7IOvXZQgpu8u58nZMhZclnvMnvN5QfmYHVPTecTZda5aiiHrAz0h7Du
 rBbsxsKMPMmxVCqCbRfCk8WTSONfZockZ/7OR0I6ZoCpARFz+x07WbISH5MikVN/gX0I
 ho6JkqrU/b4pAs7PRgD5WwDNDLxsIaaQVgQd3XJWNFmjPfD2wrFqwAsXoLnVwlnDQl6U
 puAr5Sr6xeI1mb2wz+qimBsKdSMqsPRUh9uuWYNAT0ycBVNjujHAt9jMWuQmAKvBZ/J9
 6ZnvFGMh5roUxYM9eKKytBNwsoBemmfWPe+gNacCzNLb6sJZUAR1CdaKO9CehuAA4DgP
 62rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Eif0tSdjmj2Yq1mv1zEmYTveCsypKcSd8eRBDyEVPj8=;
 b=rohqX7O7McvIAfz2TtURv/BFcnGE+Giwivt/EZHsEeN/wxDCKO/5NnTLIOy+9MJWM9
 UQEWXKcIiWsxaVKb+DJBpSS1UmQ6iyf4N2HGOnaeA2n4olcaryoUSvYo2Y3/ESb2B7Su
 aqN8Re078SbdESs5RtYzDvKBmHZCvUYfvEpM6MoP+ZuAF+hAWxK75q831vc9niLNCNAD
 wCq2LnpQ1WjoPLsoGduVMlwi2o8TbSsbUoK1fnE9RJ5ePsUxU6E4BfeI/W7uZZ6EJtnE
 KvFSqrtgAU+/Li1l3p8aR0k7yEmwZJBdB8BdhtKN1fcsEoUVv/5WRAF2zM0c2m8k3vDN
 s3ZQ==
X-Gm-Message-State: APjAAAVWyfQ8d4J0QGt6O6OQwnXfN9G6x0XywGOdWaAQe6j3RMokuifT
 KKtS86zye9fPxiFbdBFGayRC0E7Oc9jPWPek7EAkWQ==
X-Google-Smtp-Source: APXvYqyfQBFe/29CSk8PWk9XZHSm844LRGbsRaoFyuT1IqwspKonwrHRATabye/CcoNG2HRaVTzZsPmDPHQR8sbA2io=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr29309409otj.135.1571147757780; 
 Tue, 15 Oct 2019 06:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191015123854.12039-1-kwolf@redhat.com>
In-Reply-To: <20191015123854.12039-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 14:55:43 +0100
Message-ID: <CAFEAcA8vUcj2bQDno17ncH=zoDvW-9wrzaWo4pLyPTX_Ot=AAQ@mail.gmail.com>
Subject: Re: [PATCH] doc: Describe missing generic -blockdev options
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 13:40, Kevin Wolf <kwolf@redhat.com> wrote:
>
> We added more generic options after introducing -blockdev and forgot to
> update the documentation (man page and --help output) accordingly. Do
> that now.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-options.hx | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 793d70ff93..9f6aa3dde3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -849,7 +849,8 @@ ETEXI
>  DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
>      "-blockdev [driver=]driver[,node-name=N][,discard=ignore|unmap]\n"
>      "          [,cache.direct=on|off][,cache.no-flush=on|off]\n"
> -    "          [,read-only=on|off][,detect-zeroes=on|off|unmap]\n"
> +    "          [,read-only=on|off][,auto-read-only=on|off]\n"
> +    "          [,force-share=on|off][,detect-zeroes=on|off|unmap]\n"
>      "          [,driver specific parameters...]\n"
>      "                configure a block backend\n", QEMU_ARCH_ALL)
>  STEXI
> @@ -885,6 +886,22 @@ name is not intended to be predictable and changes between QEMU invocations.
>  For the top level, an explicit node name must be specified.
>  @item read-only
>  Open the node read-only. Guest write attempts will fail.
> +
> +Note that some block drivers support only read-only access, either generally or
> +in certain configurations. In this case, the default value
> +@option{read-only=off} does not work and the option must be specified
> +explicitly.
> +@item auto-read-only
> +If @option{auto-read-only=on} is set, QEMU is allowed not to open the image
> +read-write even if @option{read-only=off} is requested, but fall back to
> +read-only instead (and switch between the modes later), e.g. depending on
> +whether the image file is writable or whether a writing user is attached to the
> +node.
> +@item force-share
> +Override the image locking system of QEMU and force the node to allowing
> +sharing all permissions with other uses.

Grammar nit: "to allow sharing"; but maybe the phrasing could
be clarified anyway -- I'm not entirely sure what 'sharing
permissions" would be. The first part of the sentence suggests
this option is "force the image file to be opened even if some
other QEMU instance has it open already", but the second half
soudns like "don't lock the image, so that some other use later
is allowed to open it" ? Or is it both, or something else?

> +
> +Enabling @option{force-share=on} requires @option{read-only=on}.

thanks
-- PMM

