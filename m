Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0FEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A70D22519
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSIEDpoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A70D22519
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPBL-0003Db-KI
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXP9l-000215-86
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXP9k-00047P-3a
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:32:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20394
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXP9k-000424-02
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574253135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNr91VHOHr+EjZehfhxVDFvZzrBBHC3X4uXRcPLqpE0=;
 b=fSIEDpohNEF6lVcGUneLvau9Auy1hkCZ6AvPTSDP/h0oD6xNwMIyeKWKuWGeMDbr5IYbIY
 u3kStb7KYQ9SAgEZqlyHQ4r5BA8a3rViXsrrXlANoFKLFN5leAIKgCG/vptdawdQuVwPmK
 TzryKSkrAY0b/g0wiHVFeGIZjHZ9qdg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-Excm-KMrPnq4Z63jUMplvQ-1; Wed, 20 Nov 2019 07:32:14 -0500
Received: by mail-wr1-f69.google.com with SMTP id k15so21074177wrp.22
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 04:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fyra5V6iUSdWSbfZeV/HRb8fo7AY542XDy1yURjY304=;
 b=VSbzj6XzUWkolFgDI/yUgD/k1aDy5ZgxsBxC7Q8ZqeHq1UTrILA8PJ2fePdaLWnZIS
 0ZFowG0xF4q/TnOxchDiH6PFHUf7CRzKMk0CWTd/9Zdcrj5jt3vEC/wnzcF3oIS4R0xD
 tDccrHIsVBe850b99L0/XOXfrI5quK9Xqv4MmYySt0aNQV6VADmdi8T+95mEUAqHPNTi
 4JEb2V7C33LIwc/dPSrGmDHy8GnOIuQiwXUQKJ6910nutFN6AbJvkDX0CqFXJOU5H/yx
 1ibSSYQ26LBrw0oyos9xyI3NhCeMsxVz1Sw29JXsfuN5KVHuBxjFYoTzFHgNtUTWWz2f
 Hw0w==
X-Gm-Message-State: APjAAAViBIu/T/Tyxd9rI+cAZBqO7598bRjwQHAiTt5s1QjVlj7lLWWW
 UFELH6RDOANHIZi/6hAgtusDBVe5ry8HlPlqAZxLc365ECeHYLQC6I0zOGrYV34i5lR5Vm2BCem
 0v2f9XNTxOWyT6sU=
X-Received: by 2002:adf:9323:: with SMTP id 32mr3022949wro.15.1574253133119;
 Wed, 20 Nov 2019 04:32:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKq4UqQiCDcAplWhMEJXbGM/xR269ds7Zc2uF1Ap6RLkV7dUnTlk5OfOT54RCk+dk5XUN4lw==
X-Received: by 2002:adf:9323:: with SMTP id 32mr3022903wro.15.1574253132875;
 Wed, 20 Nov 2019 04:32:12 -0800 (PST)
Received: from [10.201.33.134] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id g138sm6672647wmg.11.2019.11.20.04.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 04:32:12 -0800 (PST)
Subject: Re: [PATCH v3 12/33] serial: replace serial_exit_core() with unrealize
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-13-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <58a2eeb4-9241-2beb-d5fd-41e306f5376e@redhat.com>
Date: Wed, 20 Nov 2019 13:32:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-13-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: Excm-KMrPnq4Z63jUMplvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> Instead of calling serial_exit_core() directly, use the QDev unrealize
> callback.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial-pci-multi.c | 2 +-
>   hw/char/serial-pci.c       | 2 +-
>   hw/char/serial.c           | 5 ++++-
>   include/hw/char/serial.h   | 1 -
>   4 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 60c1c948b8..a3200555aa 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -56,7 +56,7 @@ static void multi_serial_pci_exit(PCIDevice *dev)
>  =20
>       for (i =3D 0; i < pci->ports; i++) {
>           s =3D pci->state + i;
> -        serial_exit_core(s);
> +        object_property_set_bool(OBJECT(s), false, "realized", NULL);
>           memory_region_del_subregion(&pci->iobar, &s->io);
>           g_free(pci->name[i]);
>       }
> diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
> index 35a8552674..54bdd98325 100644
> --- a/hw/char/serial-pci.c
> +++ b/hw/char/serial-pci.c
> @@ -69,7 +69,7 @@ static void serial_pci_exit(PCIDevice *dev)
>       PCISerialState *pci =3D DO_UPCAST(PCISerialState, dev, dev);
>       SerialState *s =3D &pci->state;
>  =20
> -    serial_exit_core(s);
> +    object_property_set_bool(OBJECT(s), false, "realized", NULL);
>       qemu_free_irq(s->irq);
>   }
>  =20
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index bf34d9594e..667570e310 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -951,8 +951,10 @@ static void serial_realize(DeviceState *dev, Error *=
*errp)
>       qdev_set_legacy_instance_id(dev, s->instance_id, 2);
>   }
>  =20
> -void serial_exit_core(SerialState *s)
> +static void serial_unrealize(DeviceState *dev, Error **errp)
>   {
> +    SerialState *s =3D SERIAL(dev);
> +
>       qemu_chr_fe_deinit(&s->chr, false);
>  =20
>       timer_del(s->modem_status_poll);
> @@ -1014,6 +1016,7 @@ static void serial_class_init(ObjectClass *klass, v=
oid* data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       dc->realize =3D serial_realize;
> +    dc->unrealize =3D serial_unrealize;
>       dc->vmsd =3D &vmstate_serial;
>       dc->props =3D serial_properties;
>   }
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index b445df5951..7cc6304f1d 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -84,7 +84,6 @@ typedef struct SerialState {
>   extern const VMStateDescription vmstate_serial;
>   extern const MemoryRegionOps serial_io_ops;
>  =20
> -void serial_exit_core(SerialState *s);
>   void serial_set_frequency(SerialState *s, uint32_t frequency);
>  =20
>   #define TYPE_SERIAL "serial"
>=20

Nice.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


