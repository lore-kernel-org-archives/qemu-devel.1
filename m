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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542B2C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B54120737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmgDISZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B54120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfjL-0003zR-AT
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfia-00033f-R8
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfiZ-0001wL-RU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:56:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jOfiZ-0001th-JO
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:56:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id i10so18559476wrv.10
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s1hbOXlkB57cmk9x1rzEZC2RmXxk31OeTQ7tffL5Cdc=;
 b=BmgDISZ6IHQfA05jpMGczTC2ruaCsUWnJ1OMre5UY4IoO4uG2naPwwjGFftUIhlqUX
 5x1tGBIuzdeSx6uAIvO4vwkQQJsBFxGUuIUdUOKGqvgToe6AaGij4YXEjp6m0u+Vzibf
 yWiKSENMnoJM9RuhaBD0vSKNKvb7WA5AOEprcTAWgw18jvithPyutTC+tAqROpBYCPm6
 aVprtJvgtKnLoQ1F6K4n8KlRUnKNSdsQcxefI81gq7W4utrz/T21RCGzX2ZHZZhlFgtY
 XslMNZfDpesaF+4EODxAtKDQdSehMCNjM7RxO1aIhzH7/mEiyGLr2GR9jk9cYbOp1DIo
 ROhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s1hbOXlkB57cmk9x1rzEZC2RmXxk31OeTQ7tffL5Cdc=;
 b=nzAZfbLDuy8HZOoMXf2hrg5aPjdhR+P7+3KwUNPD/TFkZQI03tIP/1o16egJ4zjvlQ
 Ma3W8DWvHPMA4giOOFmNHYQz7EBxq8sntuN0aOxGeX0SWVMXyIlLp7VLs+JrMINO/hj/
 KvaEa2y408AnwKWw6tAEJwyuIhlw/jJ/NKJQAhrWUsz0A65jzDaeYdN/MIgNy7zimQta
 lGf43UgtQXvFDf1hCXpgsfc9JMYm6HI0DWe22X0maHFz7I0GNb5jDjwal4+PiAWRRjkJ
 WodbcYP8S2/sNrM/yEzLCFceYS0en1dzSPkb8GuRYHDuWW5mUn4mHVgHixx8uxB3QahY
 V6Eg==
X-Gm-Message-State: AGi0PuZIGhRNErwIVw54Nsa+nufXGpgvWGFzbs12dhmklAlz4PN89n1R
 ayda1uyG+Uyu4ndfQUvUKbPfVm/vQ4wp13Ae3kY=
X-Google-Smtp-Source: APiQypJOvwMeYAekCJtCMUwbtH13wtyf3P+Ck3fb1nf+qMDDBIIkhLI4Gaq3RgTDFUDiNBaf9Mlk6v1mYYKxBTL5v1c=
X-Received: by 2002:adf:ed07:: with SMTP id a7mr29463526wro.2.1586948190064;
 Wed, 15 Apr 2020 03:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-6-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-6-alazar@bitdefender.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Apr 2020 12:56:18 +0200
Message-ID: <CAJ+F1CLrHNs=WS6+zOLquX6jXxSnEzMF1ZrM_X7M9oYSZVB6pA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/26] char-socket: add 'fd' property
To: =?UTF-8?Q?Adalbert_Laz=C4=83r?= <alazar@bitdefender.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 15, 2020 at 3:07 AM Adalbert Laz=C4=83r <alazar@bitdefender.com=
> wrote:
>
> This is used by the VM introspection object, after handshake, to hand
> over the file descriptor to KVM.
>
> CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>


patch looks ok,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


Though I wonder about potential conflicts of fd usage here..


> ---
>  chardev/char-socket.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 22ab242748..76d0fb8839 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1499,6 +1499,21 @@ static bool char_socket_get_reconnecting(Object *o=
bj, Error **errp)
>      return s->reconnect_time > 0;
>  }
>
> +static void
> +char_socket_get_fd(Object *obj, Visitor *v, const char *name, void *opaq=
ue,
> +                   Error **errp)
> +{
> +    int fd =3D -1;
> +    SocketChardev *s =3D SOCKET_CHARDEV(obj);
> +    QIOChannelSocket *sock =3D QIO_CHANNEL_SOCKET(s->sioc);
> +
> +    if (sock) {
> +        fd =3D sock->fd;
> +    }
> +
> +    visit_type_int32(v, name, &fd, errp);
> +}
> +
>  static int tcp_chr_reconnect_time(Chardev *chr, int secs)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> @@ -1539,6 +1554,9 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
>      object_class_property_add_bool(oc, "reconnecting",
>                                     char_socket_get_reconnecting,
>                                     NULL, &error_abort);
> +
> +    object_class_property_add(oc, "fd", "int32", char_socket_get_fd,
> +                              NULL, NULL, NULL, &error_abort);
>  }
>
>  static const TypeInfo char_socket_type_info =3D {
>


--=20
Marc-Andr=C3=A9 Lureau

