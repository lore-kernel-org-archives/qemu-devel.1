Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE8FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B46E2230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaslSEzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B46E2230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXLya-0007iX-I1
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iXLxE-00074l-6g
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iXLxD-0001Za-0q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:07:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32057
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iXLxC-0001Z4-U2
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574240834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALFXgvw2+Ywh0La2rY/2AgSmoI+KxNje5YV530vNzaQ=;
 b=KaslSEzrunT729p4n+/jV81Yf862r0Wx+o6k0aGtgJ5OZLPB5EcDemsqvwg+BXQ4A2Z/bb
 W0Js3CAwV4BNBfpgByHIDVVw2sIh/tJclKZQuXv1WCdCIKaO3yBf22XfbD1F4FSuhZNQRt
 us397FXmEpqp9KxPb0b2du8C5fN2RB4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-cJgjt3T5MEqruQYGv1z1nw-1; Wed, 20 Nov 2019 04:07:12 -0500
Received: by mail-ot1-f70.google.com with SMTP id g17so13608704otg.10
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ALFXgvw2+Ywh0La2rY/2AgSmoI+KxNje5YV530vNzaQ=;
 b=Fz9iUzy3Bct5g3oZi7DqEE9v7SiODRH+Qgtouh6bDhcS9eyMidKipLSLzAl2/DkK3C
 TZOXIqjyAlNDuULI8tQ9bx03ymx+kdR10b328EvhhIS7qHcQJIVxBmYxZ1z6JU2KT02p
 CDxXYahXLoAv6WTpQyoaldPVI+ykciWFxJR1aIhjzHiq6u8IrWpWd4V4iRZAVo8Jpb2G
 d7nsvtj5cf0so0XTjmxnANmIV0Y3LjWeOOhJdMPSoyf2ikHStpSaZvLERTgn0VbSy9g2
 yb7hMkY2XqZSir15rby4v12fOKbM5q+Uoc3yBANy5c4QgjwatyjpLzR7LweqJmNsPIUf
 KoGQ==
X-Gm-Message-State: APjAAAUYleMOpBkImpIp1RGt+NJo9INsqifgjKPX94poWdZHChTxRFA+
 H7yMwZMPYNxhQiJYPLaLUq6gOmt92t7qjV9YwmUVAF4O0YtikhmeglrVngNIfR8/5W06KRSib0w
 RadLBuvr7VNTWe119abFGizPb9aiWbHM=
X-Received: by 2002:a9d:5cc7:: with SMTP id r7mr1058746oti.331.1574240831078; 
 Wed, 20 Nov 2019 01:07:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9M60RPEuZadjNYvLk44fFKenxtWl4x7M+j6aew8VnTx12/cx7FyOGtCcqI6LQDW1zZzW87WZI2Z8KL9CqFbU=
X-Received: by 2002:a9d:5cc7:: with SMTP id r7mr1058729oti.331.1574240830680; 
 Wed, 20 Nov 2019 01:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-11-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-11-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Nov 2019 13:06:59 +0400
Message-ID: <CAMxuvawDuKD9_6w06KP9m2HqWkAx6HEtSVLFjWLY=yE9AgpFRw@mail.gmail.com>
Subject: Re: [PATCH v3 10/33] serial: add "instance-id" property
To: qemu-devel <qemu-devel@nongnu.org>
X-MC-Unique: cJgjt3T5MEqruQYGv1z1nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Oct 23, 2019 at 9:33 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> This property will be used to move common vmstate registration to
> device realize in following patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I realize adding a "instance-id" property instead of calling
qdev_set_legacy_instance_id() manually doesn't really help.
Patch dropped.

> ---
>  hw/char/serial.c         | 3 +++
>  include/hw/char/serial.h | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 069d8715d0..0b61a71e4e 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -990,6 +990,7 @@ SerialState *serial_init(int base, qemu_irq irq, int =
baudbase,
>      s->irq =3D irq;
>      qdev_prop_set_uint32(dev, "baudbase", baudbase);
>      qdev_prop_set_chr(dev, "chardev", chr);
> +    qdev_prop_set_int32(dev, "instance-id", base);
>      serial_realize_core(s, &error_fatal);
>      qdev_set_legacy_instance_id(dev, base, 2);
>      qdev_init_nofail(dev);
> @@ -1003,6 +1004,7 @@ SerialState *serial_init(int base, qemu_irq irq, in=
t baudbase,
>  static Property serial_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", SerialState, chr),
>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> +    DEFINE_PROP_INT32("instance-id", SerialState, instance_id, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -1073,6 +1075,7 @@ SerialState *serial_mm_init(MemoryRegion *address_s=
pace,
>      s->irq =3D irq;
>      qdev_prop_set_uint32(dev, "baudbase", baudbase);
>      qdev_prop_set_chr(dev, "chardev", chr);
> +    qdev_prop_set_int32(dev, "instance-id", base);
>
>      serial_realize_core(s, &error_fatal);
>      qdev_set_legacy_instance_id(dev, base, 2);
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 3dc618598e..b472c7cd57 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -78,6 +78,7 @@ typedef struct SerialState {
>
>      QEMUTimer *modem_status_poll;
>      MemoryRegion io;
> +    int instance_id;
>  } SerialState;
>
>  extern const VMStateDescription vmstate_serial;
> --
> 2.23.0.606.g08da6496b6
>


