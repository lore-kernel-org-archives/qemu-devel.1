Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6641DC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BEE2051A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AH95zfq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BEE2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeZp-0006oC-Ch
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyeZ9-0006Fd-Se
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyeZ8-0003I4-1V
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:27:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38898
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyeZ7-0003B3-Tn
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580747232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QeCBVp1KPvqehrC6OiB2uJKqww75jQAealCEUARBU5U=;
 b=AH95zfq1UbY8wWWL2m2AvNrrO4G3+HgzZSeW3bfx5NP8ccZCnm8r/Fi58O5BuwW/YWeesn
 1VXiXMZn1t3ETo1GFtTKNQCf3oVgjZi+O/6k9zqt/VGI+9UW5nV0JnASDqryNjK0oEek3j
 y7i/do3Wop3xlzTkkyo+Ryla3Z9D/qE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-wswZNTZxO0mVXELnzKBvwQ-1; Mon, 03 Feb 2020 11:27:11 -0500
Received: by mail-wm1-f71.google.com with SMTP id s25so5040306wmj.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V9ZnIYefrPXQs+RPAOIp4pYvstrzQL+oKuT6OoiNitI=;
 b=gQxL3Lyhii7JHIDjuDU+yAkvYeCnYI4DgjSa7gVhppq8z/t8zUo12SHZDyrlQ/m14L
 Tvd5Jn8qUavM/5ND94Zlizugy0yQjuODZgzkSLog6ck5vspKjlZFBoeucF4XL0rqBzDl
 OmxW9WX4+v3UY3M0OKS2DI5W4KlGmVMq6XNm6ee/f6jsIlQc+YsQp0RWBLiDPMNQFPc/
 XDrwCXqAN3DVO30efCehkwLBLn6+ya7HW96b+x6DkaVu0QG6iNDGzig6eUJAPwEyxx/i
 ILLUcjO+e1Xv1OYNt6YEoiJnGp42b+88VcdL+wO+rpedxgeY2KuWPMelZohzkjN6Ibfw
 D8bg==
X-Gm-Message-State: APjAAAXOUJxAVf2meLCfho6pfYvVgUEVTuWJJk9b+/olwP+bO5/+OO8F
 n8XqHhP2XBYtwfVLjdN6LdUjNyHfap9LLzPYJKhD/hvuZzVZO/cj7JP3cPejNONnuPbnUejcY0o
 v48L9R7KoHCm0sCs=
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr15471380wru.99.1580747229980; 
 Mon, 03 Feb 2020 08:27:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhWHVzgTNBLX4cg3QI1NBiuM24400sOv0IEQ3i9nR/19BV6mNRxUjoGn/db5isItTvrrcNaA==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr15471366wru.99.1580747229803; 
 Mon, 03 Feb 2020 08:27:09 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id a62sm24771220wmh.33.2020.02.03.08.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 08:27:09 -0800 (PST)
Subject: Re: [PATCH v2 2/2] bcm2835_dma: Re-initialize xlen in TD mode
To: Rene Stange <rsta2@o2online.de>
References: <5397138.k0qeMALlIp@desktop2>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <80ae5ce3-c58d-800c-4748-ea4842a6ff84@redhat.com>
Date: Mon, 3 Feb 2020 17:27:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5397138.k0qeMALlIp@desktop2>
Content-Language: en-US
X-MC-Unique: wswZNTZxO0mVXELnzKBvwQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Andrew Baumann <andrew.baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 4:40 PM, Rene Stange wrote:
> TD (two dimensions) DMA mode did not work, because the xlen variable
> has not been re-initialized before each additional ylen run through
> in bcm2835_dma_update(), which has been fixed.

"which has been fixed" confused me, because this current patch is fixing=20
it. Using present tense makes it easier to understand for non-native=20
English speakers IMHO:

   TD (two dimensions) DMA mode does not work, because the xlen
   variable is not re-initialized before each additional ylen
   run through in bcm2835_dma_update(). Fix it.

If you agree, maybe Peter (the maintainer who will take your patch) can=20
make the change for you.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>=20
> Signed-off-by: Rene Stange <rsta2@o2online.de>
> ---
>   hw/dma/bcm2835_dma.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
> index 667d951a6f..ccff5ed55b 100644
> --- a/hw/dma/bcm2835_dma.c
> +++ b/hw/dma/bcm2835_dma.c
> @@ -54,7 +54,7 @@
>   static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
>   {
>       BCM2835DMAChan *ch =3D &s->chan[c];
> -    uint32_t data, xlen, ylen;
> +    uint32_t data, xlen, xlen_td, ylen;
>       int16_t dst_stride, src_stride;
>  =20
>       if (!(s->enable & (1 << c))) {
> @@ -82,6 +82,7 @@ static void bcm2835_dma_update(BCM2835DMAState *s, unsi=
gned c)
>               dst_stride =3D 0;
>               src_stride =3D 0;
>           }
> +        xlen_td =3D xlen;
>  =20
>           while (ylen !=3D 0) {
>               /* Normal transfer mode */
> @@ -117,6 +118,7 @@ static void bcm2835_dma_update(BCM2835DMAState *s, un=
signed c)
>               if (--ylen !=3D 0) {
>                   ch->source_ad +=3D src_stride;
>                   ch->dest_ad +=3D dst_stride;
> +                xlen =3D xlen_td;
>               }
>           }
>           ch->cs |=3D BCM2708_DMA_END;
>=20


