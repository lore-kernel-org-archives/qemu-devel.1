Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6705C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840F221E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUCjEiRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840F221E6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLHN-0005S6-SS
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 08:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46816)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvLGz-00051z-KG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvLGy-0000qU-NK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:42:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvLGy-0000pZ-G4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:42:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id q12so960057wrj.12
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9Bb8vb6J7sHdQ0mOAQgopc35eYhTKZ7e+0yLXHRBn7k=;
 b=RUCjEiRh0MQkDGLckr3oowu6dT8364GZIVxASR9+JyO2qCkL9PAFeAwCV3z1JtjXJ2
 o+/lqyjDJYF4aOsPvsJNo58yybm0v2Gt8mqWy0kH7wVEHNTZlwYff1nYmhrjAPm4Rtev
 zQeFGb4oAh8FwWQiB60GRTipIRhd1aXulMzj6/oTGkQXhUK+qZsCVk12yIV1yP0/ffX6
 t0lac0Uw4yyRCEsJKG/VYfapOXlNFuVU3YK77PLtIQPGQV74ns8RoeKzhKdVaDXRdmtd
 I2yvFddsRI62EDa8voj4ZSBDQKaLlJndu3o4fJsp21tzHEsjP/ujh/10YpcTVXkzcdiu
 tBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9Bb8vb6J7sHdQ0mOAQgopc35eYhTKZ7e+0yLXHRBn7k=;
 b=AYqixx1erzD/9NRzSmvSjqfjIwlaQ0VptGDf4ufs0vk6EDIrgEfLhsAmEqZ8ZBkiNl
 QClrpFNcC9bRmS7rxOJllr4XHnXA2ZfF4NWnCNqLul6ncSDDVuPZuNC4XTBniLJlLnrk
 FVzNTLjtbBL40gZVWpTi7BWlyXe0robHaXoy6jmazRbYqs4p6+RaUZiAEkkKN2XFVscN
 qE6K0E3uH8iAGcSJdRlDJuHfdCbFQU1ZQpMKYlYusjRGOmYdklWDsgUKU/UAb2H+AzG8
 nCEag8A7L2DFZ4G6F6v3GrZgxfX5pOPL2ZuBWseoDMKLNzUqeyLl1QJ+rpBxbW1FzJjP
 +mZA==
X-Gm-Message-State: APjAAAV0a5EnPSJ7vM2nRPK2yfXfBX6gHyTaxtRQCs+P9kpOq5ckHoCu
 TszB4zPukdiQRMFCrF0YkWqrGJUd2rg=
X-Google-Smtp-Source: APXvYqxEAw2Kit4NaaRFavBd8+9ry22iejWzCDSlQ4Oo3oxkyPoDyjsJ3m429izluMUnS+OcdViwYw==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr11158784wrj.16.1565181750930; 
 Wed, 07 Aug 2019 05:42:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g19sm160899294wrb.52.2019.08.07.05.42.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 05:42:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E5E041FF87;
 Wed,  7 Aug 2019 13:42:29 +0100 (BST)
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <20190730123759.21723-4-pbonzini@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <20190730123759.21723-4-pbonzini@redhat.com>
Date: Wed, 07 Aug 2019 13:42:29 +0100
Message-ID: <87pnlhi1u2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 3/3] tests/tcg: move configuration to a
 sub-shell script
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Avoid the repeated inclusions of config-target.mak, which have
> risks of namespace pollution, and instead build minimal configuration
> files in a configuration script.  The same configuration files can
> also be included in Makefile and Makefile.qemu
>
<snip>
> diff --git a/configure b/configure
> index 714e7fb..b0bd308 100755
> --- a/configure
> +++ b/configure
<snip>
>
>  if test "$libpmem" !=3D "no"; then
> @@ -6516,6 +6468,12 @@ if ! $python -c 'import sys; sys.exit(sys.version_=
info < (3,0))'; then
>    echo "warning: Python 3 will be required for building future versions =
of QEMU" >&2
>  fi
>
> +(for i in $cross_cc_vars; do
> +  export $i
> +done
> +export target_list source_path
> +${SHELL-/bin/sh} $source_path/tests/tcg/configure.sh)
> +

Do we really want to use the users SHELL here? What's wrong with just
calling it and letting the OS derive things from the #!?

--
Alex Benn=C3=A9e

