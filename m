Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941BCC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFC922244
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oP0bhcgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFC922244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWkY-0004Rr-Ap
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIWjW-0003Vn-N3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:40:22 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:35537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIWjU-0006y9-9i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:40:22 -0400
Received: by mail-ej1-x644.google.com with SMTP id u21so10164487eja.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kGZZ8aqSQk9cHzUIibLvZgqJ7ShiwOVZPvdjZ9DjNgs=;
 b=oP0bhcgTg6Y0BiYUXL9yKPKXHp71Ij3O7DOG4EoowS99f2oW1dn4wxmbtWHxcELhD/
 FeXMMwvJuB/ao2N3wm/Oe4bW0BcZRTNyFIqKEgFe9UWt0EBLvwtahA2T00arYlipXB+u
 UNlw7D8CUhhFGOcxqNnn4/2ECKJfVMMFa8BuDUKk0af5tiUyMNmVVOUKFpgdstPRQEA3
 roVHmPZ4guGjOqlrlNyxWAQFd+V5SccL6YROM5Nl8Aaq1rVehvCZ8pgZxi5C2Pm9gAmJ
 SIVyqnNSBH3O0eNJ9fdW044XYu8Ai5nnwq3mALIkA3fUGchlRQ4u51BR5zK2fMedOOtE
 a40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kGZZ8aqSQk9cHzUIibLvZgqJ7ShiwOVZPvdjZ9DjNgs=;
 b=pVb5KWemJPkC0S4h7m35wbnk8motp0Jk+mbLgSEtqYMCKW3YLrU5A5YfwrXTQ14akx
 slVuN7Zu2nDbzUCYWCEvcuNdW/a8NDIeBloDlZ+lBmpRm98ryRodvqHVEmlH/DsdKnRF
 nxBbhS9ZUYct52L4pX7B060PAGSfbvp60Oj+ztZHt7aBpFlgmPPBGrjM8Fp82Nbm87vA
 w4ygHcBv5qBM1RgCbYbXF09Nj0p3XfhlgLHqN9PAX85bRZxSkcx3C74nvvtna+5mbGcj
 y5GibDYQ08Ek6PRd/J+weEKPwfZRv0ZgGHSnegcgI0VlqMiWZdCuYM6ZML7wq9cfCVV3
 hK8w==
X-Gm-Message-State: AOAM532OzcKEzz60kmccWtbPX7sWDzpoqREe2ek/GY477KcwT5pxPKJK
 +JK0RbfT22BDqK1g2zDJ60rBEUPH8XwUCEaH0IPOSA==
X-Google-Smtp-Source: ABdhPJyGUaZzaR7a/6wMfmr7/7E1Yk/tBJ51Nfr9dGpLueJTbH+9JZIZF+06YlvB/hpxzwsi33x0rYZ7+e6UtwEae5c=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr24747960ejk.250.1600260018640; 
 Wed, 16 Sep 2020 05:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200916122648.17468-1-alex.bennee@linaro.org>
 <20200916122648.17468-8-alex.bennee@linaro.org>
In-Reply-To: <20200916122648.17468-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 Sep 2020 13:40:07 +0100
Message-ID: <CAFEAcA_UEoe2H5zc=L1T3p31FoxKSfG0mRznN-68FQmGTp3+pg@mail.gmail.com>
Subject: Re: [PULL 7/8] gitlab: create a build-deprecated target
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 13:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> These targets might be deprecated but we should keep them building
> before the final axe comes down. Lets keep them all in one place and
> don't hold up the CI if they do fail. They are either poorly tested or
> already flaky anyway.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20200915134317.11110-8-alex.bennee@linaro.org>
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 72e8604579ee..f027b55aef15 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -254,6 +254,16 @@ build-clang:
>        ppc-softmmu s390x-softmmu arm-linux-user
>      MAKE_CHECK_ARGS: check
>
> +# These targets are on the way out
> +build-deprecated:
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: debian-all-test-cross
> +    CONFIGURE_ARGS: --disable-docs --disable-tools --disable-system
> +    MAKE_CHECK_ARGS: check-tcg
> +    TARGETS: ppc64abi32-linux-user tilegx-linux-user
> +  allow_failure: true

It's kind of awkward to have the CI config need to be updated when
we mark a config as deprecated. Can we have something so that
the CI just arranges to build all of the deprecated targets?

(As demonstration, this list is missing unicore32, which is also deprecated=
.)

Also, "allow_failure: true" seems wrong to me. These targets
are only deprecated, which means we promise that the feature
should still work (to whatever extent it already did) for the 2
releases in which it is deprecated. We want our CI to tell us
if it fails to compile or fails tests, because we would need to
fix those bugs for a release.

thanks
-- PMM

