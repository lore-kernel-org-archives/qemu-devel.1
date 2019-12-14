Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE9C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF82420706
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/AY/6Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF82420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEyq-0006BH-Ua
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igExQ-0004wY-7a
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igExP-0007Gu-4e
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:28:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21542
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igExO-0007Fz-V4
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576358890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqTgi9j/jhtr42IfwQf0+7gZ3TCeovc7vsWx2qHwx3M=;
 b=J/AY/6SqDC1K+YXn2DMcrwoss8Y1+kfSQdZCHFTQcRCYRi8F36wpkUWu9pwzqFMxNcwLZY
 TJ1MH9KuadX+qTq75DHfAEXoK13f5EMKTrrzBFhnEPMx2yET35FOLCz+hyoFw7gIRFAS7k
 SS/KCVaQuuI/uWgY1zNKjui3zpzT6xU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-P1ZBoeLPPU6Ik_VfUyCeRQ-1; Sat, 14 Dec 2019 08:26:26 -0500
Received: by mail-wr1-f69.google.com with SMTP id f17so975020wrt.19
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 05:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VUOaS9SLKy0S5udu0MSJonksmndQX9tSmP1r0VkVwso=;
 b=ComerRmrlc7v2GCRtCsUhAD8XD4dqgd2KtaZwJl4sP5XA4YpanG5LocQ2ASpCVHJb2
 CzKSNJQTAwyaAmiJGgesqNgnM+Fcbq5cLxqLGnkaq+HwI6ePKoGZ71C9jTOb+zYpzDhR
 7p10eT60kj94TVLhzXFwrQcUN2cKPG4cAQ0jT8POKLPNEub2BvOe0MSNOjz7CinDTJE0
 2PlGdse9nDgkHHQ/IhhW3AVuD3v5sAHElwtK7Uqd4nc4O64x/70UoO1HJ+FXSEsFUQIM
 cTkrW6Hmi3gm9ND8GUaens8AfvGgxRh5OE7pLeR+NNj6kAloOvJoehdEZWMka0FKF/co
 rHLg==
X-Gm-Message-State: APjAAAVmPstSQF0W3aKTKPCN0qwbM/NaUpoXicqKkyCppHg+q1Ix1aY2
 8epaEzEvv44tzl+Za1E1CDJJ5aAakVBOjfd9NdnnMJz0LxlO7E5Yy9oP9zoY5C7W1/EYqsfnOtJ
 l2+CYQfFIF45guLA=
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr18850413wme.27.1576329985084; 
 Sat, 14 Dec 2019 05:26:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwGG/0doXMZkDVP0Kj/d0XqKMN96rWmAEC8YShrCxgAOtFiQpSUpF12OVV4nN9DqCkGHrw0TA==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr18850391wme.27.1576329984784; 
 Sat, 14 Dec 2019 05:26:24 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id q68sm11703306wme.14.2019.12.14.05.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 05:26:24 -0800 (PST)
Subject: Re: [PATCH 03/10] dp8393x: Have dp8393x_receive() return the packet
 size
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <fb6dc2fc63561e73ecd62286a2703883e31fd394.1576286757.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9bbfe8c9-0577-f5bc-1757-78f77ab00946@redhat.com>
Date: Sat, 14 Dec 2019 14:26:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fb6dc2fc63561e73ecd62286a2703883e31fd394.1576286757.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: P1ZBoeLPPU6Ik_VfUyCeRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Herve Poussineau <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Finn,

On 12/14/19 2:25 AM, Finn Thain wrote:
> This function re-uses its 'size' argument as a scratch variable.
> Instead, declare a local 'size' variable for that purpose so that the
> function result doesn't get messed up.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>   hw/net/dp8393x.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 3fd59bc1d4..462f8646e0 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -741,20 +741,21 @@ static int dp8393x_receive_filter(dp8393xState *s, =
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

I'm tempted to remove rx_len and use pkt_size, pkt_size +=20
sizeof(checksum) in place.

Anyway:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

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
> @@ -848,7 +849,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
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


