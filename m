Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B944C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 19:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4864B20658
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 19:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ2fVk0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4864B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYEpg-0000kj-BD
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 14:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iYEof-0008KR-V9
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 14:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iYEod-0005BH-4l
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 14:42:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45029
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iYEod-0005B1-1C
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 14:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574451722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kP1d71RujJG8R6w3M7TwO/JzpHHg8Y21s1bWY8+jkgc=;
 b=IZ2fVk0kTRE+18ve9LyxF5w1JKVSLUXjBFDk6UEIqYYDTdsVCJA0xpx4+axnQqQI/PtKXW
 brEQba8t2mkAt/m9xqfvc3j9xoiLpC6PMOs1US2OsFDqKhNkvP5QF4ni3QvLm7z0AvrT2/
 e5IUK6sNsCjZUEWfm3Wz4A51WYtW0j0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-1cDf-pszN4O781O7exBsSA-1; Fri, 22 Nov 2019 14:41:58 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so4317557wrm.18
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 11:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YNYqHA4DSfWnWa74/rLsawo64tbCUWrEOadlK4S6zQ8=;
 b=jix1QsIMI/f6E8SXSxHf1NO8DSO8+spaRSNNabKU+QbyCG8qEmc9Y24tBm8ES+6PL3
 pw1bCGdUfpOJyoAdM4h+7XxuxOtO5XqBzALw9LZP+kgimskQSoSmtDZGmNQUAGgnneUz
 kD7ecUawTD5UHdO8Bqj8f2t5t32OlBJSTn4Yjstl6lt0bqkJRAYQ4EvxG7xG6HM7ab33
 lTJU2kqoW8UKM9raN0xgvrAjLJI5iDcLkLjKklpN2WVhfFDHf8OH2/0TnY/mxHiQuGmo
 kXBMyFKMT/99OhM4dQ6nSKZDgedu7cqFBNA+HPQMoJ5a87oKRpviX7Yvp/zFdmVLjpXW
 tA0Q==
X-Gm-Message-State: APjAAAVV2qrK9kQboBjiwv7XcZU0o0i2UKRbyQQ/FEFnQEkBHD5y6ACR
 lVXcygDRei0uVQ1dK3LMelS7x5pjBtP+yRDluNgfduBKebSit6QnQDJRKUkxRjx8zFopxAzzf9T
 vggq47KtY6gu6+Nc=
X-Received: by 2002:a1c:7507:: with SMTP id o7mr17499055wmc.163.1574451717731; 
 Fri, 22 Nov 2019 11:41:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRQ/4rCwCc3SRVcWxd6ZwztRnLCTsgA5PiTxhzlKHn1TckUGmR2XRH2KiXdAE1VGttPYDo0Q==
X-Received: by 2002:a1c:7507:: with SMTP id o7mr17499043wmc.163.1574451717529; 
 Fri, 22 Nov 2019 11:41:57 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id 19sm10390159wrc.47.2019.11.22.11.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 11:41:56 -0800 (PST)
Subject: Re: [PATCH] linux-user: fix translation of statx structures
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Ariadne Conill <ariadne@dereferenced.org>
References: <20191122174040.569252-1-ariadne@dereferenced.org>
 <CAL1e-=jBhF476ZErrbZ_ANBnrKhNNgYtntGDB-5BDMXdT9J0aQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7cd7bcbf-70f1-02b8-fa25-6e335f0669a1@redhat.com>
Date: Fri, 22 Nov 2019 20:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jBhF476ZErrbZ_ANBnrKhNNgYtntGDB-5BDMXdT9J0aQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 1cDf-pszN4O781O7exBsSA-1
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 7:27 PM, Aleksandar Markovic wrote:
> On Fri, Nov 22, 2019 at 7:22 PM Ariadne Conill <ariadne@dereferenced.org>=
 wrote:
>>
>> All timestamps were copied to atime instead of to their respective
>> fields.
>>

Fixes: efa921845c0

>> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
>> ---
>=20
> What a bug.
>=20
> Laurent, perhaps a good candidate for 4.2?

Agreed.

>=20
> Thanks for submitting this, Ariadne Conill!

And welcome to QEMU :)

> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>>   linux-user/syscall.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index ce399a55f0..171c0caef3 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -6743,12 +6743,12 @@ static inline abi_long host_to_target_statx(stru=
ct target_statx *host_stx,
>>       __put_user(host_stx->stx_attributes_mask, &target_stx->stx_attribu=
tes_mask);
>>       __put_user(host_stx->stx_atime.tv_sec, &target_stx->stx_atime.tv_s=
ec);
>>       __put_user(host_stx->stx_atime.tv_nsec, &target_stx->stx_atime.tv_=
nsec);
>> -    __put_user(host_stx->stx_btime.tv_sec, &target_stx->stx_atime.tv_se=
c);
>> -    __put_user(host_stx->stx_btime.tv_nsec, &target_stx->stx_atime.tv_n=
sec);
>> -    __put_user(host_stx->stx_ctime.tv_sec, &target_stx->stx_atime.tv_se=
c);
>> -    __put_user(host_stx->stx_ctime.tv_nsec, &target_stx->stx_atime.tv_n=
sec);
>> -    __put_user(host_stx->stx_mtime.tv_sec, &target_stx->stx_atime.tv_se=
c);
>> -    __put_user(host_stx->stx_mtime.tv_nsec, &target_stx->stx_atime.tv_n=
sec);
>> +    __put_user(host_stx->stx_btime.tv_sec, &target_stx->stx_btime.tv_se=
c);
>> +    __put_user(host_stx->stx_btime.tv_nsec, &target_stx->stx_btime.tv_n=
sec);
>> +    __put_user(host_stx->stx_ctime.tv_sec, &target_stx->stx_ctime.tv_se=
c);
>> +    __put_user(host_stx->stx_ctime.tv_nsec, &target_stx->stx_ctime.tv_n=
sec);
>> +    __put_user(host_stx->stx_mtime.tv_sec, &target_stx->stx_mtime.tv_se=
c);
>> +    __put_user(host_stx->stx_mtime.tv_nsec, &target_stx->stx_mtime.tv_n=
sec);
>>       __put_user(host_stx->stx_rdev_major, &target_stx->stx_rdev_major);
>>       __put_user(host_stx->stx_rdev_minor, &target_stx->stx_rdev_minor);
>>       __put_user(host_stx->stx_dev_major, &target_stx->stx_dev_major);
>> --
>> 2.24.0
>>
>>
>=20


