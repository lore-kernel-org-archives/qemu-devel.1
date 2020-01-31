Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE633C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97A220663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7wOyYVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97A220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZ4z-0005qP-Sj
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixYAV-0004kq-47
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixYAT-0000KE-IJ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:25:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23100
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixYAT-0000GO-Db
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580484313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vryc8t50cLBetmKLobUSeCj25tJV2in60GpLagCTFo=;
 b=i7wOyYVAXtfpPyFVCggb/BdvFpcv4VSLAIFQ9A/b8YWTNpapJQZeR1DWqwgNkoMEmscAeg
 Y1DQNHC5YfE13r8OsswG6C2fzBbrWOZdHJNkIoppl4L37g/aZyZWCgcNyz/yXIAFDBDEZL
 e8KfE2N2eGbnZMsXIZfLzGEe2fIdpyo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-V4eO4ngXNpm0G5qx4Jwk5g-1; Fri, 31 Jan 2020 10:24:57 -0500
Received: by mail-wr1-f72.google.com with SMTP id v17so3477086wrm.17
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U/djChIU2KmYPwUFKm+/WsJ3L57FPdArNs8otnpi7Gw=;
 b=BKCLD0wRjWuAg31WKbK72pEchTD2IyZnzzCYcRrZM1To5KPoISVlGSLJCIZDy6p2L6
 af9YuVQbC1iE75BYMJPXm7mdtSkXEsGoy3augTM8Q6qQrok4xY3nKSnjofM9yNFs/Qy2
 /qVlS8ANVj911sN8GfSD9u3hjVO19dGuG3V7A84RM/NuhDv0U8CNGPsG7FswxkX1At3L
 MsS3X22FLyT9ISXnKMhelFNVD090WQug2GzqqsIQ/ixzija2sUgRC/ZbrI5BIqzPp7Nl
 AHhAKN2E6p4H2rdebvm280+Fwl7NIgeyR8kPue0Mj6CaFjzWjT+C20uM+KN6IQ/cRRGm
 cb/Q==
X-Gm-Message-State: APjAAAU/Llm3dDwwQ3brjj8mBPmQjJ+aK877Znj9ywJ0uKa52mGctN8i
 i6OU+OO5OWPl8aH6NkXl35cPjdScafrY4+VwSswBV3KTU/3Fxkr1RuHzLQKJ6pGcUvbgXBmT5MM
 f3ea+34dBG0BmxAI=
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr12691576wrn.400.1580484294518; 
 Fri, 31 Jan 2020 07:24:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVuDFmEtTGtPSxX1snZpup5r0ln1E/VqZWRsKTZhoaqsiV1MfPnKN7nRIrgtnKaRdVHiHZKA==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr12691557wrn.400.1580484294221; 
 Fri, 31 Jan 2020 07:24:54 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n1sm12005499wrw.52.2020.01.31.07.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:24:53 -0800 (PST)
Subject: Re: [PATCH v2 08/12] .travis.yml: Add description to each job
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-9-alex.bennee@linaro.org>
 <79ebc114-fb94-7dee-b57c-b3df7be038bf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ca68c7c0-3750-b5b5-5bf2-e16b2cd503dd@redhat.com>
