Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFFFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075FA2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCkYPf9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075FA2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVl1-0001L6-0h
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLVk0-0000QW-Vn
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLVjz-0002Yu-OU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:08:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLVjz-0002YP-AE
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571418517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXGwq7satY0SL/cS2CzEgbJS0cYj7J5feez3/pDUP94=;
 b=cCkYPf9YOq+WBLw/9d8KGejYjylxzwd43NIRp8jqrxdXgEa5e+jNWWXQFz2ow5xXpHIhS9
 J3EqXGV6tYW6C+qAeaBFuvXjh9LJSTUv4ZRxWkr/W4SRg/s5Rdh/ZoCl3zaqtyN4/8kaA3
 d3RCJfiD3egg2n8/Y049WyYwMklShKs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-1VYITBcDP4y2Q1YODPqQEQ-1; Fri, 18 Oct 2019 13:08:34 -0400
Received: by mail-wm1-f71.google.com with SMTP id g67so2592434wmg.4
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yg31NkL/u8KHyGmrjmGF2gQvSSP84/j0Vs1bd0WsxgA=;
 b=eh2mHGlGKE3lpCIbNPpat6oMDpdKt96yQH+bcS1gmjqt/rpJXJbGtPSYwKUr6rePr8
 Me37D+qkKoSMsW5gIJco2d7PeVJTGErVbcYPydtD8p7gQ6DQ2erWeJSlXxtTODzZgtR9
 DQ1WY1YKOruVKfhGkr1syLDBTbfi1owzAOyDaBkifht1qP7zQpHJj+nYtFT1KALblXP1
 183J3osrVikVtGvz9npL4zkluL0ZeF0q6VDDBZzIcPJaCYC/s39NXfIg6M5SDQlZllvT
 Uu4QNU2tZvlnvJ4kxXhj0ommT+gu3gse5Ly/8ET7VO8ZfFUM9wxgm45Vrvm2ody2rozD
 pqsw==
X-Gm-Message-State: APjAAAV/ieqQnM0rb47CDZX+lv/LWZNJXWr3AWizpgSrO74cOBp4ppk/
 3qCEkt0MYruAPTCzIaIuGfoxWihYsAyvTcwocRFK6KNA+MUb2/SNp6OxLF3yGUBJRzrhQgsKvgG
 ZLlYKnO93nqMlXf4=
X-Received: by 2002:adf:fe10:: with SMTP id n16mr9272897wrr.288.1571418512954; 
 Fri, 18 Oct 2019 10:08:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzACGUco+CIdwKaVFRn3TA87hhQr6mRLKx+T2TtiDm5YG1doy87BBw82+uiyAR46Gt3R565vQ==
X-Received: by 2002:adf:fe10:: with SMTP id n16mr9272860wrr.288.1571418512633; 
 Fri, 18 Oct 2019 10:08:32 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id y19sm5760739wmi.13.2019.10.18.10.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 10:08:31 -0700 (PDT)
Subject: Re: [PATCH v2] .travis.yml: Test the release tarball
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191007160450.3619-1-philmd@redhat.com>
 <4fbafa72-321c-2062-f97e-502616ec6c32@redhat.com> <87v9smnj2h.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <85317436-ca1e-ce9c-2242-9c31ab6b4f9d@redhat.com>
Date: Fri, 18 Oct 2019 19:08:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87v9smnj2h.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: 1VYITBcDP4y2Q1YODPqQEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 10/18/19 5:56 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> ping?
>=20
> I've pulled it into testing/next to play but I was wondering if it was
> worth it given how infrequently it would run...

Well, it will run when we tag release candidate and catch eventual bugs=20
before we tag the final release. The idea is to avoid the same mistake=20
we did with the last release that Bruce spotted.

>> On 10/7/19 6:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Add a job to generate the release tarball and build/install few
>>> QEMU targets from it.
>>> Ideally we should build the 'efi' target from the 'roms' directory,
>>> but it is too time consuming.
>>> This job is only triggered when a tag starting with 'v' is pushed,
>>> which is the case with release candidate tags.
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> v2: addressed mdroth comments
>>> This job is quick enough: Ran for 16 min 33 sec
>>> https://travis-ci.org/philmd/qemu/jobs/594565293
>>> Based-on: <20191007133540.30623-1-philmd@redhat.com>
>>> pull request including "Fix tarball builds of UEFI/EDK2 firmware"
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02734.html
>>> ---
>>>    .travis.yml | 23 +++++++++++++++++++++++
>>>    1 file changed, 23 insertions(+)
>>> diff --git a/.travis.yml b/.travis.yml
>>> index d0b9e099b9..d881ea0849 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -339,3 +339,26 @@ matrix:
>>>            - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch=
64-softmmu,alpha-softmmu"
>>>            - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>>            - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>> +
>>> +
>>> +    # Release builds
>>> +    # The make-release script expect a QEMU version, so our tag must s=
tart with a 'v'.
>>> +    # This is the case when release candidate tags are created.
>>> +    - if: tag IS present AND tag =3D~ /^v\d+\.\d+(\.\d+)?(-\S*)?$/
>>> +      env:
>>> +        # We want to build from the release tarball
>>> +        - BUILD_DIR=3D"release/build/dir" SRC_DIR=3D"../../.."
>>> +        - BASE_CONFIG=3D"--prefix=3D$PWD/dist"
>>> +        - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-softmmu,arm=
eb-linux-user,ppc-linux-user"
>>> +        - TEST_CMD=3D"make install -j3"
>>> +        - QEMU_VERSION=3D"${TRAVIS_TAG:1}"
>>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>> +      before_script:
>>> +        - command -v ccache && ccache --zero-stats
>>> +        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>>> +      script:
>>> +        - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
>>> +        - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
>>> +        - tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-$=
{QEMU_VERSION}
>>> +        - ./configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && =
exit 1; }
>>> +        - make install
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20


