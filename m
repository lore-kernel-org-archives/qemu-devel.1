Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCC0C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 07:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780192073A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 07:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLi0g+jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780192073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip5Kz-0005yZ-IK
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 02:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ip5KL-0005So-Bs
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 02:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ip5KH-0003lf-Tm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 02:00:24 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ip5KH-0003kq-Lg
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 02:00:21 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so2155247wrh.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ewQd+C1t88jfyOsiU1eMLl2xqapKklP+pItePh/Dt5Y=;
 b=GLi0g+jScWnF26ANMRhoCx7O10p+lI4Fp2iu2SluK8upXyyAGIHQ8pjJYGXCejp+GQ
 SCBtMTCog/I+JdTMzXgsW6ln1TvCKkLbRpTnk6lJvTwBYnuwmZvrJx+BNyi5C94PEtJ4
 Cu3vXCJtghDIWLLQknjI3YQSoCUtmHNBVb8pN7tvzasumTxiQnbei4YjuniZoNvuuiQa
 mO2y30dN0qXyqztolINrUtUlQ29sFOdkq+/u61E5t11CkYv/+U6QivWi9svTtbwlVgg+
 B6Dw+9udrQfQeivqVTJl1Bz/rkULIJR6V7UmTXiJCuQrVDkJINh8B9UXtIuxUoaps8rB
 j19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ewQd+C1t88jfyOsiU1eMLl2xqapKklP+pItePh/Dt5Y=;
 b=Y+Rj2rQc+ZEaC4SahuQeuNDS1Oi0sv0t99UrHdXR/04LrPgguVxsZdrqVV+Umh8gsW
 6hLy8KH4RpQYAjO6JEgMAUqbF9EG+7MeBzPN5pmvGgR/ToBB2QYhHmO+fR7GWICP63jF
 9UIL33E2pvux5lK6avthDeoGaBUIoztttzRXVgl9xDu54aHJEbPARKXmpGLhusBWc8s2
 2E6KGGQtmP1rDXohj73NrM6A/yPao09u7i6N3DWlrVK0nhK/4MQahwBOSAImg19Z5Q1S
 elokuTGo4QDuyjwI1qxTIewOa7oGDtao3Tn4VQ9bD8dUm+H8fs5Il7kLKXQDUb348lyl
 C6Hg==
X-Gm-Message-State: APjAAAWl51Z/0Lm3OcdenZL06FxYk4XFp6lmVW8e33Ccu2BgS19Ue5Wa
 ZcShpH2eHoMbINgFcI8oU8XbpQ==
X-Google-Smtp-Source: APXvYqzq/n/cE/YS2XXcpPBo+r404XtQXCZALkJ34KX8LQDXlh5E2r+1+ZutzsAtknC56jgExn3uIQ==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr2659541wru.154.1578466820118; 
 Tue, 07 Jan 2020 23:00:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p15sm2451143wma.40.2020.01.07.23.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 23:00:18 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 036431FF87;
 Wed,  8 Jan 2020 07:00:18 +0000 (GMT)
References: <20200107135311.5215-1-alex.bennee@linaro.org>
 <20200107135311.5215-7-alex.bennee@linaro.org>
 <cf1af57a-c397-9503-cc49-a93dc58a2cc0@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v1 6/6] travis: install homebrew python for OS X
In-reply-to: <cf1af57a-c397-9503-cc49-a93dc58a2cc0@redhat.com>
Date: Wed, 08 Jan 2020 07:00:17 +0000
Message-ID: <87ftgqjuv2.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 1/7/20 2:53 PM, Alex Benn=C3=A9e wrote:
>> Our python3 requirements now outstrip those of the build.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .travis.yml | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git a/.travis.yml b/.travis.yml
>> index 848a2714efe..a86ca34f79d 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -57,6 +57,7 @@ addons:
>>         - glib
>>         - pixman
>>         - gnu-sed
>> +      - python
>>       update: true
>>=20=20=20
>
> This doesn't seem enough, I'm getting:
>
> ./configure --disable-docs --disable-tools
> ERROR: Cannot use '/usr/local/bin/python', Python >=3D 3.5 is required.
>
>        Use --python=3D/path/to/python to specify a supported Python.
>
> Apparently we don't set this in PATH ourselves.

It looks like brew fell over:

  =3D=3D> Downloading https://homebrew.bintray.com/bottles/python-3.7.6_1.m=
ojave.bottl

  =3D=3D> Downloading from https://akamai.bintray.com/64/643d627c2b4fc03a32=
86c397d2992

  ######################################################################## =
100.0%

  =3D=3D> Pouring python-3.7.6_1.mojave.bottle.tar.gz

  Error: The `brew link` step did not complete successfully

  The formula built, but is not symlinked into /usr/local

  Could not symlink Frameworks/Python.framework/Headers

  Target /usr/local/Frameworks/Python.framework/Headers

  is a symlink belonging to python@2. You can unlink it:

    brew unlink python@2

  To force the link and overwrite all conflicting files:

    brew link --overwrite python

  To list all files that would be deleted:

    brew link --overwrite --dry-run python

  Possible conflicting files are:

  /usr/local/Frameworks/Python.framework/Headers -> /usr/local/Cellar/pytho=
n@2/2.7.17/Frameworks/Python.framework/Headers

  /usr/local/Frameworks/Python.framework/Python -> /usr/local/Cellar/python=
@2/2.7.17/Frameworks/Python.framework/Python

  /usr/local/Frameworks/Python.framework/Resources -> /usr/local/Cellar/pyt=
hon@2/2.7.17/Frameworks/Python.framework/Resources

  /usr/local/Frameworks/Python.framework/Versions/Current -> /usr/local/Cel=
lar/python@2/2.7.17/Frameworks/Python.framework/Versions/Current

  =3D=3D> /usr/local/Cellar/python/3.7.6_1/bin/python3 -s setup.py --no-use=
r-cfg insta

  =3D=3D> /usr/local/Cellar/python/3.7.6_1/bin/python3 -s setup.py --no-use=
r-cfg insta

  =3D=3D> /usr/local/Cellar/python/3.7.6_1/bin/python3 -s setup.py --no-use=
r-cfg insta

  =3D=3D> Caveats

  Python has been installed as

    /usr/local/bin/python3

  Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to

  `python3`, `python3-config`, `pip3` etc., respectively, have been install=
ed into

    /usr/local/opt/python/libexec/bin

  If you need Homebrew's Python 2.7 run

    brew install python@2

  You can install Python packages with

    pip3 install <package>

  They will install into the site-package directory

    /usr/local/lib/python3.7/site-packages

  See: https://docs.brew.sh/Homebrew-and-Python

  =3D=3D> Summary

  =F0=9F=8D=BA  /usr/local/Cellar/python/3.7.6_1: 3,977 files, 60.8MB

--=20
Alex Benn=C3=A9e