Date: Fri, 31 Jan 2020 16:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <79ebc114-fb94-7dee-b57c-b3df7be038bf@redhat.com>
Content-Language: en-US
X-MC-Unique: V4eO4ngXNpm0G5qx4Jwk5g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 8:06 PM, Thomas Huth wrote:
> On 30/01/2020 12.32, Alex Benn=C3=A9e wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> The NAME variable can be used to describe nicely a job (see [*]).
>> As we currently have 32 jobs, use it. This helps for quickly
>> finding a particular job.
>>
>>    before: https://travis-ci.org/qemu/qemu/builds/639887646
>>    after: https://travis-ci.org/philmd/qemu/builds/641795043
>>
>> [*] https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-w=
ithin-matrices
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Message-Id: <20200125183135.28317-1-f4bug@amsat.org>
>>
>> ---
>> [ajb]
>>    - drop [x86]
>> ---
>>   .travis.yml | 101 ++++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 67 insertions(+), 34 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 7526967847..056db1adac 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -96,24 +96,28 @@ after_script:
>>  =20
>>   matrix:
>>     include:
>> -    - env:
>> +    - name: "GCC static (user)"
>> +      env:
>>           - CONFIG=3D"--disable-system --static"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>  =20
>>  =20
>>       # we split the system builds as it takes a while to build them all
>> -    - env:
>> +    - name: "GCC (main-softmmu)"
>> +      env:
>>           - CONFIG=3D"--disable-user --target-list=3D${MAIN_SOFTMMU_TARG=
ETS}"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>  =20
>>  =20
>> -    - env:
>> -        - CONFIG=3D"--disable-user --target-list-exclude=3D${MAIN_SOFTM=
MU_TARGETS}"
>> +    - name: "GCC (other-softmmu)"
>> +      env:
>> +       - CONFIG=3D"--disable-user --target-list-exclude=3D${MAIN_SOFTMM=
U_TARGETS}"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>  =20
>>  =20
>>       # Just build tools and run minimal unit and softfloat checks
>> -    - env:
>> +    - name: "GCC check-softfloat (user)"
>> +      env:
>>           - BASE_CONFIG=3D"--enable-tools"
>>           - CONFIG=3D"--disable-user --disable-system"
>>           - TEST_CMD=3D"make check-unit check-softfloat -j3"
>> @@ -121,41 +125,48 @@ matrix:
>>  =20
>>  =20
>>       # --enable-debug implies --enable-debug-tcg, also runs quite a bit=
 slower
>> -    - env:
>> +    - name: "GCC debug (main-softmmu)"
>> +      env:
>>           - CONFIG=3D"--enable-debug --target-list=3D${MAIN_SOFTMMU_TARG=
ETS}"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug"
>>  =20
>>  =20
>>       # TCG debug can be run just on its own and is mostly agnostic to u=
ser/softmmu distinctions
>> -    - env:
>> +    - name: "GCC debug (user)"
>> +      env:
>>           - CONFIG=3D"--enable-debug-tcg --disable-system"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>  =20
>>  =20
>> -    - env:
>> +    - name: "GCC some libs disabled (main-softmmu)"
>> +      env:
>>           - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-att=
r --disable-brlapi --disable-libusb --disable-replication --target-list=3D$=
{MAIN_SOFTMMU_TARGETS}"
>>  =20
>>  =20
>>       # Module builds are mostly of interest to major distros
>> -    - env:
>> +    - name: "GCC modules (main-softmmu)"
>> +      env:
>>           - CONFIG=3D"--enable-modules --target-list=3D${MAIN_SOFTMMU_TA=
RGETS}"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>  =20
>>  =20
>>       # Alternate coroutines implementations are only really of interest=
 to KVM users
>>       # However we can't test against KVM on Travis so we can only run u=
nit tests
>> -    - env:
>> +    - name: "check-unit coroutine=3Ducontext"
>> +      env:
>>           - CONFIG=3D"--with-coroutine=3Ducontext --disable-tcg"
>>           - TEST_CMD=3D"make check-unit -j3 V=3D1"
>>  =20
>>  =20
>> -    - env:
>> +    - name: "check-unit coroutine=3Dsigaltstack"
>> +      env:
>>           - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-tcg"
>>           - TEST_CMD=3D"make check-unit -j3 V=3D1"
>>  =20
>>  =20
>>       # Check we can build docs and tools (out of tree)
>> -    - env:
>> +    - name: "[x86] tools and docs"
>=20
> Could you please also drop this "[x86]" here?

The hunk got applied into the next patch:

      # Check we can build docs and tools (out of tree)
-    - name: "[x86] tools and docs"
+    - name: "tools and docs (bionic)"
+      dist: bionic
        env:
          - BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
          - BASE_CONFIG=3D"--enable-tools --enable-docs"


