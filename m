Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27390C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24902068F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cP3MXqBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24902068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDi0-00083I-NJ
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iYDP3-0003vG-Dn
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iYDP1-0001Nf-Oy
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:11:33 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iYDP1-0001M3-Hb
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:11:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so9749028wrr.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 10:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BwfFxc3KNXpLlF0IGqIocM5VVr7KpNHDmYPPgGaTzo4=;
 b=cP3MXqByH/P1qn1CEREXo3AWpPvkMnd1ZxPEm3I7izZQkQ/aXyBo2PdmgBkk+Kz9/i
 ChL8OHPmVfEO4WjBluT83DitwjEYlDsjdJeUBuUoKinV1CCwOIQC5x9CSwZkPpwRQAiX
 5aGAluq4UaT44FOjusQJVU7Bw4I2W4lMtWPxkeXpGWXbIdymPUVXYk9EM++R8r2xj9Gz
 yx2XAk/Cgz4QaxV6IXozKlYBoNCVwFFar2e7e4md60IZXRDW8dZx3HQudp+gHF4dPaSq
 AlC1f9EycgQrRiQSo1pX3bhNcI/UOEYoozUa2YbLq1qdDmyB46NdFjcZxxAUtPT+Fx4p
 d3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BwfFxc3KNXpLlF0IGqIocM5VVr7KpNHDmYPPgGaTzo4=;
 b=othzKqGrl14iN7+E650KRTpqjbfso+7Lyxe8uP1RvyHoIfLUTEGzOv8k+uBC89vpCP
 +u+F83SMvClBSu2JjxE8aHyU6KbBdYqkmOjwF+mqlMw4h0lGJGSBYXmXQ5B4bgGSdKxN
 kWwTZ4DewUlNmt7vWPumMeMXboWLrV3kW6JlNVTq1F1XzMXgvvzzu3CmPvi813YGr5zu
 GXK6IueSFPF4P3LnB/zKlfDeOZi7/AdJx+tT4IbqmPXjBC7ckdqSLfM5A0GUxbU87mKF
 339ggbjZaKAdkK8VK5wCDUE5mPju1r4+L9d6rsyTQuH7REpFzjlGPkO4Wdm2zD2IZMvm
 obgQ==
X-Gm-Message-State: APjAAAUg7MpaXsAE/u/+B9zfGcyzNy50C7mZPhXaY17wqXCwYsJJlFvy
 tMG94ngTYPr/VMeVlox2kct8CQ==
X-Google-Smtp-Source: APXvYqxTP2FeR17o6JOxQ09L6pcUCwIOpe36IbCjrj/ZSrB3xUkWU3fkOPB3JyO4zepmBCcekl9AoA==
X-Received: by 2002:adf:f550:: with SMTP id j16mr20210269wrp.33.1574446289111; 
 Fri, 22 Nov 2019 10:11:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o1sm8941913wrs.50.2019.11.22.10.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 10:11:27 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 989EC1FF87;
 Fri, 22 Nov 2019 18:11:26 +0000 (GMT)
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-7-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 6/6] travis.yml: Enable builds on arm64, ppc64le and s390x
In-reply-to: <20191119170822.45649-7-thuth@redhat.com>
Date: Fri, 22 Nov 2019 18:11:26 +0000
Message-ID: <8736ef93xt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Travis recently added the possibility to test on these architectures,
> too, so let's enable them in our travis.yml file to extend our test
> coverage.

This is good as far as it goes but it would be nice to exercise the
respective TCG backends. If added two commits to:

  https://github.com/stsquad/qemu/commits/review/multiarch-testing

which allow for that. I'll know if they worked properly in a hour or two
once the testing has finished.

>
> Unfortunately, the libssh in this Ubuntu version (bionic) is in a pretty
> unusable Frankenstein state and libspice-server-dev is not available here,
> so we can not use the global list of packages to install, but have to
> provide individual package lists instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index c09b6a0014..cf48ee452c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -360,6 +360,89 @@ matrix:
>          - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>=20=20
> +    - arch: arm64
> +      addons:
> +        apt_packages:
> +          - libaio-dev
> +          - libattr1-dev
> +          - libbrlapi-dev
> +          - libcap-dev
> +          - libcap-ng-dev
> +          - libgcrypt20-dev
> +          - libgnutls28-dev
> +          - libgtk-3-dev
> +          - libiscsi-dev
> +          - liblttng-ust-dev
> +          - libncurses5-dev
> +          - libnfs-dev
> +          - libnss3-dev
> +          - libpixman-1-dev
> +          - libpng-dev
> +          - librados-dev
> +          - libsdl2-dev
> +          - libseccomp-dev
> +          - liburcu-dev
> +          - libusb-1.0-0-dev
> +          - libvdeplug-dev
> +          - libvte-2.91-dev
> +      env:
> +        - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS},x86_64-linux=
-user"
> +
> +    - arch: ppc64le
> +      addons:
> +        apt_packages:
> +          - libaio-dev
> +          - libattr1-dev
> +          - libbrlapi-dev
> +          - libcap-dev
> +          - libcap-ng-dev
> +          - libgcrypt20-dev
> +          - libgnutls28-dev
> +          - libgtk-3-dev
> +          - libiscsi-dev
> +          - liblttng-ust-dev
> +          - libncurses5-dev
> +          - libnfs-dev
> +          - libnss3-dev
> +          - libpixman-1-dev
> +          - libpng-dev
> +          - librados-dev
> +          - libsdl2-dev
> +          - libseccomp-dev
> +          - liburcu-dev
> +          - libusb-1.0-0-dev
> +          - libvdeplug-dev
> +          - libvte-2.91-dev
> +      env:
> +        - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS},x86_64-linux=
-user"
> +
> +    - arch: s390x
> +      addons:
> +        apt_packages:
> +          - libaio-dev
> +          - libattr1-dev
> +          - libbrlapi-dev
> +          - libcap-dev
> +          - libcap-ng-dev
> +          - libgcrypt20-dev
> +          - libgnutls28-dev
> +          - libgtk-3-dev
> +          - libiscsi-dev
> +          - liblttng-ust-dev
> +          - libncurses5-dev
> +          - libnfs-dev
> +          - libnss3-dev
> +          - libpixman-1-dev
> +          - libpng-dev
> +          - librados-dev
> +          - libsdl2-dev
> +          - libseccomp-dev
> +          - liburcu-dev
> +          - libusb-1.0-0-dev
> +          - libvdeplug-dev
> +          - libvte-2.91-dev
> +      env:
> +        - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS},x86_64-linux=
-user"
>=20=20
>      # Release builds
>      # The make-release script expect a QEMU version, so our tag must sta=
rt with a 'v'.


--=20
Alex Benn=C3=A9e

