Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782B1C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C752189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTgJj9yX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C752189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiabz-0005nz-I0
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hiabD-0005O3-BN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hiabC-0002Xo-H7
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:26:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hiabC-0002X2-9E
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:26:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so1664040wrw.13
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AM/jDFMBQy3O5wIoC0iRg+YUu5zIxRoF/POphW+Fr4c=;
 b=HTgJj9yX9RCDCqFCZhLd1I6GEvKQImwvJ1/eicOy1JB7j5k23QdQX+Je5OhJnzYwpM
 /kQjsBnYpNPFqzHAktu2VO3IRdk0rpnMHml7C0MkQLLQHQ6nZ2METkGwHgVYADH02BV5
 4yHv96z2ebC+wonIV3/y1VKDB3/MVbRt7DghB761O1T6LYuQJPAydrLipfrLXCfX8ssr
 LWRV+qnsp+L8/1svBUotJAbcZOxf+b3DToqP1Z2NAVCXXP51UWWaI0e/9QO09Zmd9PnS
 r9ygwNkazRo/J8rokB7n/n8tY9xEk+weuh36jiu7VH1OoWei7s9nHwMmqODGgDSicw85
 uywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AM/jDFMBQy3O5wIoC0iRg+YUu5zIxRoF/POphW+Fr4c=;
 b=VwdcVIAT/RUY15v4cL0LHyq5WuMoQEcdJB9+bx6Z+EfqnmeMb9JEKFF/ckhJhb9mUR
 eDUmNjtrUvMlmI1yEZCH5zhb871690bhlXJ3lzvoi2g2P7ugTTg4eM6TolnY5zEUspRN
 cGAlTcQGIwDhdfMGoLu5haycP/Na2IgKL4oGkDwkqLpukhc3kVrF95pzG/aCIHEwhc0V
 4GwZz9nEzTpv+y9WjL3NMs83WIYbfdaFrpy4KHts61BYKWZkjoG8NZbBvpjmShg0Tk89
 krG5yrc49GZDC8GHu6NlvQdlhGpB6irsDa1siebUCAJBM5ohLLvff+BIf8ASNIFGoRbW
 Q+mg==
X-Gm-Message-State: APjAAAXBGr6Tc4OLjU6J9LX4X+YVgLKw6tOC9UanASWcpHDgjgV/aixy
 tgfrW3FCINoXSJwGfZldUDVJQtT3XIBclDH/2tQ=
X-Google-Smtp-Source: APXvYqzU8iCyihUs0HeH2fxa/EHoDENe6TBmrCL1xXh5VTjUiGTqMh9mcPcGBETZw5rgLLn2uYZxSB2yO8936fdnjMc=
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr6429761wrv.186.1562142400211; 
 Wed, 03 Jul 2019 01:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190628161358.10400-1-liq3ea@163.com>
In-Reply-To: <20190628161358.10400-1-liq3ea@163.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Jul 2019 12:26:29 +0400
Message-ID: <CAJ+F1CJ1woPtc8teijfUACgfKk+PXC9wHXqLgBXR3NZOK_EOmg@mail.gmail.com>
To: Li Qiang <liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: check if the resource already
 exists in virtio_gpu_load()
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
Cc: QEMU <qemu-devel@nongnu.org>, Li Qiang <liq3ea@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 8:53 PM Li Qiang <liq3ea@163.com> wrote:
>
> While loading virtio-gpu, the data can be malicious, we
> should check if the resource already exists.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 2b0f66b1d6..f1ebed9959 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1002,6 +1002,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaq=
ue, size_t size,
>
>      resource_id =3D qemu_get_be32(f);
>      while (resource_id !=3D 0) {
> +        res =3D virtio_gpu_find_resource(g, resource_id);
> +        if (res) {
> +            return -EINVAL;
> +        }
> +
>          res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>          res->resource_id =3D resource_id;
>          res->width =3D qemu_get_be32(f);
> --
> 2.17.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

