Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67AFCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741512082C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBXaLDiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741512082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUed-0002Py-IJ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iLUcN-0000Yd-45
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iLUcL-0000ya-PW
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:56:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iLUcL-0000xh-IC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:56:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id t16so1686187wrr.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Y+Myqfhf2aMdRcDvSgdf44eOFjdUDOf+Xb6lNHTRiDI=;
 b=TBXaLDiFRA2P6IzaVHca6I3Fep70DX7ttPr3+46Mg3N6jFbygLo/S4omf2m2LL1iS6
 WjieD2oA6Xr/3yKRAtuteuuEdugu9WkYMNQL0xvT6qI5ZRsEZuc9RIYyv7xkb8C/BE4A
 YMzbYMypIZjvEJV6Up8WB6TFXNwAKk0ZI2rc2vVQd9SbbVA+9U7tIm3WSWikk+YiRImL
 C0P9efpIltsQF8ig8iYaj/io3kXyENEXETw7zF+4VAMQ33tGhLYs7LTPVhryJzfWpp7v
 hriJRhJbOaIuYmxDCYiIAWc/b6NhSp388BDKbovftbluxHpqSNtHU+dL7bt7NPwzIqPN
 UDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Y+Myqfhf2aMdRcDvSgdf44eOFjdUDOf+Xb6lNHTRiDI=;
 b=qB2iFdg12JAF0ezYEj+ll9QxSL5Z6U50RBf74lOmmYgRTlZ7WwIKMVJEaaRCiAQipO
 3/LT3f5qMe0axTTKGDmUsPSi6l5vfrh8i4RXtEgLAwPbd4oECwvCG1pGNT7RwRAzMoWI
 Ae8AXM0yp8wPsARuA5NImim+6ULgcN9QilDkNrf7xyUt1IkTz6K92in9tkMNjSaCUVVp
 EoeDN2r6r4oZUIDiwaZ7YKlcq6w5lZ4NpwSLheM7FPhi99/otfBceWEyPtuUvtSAPoKN
 vq2N1l/FqrUnXuwhN/z12oj33EnIp5vKB497crz3Wdh2nURKwTdtklzmau8oeSqRMjWk
 FUsQ==
X-Gm-Message-State: APjAAAVF5ZwyOuZWHJdLhaWyViM0GK5GFYlmQl4TohECs5fVHmcHxAEZ
 8twNJc96n60pzlcrFGBT0wBiwg==
X-Google-Smtp-Source: APXvYqzpP2KkPZ1TBLAlRxJPIDwBWZ8er2a6XreyLRtvmHEjTNEgTvEJs6E/RyhBhAH5dT39Ezq5uw==
X-Received: by 2002:adf:94e2:: with SMTP id 89mr7597687wrr.259.1571414200184; 
 Fri, 18 Oct 2019 08:56:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u11sm5612208wmd.32.2019.10.18.08.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 08:56:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D22551FF87;
 Fri, 18 Oct 2019 16:56:38 +0100 (BST)
References: <20191007160450.3619-1-philmd@redhat.com>
 <4fbafa72-321c-2062-f97e-502616ec6c32@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] .travis.yml: Test the release tarball
In-reply-to: <4fbafa72-321c-2062-f97e-502616ec6c32@redhat.com>
Date: Fri, 18 Oct 2019 16:56:38 +0100
Message-ID: <87v9smnj2h.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> ping?

I've pulled it into testing/next to play but I was wondering if it was
worth it given how infrequently it would run...


>
> On 10/7/19 6:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Add a job to generate the release tarball and build/install few
>> QEMU targets from it.
>> Ideally we should build the 'efi' target from the 'roms' directory,
>> but it is too time consuming.
>> This job is only triggered when a tag starting with 'v' is pushed,
>> which is the case with release candidate tags.
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> v2: addressed mdroth comments
>> This job is quick enough: Ran for 16 min 33 sec
>> https://travis-ci.org/philmd/qemu/jobs/594565293
>> Based-on: <20191007133540.30623-1-philmd@redhat.com>
>> pull request including "Fix tarball builds of UEFI/EDK2 firmware"
>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02734.html
>> ---
>>   .travis.yml | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>> diff --git a/.travis.yml b/.travis.yml
>> index d0b9e099b9..d881ea0849 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -339,3 +339,26 @@ matrix:
>>           - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64=
-softmmu,alpha-softmmu"
>>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>> +
>> +
>> +    # Release builds
>> +    # The make-release script expect a QEMU version, so our tag must st=
art with a 'v'.
>> +    # This is the case when release candidate tags are created.
>> +    - if: tag IS present AND tag =3D~ /^v\d+\.\d+(\.\d+)?(-\S*)?$/
>> +      env:
>> +        # We want to build from the release tarball
>> +        - BUILD_DIR=3D"release/build/dir" SRC_DIR=3D"../../.."
>> +        - BASE_CONFIG=3D"--prefix=3D$PWD/dist"
>> +        - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-softmmu,arme=
b-linux-user,ppc-linux-user"
>> +        - TEST_CMD=3D"make install -j3"
>> +        - QEMU_VERSION=3D"${TRAVIS_TAG:1}"
>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>> +      before_script:
>> +        - command -v ccache && ccache --zero-stats
>> +        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>> +      script:
>> +        - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
>> +        - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
>> +        - tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-${=
QEMU_VERSION}
>> +        - ./configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && e=
xit 1; }
>> +        - make install
>>


--
Alex Benn=C3=A9e

