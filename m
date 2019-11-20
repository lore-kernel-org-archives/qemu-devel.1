Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A258C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04140206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWueFsOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04140206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXScA-0003bp-H9
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXSaX-0001bE-UY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXSaW-0000MX-NA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:12:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXSaW-0000MP-Jf
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574266335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ajz+jKHiyhzDkIc+tbd/O26GtLIaH7C9+TR2J9aW/U=;
 b=EWueFsObsK9PnUnZURgpyMYnHJuZKyE4knECtsS9tPfQ+u9uuk4nIAXD/PoIKc0QquX9im
 N9v9SxAnwBJiwt+se4IU74TdEs8uHykYsNpzbOg0z0QGoZCyXHITEIZaSJhYueqQgqSbep
 FvsZU7qVigqxDc9+9p7g4Ey7rJZFWog=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-f1Pmc4KCO3ydo75uT8JRwQ-1; Wed, 20 Nov 2019 11:12:14 -0500
Received: by mail-wr1-f71.google.com with SMTP id b4so21474436wrn.8
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rh5wDR+6BNNd6qIbACXB64wpSn3+cjVuyoAoUI0KvDc=;
 b=jFGvUzwtMWuVmDfhtsWgyM3NOog2JwNVpISiLdGfBX3jrpy7Npkw5hmdZFuigQCtil
 SgRcCCQNkv/2RgHViV5vAMdCHG0RBj5qn3C1VK2aD+Dv0rjZW1euPOxqr9t9W5eVnC2/
 +hzOKqtuRROPQhKLz+gbE6SYyOMJhvannuugT8xddjnrKVi6I53dVSyqS7WwVX8W0rP4
 yJBGiEAEicG7b0188Pc/ijMmesdzF7jMSR6Zxyt9b5KP2DZlrwp3bdIVUrVbA/Y5jKaq
 eCgglCookjNf8qC1kAUakouAr8DYN2kvX17sHnU4n3bKqBkHjf71hf7UDR+U1X2P/tRR
 8QOw==
X-Gm-Message-State: APjAAAX6BH4wp/vWIMilu+SX5RJIutfjexdIX+YupUt8mhH6XxLg4NNq
 zwStbPxFzHe30vRAoU7uGdvvaKYze3KdoT+gc2tnEjF/uA75HognkxeZ7nim4CEw3Z4gLQFjLpy
 KQrBXdZlu6Mj3b/c=
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr4138989wmh.151.1574266333310; 
 Wed, 20 Nov 2019 08:12:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3ISohGk86ZuK7IwZw9NRx2FE/Db4SAeemPKFUBxTx65xisgH7avZGbW9+Cf9136ipCOzd7g==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr4138962wmh.151.1574266333068; 
 Wed, 20 Nov 2019 08:12:13 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id j7sm34379122wro.54.2019.11.20.08.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 08:12:12 -0800 (PST)
Subject: Re: [PATCH v4 10/37] serial: realize the serial device
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-11-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5c357fa2-d9a6-4d4b-e88f-9d9c59084df7@redhat.com>
Date: Wed, 20 Nov 2019 17:12:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-11-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: f1Pmc4KCO3ydo75uT8JRwQ-1
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> Instead of calling serial_realize_core(), use the QDev realize
> callback.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial-isa.c       | 2 +-
>   hw/char/serial-pci-multi.c | 2 +-
>   hw/char/serial-pci.c       | 2 +-
>   hw/char/serial.c           | 8 ++++----
>   include/hw/char/serial.h   | 1 -
>   5 files changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index 2a4c8de1bf..db8644551e 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -74,7 +74,7 @@ static void serial_isa_realizefn(DeviceState *dev, Erro=
r **errp)
>       index++;
>  =20
>       isa_init_irq(isadev, &s->irq, isa->isairq);
> -    serial_realize_core(s, errp);
> +    object_property_set_bool(OBJECT(s), true, "realized", errp);
>       qdev_set_legacy_instance_id(dev, isa->iobase, 3);
>  =20
>       memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "seri=
al", 8);
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 4891f32230..0e1fdb75d2 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -106,7 +106,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, =
Error **errp)
>  =20
>       for (i =3D 0; i < nports; i++) {
>           s =3D pci->state + i;
> -        serial_realize_core(s, &err);
> +        object_property_set_bool(OBJECT(s), true, "realized", &err);
>           if (err !=3D NULL) {
>               error_propagate(errp, err);
>               multi_serial_pci_exit(dev);
> diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
> index db2c17aafd..4b6a217365 100644
> --- a/hw/char/serial-pci.c
> +++ b/hw/char/serial-pci.c
> @@ -49,7 +49,7 @@ static void serial_pci_realize(PCIDevice *dev, Error **=
errp)
>       SerialState *s =3D &pci->state;
>       Error *err =3D NULL;
>  =20
> -    serial_realize_core(s, &err);
> +    object_property_set_bool(OBJECT(s), true, "realized", &err);
>       if (err !=3D NULL) {
>           error_propagate(errp, err);
>           return;
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 4a598ead21..1f3859eef1 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -934,8 +934,10 @@ static int serial_be_change(void *opaque)
>       return 0;
>   }
>  =20
> -void serial_realize_core(SerialState *s, Error **errp)
> +static void serial_realize(DeviceState *dev, Error **errp)
>   {
> +    SerialState *s =3D SERIAL(dev);
> +
>       s->modem_status_poll =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTime=
rCB *) serial_update_msl, s);
>  =20
>       s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTim=
erCB *) fifo_timeout_int, s);
> @@ -990,7 +992,6 @@ SerialState *serial_init(int base, qemu_irq irq, int =
baudbase,
>       s->irq =3D irq;
>       qdev_prop_set_uint32(dev, "baudbase", baudbase);
>       qdev_prop_set_chr(dev, "chardev", chr);
> -    serial_realize_core(s, &error_fatal);
>       qdev_set_legacy_instance_id(dev, base, 2);
>       qdev_init_nofail(dev);
>  =20
> @@ -1011,6 +1012,7 @@ static void serial_class_init(ObjectClass *klass, v=
oid* data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       dc->user_creatable =3D false;
> +    dc->realize =3D serial_realize;
>       dc->vmsd =3D &vmstate_serial;
>       dc->props =3D serial_properties;
>   }
> @@ -1074,8 +1076,6 @@ SerialState *serial_mm_init(MemoryRegion *address_s=
pace,
>       s->irq =3D irq;
>       qdev_prop_set_uint32(dev, "baudbase", baudbase);
>       qdev_prop_set_chr(dev, "chardev", chr);
> -
> -    serial_realize_core(s, &error_fatal);
>       qdev_set_legacy_instance_id(dev, base, 2);
>       qdev_init_nofail(dev);
>  =20
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 3dc618598e..571aab97c8 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -83,7 +83,6 @@ typedef struct SerialState {
>   extern const VMStateDescription vmstate_serial;
>   extern const MemoryRegionOps serial_io_ops;
>  =20
> -void serial_realize_core(SerialState *s, Error **errp);
>   void serial_exit_core(SerialState *s);
>   void serial_set_frequency(SerialState *s, uint32_t frequency);
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


