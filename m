Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE367C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F6322B48
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/vdEwMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F6322B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igMdX-00081P-H0
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 00:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igMct-0007Zc-Gn
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igMcq-0007Qt-9p
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:39:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igMco-0007Ph-QS
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576388365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGtFvKsCF4hb5bUxjq8D6WASujeQjm2T4y4t85iQoBk=;
 b=B/vdEwMh88U8k/9Ei/SCaelo5m81UR8RwKNS2jVrdqjh74RSteEuXGx5fmvUfc9fxkL3np
 pzHvWjnlOnbwY6UEYjdTUKJsmHA/7MNecRuJRHvAtX25Cr33hkjbnGAhBaI19bI5npRgE+
 8F8OtE9rd5VmvUhn5PlwprPT2jOKynU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-phzsSYnRPbO3Om0R692LyQ-1; Sun, 15 Dec 2019 00:39:23 -0500
Received: by mail-wr1-f71.google.com with SMTP id y7so464778wrm.3
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 21:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sSfwhUSbPSFH3qhKDXzrTyLrD9yXVAhjDWmLlRdn3PI=;
 b=qfe9Aahoq/Cm5vL1E74zHIw1Y7e5gkZSxsxhWE3QK6e5mUhyjSO6eHll0dsvuhyVPt
 KzGUtfR+8hulUVN4uZwSEquG0Igblqwprk8/DkgQiay7/OhdmUuGs5dQsVgS6BmAU220
 tO5AwW6eaYNRzseeI5v8NgAr+atF4iexErz2i56A7fOwjC+KiNbodPaPp5/mNgd4fIxs
 wcydgQ8KKbCg8PEdb6dvqzgeP8l+XZ4gVSDeHrthMOlnzhorHozg3AaQFOeRs7NbdSzW
 pgz0KIuz7XyRTHmEmx9YLbo/otOSNOmeoaUmBBANGHhBYmX3XL9uzxK7h/LgPsA12qIy
 R3zg==
X-Gm-Message-State: APjAAAXPHuwqr8lVLjrXPDxqw/i+VPIHfpqgDON4i2dyPxmXgsUrmjuX
 X5UVgKCXb1qQhN6wuZ+WmQtPIn6zqSXhKOagXTwYoazfDU3vNMwNHQk5H7+kF5j3V3W8XKDbSf/
 YsnWJabO5DnpJ0gM=
X-Received: by 2002:a7b:c444:: with SMTP id l4mr22486126wmi.178.1576388362687; 
 Sat, 14 Dec 2019 21:39:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyclrX56uDuok3rHi9fRwE8pFo2QPzT9ei6nnsu2KDwAA5GEA88aldNaNoJYAsAYEA/5B4i/Q==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr22486108wmi.178.1576388362444; 
 Sat, 14 Dec 2019 21:39:22 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id l2sm15987078wmi.5.2019.12.14.21.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 21:39:21 -0800 (PST)
Subject: Re: [PATCH v4 20/37] mips: use sysbus_mmio_get_region() instead of
 internal fields
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-21-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e59522d4-54a8-b075-9236-fa5d93614ebe@redhat.com>
Date: Sun, 15 Dec 2019 06:39:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-21-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: phzsSYnRPbO3Om0R692LyQ-1
X-Mimecast-Spam-Score: 0
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
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> Register the memory region with sysbus_init_mmio() and look it up with
> sysbus_mmio_get_region() to avoid accessing internal device fields.
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial.c       | 1 +
>   hw/mips/mips_mipssim.c | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 23f0b02516..02c545ff8c 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -993,6 +993,7 @@ static void serial_io_realize(DeviceState *dev, Error=
 **errp)
>       qdev_init_nofail(DEVICE(s));
>  =20
>       memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8)=
;
> +    sysbus_init_mmio(SYS_BUS_DEVICE(sio), &s->io);
>       sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
>   }
>  =20
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 2c2c7f25b2..84c03dd035 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -227,7 +227,8 @@ mips_mipssim_init(MachineState *machine)
>           qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>           qdev_init_nofail(dev);
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> -        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8, &SERIAL_IO(dev)->seria=
l.io);
> +        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
> +                      sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));

TIL sysbus_add_io(), nice.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       }
>  =20
>       if (nd_table[0].used)
>=20


