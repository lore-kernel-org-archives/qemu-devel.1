Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884DFC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5005120737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuLYskoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5005120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfb3-00064u-Ht
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfZZ-0004K9-QV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfZY-00070Z-NI
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:47:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jOfZY-0006xi-Gr
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:47:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so18400371wma.4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eaH8cnBY+1M0lWYZxTpwdfzQ/feooZwfZWoSUSO/MQg=;
 b=uuLYskoeRrd/xxXh8dn9deOFfxrz1mXX1hq2G8jr8RkGHwA/XGYbNU9QHyHZYvL4uj
 0JkLxwlb/LMPuESEgSE1cSLin7PVjE57RzEdQ16F3uHzQHzx7dD5R/sJ0Aibt8GLqUF+
 8TWCYk7yvB73S4jgK8R2h84+ysnDgCm7tsIU1udvYS0FWM6mwRdVzPrUYCVmbEmdFvyj
 OBakrF93IwI0otvLTkL3rUPRhwex5fno8yvD+Xtyse16sKQPlfZPJVnsoRLpkPTuTEUn
 /QR7mYHmp+a8f4r2qx6gj14OIgQ1dSVuWMGDkLN/RpluWu7xBoDfLNVGocwoYYQn7yh6
 guRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eaH8cnBY+1M0lWYZxTpwdfzQ/feooZwfZWoSUSO/MQg=;
 b=D0j+zJAuamGoSkKQB4q25vuEUuRFnCzHE8aXoge4WFP9wu10XInolNsdpKIlENfk1H
 n087k+bwQC9MJG44U1dHTJBc1GtqEP717oIo/9MYI+a9y1nixGV7YVLzK+brWCwAbJEy
 EU2j5MO+GDgqfF0w+9K+4tDGLtLLI91aJ9rbDc+wtWdiHjYohERxMedyNkYZuPBVpxrf
 TvaQV5zxGn00kEg4c3ptKOeMoCWUHzzRZ7vyt4bsril6I8arGn03GvMBnTNT0u4FHWNl
 mbwn04/DS/oKGU63TP9tZwagfxEzapVyWa2zqtAXeQeFda02YSCtGeY/NhBOcTIFX4+K
 Gcgw==
X-Gm-Message-State: AGi0PubJUDH5L9/1NlnXIROyOXunIYTNNubNfTeNEHMAL1zNkJaDTCg1
 z+KIH+3gj/Dx7e5jkBwiDCjCwTkGHgVK5X+8By458Z5+
X-Google-Smtp-Source: APiQypJqMne8VMtYR4ud5M7+hY5dvvC18aUKHQjcImbugMgHreM/SqG2p4uiKYNpVNg+6jM+hx1KoiZiWWFhjbNdd5E=
X-Received: by 2002:a1c:e284:: with SMTP id z126mr4817729wmg.32.1586947630424; 
 Wed, 15 Apr 2020 03:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-5-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-5-alazar@bitdefender.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Apr 2020 12:46:57 +0200
Message-ID: <CAJ+F1C+JsPGWy=KJXcDyfsHOmmtUPP7vNvwJu_pFeeO6Mg-XyQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 04/26] char-socket: add 'reconnecting' property
To: =?UTF-8?Q?Adalbert_Laz=C4=83r?= <alazar@bitdefender.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Apr 15, 2020 at 3:03 AM Adalbert Laz=C4=83r <alazar@bitdefender.com=
> wrote:
>
> This is used by the VM introspection object to check if the connection
> will be reestablished in case it disconnects from some reason.
>
> The closing of the socket is used by any of the three parties involved,
> KVM, the introspection tool and QEMU (eg. on force-reset), to signal
> the other parties that the session is over. As such, it is very important
> that the socket will reconnect.
>
> CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
> ---
>  chardev/char-socket.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index fd0106ab85..22ab242748 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1492,6 +1492,13 @@ char_socket_get_connected(Object *obj, Error **err=
p)
>      return s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
>  }
>
> +static bool char_socket_get_reconnecting(Object *obj, Error **errp)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(obj);
> +
> +    return s->reconnect_time > 0;
> +}
> +
>  static int tcp_chr_reconnect_time(Chardev *chr, int secs)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> @@ -1528,6 +1535,10 @@ static void char_socket_class_init(ObjectClass *oc=
, void *data)
>
>      object_class_property_add_bool(oc, "connected", char_socket_get_conn=
ected,
>                                     NULL, &error_abort);
> +
> +    object_class_property_add_bool(oc, "reconnecting",
> +                                   char_socket_get_reconnecting,
> +                                   NULL, &error_abort);

That may be misleading, as the socket connection may be established
and this will return true if reconnect_time > 0. Why not have a
"reconnect-time" property instead?

>  }
>
>  static const TypeInfo char_socket_type_info =3D {
>


--=20
Marc-Andr=C3=A9 Lureau

