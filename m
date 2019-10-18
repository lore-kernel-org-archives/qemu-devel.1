Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDC8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBBC21925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMhhgu6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBBC21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLR3s-0006Vs-Fs
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLR1l-0004JT-M7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLR1k-0000bQ-4x
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:06:41 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLR1j-0000ae-UV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:06:40 -0400
Received: by mail-oi1-x244.google.com with SMTP id k20so5002698oih.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pbtQf0dCAxjRy4gOM7VwKg1sAYn/2JuMOtYjd4ENOrw=;
 b=AMhhgu6n+WYaGZaDREALzjKqN+m0weP3LtUv/9Jy9ClRzZ1bMJJ3uXf4Ls8cdz9BGg
 vCB8Uj2T59pNspCDM0HuR0yey55t56QT3F63vFKNAiWCTH2pYlhC9733rz2pxDLbTmBe
 svf0mP74E1UcVj7FCkQWENNGo6T6q8TvhITHGzQLoy3dd+eN2lHgl5trgChiKOzn4TUu
 TYOahUUUv9psz3mpc8SyNAboSBWb4icq7KZaQiiA0JJDB3CDwZ7S9KWqWPmUNWnF1pgq
 +gcy+AgMkmzrWgcxyDNJopBQXJ0eyENBC7yZgdSnvPhWtx9FwIUt6vz3pGOI/UQMtf+h
 D/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pbtQf0dCAxjRy4gOM7VwKg1sAYn/2JuMOtYjd4ENOrw=;
 b=I9nskvl4MiDvG6V7fGNlN5i2pU+VqpGG+MAPP3QnYISVlew0ag6y0eHEN8mOxT+xwd
 uRShvCZ/780Qlcx75mcXh8z07vro7KTuQhh1eF42WpBUpJQTStFCEqMPtMfVcVRwMtUl
 9z8M9jnr+szgzV75XckCjmjEiVXxCNNLRXpVwTjjzrwktYt+3M6NU3fBGvkpwHGp9TTn
 A46H9fjAOr2gAIQRTMs2Q/sUgUxLtENDToAF0wwEK1WIKbsQMSJDDjqi1eY/nOVW+TFG
 DH97/AYgnd7XK8TzKXER5+gUHg25u/syIthpJ5W8UJ0gyykIinbvt5Z3lP9FLRv1nwic
 IEFg==
X-Gm-Message-State: APjAAAVJgIcP1SMqKg3fbo2vriExtqsmFjNmH3oNk6A9JYkj2eEWVPLY
 sPf4a+yy0GuxWFhPe2IXHxWpgBZm0fADZSPRzJe2eA==
X-Google-Smtp-Source: APXvYqzDUxnxxqPWeC82g5BvY/sqLkwv4+5zN0Cp+O4AT7V36kUg9GPl9AIfB22NBuoN/ZN62fsJQBiSoJ2nYjOf2zE=
X-Received: by 2002:aca:49c2:: with SMTP id w185mr7861115oia.163.1571400398903; 
 Fri, 18 Oct 2019 05:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191018120235.4438-1-kwolf@redhat.com>
In-Reply-To: <20191018120235.4438-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 13:06:27 +0100
Message-ID: <CAFEAcA-qpw4bZXgMLOn2PcTedNeELJKPOaV9be=Dbxv9PisQQw@mail.gmail.com>
Subject: Re: [PATCH v2] doc: Describe missing generic -blockdev options
To: Kevin Wolf <kwolf@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 13:02, Kevin Wolf <kwolf@redhat.com> wrote:
>
> We added more generic options after introducing -blockdev and forgot to
> update the documentation (man page and --help output) accordingly. Do
> that now.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-options.hx | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 793d70ff93..2e6ba5ef1f 100644
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
> @@ -885,6 +886,25 @@ name is not intended to be predictable and changes between QEMU invocations.
>  For the top level, an explicit node name must be specified.
>  @item read-only
>  Open the node read-only. Guest write attempts will fail.
> +
> +Note that some block drivers support only read-only access, either generally or
> +in certain configurations. In this case, the default value
> +@option{read-only=off} does not work and the option must be specified
> +explicitly.
> +@item auto-read-only
> +If @option{auto-read-only=on} is set, QEMU may fall back to read-only usage
> +even when @option{read-only=off} is requested, or even switch between modes as
> +needed, e.g. depending on whether the image file is writable or whether a
> +writing user is attached to the node.
> +@item force-share
> +Override the image locking system of QEMU by forcing the node to utilize
> +weaker shared access for permissions where it would normally request exclusive
> +access.  When there is the potential for multiple instances to have the same
> +file open (whether this invocation of qemu is the first or the second

"QEMU" should be all-upper-case.

> +instance), both instances must permit shared access for the second instance to
> +succeed at opening the file.
> +
> +Enabling @option{force-share=on} requires @option{read-only=on}.
>  @item cache.direct
>  The host page cache can be avoided with @option{cache.direct=on}. This will
>  attempt to do disk IO directly to the guest's memory. QEMU may still perform an
> --
> 2.20.1

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

