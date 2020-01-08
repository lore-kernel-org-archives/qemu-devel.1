Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADAAC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357332075D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI1b7lAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357332075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8tc-0002LV-Cb
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ip8su-0001vG-Bc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ip8ss-0002R4-Sy
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:48:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36791
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ip8ss-0002Qb-Pa
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578480498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3qYOahYJeE7qMzSZ4NIX+rDkd6puWt8RGy6TJ6GnYDY=;
 b=dI1b7lAUH9x7uufSiGg5zPrr6KmRbwdAk0cKdQ1WMkCny6V605BKFDU8Zb3qZdtuDNC4w2
 AtwTGnNL+F208sESy/5/wL5hvMDI7v60i/OOicqzIpWmWX1TxuloDKrMj4YIw/wjhZCEMa
 BCNW7JGBsS7YSr3DuaqFSRySCL4PWAw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-hlR0yXv1NLG2A7cEsiGlsA-1; Wed, 08 Jan 2020 05:48:16 -0500
Received: by mail-wm1-f72.google.com with SMTP id z2so292477wmf.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 02:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MIYeXQ3oEWfXa9GTaLH3sjQx2MPq4A21LtHJM/IyMn0=;
 b=EXeE4EVnftiEFV8PxQgG1wtqw0Q+hYeTS2FqbIqPyW7qVNtxv/g4Qlzx37LtdLfsJy
 mpFHVBu16QgpB3jcq2PwkNaDY1RZbezlMJXzz7ZrHtTWHxnVkjyn23rowC7cQ4p8Vp1z
 6HlZ39t+DHRDOqiokciUaec0OVuPHy9jKXC06BuzTm2YWKUb8FWfDszW3DF9H+nsL3GK
 Hh2GobW0PI8cSpZn3ZbWDhjqOnXs01y1PdC6YOHZ6l9kkduGmcjymEIfX9bZ9/Iaw3OK
 RijHew3tId5WZB/jjXk4Ih05ccgkEo5fswMBUeDsWEcyYrCEzZzx3NcHiGeQG47ZJ2yd
 Z0KA==
X-Gm-Message-State: APjAAAVeUZwCYheQhwxZ3hkx71lpn6T6fulh0P9+5ge4yIBAB+p+mwLs
 Biev69eRDHe7PsoG9gxqrvUNV4WTwmQjJV4btX/f5YMmHOzvfaVCHUG3Eatq7lbGFEOstAsjYEO
 QOiENmlEHElvlJPk=
X-Received: by 2002:adf:ea51:: with SMTP id j17mr3783644wrn.83.1578480494926; 
 Wed, 08 Jan 2020 02:48:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxP2l79zZZOyKYMOVCnN3ZhLnwejC311SdGol2Q1b7oLvoCAFwHRzo2da45Z6/TrqlOTm5KGg==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr3783625wrn.83.1578480494606; 
 Wed, 08 Jan 2020 02:48:14 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id c4sm3336770wml.7.2020.01.08.02.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 02:48:14 -0800 (PST)
Subject: Re: [PATCH v1 6/6] travis: install homebrew python for OS X
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200107135311.5215-1-alex.bennee@linaro.org>
 <20200107135311.5215-7-alex.bennee@linaro.org>
 <cf1af57a-c397-9503-cc49-a93dc58a2cc0@redhat.com> <87ftgqjuv2.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2313ed3f-ae42-c935-6a7b-a7ddfaa02720@redhat.com>
