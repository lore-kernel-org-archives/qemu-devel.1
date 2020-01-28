Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDCFC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3D924684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwSJ0xwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3D924684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOg3-0004AE-AC
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwOeg-0002ND-U8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwOeg-0003dz-05
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:03:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwOef-0003do-Sb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580209417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gi6Pqe//MJCW7EDTRuG5DbCJJFa4NXooa1ZWKwDKw6A=;
 b=UwSJ0xwJ9UnDI+HLpJS/49Im4IhtLIQEuuxISOpcBQyc0jXGMBr+3Rmd7m03LH2Y2Cw8Ri
 vN/vHNmM0VXLdaAUYpikZd5O6T6/Rq+qMwxopcK5kXuOWnyg+O8nR2wjDYpC7JG0EZpSmb
 SLgKqVz+wwnwq4R5v7NtCKwXGbNhLTg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-dLUIEGenMgeTEdRJQ4ZdgA-1; Tue, 28 Jan 2020 06:03:35 -0500
Received: by mail-wr1-f69.google.com with SMTP id j4so7853936wrs.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 03:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p1OObKjr/afiKgEYGbv2UgsWBGgfHHUqvbmYutwcmBo=;
 b=byT/H3L8ITrRbfCZwEZBdxeEvQESZi2S8aJxUDbMOnVWeaTNSjq77rXSPr9Opkp+7j
 ePMhvLGO75N0OVMYiv6yhHbBgztZqyYCwXIlfnxuM6TJPwNyMyvdefWocEkhk4Rhu+DL
 6BHRIrOAq6FixBhMoZ/27ktVVZqlinsHDwALUMkkmBcvoX1N3rijgGEj+D10vpC9Z78v
 bqDmmdCKCZpgTlArTHnulAboEU6iYCbCD2loq8g2dvNgt6gPkzrcvrqSz1oViXeGViFS
 SVCVau5vU6BPLc/m8vJDA8gzO4Evv98B2e9SAr4kvziYyE27f4sqYK6bVYX9aZ1zndXh
 pfxA==
X-Gm-Message-State: APjAAAVl7QE0ReCUNp3ejXUglQzOnTLEQFn+oU1wR/x6dqRtu5N2/WGV
 Of4uyLt4x0nlNal0tTWlSxQ60c8t6Hcp9kyzVdGa6nE6k5GoOIfJJwoAIGbQ0M3ZQB0YzbXkXqI
 mC2mPrA0Z1LdJ7vo=
X-Received: by 2002:a05:600c:24ca:: with SMTP id
 10mr4261874wmu.108.1580209414403; 
 Tue, 28 Jan 2020 03:03:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRkl/XKHpODHg8pP9bpQ1rDYT4Kd9E0dO5ApRcT0799Zp3rh04ZoKICh6Bpg41O+X5F77F9g==
X-Received: by 2002:a05:600c:24ca:: with SMTP id
 10mr4261816wmu.108.1580209413855; 
 Tue, 28 Jan 2020 03:03:33 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id y10sm6628457wrw.68.2020.01.28.03.03.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 03:03:33 -0800 (PST)
Subject: Re: [PATCH v3 04/14] dp8393x: Have dp8393x_receive() return the
 packet size
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <a582b4412af479e0830d1ef0005a91a98bfc56cc.1579474761.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b47b1144-bb76-9f70-3351-86ba605e4ac3@redhat.com>
Date: Tue, 28 Jan 2020 12:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a582b4412af479e0830d1ef0005a91a98bfc56cc.1579474761.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: dLUIEGenMgeTEdRJQ4ZdgA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 11:59 PM, Finn Thain wrote:
> This function re-uses its 'size' argument as a scratch variable.
> Instead, declare a local 'size' variable for that purpose so that the
> function result doesn't get messed up.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 2d2ace2549..ece72cbf42 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -757,20 +757,21 @@ static int dp8393x_receive_filter(dp8393xState *s, =
const uint8_t * buf,
>   }
>  =20
>   static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
> -                               size_t size)
> +                               size_t pkt_size)
>   {
>       dp8393xState *s =3D qemu_get_nic_opaque(nc);
>       int packet_type;
>       uint32_t available, address;
> -    int width, rx_len =3D size;
> +    int width, rx_len =3D pkt_size;
>       uint32_t checksum;
> +    int size;
>  =20
>       width =3D (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
>  =20
>       s->regs[SONIC_RCR] &=3D ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR=
_FAER |
>           SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
>  =20
> -    packet_type =3D dp8393x_receive_filter(s, buf, size);
> +    packet_type =3D dp8393x_receive_filter(s, buf, pkt_size);
>       if (packet_type < 0) {
>           DPRINTF("packet not for netcard\n");
>           return -1;
> @@ -864,7 +865,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
>       /* Done */
>       dp8393x_update_irq(s);
>  =20
> -    return size;
> +    return pkt_size;
>   }
>  =20
>   static void dp8393x_reset(DeviceState *dev)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


