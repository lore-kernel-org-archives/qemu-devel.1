Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6047C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB1B2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JT/Kq/SV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB1B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkO9-0003m6-Hj
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 08:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbkNT-0002TO-Mh
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:32:48 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbkNR-0001jH-Vl
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:32:47 -0400
Received: by mail-ej1-x644.google.com with SMTP id s3so8604108eji.6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QnO7nxJ8CCi/d6gZI0fJ1DVNg97xjsX5scJhajPNvB8=;
 b=JT/Kq/SVyD6LNE/An6DJqJcpq2iCu74vW/8HY4C0hLURcEb9OdcoFHGL0pMoNwCYrU
 i+r7uRUMMudMsiE3BzuFBcjv9uts0+2l2g7JJQISmGht0a/Iah1MyaGtO4rmuN8KJhlk
 E8hkEuoXD+/MESS/O9sm8XAn+fWN1A6MiziF+gxEX3u/2/HyImOWqz5FW0cKwbkgC5hl
 rxRhYhDmmUPyNKDJYJM1bW32UMAPY3AdmUCJKQm0gnbTjFI4kISW3z3WqcHpMkS2l0jr
 3gG6F2oQ2ueCnFA3OgxooIkW/8hfoFOyc2rJ3BMzp9wpXVR4+LZrAY7MW3sT93zmiBGO
 qeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QnO7nxJ8CCi/d6gZI0fJ1DVNg97xjsX5scJhajPNvB8=;
 b=V4IgmwXeqw0qNCqUjGyhzm3FSQHJ5AWqGA5goNOTbjKXRIIwuAi9Nkreh+FEdMmvAW
 AGw0I1T+AcEZ+77oA81vCok/TelIgYBfv06ddDlC/Ukwz+/QxnCWde8gadQ9tICldrUG
 1hVJM71+dW38wsb55Y9YZm7CRIum/A3etuX3h6R9UepkngReIrXHPGGPq3vuL0N0gnYL
 5Ns7p6COaE9eIYea32CUg10Zh7DOhdUg5TaAQrOtNRwPWSp7ujQpm1cqPVKYkh2IroR6
 CGWw6fC6zF8Jh9+O9fk76ay/QBDUNmsA6zoYUDFMI/yQxKFNt7vJiGA07LfB0d/brFUt
 uHQg==
X-Gm-Message-State: AOAM531yYeKJS1HNYbmEPB8Ji51Yh5d5WEntuIOxL+b70Pad9RX0HoNN
 lnOtx3V3mNgCrxkZ49Zvmni1nQ==
X-Google-Smtp-Source: ABdhPJyddI2N9xqbRM4wgQBgCOalDiW+5ROGc7fSKkHI7/KhJwpBsjsJh4kWS9Jau0v0ugNVectUuQ==
X-Received: by 2002:a17:906:404c:: with SMTP id
 y12mr3518096ejj.9.1590064364243; 
 Thu, 21 May 2020 05:32:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id cz9sm4566051edb.18.2020.05.21.05.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 05:32:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E02D71FF7E;
 Thu, 21 May 2020 13:32:41 +0100 (BST)
References: <20200521102130.17619-1-alex.bennee@linaro.org>
 <CAFEAcA-0f8tsTSu2nc9Z2tnEA4YBMbzWru1yUbW_xxM1=zV0JQ@mail.gmail.com>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] linux-user: limit check to HOST_LONG_BITS == 32
In-reply-to: <CAFEAcA-0f8tsTSu2nc9Z2tnEA4YBMbzWru1yUbW_xxM1=zV0JQ@mail.gmail.com>
Date: Thu, 21 May 2020 13:32:41 +0100
Message-ID: <87blmhfoye.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 21 May 2020 at 11:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Newer clangs rightly spot that you can never exceed the full address
>> space of 64 bit hosts with:
>>
>>   linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
>>   long' > 18446744073709551615 is always false
>>   [-Werror,-Wtautological-type-limit-compare]
>>   4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>   4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>>   4687 1 error generated.
>>
>> So lets limit the check to 32 bit hosts only.
>>
>> Fixes: ee94743034bf
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  linux-user/elfload.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 01a9323a637..797fbf2337a 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -2072,6 +2072,7 @@ static void pgb_have_guest_base(const char *image_=
name, abi_ulong guest_loaddr,
>>                           image_name, (uint64_t)guest_hiaddr, reserved_v=
a);
>>              exit(EXIT_FAILURE);
>>          }
>> +#if HOST_LONG_BITS =3D=3D 32
>>      } else {
>>          if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>              error_report("%s: requires more virtual address space "
>> @@ -2079,6 +2080,7 @@ static void pgb_have_guest_base(const char *image_=
name, abi_ulong guest_loaddr,
>>                           image_name, (uint64_t)guest_hiaddr - guest_bas=
e);
>>              exit(EXIT_FAILURE);
>>          }
>> +#endif
>
> Could we write this so that we have the #if...#endif
> conditional nested inside the if { ... } else { ... },
> rather than having the two conditional constructs
> oddly intermeshed?

Sure - I thought the compiler would complain about having an empty else
leg but I've just checked and it doesn't seem to care.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

