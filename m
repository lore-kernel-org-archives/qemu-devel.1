Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D2ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 19:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761E7206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 19:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4Pwysp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761E7206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHYOI-0004VV-GZ
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 15:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHYNW-0003yT-Ui
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 15:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHYNU-0004GK-Ii
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 15:09:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHYNU-0004FM-DY
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 15:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570475343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMtEz5bt8QsAx3TMYHfnqFLaqCzgcSXDf+ZKj4TOB5I=;
 b=C4Pwysp71PlxS2j5mNE7znb5JL2q1LAZOEPoGbjw/VThHvn0NoroUCWJnQLvmO4BqLMvsW
 sJpPSu0H3x99hBdl9L+fSoJbAzqQ8lMEhnCAh6PjCziAeoZS6VGgkswrj1N38wRVTGwJO5
 0dmHJtQqLYloWeXPri5znt771UtBdXA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-VAnSoDFCN1i1F65vsw5-jw-1; Mon, 07 Oct 2019 15:09:01 -0400
Received: by mail-wr1-f69.google.com with SMTP id v18so7940404wro.16
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 12:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jsqNBHA6n0AqmqeyCnhO1qMSWRKg47XSsD0X55QWLrI=;
 b=tN8YZ+iwF/wsAKAjPWbKwRbzf9/3V9EGYOeKIsLWG6x0ghLjEyizwaGGdTvKlsMgna
 JuRVq2F+6Rm5ezLuEqwrA4u2TZ0clqDdbV63YSYlQlSQ/zr+iykQt8/fDxVW3e6RE+RN
 wqoCSSMZl1xjpSn1DI1A8nc5vQweYehAZEnelZ+aUPa8sFNEx4kFP/IwRMZAVt2d2bTt
 To/fsaDToEmkaPhsngheS7Jd0v/C6/BtYtG42cuo3XUo6HIvOAXD5XgQYwBJLc7k3oK+
 im2PVw9fE1OpJ9P93wH+/vjZW8CcqXXoGWnswpBpe0ttIythjRS3UPMSQA4h3cLmO4bE
 n3Hw==
X-Gm-Message-State: APjAAAX/KM5RGK4r3UndlDLeolYjurB5Fh7V50WvGh52BlpKAmTDUwQB
 kvv3tNlCT8LoOtMiDs/5qpfTcTD+ziCr4CnIEhYL9Cp7HRVrOBdDDMnQB3gyhHyPWL7diyYEAT0
 +/p5kcEteEBFuk8M=
X-Received: by 2002:adf:f684:: with SMTP id v4mr21163959wrp.155.1570475339876; 
 Mon, 07 Oct 2019 12:08:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzs7fRQFq05u1/meQ1zgnQIqB1w+8kss0/cJ+OPZfIYpJeOy3eOOowDQkB9eUrpDD6vZ8hegg==
X-Received: by 2002:adf:f684:: with SMTP id v4mr21163949wrp.155.1570475339708; 
 Mon, 07 Oct 2019 12:08:59 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id a4sm290374wmm.10.2019.10.07.12.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 12:08:59 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: reduce scope of the --enable-debug build
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191007160708.26208-1-alex.bennee@linaro.org>
 <CAFEAcA940hceuNdjNDBuJugrz64=7TQK78dR+KfYaR3xuhYf8w@mail.gmail.com>
 <877e5gjs0p.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f416e24-2c62-3bde-eda7-1a3e8dee47d1@redhat.com>
Date: Mon, 7 Oct 2019 21:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <877e5gjs0p.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: VAnSoDFCN1i1F65vsw5-jw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 9:05 PM, Alex Benn=C3=A9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On Mon, 7 Oct 2019 at 17:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>>
>>> Adding debug makes things run a bit slower so lets not hammer all the
>>> targets.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>   .travis.yml | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index d0b9e099b9..fc0888aff5 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -124,12 +124,13 @@ matrix:
>>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>>
>>>
>>> +    # --enable-debug implies --enable-debug-tcg, also runs quite a bit=
 slower
>>>       - env:
>>> -        - CONFIG=3D"--enable-debug --enable-debug-tcg --disable-user"
>>> +        - CONFIG=3D"--enable-debug --enable-debug-tcg --target-list=3D=
${MAIN_SOFTMMU_TARGETS}"
>>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug"
>>
>> If (as noted in the comment) --enable-debug implies
>> --enable-debug-tcg, why do we need to give both options ?
>=20
> We don't really - I was just being verbose. I'll drop it.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


