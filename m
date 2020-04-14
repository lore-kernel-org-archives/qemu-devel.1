Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184F3C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D648C20857
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLCw0krn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D648C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOJPk-0005xf-2D
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 07:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOJO7-0005P3-Uz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOJO6-0006wL-TQ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:05:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOJO6-0006w5-QY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586862354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhKic4CgLDAITTVqOWLQc/a0CpGBlrbxOka9h/3X3Xg=;
 b=RLCw0krnZXF2ID2OANKOdLOwVIoYkC8y1heVodYxFORhTCpbzYjqkoG/XbzPA1EXiQrQ/4
 wLHd78G4bYuZqhhP/I4A4CvIvazwkrlG53YU39g61xSd3teFcu1qkpVPYkk//N3kjZT30a
 yFfgTkM8EVSqysdp25dSAFHNqwI5dzo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-bcdalglVNDieb2-SIL8Glw-1; Tue, 14 Apr 2020 07:05:51 -0400
X-MC-Unique: bcdalglVNDieb2-SIL8Glw-1
Received: by mail-wr1-f69.google.com with SMTP id r17so8475142wrg.19
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 04:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IMZOTjQzgLyDI6M332pDffSdIQH9Z471mNNr3+WXrPk=;
 b=acWZqOvvYCW3RLK1F0Urvpjpmp47nCEeXNlVhCWvFkI5zEdBk0Ox+efzjF/aqVqFIN
 J1SDUpnfs+T9NBgSz5hmx2NAx5z4Lomi6ub7fkuFOgoG8ZHKLrwf1lkppfMqAYaAw4Cc
 z75E1YaZiM8Axy0lZ2RMi5n0s8sbo8XLQvWFgve4074jivwki/cbKvg9q6gU7Bhy6TlU
 dWG1sHS94qK4fLdlZfOUyvdorXEQLw1Jhexz4gpBXZ4sAYQIEXuZb0ywCRUt/USP9h96
 Tx4efh4wDu0jCbS/lnF/WldaKcTPrtwxR5ERGBesyV1b/VY39ORsQLq6N4xBSkDCZgFV
 ZboA==
X-Gm-Message-State: AGi0PubqhQcTlLySRwXkTLtD0NfGuAP7fLY4b2Kg70SpXulpPTZ4jYdP
 W+/Lcvd8TNdRT+iMIqcuUUlLn5AXW81hr9OIAyKeYQ2FItdhqX8+e6mrwWedrfxd8vPRTWrf3io
 hUbAJzTS3RK1ALSM=
X-Received: by 2002:adf:c442:: with SMTP id a2mr21985007wrg.110.1586862349945; 
 Tue, 14 Apr 2020 04:05:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypIbN0fe8Ama2qI+/1Q2RknOTHjp0tsYdxi96xJzVtLc36o6Mc5PQ1OJRdgjk0mUpKicyivIhg==
X-Received: by 2002:adf:c442:: with SMTP id a2mr21984989wrg.110.1586862349740; 
 Tue, 14 Apr 2020 04:05:49 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k185sm18888734wmb.7.2020.04.14.04.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 04:05:49 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] gdbstub: Do not use memset() on GByteArray
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200414102427.7459-1-philmd@redhat.com>
 <CAFEAcA-PyMisjC25CSGyU5-ASjaAd7gQMabzMCR=uvudSBk-Fw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <357e2335-b00f-cd28-4ade-d6286ace144f@redhat.com>
Date: Tue, 14 Apr 2020 13:05:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-PyMisjC25CSGyU5-ASjaAd7gQMabzMCR=uvudSBk-Fw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 12:52 PM, Peter Maydell wrote:
> On Tue, 14 Apr 2020 at 11:24, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> Introduce gdb_get_zeroes() to fill a GByteArray with zeroes.
>>
>> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   include/exec/gdbstub.h  | 9 +++++++++
>>   target/arm/gdbstub.c    | 3 +--
>>   target/xtensa/gdbstub.c | 6 ++----
>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>> index 30b909ebd2..b52d9933ee 100644
>> --- a/include/exec/gdbstub.h
>> +++ b/include/exec/gdbstub.h
>> @@ -125,6 +125,15 @@ static inline int gdb_get_reg128(GByteArray *buf, u=
int64_t val_hi,
>>       return 16;
>>   }
>>
>> +static inline int gdb_get_zeroes(GByteArray *array, size_t len)
>> +{
>> +    for (size_t i =3D 0; i < len; i++) {
>> +        gdb_get_reg8(array, '\0');
>> +    }
>> +
>> +    return len;
>> +}
>=20
> The other implementation option here would be
>=20
>       guint oldlen =3D array->len;
>       g_byte_array_set_size(array, oldlen + len);
>       memset(array->data + oldlen, 0, len);

I thought about it but I'd rather not access GByteArray internals.

>=20
> For length values < 16 my guess is the perf difference is
> not going to be noticeable though.

On ARM it is called with size=3D12:

target/arm/gdbstub.c:50:        memset(mem_buf, 0, 12);

On Xtensa it is only used with unimplemented registers:

         qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported type %d\n"=
,
                       __func__, n, reg->type);

If you prefer I can use a static empty buffer of 16 bytes and copy from it:

static inline int gdb_get_zeroes(GByteArray *array, size_t len)
{
     static const uint8_t zeroed_buf[16] =3D { };

     g_byte_array_append(array, zeroed_buf, MIN(len, sizeof(zeroed_buf)));
     for (size_t i =3D sizeof(zeroed_buf); i < len; i++) {
         gdb_get_reg8(array, '\0');
     }

     return len;
}

>=20
> thanks
> -- PMM
>=20


