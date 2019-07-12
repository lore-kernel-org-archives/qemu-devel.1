Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D133C742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BF221019
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkAN0Pw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BF221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlqym-0004mx-FL
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 04:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlqyZ-0004BR-IE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlqyY-0004r4-Ga
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:32:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlqyY-0004px-9p
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:32:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id a15so8053629wmj.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6y4zfnhzjnfMXyZWyrzkDiDfLrNFeXxowmp6Xex7n24=;
 b=jkAN0Pw/jPdvYPF1LtFo+LgMxviOodG/4d3m5fY9BDfWq0kh83V1DunB0I0HsECgu5
 zThBNBZKVtzD2RldBFWtWrwiH3YWF70zsDUWXIiGMTkhO+aOEwpXpdhnuIfzWByIo9p3
 534s+eIXotuBU2TIL+S+54dzkq5Oozx6wL4yB+ZnORb262HpICVZn3hc3k94iqAkbhuY
 KWvDfSnQH0QSL3mtv6MWlkGP6sf2rnwozwRP+hEs5AvssC5G75wMqNroWGTR5FElWHE0
 gyZbPPAoaQJCwmSUjaNnaJWd+OxyVODdYs2as89kqYYv71QAdKg881ggP2FvCs83150t
 3fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6y4zfnhzjnfMXyZWyrzkDiDfLrNFeXxowmp6Xex7n24=;
 b=MvOQrzwHyrOiZg1PZvKWMjc9uoZqROnyBhJvaJFsh2nAv136SDC2WGnGM8hzYUnSAA
 ySZ4M0zs0M+ZybvQ2BEYYDdx8K4WueJ0Kmbg/l/UCuA70DjpNVJUWTujR/TSdpyqwx01
 +mwvKciCsoT/jn3QJjQf5RVpqQ0KM9mtLmE4JeI53GGAPYggbXw98tzWpb4cicwO2/iD
 nz0+bUyQOdcq3cce11momtwRghY9lJ0A6dRqDJJMr08t+lPQGoyb8/tpQ/nEwbYitLwj
 WRZA/qxpyyYRFL7/d4ukTPTCww/8A2Z1C7VlASjoXVoDv7nLXYvHmPjp1JcazvhcTU9Q
 Ykng==
X-Gm-Message-State: APjAAAVjXuvMpx8UtNHeD8ycCADhzqUP+RVmcvNLPX/wmbtwUJ0VHKQr
 9a3SzieYnRmQr1pKd+pD9X2lRIP4IcmzOp43k7w=
X-Google-Smtp-Source: APXvYqw4mH/Cyl7WxHkqj6nWK2j7OsHBawptFcT04LRAW6PN+tH4cUTyc5H5xQ3/p3FZM1UeMRKv7crOVjixe3Mg7eU=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr8167357wma.107.1562920335716; 
 Fri, 12 Jul 2019 01:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081910.29085-1-sw@weilnetz.de>
In-Reply-To: <20190712081910.29085-1-sw@weilnetz.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jul 2019 12:32:04 +0400
Message-ID: <CAJ+F1CLf2z7oG4h-wnaPDweNFYOOBGZadQctYjT7ZA-EFVD13Q@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Add missing GCC_FMT_ATTR
 and fix three format errors
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 12:25 PM Stefan Weil <sw@weilnetz.de> wrote:
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  contrib/libvhost-user/libvhost-user.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 4b36e35a82..59b3202979 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -142,7 +142,7 @@ vu_request_to_string(unsigned int req)
>      }
>  }
>
> -static void
> +static void GCC_FMT_ATTR(2, 3)
>  vu_panic(VuDev *dev, const char *msg, ...)
>  {
>      char *buf =3D NULL;
> @@ -661,7 +661,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserM=
sg *vmsg)
>
>          if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
>              vu_panic(dev, "%s: Failed to userfault region %d "
> -                          "@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n",
> +                          "@%" PRIx64 " + size:%zx offset: %zx: (ufd=3D%=
d)%s\n",
>                       __func__, i,
>                       dev_region->mmap_addr,
>                       dev_region->size, dev_region->mmap_offset,
> @@ -1753,7 +1753,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
>
>      /* If their number is silly, that's a fatal mistake. */
>      if (*head >=3D vq->vring.num) {
> -        vu_panic(dev, "Guest says index %u is available", head);
> +        vu_panic(dev, "Guest says index %u is available", idx);

The original version (hw/virtio/virtio.c) print *head. The message
isn't great, but I would rather stay consistent for now.

other than that,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>          return false;
>      }
>
> @@ -1812,7 +1812,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_d=
esc *desc,
>      smp_wmb();
>
>      if (*next >=3D max) {
> -        vu_panic(dev, "Desc next is %u", next);
> +        vu_panic(dev, "Desc next is %u", *next);
>          return VIRTQUEUE_READ_DESC_ERROR;
>      }
>
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

