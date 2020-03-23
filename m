Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB15DC4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FBD206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBWAWkN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FBD206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJtp-0007PD-Oa
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGJsE-0006L5-Gc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGJsD-0005uA-1e
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:59:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGJsC-0005tS-RD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:59:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id w10so16184807wrm.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IIS4HILaYdBqMIUTROjvK0RtCJdPWP6Rs7yVeXF5BeY=;
 b=pBWAWkN/sP/R3XvWhYAXatKpDfZqlKgAyQvMNhfuGKERtDglZDTVzXcnaCKMx2Rez7
 iRM7/XNSwJUIs8svbPwnSUFu3pyJOlv2BL9jRvmT8yJz59LMt8uNS2CkphFD8/2QwxFa
 6q7/ZCBx/VuoEiZ7LH1UW+Rc2hMxtGRjZ3ngUeK6eLouDoUh1waMUWwZ35XSSGgNEWfi
 NCzXiBRfGvWBQRd4emSnXsMEljP12KZNFsdJVCq382u/mZVWIKwzL0+IYCBjacZJKOJH
 jV2BVNJ6L0nct8HcqF2HO5cwAaAyVoUXiYEnsUk71RADWRax7MW+RmXPeEqpby4KP1mN
 LxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IIS4HILaYdBqMIUTROjvK0RtCJdPWP6Rs7yVeXF5BeY=;
 b=r40zP0xvQAbhz/JenN0Ntv/j/+tiEnYFCmUzN3msKLFRAcV9vCbP2rMkZ+jVboXwei
 3tE76wtas2GnAQk4c59zddN1WUoOh9Uoyqc5QA5b8WjJWiOBZ8gmZQqUUWUma2zU7s3N
 GrOunZVXmzqNBNUvavrwp0EmzEBRRQoopathg8Hlu2gMybTIPuHZVCFYnTJFk7oOjpAz
 E7qQqgC83sXmwO8FNlbB3WUyOkWX1nvKYjGmdHRLA7dQtB7iJEcfFKMmSPGfxonT7Nyv
 kYaR6UG9M+e06s4oHGd3jo38iDHEqkw6WGJADi5fVv7AHA1DSaJkWZXkNPj/xg7Gcbrn
 MXdg==
X-Gm-Message-State: ANhLgQ2qlkogxeb+C1mZG36kk2jzPBzXdTz53wlECHi+lga5mRwMHop+
 PRzAJw65/qrSOjbRg8nneLv3Zg==
X-Google-Smtp-Source: ADFU+vtaNapeC8Ec9gzzV0mKprxkuFp8QKDsO+viiLexvCPbDR98NwE9thK+llvyWZxenGXd96axwQ==
X-Received: by 2002:adf:de90:: with SMTP id w16mr16562436wrl.292.1584957595657; 
 Mon, 23 Mar 2020 02:59:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d206sm15737428wmf.29.2020.03.23.02.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 02:59:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2E3FA1FF7E;
 Mon, 23 Mar 2020 09:59:53 +0000 (GMT)
References: <20200322154015.25358-1-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] .travis.yml: Add a KVM-only s390x job
In-reply-to: <20200322154015.25358-1-philmd@redhat.com>
Date: Mon, 23 Mar 2020 09:59:53 +0000
Message-ID: <87k13bbdd2.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Add a job to build QEMU on s390x with TCG disabled, so
> this configuration won't bitrot over time.

Queued to testing/next, thanks.

This only tests the build though - we don't exercise KVM doing this.

>
> This job is quick, running check-unit: Ran for 5 min 30 sec
> https://travis-ci.org/github/philmd/qemu/jobs/665456423
>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .travis.yml | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 5672d129ec..e0c72210b7 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -525,6 +525,48 @@ jobs:
>                $(exit $BUILD_RC);
>            fi
>=20=20
> +    - name: "[s390x] GCC check (KVM)"
> +      arch: s390x
> +      dist: bionic
> +      addons:
> +        apt_packages:
> +          - libaio-dev
> +          - libattr1-dev
> +          - libbrlapi-dev
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
> +          # Tests dependencies
> +          - genisoimage
> +      env:
> +        - TEST_CMD=3D"make check-unit"
> +        - CONFIG=3D"--disable-containers --disable-tcg --enable-kvm --di=
sable-tools"
> +      script:
> +        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
> +        - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
> +        - |
> +          if [ "$BUILD_RC" -eq 0 ] ; then
> +              mv pc-bios/s390-ccw/*.img pc-bios/ ;
> +              ${TEST_CMD} ;
> +          else
> +              $(exit $BUILD_RC);
> +          fi
> +
>      # Release builds
>      # The make-release script expect a QEMU version, so our tag must sta=
rt with a 'v'.
>      # This is the case when release candidate tags are created.


--=20
Alex Benn=C3=A9e

