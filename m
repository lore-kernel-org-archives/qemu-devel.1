Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F5FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E194E222C4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaXL+2PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E194E222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inKjJ-00086L-Ok
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inKiI-0007WG-No
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inKiG-0000wb-4L
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:01:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47754
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inKiF-0000oX-B0
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578049310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4kKn1kJ1qGKPJJyyyhi9yKBCm2EaNRNuKV2y68VO/g=;
 b=CaXL+2PRTrZbHvgu+RySCgCs5WKDyafuKd1Iybx176aWARPOg3QVCaK8/il+n4f447TphE
 AWCBesY/ItgR2FwXsEToEKZDiuEOIzuUjtWz8RxAqsrJm/EB2wPphCHRRJKKMLUb4WG0Ck
 1B/C1GHCp7FRsZU5dgVxOV1oQDf7XrY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-pyTIMlOhN1uLAK4w3UBSaQ-1; Fri, 03 Jan 2020 06:01:48 -0500
Received: by mail-wr1-f72.google.com with SMTP id z14so23073052wrs.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 03:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cKdvHPgQvCFIBE4mBv+GvczUV/D4daQEO3nB2sZG1CI=;
 b=MbF/Jm2+YRMBb+7T0Dpa/6OAxdxrfKE14+v9zdFC4djBnIf4TTixEZVfaDcIdaR0Pw
 uLuFPEVqLrHRhOj1vtK220+axQp8xkCjx68T3p6O2O2MAz/QfzvMSJa1gmgsx3/jf1YK
 s6zoDWVGpbEqgoCXZj0I+9v9xMvLMFFQddqW4+iHVcilxnn7Q2HOeYY8H9haz4mkKRVv
 Hc4xlEHTyEzaCsk20l73a20oI1+jvWISlvp0UqtEpOZ2eLm8HcvIBF5RmCHGZHgXi7Bl
 MrYCVqtkiZujxWr4GQrC4zMscCGRmXbfbmwWZ6lyedl/GPoKNgIaY5LiPisAdB726tU5
 91Ow==
X-Gm-Message-State: APjAAAUFSAZ8bArDW6/MCvdU/B4AhtYnPq0CelFBU36nE7pqYDpzWOzC
 LGz9YE5LkOJDhR6hVBksWEv2cX3w+yG29FRzYSWbt+3GXVDPHyefkf4JTouLj0Th5h9B822bfjT
 fjcH5ZazYphlP33E=
X-Received: by 2002:a1c:200a:: with SMTP id g10mr19340400wmg.77.1578049307678; 
 Fri, 03 Jan 2020 03:01:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhgzSeaGONkVki79PBDUOi1LuTIpwDEMBuXnUcVYvAKc9Frv+XL+0xb/xwwOrkpbyHVEKYQQ==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr19340358wmg.77.1578049307473; 
 Fri, 03 Jan 2020 03:01:47 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id e16sm58779539wrs.73.2020.01.03.03.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 03:01:46 -0800 (PST)
Subject: Re: [PATCH v6 02/21] libqos: Rename i2c_send and i2c_recv
To: Thomas Huth <thuth@redhat.com>, "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-3-alxndr@bu.edu>
 <8a74a941-b646-3708-c6cc-5dcb0fb1fbca@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dcd102bf-e390-b8df-c0c7-f2459132790f@redhat.com>
Date: Fri, 3 Jan 2020 12:01:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8a74a941-b646-3708-c6cc-5dcb0fb1fbca@redhat.com>
Content-Language: en-US
X-MC-Unique: pyTIMlOhN1uLAK4w3UBSaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 1:02 PM, Thomas Huth wrote:
> On 29/11/2019 22.34, Oleinik, Alexander wrote:
>> The names i2c_send and i2c_recv collide with functions defined in
>> hw/i2c/core.c. This causes an error when linking against libqos and
>> softmmu simultaneously (for example when using qtest inproc). Rename the
>> libqos functions to avoid this.
>>
>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> ---
>>   tests/libqos/i2c.c   | 10 +++++-----
>>   tests/libqos/i2c.h   |  4 ++--
>>   tests/pca9552-test.c | 10 +++++-----
>>   3 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
>> index 156114e745..38f800dbab 100644
>> --- a/tests/libqos/i2c.c
>> +++ b/tests/libqos/i2c.c
>> @@ -10,12 +10,12 @@
>>   #include "libqos/i2c.h"
>>   #include "libqtest.h"
>>  =20
>> -void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
>> +void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
>>   {
>>       i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
>>   }
>>  =20
>> -void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
>> +void qi2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
>>   {
>>       i2cdev->bus->recv(i2cdev->bus, i2cdev->addr, buf, len);
>>   }
>=20
> I'd prefer qos_i2c_send and qos_i2c_recv instead ... but that's just a
> matter of taste.
>=20
> Acked-by: Thomas Huth <thuth@redhat.com>

Agreed.

Renamed qos_*:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


