Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC4C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C20020644
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Avlu8ma9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C20020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrkE-0005E7-F6
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 15:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbrBz-0003Qn-QJ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 14:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbrBx-00083P-Pq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 14:44:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbrBv-0007w9-TH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 14:44:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id f9so3515501wre.12
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OcBis/Ewv7p/zpDngajbhGewfYZcG64k3XgPRs3kaNI=;
 b=Avlu8ma9AQsuiA9sB+IjSf3kUfuXp+/VvTX9BVguct65Yl8FlHWamB81tXHHDkj/6j
 a+HyHHEt5S8iShHkdDbYADrL9qoWLbeyauYxIoD6VEL7ieT8z8de+EhW8xBfvLMxe419
 qZBVCz0f7/kkNx4lRe2Ib2LOSv/8xWaHi7A46nca/4iemXOAvOxnmHbRvg6DKqb48A7h
 8WkyX/SdmAEUPd20ogBegFt608isQ6umKN6O7YTK7YimAlYelfoyMFDIxLysyPv18+nz
 GWPtUjfOZlfB8iiPnMyzmwzC6315Yk3jM7XnXsNVu5dg3csErqshW8ny0wLVlMmHgBtr
 E7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OcBis/Ewv7p/zpDngajbhGewfYZcG64k3XgPRs3kaNI=;
 b=j26ulx8pv+mqf87OFjUJvxq19HN7ABEsAF3aJ0wTIe8oK44Oh0608OeOVHOsAoYFHf
 Bd4R++6y4fkvNfX+inDIvCGa+UMWUg4OtlvJYI1/gcMBDgIY7q+glMIfikgf9bRX9NVF
 BbckGms5JH0dxxGftZqKIFAesuWzFZhSrvqgS37h9FV8dzc5U7WNdArYkP697TprtFcu
 6EsifsEKkQ86F8YlGLQxggUFnA7llubg6/lzL2LaRTRuQWVdFCuujcJ7DqiKkJQWaINI
 JFwZDy9R00Nh6O7AI6lC8h5uL2UAO/2x4c0bYZSjIRw3Ty4q0VHRiWOEIOvjH/WXWxmd
 JNiQ==
X-Gm-Message-State: APjAAAWbELfmEyTUzvENZRjLdijg5nKGpU9fkPh30l/TnF+j+MMaiueS
 pmE08KC4O4KrYZM1TULcDNlPUQ==
X-Google-Smtp-Source: APXvYqyL4RTHOGO+7O2qKV4L93OSy04f5h7cQ4vbGPF/tFv8YbaUrXPb9JDZkXk+5RKK5bhfnSerTg==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr3102741wrm.191.1560537882837; 
 Fri, 14 Jun 2019 11:44:42 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g19sm4583129wmg.10.2019.06.14.11.44.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 11:44:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DBC1B1FF87;
 Fri, 14 Jun 2019 19:44:41 +0100 (BST)
References: <20190311003052.13778-1-philmd@redhat.com>
 <20190311003052.13778-6-philmd@redhat.com>
 <ecd8aaf1-f75e-abd0-48b1-e80a227f01c3@redhat.com>
 <19958c32-2df9-cccf-3f05-c2fa0fe3dec2@redhat.com>
 <b8aad7bf-1dec-5c1d-1b76-d15b639e4953@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laszlo Ersek <lersek@redhat.com>
In-reply-to: <b8aad7bf-1dec-5c1d-1b76-d15b639e4953@redhat.com>
Date: Fri, 14 Jun 2019 19:44:41 +0100
Message-ID: <87tvcsc8h2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 5/5] .travis.yml: Build and install EDK2
 roms
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
Cc: Fam Zheng <fam@euphon.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michal =?utf-8?B?UHLDrXZvem7DrWs=?= <mprivozn@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laszlo Ersek <lersek@redhat.com> writes:

