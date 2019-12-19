Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D546CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC152068F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIGx0Wpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC152068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuqS-0006dg-Me
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihupC-0005PH-7p
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihupA-0007Xc-Vi
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:22:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihupA-0007UB-O5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3M1f4J2R5iqemW6qipHCEPwrKcbOp1nWjy7gB/bMvI=;
 b=BIGx0Wpe4bHF5W/vcPQ4tyudzpIZj+eyn5Ypp2z+I+s08P2yZ7TxOAYOmyHxigHxiw+lpm
 g+glqQ7/3byi//RGH4RStwxmmzCYdrVtlwSGPtSc/qo8QQTbaZWIqOJMLISYzsDE7dStZo
 bjC6gEpeAnvboO6RBIoK8fgBloeaT+g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296--NxNiX2qNaqWE0Br0MnyeA-1; Thu, 19 Dec 2019 07:22:27 -0500
Received: by mail-qk1-f200.google.com with SMTP id s9so3467059qkg.21
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=22pE+dl2XwWaFxYIJME1WJlxu9cbkzTLWmgaDhuBg24=;
 b=BIU/gtZj8qK+pwutnQaiVBpJd4+oh69el1C0ep1zGg69UuBTr/xU4wxr/R8wzRN2j+
 hX/7slV/ReeUYkbr++is6Dli7znJorBn+C0DjZSEalhOSWgRs/uYhtayhu3V0nH+ZxOH
 aPXjroydOe46KYdENdXnro5LDDbygySpoT48hY7BeThgL32w7ORoja5fjdIyZUh2KAyq
 qes2CHXCiCzV8LtfhymnoDJXeWM4Y8qG+NQRHB0zebsD6HPjPjA2jqaGyIqzKdzpx42Y
 3O0QdfxzlodHQx6B7Tq2Jcdpo7ykcXwosENEN+hQEQrWlKWtdX5tmOzrWF79wlzsf+/q
 EfOA==
X-Gm-Message-State: APjAAAU/9CsXxAtMtrcTGbzFhVkuNT8G+dYemJJkImJNV5CIsQXsTrU5
 b3eOIo9/4JYRq+LCX+tUIJUWg5eEV7PDIPGlXaL0UB73iR3UQXRfLdKrKWh6J81j07AJr4mJKdn
 FqRTZG0P1oLQeod0=
X-Received: by 2002:ae9:ed53:: with SMTP id c80mr7448520qkg.445.1576758146681; 
 Thu, 19 Dec 2019 04:22:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTmKG4jU4KJZUVX5UKzJTUBCa4y26F+TAPB3td2w56bM3Zmqmrlc5fg5JC0dfp5+ovW9UMPg==
X-Received: by 2002:ae9:ed53:: with SMTP id c80mr7448499qkg.445.1576758146469; 
 Thu, 19 Dec 2019 04:22:26 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id t42sm1846093qtt.84.2019.12.19.04.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 04:22:25 -0800 (PST)
Date: Thu, 19 Dec 2019 07:22:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 10/14] virtio-console: Explicit we ignore some
 QEMUChrEvent in IOEventHandler
Message-ID: <20191219072216-mutt-send-email-mst@kernel.org>
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-11-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218172009.8868-11-philmd@redhat.com>
X-MC-Unique: -NxNiX2qNaqWE0Br0MnyeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 06:20:05PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> The Chardev events are listed in the QEMUChrEvent enum. To be
> able to use this enum in the IOEventHandler typedef, we need to
> explicit all the events ignored by this frontend, to silent the
> following GCC warning:
>=20
>     CC      hw/char/virtio-console.o
>   hw/char/virtio-console.c: In function =E2=80=98chr_event=E2=80=99:
>   hw/char/virtio-console.c:154:5: error: enumeration value =E2=80=98CHR_E=
VENT_BREAK=E2=80=99 not handled in switch [-Werror=3Dswitch]
>     154 |     switch (event) {
>         |     ^~~~~~
>   hw/char/virtio-console.c:154:5: error: enumeration value =E2=80=98CHR_E=
VENT_MUX_IN=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   hw/char/virtio-console.c:154:5: error: enumeration value =E2=80=98CHR_E=
VENT_MUX_OUT=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   cc1: all warnings being treated as errors
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add all missing enums
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/char/virtio-console.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index c13649f1ef..cbb304d270 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -162,6 +162,11 @@ static void chr_event(void *opaque, int event)
>          }
>          virtio_serial_close(port);
>          break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
>      }
>  }
> =20
> --=20
> 2.21.0


