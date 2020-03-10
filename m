Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EA4C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF01227BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfpBWbRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF01227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfts-00022P-8z
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBfsl-0001Mq-Bs
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBfsj-00025s-MB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:29:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBfsj-00022y-Cq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:29:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so16178289wrl.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EWcVS7Hv8O7iSevxGE37M4tGL/34ARgfBUuiLALKX6I=;
 b=dfpBWbRfcNW3l3wU1YvRoYGtko2Av5O8ThIwD0Zorh6KHE8M60SXnEFe1tljKWTNuB
 HgJGfjoDxRGAZMJAp/AXuASt0sqrzhXH4fXp/NAvw0xLWg94UgtGbqBplM+Cr7ZxERHH
 DHHuq0NgQjLGcoEfzihFanC02WJzJ9khHRaxhDdijevhjjgF5m7O+urlfhTtExMZK1OD
 a0TrSfwdWOyeU4bB9J3iI2OpZlj2+IweczUh4pxBBhC1iih+Vf4soosy64IAPppoMof2
 QDwxDbkgl/FeSBDbp9fRgWBdGQpeHTdLmkWF+YkYkHfpSMoUTNrux7cs0EDOVee6kKWb
 mwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EWcVS7Hv8O7iSevxGE37M4tGL/34ARgfBUuiLALKX6I=;
 b=Tbar7UXrw0fBEJQCnUwE87eHtZG8HPvOcUkNbsnIgHAYdQkNfBSiTPQ2BZfBN/CpOJ
 FDV9Mm8RbeIdspvK3Xj8jioe+6jDqAImK1NGnnldZEjrEybuv4y8GuF/EdaB2shEEV4f
 i0EIzANH3ONJaggZjQ+Q3i2aB0fgb+dX5J9VfdMy8lPAO82SJu5ehjS1G24dPqpzWZHK
 R0c4xyYH5YFOe+/e07Nl0nfi4FUJem7bpkuOwOGXvxo05z3ZrxpSyWpnDec0Bs6AsxSH
 z+Jera0gGsM/sfEL4T8uuFktN5LH5WhFnIkg99MFK9iwv5Z8IIJj2Y+dDDo/3bnsnGiq
 fiFA==
X-Gm-Message-State: ANhLgQ09pvKDfvBAgs+KKZFTkrYUwZckSmUP5wBFh1W3j5CG00VAWoil
 new9LSNZIzCK6p2N5iM5CPAuxQ==
X-Google-Smtp-Source: ADFU+vvkPYt36yJF9sJ0+YXQ82JLuFkTGnrbLLLQhuMJS3GppTD6rY5AK5CjRhxEEc72c5377wrD9w==
X-Received: by 2002:adf:de0d:: with SMTP id b13mr27796587wrm.297.1583850555806; 
 Tue, 10 Mar 2020 07:29:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s13sm15093698wrw.29.2020.03.10.07.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 07:29:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C65C41FF7E;
 Tue, 10 Mar 2020 14:29:13 +0000 (GMT)
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-2-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/5] Makefile: Allow for subdirectories in Sphinx manual
 dependencies
In-reply-to: <20200309215818.2021-2-peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 14:29:13 +0000
Message-ID: <87d09ki8qu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Currently we put 'docs/foo/*.rst' in the Make list of dependencies
> for the Sphinx 'foo' manual, which means all the files must be
> in the top level of that manual's directory. We'd like to be
> able to have subdirectories inside some of the manuals, so add
> 'docs/foo/*/*.rst' to the dependencies too.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 2e930688942..5dba949947a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1081,7 +1081,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
>  # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
>  build-manual =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" $(SPHI=
NX_BUILD) $(if $(V),,-q) -W -b $2 -D version=3D$(VERSION) -D release=3D"$(F=
ULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 =
,"SPHINX","$(MANUAL_BUILDDIR)/$1")
>  # We assume all RST files in the manual's directory are used in it
> -manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
> +manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst $(SRC_PATH)/docs/$1=
/*/*.rst) \
>                $(SRC_PATH)/docs/defs.rst.inc \
>                $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
>  # Macro to write out the rule and dependencies for building manpages


--=20
Alex Benn=C3=A9e

