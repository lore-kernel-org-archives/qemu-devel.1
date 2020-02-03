Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE68C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9127220838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxFCP2H/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9127220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygBx-0003oW-NM
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iygA6-0001w7-QD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iygA5-00059Q-Gt
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:09:30 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iygA5-00053u-91
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:09:29 -0500
Received: by mail-wr1-x441.google.com with SMTP id y11so19483979wrt.6
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 10:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EbpxSrriZA9kNXvoDhil1LWfBx0aG5U90532wLNVC60=;
 b=gxFCP2H/RX+X6FGp3r+32yh/oGOy46zhKEm8oTt7fuvpBIaxgL3KawvcDqEOcSlsLH
 EUqFGuk4af4TmJB7MH6rrWo6YZzDPaFUy9SFbQc0VXimPSqryCUwoJkIPUYyCGZ1DfaN
 i1rQwk9/GhrRVl+eleCuDFPv3K5mdCI6+LCYQWgIgj3G4kwpvdwVxt4qQmxB6M7PKlfp
 QKlU988SIYvZFzI9vedbmAoePduXpxFxQbfaGYgDYY8erfF9dCSKX8qiSqHugwSLdWeN
 mUvDRD57VRQypWGOvMGMg7D5GOI3zzfNZueQyo4HPNKKL31xEgEJCkpXKkdpMt8/xgCE
 o/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EbpxSrriZA9kNXvoDhil1LWfBx0aG5U90532wLNVC60=;
 b=f0wT/kEmvI8fV7KQ+O7mfD8pTAyZRoYBuqi/lSM2lykANpERd2vR9JZzky4rJ/UJMS
 hMrXMbEPcH+MyyErAzuQq5RnaDKwLZD4bhOVFnEDPjX2pO7QE7imaDlL2mdPWTQFERLD
 6UTpNsSxgjOW/eGmxcwqDP+0xYDL/yukNuHvLNl0ZZ+D0olAK7O81yIb/vqZx5i7eNrn
 psVdpJ/vwrxn/OxNnt5xs45ScyJFqzcv9GhCNo2qLs6HKF4FWpP0oUK6iOaUANhqYeDK
 rlW9SKysXjm7IZudDLM/0hfaFmwBnJIMLCotuNaDdaPKuEgbFyUqW53GyDggbLKM9s6n
 uBzg==
X-Gm-Message-State: APjAAAVETnCnEcvtAiEttLgWkPItj64OQnFYEf/Bqz39fS8+7rS8QGgP
 8gzwLNjIU8IqfsAtFuCc3lG1CA==
X-Google-Smtp-Source: APXvYqx2D1VpLs0PEo8hxSF/GWcL2AHDazLsiWSPcEhF7VhvBREeIYv/rugdzbxVXBciVC8mJb2iXg==
X-Received: by 2002:a05:6000:8c:: with SMTP id
 m12mr17306713wrx.142.1580753367769; 
 Mon, 03 Feb 2020 10:09:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c13sm16939236wrn.46.2020.02.03.10.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 10:09:26 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F29571FF87;
 Mon,  3 Feb 2020 18:09:25 +0000 (GMT)
References: <20200203132533.21850-1-peter.maydell@linaro.org>
 <20200203132533.21850-3-peter.maydell@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] configure: Check that sphinx-build is using Python 3
In-reply-to: <20200203132533.21850-3-peter.maydell@linaro.org>
Date: Mon, 03 Feb 2020 18:09:25 +0000
Message-ID: <8736bra6ga.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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


Peter Maydell <peter.maydell@linaro.org> writes:

> Currently configure's has_sphinx_build() check simply runs a dummy
> sphinx-build and either passes or fails.  This means that "no
> sphinx-build at all" and "sphinx-build exists but is too old" are
> both reported the same way.
>
> Further, we want to assume that all the Python we write is running
> with at least Python 3.5; configure checks that for our scripts, but
> Sphinx extensions run with whatever Python version sphinx-build
> itself is using.
>
> Add a check to our conf.py which makes sphinx-build fail if it would
> be running our extensions with an old Python, and handle this
> in configure so we can report failure helpfully to the user.
> This will mean that configure --enable-docs will fail like this
> if the sphinx-build provided is not suitable:
>
> Warning: sphinx-build exists but it is either too old or uses too old a P=
ython version
>
> ERROR: User requested feature docs
>        configure was not able to find it.
>        Install texinfo, Perl/perl-podlators and a Python 3 version of pyt=
hon-sphinx
>
> (As usual, the default is to simply not build the docs, as we would
> if sphinx-build wasn't present at all.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> At the moment our Sphinx extensions all work under Python 2;
> but the one for handling parsing QAPI docs out of the JSON is going
> to want to include some of the scripts/qapi Python which is more
> complicated and definitely now 3-only.  In any case it's nicer to
> fail cleanly rather than let users stumble into corner cases we don't
> test and don't want to support even if they happen to work today.
> ---
>  configure    | 12 ++++++++++--
>  docs/conf.py | 10 ++++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index 830f325822a..95055f2e9dd 100755
> --- a/configure
> +++ b/configure
> @@ -4808,11 +4808,19 @@ has_sphinx_build() {
>=20=20
>  # Check if tools are available to build documentation.
>  if test "$docs" !=3D "no" ; then
> -  if has makeinfo && has pod2man && has_sphinx_build; then
> +  if has_sphinx_build; then
> +    sphinx_ok=3Dyes
> +  else
> +    sphinx_ok=3Dno
> +  fi
> +  if has makeinfo && has pod2man && test "$sphinx_ok" =3D "yes"; then
>      docs=3Dyes
>    else
>      if test "$docs" =3D "yes" ; then
> -      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and=
 python-sphinx"
> +      if has $sphinx_build && test "$sphinx_ok" !=3D "yes"; then
> +        echo "Warning: $sphinx_build exists but it is either too old or =
uses too old a Python version" >&2
> +      fi
> +      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and=
 a Python 3 version of python-sphinx"
>      fi
>      docs=3Dno
>    fi
> diff --git a/docs/conf.py b/docs/conf.py
> index ee7faa6b4e7..7588bf192ee 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -28,6 +28,16 @@
>=20=20
>  import os
>  import sys
> +import sphinx
> +from sphinx.errors import VersionRequirementError
> +
> +# Make Sphinx fail cleanly if using an old Python, rather than obscurely
> +# failing because some code in one of our extensions doesn't work there.
> +# Unfortunately this doesn't display very neatly (there's an unavoidable
> +# Python backtrace) but at least the information gets printed...
> +if sys.version_info < (3,5):
> +    raise VersionRequirementError(
> +        "QEMU requires a Sphinx that uses Python 3.5 or better\n")
>=20=20
>  # The per-manual conf.py will set qemu_docdir for a single-manual build;
>  # otherwise set it here if this is an entire-manual-set build.


--=20
Alex Benn=C3=A9e

