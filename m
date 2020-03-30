Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8193C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955F22073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbVmx5qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955F22073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyIt-0001K2-NW
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jIyDv-0001eH-8u
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jIyDt-00024v-NB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:29:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jIyDt-00023L-GZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:29:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id t7so22669516wrw.12
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PA5wTsMyZb5SO7CwWL/Rgj9qtHWzP1IqZcCrt3MWO60=;
 b=VbVmx5qbOr6TS9xWLLA9D4rAQl6SAvOM0b+hkheFDTUvBewXWj009FkoNh+orQVu/7
 3jyq2OTBl6stLvyD05mCtW0BHuWbPnD91rsIF0crkff0iE43qP3Cb4Pvkay17kittVxZ
 a6tGjDg25gS7q0TXLQwtuWtFo9VD7PoMJ2vFs5WL+KAzogUIfbL7sj+n3JywvFZ/0fVZ
 Vtf6CPGqWpK/AMUhJVHAFUl/eV8gINhyl55QlzMK3EKPhHjjnamjNOG2EIePZ03dsPWY
 SAuGP6TQ8ij3mGp/QNyfKVGJZJkGuIKxG6vg4VHbTagiLkyeLVHC9W2RqYoyRr4vWWWE
 zPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PA5wTsMyZb5SO7CwWL/Rgj9qtHWzP1IqZcCrt3MWO60=;
 b=WKhtmXaRtyKtIwjb0GHJeHR21A1sD1h+XYVLoJzVVvud6F2Ie9BZV6t9TccUTdtLAp
 tX/3OYZG9HHz5AnlYoQ58JAZXc90gqpGg8UQpUj5f4uhebEw1FELiIj89eHKtkkSzGKQ
 RRZ6OvNA7MVs7VPW5gNDdAuNbLyxOu+jJoSy+fIwRiPbGBdnxardcpip17lQLmoXg76G
 4cAebve2r9nCuTfv0ZFZAT+ptmO1PBwodVzZtlAKTCdrpBaPC2g6aQKu/1dVOPXkrmmn
 y7p+vJgdZyE/ofU3moabhb4OVo1qsuu4FXR+kUqkiGRNmsD2vUMngxOtr5l6eEoDNC/P
 2rlA==
X-Gm-Message-State: ANhLgQ1RR7qFw+GI0bG8wJOFNRFbPyobNDMWdYE0yGhjf/eXXX0njIzD
 UJzou/L/vUvd/Ak5w44uCbRn87GCJR3tixo3SU8=
X-Google-Smtp-Source: ADFU+vuiahG8Io2cxm/zAOZtpPSYKj+B+BKC7I63A1EElTBrc7NCdWp5Ct0o0HMcss2ymTsotRZAoN+0I5lK1vY6Yj4=
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr15282533wrn.381.1585589356154; 
 Mon, 30 Mar 2020 10:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200330164712.198282-1-dgilbert@redhat.com>
In-Reply-To: <20200330164712.198282-1-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 30 Mar 2020 19:29:04 +0200
Message-ID: <CAJ+F1CKd9x3BQKCGFPF8ouW4Fzvw0R5z3ZRT_0XPNSepP5hMZQ@mail.gmail.com>
Subject: Re: [PATCH] serial: Fix double migration data
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Mar 30, 2020 at 6:47 PM Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> After c9808d60281 we have both an object representing the serial-isa
> device and a separate object representing the underlying common serial
> uart.  Both of these have vmsd's associated with them and thus the
> migration stream ends up with two copies of the migration data - the
> serial-isa includes the vmstate of the core serial.   Besides
> being wrong, it breaks backwards migration compatibility.
>
> Fix this by removing the dc->vmsd from the core device, so it only
> gets migrated by any parent devices including it.
> Add a vmstate_serial_mm so that any device that uses serial_mm_init
> rather than creating a device still gets migrated.
> (That doesn't fix backwards migration for serial_mm_init users,
> but does seem to work forwards for ppce500).
>
> Fixes: c9808d60281 ('serial: realize the serial device')
> Buglink: https://bugs.launchpad.net/qemu/+bug/1869426
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/char/serial.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 2ab8b69e03..c822a9ae6c 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1043,7 +1043,6 @@ static void serial_class_init(ObjectClass *klass, v=
oid* data)
>      dc->user_creatable =3D false;
>      dc->realize =3D serial_realize;
>      dc->unrealize =3D serial_unrealize;
> -    dc->vmsd =3D &vmstate_serial;
>      device_class_set_props(dc, serial_properties);
>  }
>
> @@ -1113,6 +1112,16 @@ static void serial_mm_realize(DeviceState *dev, Er=
ror **errp)
>      sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
>  }
>
> +static const VMStateDescription vmstate_serial_mm =3D {
> +    .name =3D "serial",
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 2,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_STRUCT(serial, SerialMM, 0, vmstate_serial, SerialState)=
,
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +

Why do you make it a sub-state?

# qemu-system-ppc -M ppce500 -monitor stdio -serial pty
in 4.2 and 5.0:
    "serial (8)": {
        "divider": "0x00d9",
        "rbr": "0x00",
        "ier": "0x00",
        "iir": "0xc1",
        "lcr": "0x03",
        "mcr": "0x03",
        "lsr": "0x60",
        "msr": "0xb0",
        "scr": "0x00",
        "fcr_vmstate": "0x01"
    },

With this patch:
    "serial (8)": {
        "serial": {
            "divider": "0x00d9",
            "rbr": "0x00",
            "ier": "0x00",
            "iir": "0xc1",
            "lcr": "0x03",
            "mcr": "0x03",
            "lsr": "0x60",
            "msr": "0xb0",
            "scr": "0x00",
            "fcr_vmstate": "0x01"
        }
    },

>  SerialMM *serial_mm_init(MemoryRegion *address_space,
>                           hwaddr base, int regshift,
>                           qemu_irq irq, int baudbase,
> @@ -1162,6 +1171,7 @@ static void serial_mm_class_init(ObjectClass *oc, v=
oid *data)
>
>      device_class_set_props(dc, serial_mm_properties);
>      dc->realize =3D serial_mm_realize;
> +    dc->vmsd =3D &vmstate_serial_mm;
>  }
>
>  static const TypeInfo serial_mm_info =3D {
> --
> 2.25.1
>
>

I understand removing the serial state from SerialClass solves the
double state issue for ISA. But at the same time, I think we should
aim to migrate ISASerial state to SerialClass state. I can take a look
if you want.



--=20
Marc-Andr=C3=A9 Lureau