Date: Wed, 8 Jan 2020 11:48:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87ftgqjuv2.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: hlR0yXv1NLG2A7cEsiGlsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 1/8/20 8:00 AM, Alex Benn=C3=A9e wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>> On 1/7/20 2:53 PM, Alex Benn=C3=A9e wrote:
>>> Our python3 requirements now outstrip those of the build.
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>    .travis.yml | 1 +
>>>    1 file changed, 1 insertion(+)
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 848a2714efe..a86ca34f79d 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -57,6 +57,7 @@ addons:
>>>          - glib
>>>          - pixman
>>>          - gnu-sed
>>> +      - python
>>>        update: true
>>>   =20
>>
>> This doesn't seem enough, I'm getting:
>>
>> ./configure --disable-docs --disable-tools
>> ERROR: Cannot use '/usr/local/bin/python', Python >=3D 3.5 is required.
>>
>>         Use --python=3D/path/to/python to specify a supported Python.
>>
>> Apparently we don't set this in PATH ourselves.
>=20
> It looks like brew fell over:
>=20
>    =3D=3D> Downloading https://homebrew.bintray.com/bottles/python-3.7.6_=
1.mojave.bottl
>=20
>    =3D=3D> Downloading from https://akamai.bintray.com/64/643d627c2b4fc03=
a3286c397d2992
>=20
>    ######################################################################=
## 100.0%
>=20
>    =3D=3D> Pouring python-3.7.6_1.mojave.bottle.tar.gz
>=20
>    Error: The `brew link` step did not complete successfully
>=20
>    The formula built, but is not symlinked into /usr/local
>=20
>    Could not symlink Frameworks/Python.framework/Headers
>=20
>    Target /usr/local/Frameworks/Python.framework/Headers
>=20
>    is a symlink belonging to python@2. You can unlink it:
>=20
>      brew unlink python@2
>=20
>    To force the link and overwrite all conflicting files:
>=20
>      brew link --overwrite python
>=20
>    To list all files that would be deleted:
>=20
>      brew link --overwrite --dry-run python
>=20
>    Possible conflicting files are:
>=20
>    /usr/local/Frameworks/Python.framework/Headers -> /usr/local/Cellar/py=
thon@2/2.7.17/Frameworks/Python.framework/Headers
>=20
>    /usr/local/Frameworks/Python.framework/Python -> /usr/local/Cellar/pyt=
hon@2/2.7.17/Frameworks/Python.framework/Python
>=20
>    /usr/local/Frameworks/Python.framework/Resources -> /usr/local/Cellar/=
python@2/2.7.17/Frameworks/Python.framework/Resources
>=20
>    /usr/local/Frameworks/Python.framework/Versions/Current -> /usr/local/=
Cellar/python@2/2.7.17/Frameworks/Python.framework/Versions/Current
>=20
>    =3D=3D> /usr/local/Cellar/python/3.7.6_1/bin/python3 -s setup.py --no-=
user-cfg insta
>=20
>    =3D=3D> /usr/local/Cellar/python/3.7.6_1/bin/python3 -s setup.py --no-=
user-cfg insta
>=20
>    =3D=3D> /usr/local/Cellar/python/3.7.6_1/bin/python3 -s setup.py --no-=
user-cfg insta
>=20
>    =3D=3D> Caveats
>=20
>    Python has been installed as
>=20
>      /usr/local/bin/python3

Based on this I tried:

-- >8 --
  before_script:
-  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ] ; then export=20
PATH=3D"/usr/local/opt/ccache/libexec:$PATH" ; fi
+  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ] ; then export=20
PATH=3D"/usr/local/opt/ccache/libexec:$PATH" BASE_CONFIG=3D"$BASE_CONFIG=20
--python=3D/usr/local/bin/python3"; fi
    - if command -v ccache ; then ccache --zero-stats ; fi
    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
    - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log=20
&& exit 1; }
---

Still:

../configure: line 1845: /usr/local/bin/python3: No such file or directory

ERROR: Cannot use '/usr/local/bin/python3', Python >=3D 3.5 is required.

        Use --python=3D/path/to/python to specify a supported Python.

>=20
>    Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
>=20
>    `python3`, `python3-config`, `pip3` etc., respectively, have been inst=
alled into
>=20
>      /usr/local/opt/python/libexec/bin
>=20
>    If you need Homebrew's Python 2.7 run
>=20
>      brew install python@2
>=20
>    You can install Python packages with
>=20
>      pip3 install <package>
>=20
>    They will install into the site-package directory
>=20
>      /usr/local/lib/python3.7/site-packages
>=20
>    See: https://docs.brew.sh/Homebrew-and-Python
>=20
>    =3D=3D> Summary
>=20
>    =F0=9F=8D=BA  /usr/local/Cellar/python/3.7.6_1: 3,977 files, 60.8MB
>=20


