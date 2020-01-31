Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248EEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E3C2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqjCyVZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E3C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZ2p-0003Rw-4N
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixY6U-0008Db-8C
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixY6S-0005Hq-85
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:21:05 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixY6R-00058Q-Ob
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:21:04 -0500
Received: by mail-wm1-x342.google.com with SMTP id m10so9051250wmc.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MXOi1qvLvE3KNt33S4qvG4RLPUd9orOU/oy9xupr8AY=;
 b=VqjCyVZ5xnkSxVPwwXy00UB/cvQceUwBcmIJqkKfj+ZtQjow3k8oiPnV8SgyIaZ2cV
 HXSjNNih5ZM6DIzAjEFhWmrxwWEMGc9fxVRHX08dFUxUbWYWFCWH/MI9+mFwGaqg7jA4
 Jv1A9ZDSE/UsvI1QYV4CxbY9SZ8k4VTAutF7u5QNvHXb3rPUH2mkv0oZzlnKx/m/gZ7B
 N2JLIoYlsG9hP9QKdmhSzo1bkMREyGL3AvzPHuP9XJh5PtjexM761vTEPNbaTWzNvuFk
 rk7pnKRQW2MTCfUrtTXEkEb2+hmmpbGKCV+CIUTxIH6ctzu10er1D855QQK7emHHKsVN
 n8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MXOi1qvLvE3KNt33S4qvG4RLPUd9orOU/oy9xupr8AY=;
 b=PlxcMYF4jMXER8YKtFnUQ5TzQTVjCp1wfIKIdr8PtUjbKpIdtkH4Pjmh4tVPoAnwRQ
 SviX+XVc8bCLAPWTKXx64MryS09vb8bbtat/tRSHzzEFOdXhmCxefPnGEKAk8OqZLD+d
 rSQda6JZHyyGFg+Wd6AvLfH5Xqxqw2AZvDr1HmSAGwu4FjRBSFawnLgWNDLE6DkhEbGr
 gQWCLvZ3XqTyI30e/gmoMvIpBaR935d8w2KlWfkmdvnCydO7qUYp+q6Gx9oCka8mkQoc
 +G1Xb4B8JO5Z89sTchlIuSA33Qgr2NuwrRojKif93sO0SsVbJoiydx8UTAboflQSfro/
 12fA==
X-Gm-Message-State: APjAAAXgWFxxLXN8HbBD8KhDzWA/FhZCXS44QE5uul0Pb7rJCCy6Je7d
 UlghaCoJz0Q7WDAeLb1E8R1zUg==
X-Google-Smtp-Source: APXvYqxhdymk8tpkDcu2P7lgJVcHoxZ8MG0vDJHOxSiBtvrDEsMFEUlbNWF639P5OVYNXXypFnrLVg==
X-Received: by 2002:a05:600c:292:: with SMTP id
 18mr13357407wmk.128.1580484061213; 
 Fri, 31 Jan 2020 07:21:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d23sm12430172wra.30.2020.01.31.07.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 07:21:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 51C4B1FF87;
 Fri, 31 Jan 2020 15:20:59 +0000 (GMT)
References: <20200124162606.8787-1-peter.maydell@linaro.org>
 <20200124162606.8787-2-peter.maydell@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 1/8] Makefile: Ensure we don't run Sphinx in parallel
 for manpages
