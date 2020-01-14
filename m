Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77381C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF1424658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDNXtqFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF1424658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irRBA-0006EL-FF
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irRAS-0005Hb-Fi
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irRAR-0005B9-3Z
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:43:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48433
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irRAR-0005As-0N
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579027434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMivcHXvHU51KJdX+nqFEEooL+yhUqH7huehonuVCnI=;
 b=DDNXtqFCMpVsQuVLA4J5OlelvT+Hfm5PKBGyQiXRuDtdylWWd+jAZqzoB68XkEx97l/nwV
 gawc0Hq2wHFNbm/zJu0N4gVw8ee4U86ZX6A9BVWyjpxnhoVkEnpOtLTIwXdqhGRCpxYwhL
 1Yv12pX8rta2url0P7JLQjQZ61lcWxI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-jc855X0rMji4-S4IL3A-RA-1; Tue, 14 Jan 2020 13:43:47 -0500
Received: by mail-wr1-f72.google.com with SMTP id f10so6899495wro.14
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RqO6jellHIOw8Qq/krkrxdIWGELIdyoYgws7Mfssl5s=;
 b=mmALEieEGlZnZ1GY72uNxEMh2Vozz468jv1Vz3N1uLjaMDnt5wstB49XI0IoDR9py4
 Oe2bxIZAUjd4WiRl0/PeaVvPyrNCmAVDwj9pH8ZgybMUw659AxsAaivpW7rabRdOzLQ7
 6N3Ij/DG2ieeU1JnsJUnpvQaBZL0ba5S/0sY6mEU9dS0KuoZcTOQjqEbzxOJ8Vv9eLnZ
 YFZcpp+C8wkWBZ/hm+FXSUzByNgYtvAYX4jW9ci/zdDmEkUdfKn0LwaPejQikoIkpIi6
 6nzhw2ePFK2/kjRDpOFveGG3EssgMLG5TE+kSdZ8GVM+JJlBPlvtLAxgXHZ41kZa9OrV
 Ke0A==
X-Gm-Message-State: APjAAAWyL0hzRwwRym4CzsHTrBl6eZjxPGbjtbhS/vaiTMwNY14THnLz
 9IAkeE9mrCtUj13Ykd3Pha4GJ671qZljT3jg3fRKG0yy8tdLX8r4XT0Zf5aAHaoj9P/UelJ5oZq
 oDBxTHW+PS1OqvPk=
X-Received: by 2002:a5d:6144:: with SMTP id y4mr27094209wrt.367.1579027425482; 
 Tue, 14 Jan 2020 10:43:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxENTX7DxFuggVhqIAwdbttMj0yUT8rFZkZ82U+HACiK/O0QYCGqRapO00khgHismZwu9QuWw==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr27094187wrt.367.1579027425204; 
 Tue, 14 Jan 2020 10:43:45 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id w19sm19213558wmc.22.2020.01.14.10.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 10:43:44 -0800 (PST)
Subject: Re: [PATCH] qcow2: Use a GString in report_unsupported_feature()
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Alberto Garcia <berto@igalia.com>
References: <20200114145437.28382-1-berto@igalia.com>
 <87blr5nc6z.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9059159-9d86-fbb6-71a1-51b1dfc3aab7@redhat.com>
Date: Tue, 14 Jan 2020 19:43:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87blr5nc6z.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: jc855X0rMji4-S4IL3A-RA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 7:08 PM, Alex Benn=C3=A9e wrote:
> Alberto Garcia <berto@igalia.com> writes:
>=20
>> This is a bit more efficient than having to allocate and free memory
>> for each item.
>>
>> The default size (60) is enough for all the existing incompatible
>> features.
>>
>> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>   block/qcow2.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index cef9d72b3a..ecf6827420 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -453,16 +453,15 @@ static void cleanup_unknown_header_ext(BlockDriver=
State *bs)
>>   static void report_unsupported_feature(Error **errp, Qcow2Feature *tab=
le,
>>                                          uint64_t mask)
>>   {
>> -    char *features =3D g_strdup("");
>> -    char *old;
>> +    GString *features =3D g_string_sized_new(60);
>=20
>         g_autoptr(GString) features =3D g_string_sized_new(60);
>=20
> will save you the clean-up later.

Does this work with g_string_free() too?

>>  =20
>>       while (table && table->name[0] !=3D '\0') {
>>           if (table->type =3D=3D QCOW2_FEAT_TYPE_INCOMPATIBLE) {
>>               if (mask & (1ULL << table->bit)) {
>> -                old =3D features;
>> -                features =3D g_strdup_printf("%s%s%.46s", old, *old ? "=
, " : "",
>> -                                           table->name);
>> -                g_free(old);
>> +                if (features->len > 0) {
>> +                    g_string_append(features, ", ");
>> +                }
>> +                g_string_append_printf(features, "%.46s",
>>       table->name);
>=20
> We have a number of cases of this sort of idiom in the code base. I
> wonder if it calls for a utility function:
>=20
>         qemu_append_with_sep(features, ", ", "%.46s", table->name)

Good idea for https://wiki.qemu.org/Contribute/BiteSizedTasks

> Anyway not mandatory for this patch so with the autoptr fix:
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
>>                   mask &=3D ~(1ULL << table->bit);
>>               }
>>           }
>> @@ -470,14 +469,15 @@ static void report_unsupported_feature(Error **err=
p, Qcow2Feature *table,
>>       }
>>  =20
>>       if (mask) {
>> -        old =3D features;
>> -        features =3D g_strdup_printf("%s%sUnknown incompatible feature:=
 %" PRIx64,
>> -                                   old, *old ? ", " : "", mask);
>> -        g_free(old);
>> +        if (features->len > 0) {
>> +            g_string_append(features, ", ");
>> +        }
>> +        g_string_append_printf(features,
>> +                               "Unknown incompatible feature: %" PRIx64=
, mask);
>>       }
>>  =20
>> -    error_setg(errp, "Unsupported qcow2 feature(s): %s", features);
>> -    g_free(features);
>> +    error_setg(errp, "Unsupported qcow2 feature(s): %s", features->str)=
;
>> +    g_string_free(features, TRUE);
>>   }
>>  =20
>>   /*
>=20
>=20


