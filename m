Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4DBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380F821789
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUp5x46J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380F821789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia4k4-0005hh-Ej
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 16:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ia4iL-0004QA-Af
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ia4iK-0002CK-AY
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:19:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47118
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ia4iK-0002B0-6z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574889547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0sdROm8vDBkkhXor0lVZMnz117098c5SxSyVxhVbXs=;
 b=IUp5x46Js4WryYQW1A/fytw3ZzI5S1T7f+RwwYETYCVXdy234zIkIq5kChhs49aOaB5ysd
 OGO51yYtr89od/HnSHAEe91kRjtF1RNIAekhJvidfwdz6b7kRFjHXPOXisQmINnIB0caCK
 3sMLfbJPZ46yktDf78VY/WgEzTizLws=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-V9CopbBLMyujVfDOrAcO7Q-1; Wed, 27 Nov 2019 16:19:04 -0500
Received: by mail-wm1-f69.google.com with SMTP id f21so2883458wmh.5
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 13:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9dDgbYK56G9JGdBXiG8g8rFq9PZSdh/Mj+NpfZWv1EM=;
 b=SfvtCNDP3gVS2DUgO0CS9CEpqGcaAI+sTCSG2cuzoutQKc5dhp35mwsZL6C8FhiNKS
 84Zu1V7d0IEFsEordg5NKAEGqqk5To/Stv3sOd2NJ4y6jeYp00XI23bv77Zr+Hc5aQ4k
 +7j95TZSvVKpwFxE71YeEjN1XWOXXbWwPCWponksvTD+1m1+DOr2uvXrgmQTvXYhPxYg
 ZWFRHfp31IFZwYVduB7iXplUaDrrsQqc2mdkHZLv9avO+DvvJLbsGbSPHsYSyzVR9jX8
 c6Cr0C9A7ek0rhok+nX+px5GS81GBGi1LeWlmiBegZBzvnScynaDn40TV16RuiUgD77h
 DF0w==
X-Gm-Message-State: APjAAAUg8YuPYpA2oJHeQaCmbndXxs7IIeBYOHrA2S1Q2G/c/ACPQSiE
 +1+70WpKV1iManJqbtiYnEW6knDVVzlvBsgEw1hwNA1GN/2DQQcMyez8aej4aEQNuP0l2WdN7om
 Vtx1LEy4ffwmeb/Y=
X-Received: by 2002:a7b:c357:: with SMTP id l23mr6319179wmj.152.1574889542932; 
 Wed, 27 Nov 2019 13:19:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxunfDAx8SenjVKVfK5fTj9T1xWoPqHD4mmHBFRfeKBgqZvhaXI10aNmMlgFyqZ1RWrArCWkw==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr6319161wmj.152.1574889542707; 
 Wed, 27 Nov 2019 13:19:02 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id i25sm7768484wmd.25.2019.11.27.13.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 13:19:01 -0800 (PST)
Subject: Re: [PATCH] travis.yml: Run tcg tests with tci
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20191127154857.3590-1-thuth@redhat.com>
 <87zhghf9lg.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ee3b2cf5-a119-95a7-1aa6-1c42b00cfd7f@redhat.com>
Date: Wed, 27 Nov 2019 22:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87zhghf9lg.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: V9CopbBLMyujVfDOrAcO7Q-1
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 7:38 PM, Alex Benn=C3=A9e wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> So far we only have compile coverage for tci. But since commit
>> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
>> for INDEX_op_ld16u_i64") has been included, we can also run the
>> x86 TCG tests with tci, so let's enable them in Travis now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   .travis.yml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index c09b6a0014..b0b634d484 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -218,7 +218,7 @@ matrix:
>>       # We manually include builds which we disable "make check" for
>=20
> this comment is out of date now (or rather has been for a while)
>=20
>>       - env:
>>           - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
>=20
> Perhaps as linux-user doesn't add much to testing the TCG we could limit
> by MAIN_SOFTMMU_TARGETS here?

Good idea.

>> -        - TEST_CMD=3D""
>> +        - TEST_CMD=3D"make run-tcg-tests-x86_64-softmmu V=3D1"
>=20
> How about "make check-qtest check-tcg"
>=20
> Which will exercise the moderate boot code tests of various
> architectures as well as x86_64 (if we include the --disable-docker
> configure stanza)

Another good idea!

>>  =20
>>  =20
>>       # We don't need to exercise every backend with every front-end


