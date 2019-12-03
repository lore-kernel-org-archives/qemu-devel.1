Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7542C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717D8206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPLkKMfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717D8206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic5Ci-0005zt-M3
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 05:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ic582-00049l-Qj
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ic57x-0001cp-7W
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:09:54 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ic57v-0001N6-Qn
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:09:53 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so2337334wmg.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 02:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GoSvpWzznq9OrdbAZELxrVFjvYwwhZel/d2luQ7Diso=;
 b=HPLkKMfg0bUyRiRsE8uw1uYYM4gBzHQshkm464kawk6lyAIDY4RrtzvtCWHOrRoV/8
 abJ5tylspCxjr/rzd7p0nf74jr9uRKWtzrpoq+zX1g9lP0Vy1F7fAA6IjlpUGeYPW9bq
 0rX/77KqKV0ALsmomA2taixu73XsgUe6pBMMO4j4AX1s6Ug5Jpzwx2GlIWPWko4kXavh
 dP6AMFXE3EdgM58MfqvZUJbyPeDHX94xNMK0yWzr1eVrzIrFx4mtPxMPZJncZ7J7n3HO
 c7DaIf2haElEs9IHGsaw/3UVtgM57xlzki22cp6w0qIJdpevYG93y0vYXIoaOFOfbPiI
 NB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GoSvpWzznq9OrdbAZELxrVFjvYwwhZel/d2luQ7Diso=;
 b=dB1Ecf5nk85SDEFPQFdkFroK4uM6RZz73OmpNs8YaoxIeM96aHfRjqqSt0CGHszFd+
 M+SOc9F80SDrjQgKN8nur8ZacHM1jZWWtt/xJ88p3oh/pvhLFviTcEhSraKR60ZXJ4h7
 owuW+MBZ8zrsgEF7pdNqfGmmXHsYWZffgABXLWZe+SyV+adn+1prgk9UxCXaslkOF1br
 vESeqkoPov42E5coh0DBBeT3GFDwhQxdOMY24stol1qwIXqhNJya4tXMPfv8Bv+hkm+y
 ADCM8I+OxHEK2M3bAn1LVDh3gZkS5ozR2uhvfa4QiMwJyRYgr0d9NyiRAiewoDci3bfn
 RuoA==
X-Gm-Message-State: APjAAAWs6TYeU/hgfTIFPt8PBG7ul7y6IPmZSWy1eeJEy/cPkV+kx4By
 6qKDtp3cXjjsfjOgr3jac2+VOA==
X-Google-Smtp-Source: APXvYqx7O//tC3aXaSW/d3kkTwEbvtQ6O0Md6d88+uixooNpTDDEl1HwUEACSVwhRboea48Dq0cpvA==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr20031554wmk.94.1575367787223; 
 Tue, 03 Dec 2019 02:09:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i8sm3025965wro.47.2019.12.03.02.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 02:09:45 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DA76A1FF87;
 Tue,  3 Dec 2019 10:09:44 +0000 (GMT)
References: <20191202101631.10003-1-thuth@redhat.com>
 <20191202101631.10003-2-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/3] iotests: Provide a function for checking the
 creation of huge files
In-reply-to: <20191202101631.10003-2-thuth@redhat.com>
Date: Tue, 03 Dec 2019 10:09:44 +0000
Message-ID: <87r21lbtzr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Some tests create huge (but sparse) files, and to be able to run those
> tests in certain limited environments (like CI containers), we have to
> check for the possibility to create such files first. Thus let's introduce
> a common function to check for large files, and replace the already
> existing checks in the iotests 005 and 220 with this function.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/005       |  5 +----
>  tests/qemu-iotests/220       |  6 ++----
>  tests/qemu-iotests/common.rc | 10 ++++++++++
>  3 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
> index 58442762fe..b6d03ac37d 100755
> --- a/tests/qemu-iotests/005
> +++ b/tests/qemu-iotests/005
> @@ -59,10 +59,7 @@ fi
>  # Sanity check: For raw, we require a file system that permits the creat=
ion
>  # of a HUGE (but very sparse) file. Check we can create it before contin=
uing.
>  if [ "$IMGFMT" =3D "raw" ]; then
> -    if ! truncate --size=3D5T "$TEST_IMG"; then
> -        _notrun "file system on $TEST_DIR does not support large enough =
files"
> -    fi
> -    rm "$TEST_IMG"
> +    _require_large_file 5T
>  fi
>=20=20
>  echo
> diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
> index 2d62c5dcac..15159270d3 100755
> --- a/tests/qemu-iotests/220
> +++ b/tests/qemu-iotests/220
> @@ -42,10 +42,8 @@ echo "=3D=3D Creating huge file =3D=3D"
>=20=20
>  # Sanity check: We require a file system that permits the creation
>  # of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
> -if ! truncate --size=3D513T "$TEST_IMG"; then
> -    _notrun "file system on $TEST_DIR does not support large enough file=
s"
> -fi
> -rm "$TEST_IMG"
> +_require_large_file 513T
> +
>  IMGOPTS=3D'cluster_size=3D2M,refcount_bits=3D1' _make_test_img 513T
>=20=20
>  echo "=3D=3D Populating refcounts =3D=3D"
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 38e949cf69..91c0217e59 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -657,5 +657,15 @@ _require_devices()
>      done
>  }
>=20=20
> +# Check that we have a file system that allows huge (but very sparse) fi=
les
> +#
> +_require_large_file()
> +{
> +    if ! truncate --size=3D"$1" "$TEST_IMG"; then
> +        _notrun "file system on $TEST_DIR does not support large enough =
files"
> +    fi
> +    rm "$TEST_IMG"
> +}
> +
>  # make sure this script returns success
>  true


--=20
Alex Benn=C3=A9e

