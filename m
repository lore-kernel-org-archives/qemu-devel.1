Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05CDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0E92251D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YR+ZW4l6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0E92251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPZm-0002Lm-Hx
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXPY3-0001Dl-EZ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXPY2-0007nt-6D
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:57:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39716
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXPY1-0007nV-NU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574254649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/Ctjf8+Vu2PC1M/BSDoeVyXahzZHXAbzR9A6DKDxlY=;
 b=YR+ZW4l6gzjGkoPCFwg2D1/798izND0/FTcmMcI6KaeffGnONppJDXESHo1PsGZIpMePea
 bCOcLT8PqoovBArj6ZUjGC3tCN2YielnS2MqN5DuwpMLoec+bnz/YBJkZnmMRChZkkzpcT
 3ntgR6Bhmrtqk9EbKFob8hLP2hfTb8c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-j_qi-2tuNciffRbAaT8yuQ-1; Wed, 20 Nov 2019 07:57:16 -0500
Received: by mail-wm1-f72.google.com with SMTP id x16so5084152wmk.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 04:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oAQSreoPfD9tCgT5z71iCNKY83QDH30dryE1pdkJyd8=;
 b=MblTEsvAeABbJP8AMoeTBMkOKnHJKTatrArLkBQR77La7+ud40u4hJ8x81ZMJDXO4y
 VVqcjFKQ6IDYmI9fCDrAFCvC2FAyz3NrCvETrxBxhb64uc14gnWX3k88upoYq8b9nJ4p
 C/U5I1r+4syaMRwxRiAcmyD30jcSEKwpHgvYxBvJf/tTpV2lCgqHWMjxxqXte4jWwKDm
 BpwG2AZa16KjL1o+Bl1tlOYEfrmSPJwPwBq24no6BdlYyuJoY3246r8KM00nIBMao9qU
 C+ZfsDkw2vc5k+BYQ1yCwEFEKij/3cI6GXQFliYkMWs8mFfm62kVnFjPLLeXx7mLsqjt
 tbQA==
X-Gm-Message-State: APjAAAUTDazfVvFblv+YgxW4IcAwadIME88dOjV/NxeSXKnuRifLkyut
 9KnAPoKNn4Gu6b8JePZcVHnOcXNqztzQeQLy6wjQDH5FeCC7Z5wkFHU/BXzqBwJELQr0s/zomMU
 2fi5ZPi31bIurN3o=
X-Received: by 2002:a1c:9646:: with SMTP id y67mr3009917wmd.79.1574254635504; 
 Wed, 20 Nov 2019 04:57:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUTpf/OvZ0+cLN15ta0xNC+TL7dt9OxSH3r3Dn5bYLtIdwv9dZGn/TXG0dSHelVa9qlBUfbA==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr3009887wmd.79.1574254635302; 
 Wed, 20 Nov 2019 04:57:15 -0800 (PST)
Received: from [10.201.33.134] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id o1sm31394257wrs.50.2019.11.20.04.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 04:57:14 -0800 (PST)
Subject: Re: [PATCH v3 15/33] serial-mm: add endianness property
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-16-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7581fd7f-9284-9f62-493d-16831209cc0b@redhat.com>
Date: Wed, 20 Nov 2019 13:57:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-16-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: j_qi-2tuNciffRbAaT8yuQ-1
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
> Add a qdev property for endianness, so memory region setup can be done
> in realize.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial.c         | 2 ++
>   include/hw/char/serial.h | 1 +
>   2 files changed, 3 insertions(+)
>=20
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index c28cfc94fd..2f7667c30c 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1081,6 +1081,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_spac=
e,
>       qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
>       qdev_prop_set_chr(DEVICE(s), "chardev", chr);
>       qdev_prop_set_int32(DEVICE(s), "instance-id", base);
> +    qdev_prop_set_uint8(DEVICE(s), "endianness", end);
>  =20
>       qdev_init_nofail(DEVICE(s));
>       qdev_init_nofail(DEVICE(self));
> @@ -1102,6 +1103,7 @@ static void serial_mm_instance_init(Object *o)
>  =20
>   static Property serial_mm_properties[] =3D {
>       DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
> +    DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_=
ENDIAN),

The endianess is related to how the chipset is wired, but is not an=20
intrinsic part of it.
Previously, serial_mm_init() was taking care of doing the correct wiring.
Now it seems the endianess is a property from the hardware.

Anyway:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 759c85976d..2d0802a909 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -86,6 +86,7 @@ typedef struct SerialMM {
>       SerialState serial;
>  =20
>       uint8_t regshift;
> +    uint8_t endianness;
>   } SerialMM;
>  =20
>   extern const VMStateDescription vmstate_serial;
>=20