> On 06/13/19 18:59, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Laszlo,
>>
>> On 3/12/19 5:29 PM, Laszlo Ersek wrote:
>>> On 03/11/19 01:30, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Add a job to build and install the EDK2 platform firmware binaries.
>>>>
>>>> This job is only triggered if the last commit matches the EDK2
>>>> name (case insensitive), or when tag are created (such releases
>>>> or release candidates).
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>  .travis.yml | 21 +++++++++++++++++++++
>>>>  1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/.travis.yml b/.travis.yml
>>>> index e942175dd3..628cc52c99 100644
>>>> --- a/.travis.yml
>>>> +++ b/.travis.yml
>>>> @@ -258,3 +258,24 @@ matrix:
>>>>      - env:
>>>>          - CONFIG=3D"--disable-system"
>>>>          - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>>> +
>>>> +
>>>> +    # EDK2 roms builds
>>>> +    - if: tag IS present OR commit_message =3D~ /(edk2|EDK2)/
>>>> +      env:
>>>> +        - CONFIG=3D"--disable-system --disable-user --prefix=3D$PWD/d=
ist"
>>>> +        - EDK2_BUILD_OPTIONS=3D"--quiet --silent"
>>>> +      script:
>>>> +        - git submodule update --init roms/edk2
>>>> +        - make -j3
>>>> +        - make -C roms efi -j2
>>>> +        - make install
>>>> +      addons:
>>>> +        apt:
>>>> +          packages:
>>>> +            - dos2unix
>>>> +            - gcc-aarch64-linux-gnu
>>>> +            - gcc-arm-linux-gnueabihf
>>>> +            - iasl
>>>> +            - nasm
>>>> +            - uuid-dev
>>>>
>>>
>>> Regardless of what problem we're trying to address with "--quiet
>>> --silent", those options are wrong. You certainly want detailed build
>>> logs for the case a CI job fails (at build time or at runtime).
>>
>> On Travis we get:
>>
>> The job exceeded the maximum log length, and has been terminated.
>> (https://travis-ci.org/philmd/qemu/jobs/545329905)
>>
>> So I moved to GitLab, but we still get:
>>
>> "Job's log exceeded limit of 4194304 bytes."
>> (https://gitlab.com/philmd/qemu/-/jobs/230772314)
>>
>> Regarding the options to pass to edk2-build.sh,
>>
>> $ build --help
>>   -j LOGFILE, --log=3DLOGFILE
>>                    Put log in specified file as well as on console.
>>   -s, --silent     Make use of silent mode of (n)make.
>>   -q, --quiet      Disable all messages except FATAL ERRORS.
>>   -v, --verbose    Turn on verbose output with informational messages
>>                    printed, including library instances selected, final
>>                    dependency expression, and warning messages, etc.
>>
>> '--log' duplicate the output, and I don't want to reduce the log
>> details, so I understand I should use:
>>
>>   ./edk2-build.sh [...] --log=3Dbuild.log >/dev/null || cat build.log
>>
>> Is that correct? But then I'd need to modify Makefile.edk2 to redirect
>> stdout.
>
> Would it be possible to invoke the outermost make like this?
>
>   make -C roms -j2 efi >make.roms.efi.log 2>&1 \
>   || ( tail -c 2M make.roms.efi.log; false )

Or something like:

     after_failure:
       - tail -c 2M make.roms.efi.log

as Cleber suggested for his acceptance tests. Generally we want to try
and make the builds less noisy and only echo relevant details when it
fails. However we've tended to turn up the noise so we can debug stuff
and that is just painful to browser on the Travis website.


>
> Thanks
> Laszlo
>
>>
>>> The reason why I only include DEBUG firmware builds in the edk2 bundling
>>> series is similar -- RELEASE builds lack DEBUG messages and ASSERT()s,
>>> and as such they are 100% unsupportable in my book. Bugs in software are
>>> the norm, not the exception, so we should allow (even force) the user
>>> (and remote systems) to provide as much information as they can.
>>
>> Sure, we have the same book here ;)
>>
>> Regards,
>>
>> Phil.
>>


--
Alex Benn=C3=A9e