In-reply-to: <20200124162606.8787-2-peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 15:20:59 +0000
Message-ID: <878sln8xes.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Sphinx will corrupt its doctree cache if we run two copies
> of it in parallel. In commit 6bda415c10d966c8d3 we worked
> around this by having separate doctrees for 'html' vs 'manpage'
> runs. However now that we have more than one manpage produced
> from a single manual we can run into this again when trying
> to produce the two manpages.
>
> Use the trick described in 'Atomic Rules in GNU Make'
> https://www.cmcrossroads.com/article/atomic-rules-gnu-make
> to ensure that we only run the Sphinx manpage builder once
> for each manual, even if we're producing several manpages.
> This fixes doctree corruption in parallel builds and also
> avoids pointlessly running Sphinx more often than we need to.
>
> (In GNU Make 4.3 there is builtin support for this, via
> the "&:" syntax, but we can't wait for that to be available
> in all the distros we support...)
>
> The generic "one invocation for multiple output files"
> machinery is provided as a macro named 'atomic' in rules.mak;
> we then wrap this in a more specific macro for defining
> the rule and dependencies for the manpages in a Sphinx
> manual, to avoid excessive repetition.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I won't claim I fully follow the invocation but it works and I have
tested it.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  Makefile  | 17 ++++++++++-------
>  rules.mak | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 04c77d3b962..9b7ff1dc82f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1028,6 +1028,14 @@ build-manual =3D $(call quiet-command,CONFDIR=3D"$=
(qemu_confdir)" sphinx-build $(if
>  manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
>                $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) \
>                $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
> +# Macro to write out the rule and dependencies for building manpages
> +# Usage: $(call define-manpage-rule,manualname,manpage1 manpage2...[,ext=
radeps])
> +# 'extradeps' is optional, and specifies extra files (eg .hx files) that
> +# the manual page depends on.
> +define define-manpage-rule
> +$(call atomic,$(foreach manpage,$2,$(MANUAL_BUILDDIR)/$1/$(manpage)),$(c=
all manual-deps,$1) $3)
> +	$(call build-manual,$1,man)
> +endef
>=20=20
>  $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
>  	$(call build-manual,devel,html)
> @@ -1041,14 +1049,9 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual=
-deps,specs)
>  $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
>  	$(call build-manual,system,html)
>=20=20
> -$(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
> -	$(call build-manual,interop,man)
> +$(call define-manpage-rule,interop,qemu-ga.8 qemu-nbd.8)
>=20=20
> -$(MANUAL_BUILDDIR)/interop/qemu-nbd.8: $(call manual-deps,interop)
> -	$(call build-manual,interop,man)
> -
> -$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7: $(call manual-deps,syste=
m)
> -	$(call build-manual,system,man)
> +$(call define-manpage-rule,system,qemu-block-drivers.7)
>=20=20
>  $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-versi=
on.h
>  	@mkdir -p "$(MANUAL_BUILDDIR)"
> diff --git a/rules.mak b/rules.mak
> index 967295dd2b6..50f6776f529 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -399,3 +399,39 @@ GEN_SUBST =3D $(call quiet-command, \
>=20=20
>  %.json: %.json.in
>  	$(call GEN_SUBST)
> +
> +# Support for building multiple output files by atomically executing
> +# a single rule which depends on several input files (so the rule
> +# will be executed exactly once, not once per output file, and
> +# not multiple times in parallel.) For more explanation see:
> +# https://www.cmcrossroads.com/article/atomic-rules-gnu-make
> +
> +# Given a space-separated list of filenames, create the name of
> +# a 'sentinel' file to use to indicate that they have been built.
> +# We use fixed text on the end to avoid accidentally triggering
> +# automatic pattern rules, and . on the start to make the file
> +# not show up in ls output.
> +sentinel =3D .$(subst $(SPACE),_,$(subst /,_,$1)).sentinel.
> +
> +# Define an atomic rule that builds multiple outputs from multiple input=
s.
> +# To use:
> +#    $(call atomic,out1 out2 ...,in1 in2 ...)
> +#    <TAB>rule to do the operation
> +#
> +# Make 4.3 will have native support for this, and you would be able
> +# to instead write:
> +#    out1 out2 ... &: in1 in2 ...
> +#    <TAB>rule to do the operation
> +#
> +# The way this works is that it creates a make rule
> +# "out1 out2 ... : sentinel-file ; @:" which says that the sentinel
> +# depends on the dependencies, and the rule to do that is "do nothing".
> +# Then we have a rule
> +# "sentinel-file : in1 in2 ..."
> +# whose commands start with "touch sentinel-file" and then continue
> +# with the rule text provided by the user of this 'atomic' function.
> +# The foreach... is there to delete the sentinel file if any of the
> +# output files don't exist, so that we correctly rebuild in that situati=
on.
> +atomic =3D $(eval $1: $(call sentinel,$1) ; @:) \
> +         $(call sentinel,$1) : $2 ; @touch $$@ \
> +         $(foreach t,$1,$(if $(wildcard $t),,$(shell rm -f $(call sentin=
el,$1))))


--=20
Alex Benn=C3=A9e

