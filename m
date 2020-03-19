Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21278C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EDC20663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sq3J5yB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EDC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0ZJ-00004r-0C
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jF0YZ-0007gX-7E
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jF0YX-00023K-GC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:10:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jF0YX-0001zy-8X
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584645011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KeIZlYuYdSffZCavj22PObhJmC7vl/Dgk31GrX797BA=;
 b=Sq3J5yB8THoCzONG+uIR7Mv9vNKt7pctekuNTuCHg/8spKkUjrbdK2Jj3U9tkwPqXa0Dvf
 6RU1X1oGjFf9ci6l1zAEmyh+BDY3xdOe4rK1ZYsUCz9hADwUyGB5i9ALPG+99Sb0y0EO0Z
 t40bYx0GRZ1mF6VFQyZxIsWRebC2Vwg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-cXD8sMdsNiSEa56UOMhBKg-1; Thu, 19 Mar 2020 15:10:06 -0400
X-MC-Unique: cXD8sMdsNiSEa56UOMhBKg-1
Received: by mail-ed1-f72.google.com with SMTP id p17so2891379edt.20
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 12:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JRfgvQ5UffiVmXJwspzTxa9KyiQLy3dR2PdjfGmWmbE=;
 b=d37ItOeUmmRtEKRyNH1YN85TVH3S7yD6XCjdEv1K1CqCt/Q15bmLf/T6SlZ3IwF8e2
 h+VNiMQg4eVty1swtHYFz+L7+MDafivWrgJ7eVJfzAtOw1x1P2MJs8SlDeSOkEnKrhiW
 H86ZeAeCEoUSN2ugHlOpn25xvpFPqC143NyRPh/6/xn1nedyosrWXWKhmDv9vSSB0Qe0
 v7tJ9n23ug+dMjAL9hM5Uywp6QfiLBr0co7IAT/2LryMotEOmQMpQM5CZaDBTzuzZN7l
 3CEELLz5dhAOiHAQfyIh66rnNTGovLIhY2PCsTzsGDFllCH/ckpZtoAILgtKt9S6ugO8
 t16g==
X-Gm-Message-State: ANhLgQ1cPh+txUrRwuneqZW1uxqpkvlasfZtnqFZJI4BIgsmuXLCx9A1
 zFBs8mJEND1UAGw/QzuSvpHVOmNo04V7p6wTmD1UZKXJqYr8Qw9yipbO5f+u+3JdVd819t23qqj
 ixtqifO8lRxp2+5g=
X-Received: by 2002:aa7:da44:: with SMTP id w4mr4182522eds.86.1584645005632;
 Thu, 19 Mar 2020 12:10:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsa/38hpJHg50p9JJgqdCs3xYFQ0LpFdeYOyXVlyC3kkAG0EbCXFlu/APdGtc5AiMLjks78lA==
X-Received: by 2002:aa7:da44:: with SMTP id w4mr4182480eds.86.1584645005215;
 Thu, 19 Mar 2020 12:10:05 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id g19sm199267ejr.65.2020.03.19.12.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 12:10:03 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] net: tulip: add .can_receive routine
To: P J P <ppandit@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20200319174050.759794-1-ppandit@redhat.com>
 <20200319174050.759794-3-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60f37208-a72c-34dc-fd88-3bbc23283d7b@redhat.com>
Date: Thu, 19 Mar 2020 20:10:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319174050.759794-3-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 6:40 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Define .can_receive routine to do sanity checks before receiving
> packet data.
>=20
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/net/tulip.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> Update v3: define .can_receive routine
>    -> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
>=20
> Update v5: fix a typo in commit log message
>    -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06209.html
>=20
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index fbe40095da..757f12c710 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -229,6 +229,18 @@ static bool tulip_filter_address(TULIPState *s, cons=
t uint8_t *addr)
>       return ret;
>   }
>  =20
> +static int
> +tulip_can_receive(NetClientState *nc)
> +{
> +    TULIPState *s =3D qemu_get_nic_opaque(nc);
> +
> +    if (s->rx_frame_len || tulip_rx_stopped(s)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf, size_t =
size)
>   {
>       struct tulip_descriptor desc;
> @@ -236,7 +248,7 @@ static ssize_t tulip_receive(TULIPState *s, const uin=
t8_t *buf, size_t size)
>       trace_tulip_receive(buf, size);
>  =20
>       if (size < 14 || size > sizeof(s->rx_frame) - 4
> -        || s->rx_frame_len || tulip_rx_stopped(s)) {
> +        || !tulip_can_receive(s->nic->ncs)) {
>           return 0;
>       }
>  =20
> @@ -288,6 +300,7 @@ static NetClientInfo net_tulip_info =3D {
>       .type =3D NET_CLIENT_DRIVER_NIC,
>       .size =3D sizeof(NICState),
>       .receive =3D tulip_receive_nc,
> +    .can_receive =3D tulip_can_receive,
>   };
>  =20
>   static const char *tulip_reg_name(const hwaddr addr)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


