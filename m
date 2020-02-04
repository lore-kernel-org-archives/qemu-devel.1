Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C53C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4752084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2V79SaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4752084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyxJw-0000hU-P8
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyxJG-00006x-Im
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyxJF-0003fR-3H
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:28:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyxJE-0003bk-W5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580819284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMrQ2FqiJxtXMoywPmShxbp0CDoQFF8TiGnGLfh3VL0=;
 b=J2V79SaJtNUrUqpqHRscojBliEBJweUJJ4U0WDeVDSXDSe+lzTQdR+UKc1ZKIMTxPVxElm
 6bRvotpdbCs8fUdzVnxEAI4+VVuBttsJqXULmF68NGuOAqsT2F1/uBS5hYgAxURaKIN0rH
 IwBLak91WF23eZn9wpVdQ2LwxYVoBoA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-2ux0qpFYO1SeHB3UFONToQ-1; Tue, 04 Feb 2020 07:28:02 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so10028295wrm.17
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 04:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cPt9M0d6iDtsqmwQp6NOAbnKeDl8EVjT5esYR0OjJQU=;
 b=oaDhfnQ7RGmo/8sor4RP30r4hfIuaB/ivSXGmjd/0i3tY8Aywtc70aSmvoFyFBoJRa
 ZS2b72pyvz33K5UQzV+d9Wad4UyasZTTFXFub0NDqzuaO6onx9mJIdlv33X3oWo4ccOZ
 uKJ0D2lrZnQs/MgZMgpVIWSmDJk3pFkI0CxXWDS2vIZsDZIIv1l5iJxNjC1ThR7FIHgo
 Yieq7/Y0sTfiwtASk81BvCXTIaAFEjun0NnCmtWNi+jOypl07UT3dyA8P0UddmOOB8kL
 DaPNvp4/dDrQP/XANqPTHdnewocBO6lwQs9gfqHnlCsZAqqNieLk16ygd/EuGIn9ixzr
 RUFw==
X-Gm-Message-State: APjAAAXf6zMnahoAgLUw7zZUVbnO+RhsPEtkEReWyNz7QR4LcKbVAfRi
 /Y0Q8rN3V4B38WZVG7PZg/1EK1Uc+eo/FxwB746zfj8c3j27HR6dhbAv3dtsfSelt7M/uUNPNV3
 tOYEbDgQ2rMg9y9Q=
X-Received: by 2002:a1c:a752:: with SMTP id q79mr5315077wme.64.1580819281385; 
 Tue, 04 Feb 2020 04:28:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+DvNIsI7PB/GMh5gaVMojIqQvMSKNjZUJNrHeGd0+dOy361U4dFruwRtzm2S96f54/PBPFA==
X-Received: by 2002:a1c:a752:: with SMTP id q79mr5315054wme.64.1580819281160; 
 Tue, 04 Feb 2020 04:28:01 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id l15sm29370822wrv.39.2020.02.04.04.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 04:28:00 -0800 (PST)
Subject: Re: [PATCH 2/3] m25p80: Improve command handling for Jedec and
 unsupported commands
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Guenter Roeck <linux@roeck-us.net>, Alistair Francis <alistair@alistair23.me>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <20200203180904.2727-2-linux@roeck-us.net>
 <accf297f-0c54-7475-8817-c1014999a57d@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4ac29597-25f8-5bf3-ef67-8bb846295de2@redhat.com>
Date: Tue, 4 Feb 2020 13:27:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <accf297f-0c54-7475-8817-c1014999a57d@kaod.org>
Content-Language: en-US
X-MC-Unique: 2ux0qpFYO1SeHB3UFONToQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 9:53 AM, C=C3=A9dric Le Goater wrote:
> On 2/3/20 7:09 PM, Guenter Roeck wrote:
>> Always report 6 bytes of JEDEC data. Fill remaining data with 0.
>>
>> For unsupported commands, keep sending a value of 0 until the chip
>> is deselected.
>>
>> Both changes avoid attempts to decode random commands. Up to now this
>> happened if the reported Jedec data was shorter than 6 bytes but the
>> host read 6 bytes, and with all unsupported commands.
>=20
> Do you have a concrete example for that ? machine and flash model.
>=20
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   hw/block/m25p80.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 63e050d7d3..aca75edcc1 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -1040,8 +1040,11 @@ static void decode_new_cmd(Flash *s, uint32_t val=
ue)
>>           for (i =3D 0; i < s->pi->id_len; i++) {
>>               s->data[i] =3D s->pi->id[i];
>>           }
>> +        for (; i < SPI_NOR_MAX_ID_LEN; i++) {
>> +            s->data[i] =3D 0;
>> +        }
>=20
> It seems that data should be reseted in m25p80_cs() also.

I am not sure, since a guest can queue various requests in a single=20
frame. Guenter patch seems correct to me.

All the others uses in decode_new_cmd() fill data[] up to the correct=20
length, so are safe.

In complete_collecting_data() the access to data[] should be protected=20
by STATE_COLLECTING_VAR_LEN_DATA (state only changes when enough data).

>>  =20
>> -        s->len =3D s->pi->id_len;
>> +        s->len =3D SPI_NOR_MAX_ID_LEN;
>>           s->pos =3D 0;
>>           s->state =3D STATE_READING_DATA;
>>           break;
>> @@ -1158,6 +1161,11 @@ static void decode_new_cmd(Flash *s, uint32_t val=
ue)
>>           s->quad_enable =3D false;
>>           break;
>>       default:
>> +        s->pos =3D 0;
>> +        s->len =3D 1;
>> +        s->state =3D STATE_READING_DATA;
>> +        s->data_read_loop =3D true;
>> +        s->data[0] =3D 0;
>>           qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n", val=
ue);
>>           break;
>>       }
>>
>=20
>=20


