Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4B5C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A93206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsfeU7NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A93206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHeK1-0005im-RE
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 22:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHeIZ-0005A5-U5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHeIV-0006mK-0k
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:00:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHeIU-0006li-Tu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585274434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7IpvI8cEd9ksPQGV/Jl1NmmsLCDtAPAIsIZ/FMhNhA=;
 b=OsfeU7NQPAfUnCNkdTi3yN7n18oKjrTwG7V6qL4Tfrh9LgPm9WWLMFxrvfa181k0GCO/5O
 gynzuWP2KtS73sUAlgXJn8FBdB3RrKt5vJqZZuceebwLyLP2b/THKctRtyEe89POdlIs47
 7H1WJdfWVG2kjfjuszzn+Sh1n5E8TdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-5Be39ZChOh6-BHUPPF7JZw-1; Thu, 26 Mar 2020 22:00:30 -0400
X-MC-Unique: 5Be39ZChOh6-BHUPPF7JZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CF19149C2;
 Fri, 27 Mar 2020 02:00:29 +0000 (UTC)
Received: from [10.72.13.132] (ovpn-13-132.pek2.redhat.com [10.72.13.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 885145DA2C;
 Fri, 27 Mar 2020 02:00:21 +0000 (UTC)
Subject: Re: [PATCH] hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW reads
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200324212103.7616-1-peter.maydell@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <de806c65-90ff-d872-a863-770fde658463@redhat.com>
Date: Fri, 27 Mar 2020 10:00:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200324212103.7616-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/25 =E4=B8=8A=E5=8D=885:21, Peter Maydell wrote:
> Coverity points out (CID 1421926) that the read code for
> REG_ADDR_HIGH reads off the end of the buffer, because it does a
> 32-bit read from byte 4 of a 6-byte buffer.
>
> The code also has an endianness issue for both REG_ADDR_HIGH and
> REG_ADDR_LOW, because it will do the wrong thing on a big-endian
> host.
>
> Rewrite the read code to use ldl_le_p() and lduw_le_p() to fix this;
> the write code is not incorrect, but for consistency we make it use
> stl_le_p() and stw_le_p().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/allwinner-sun8i-emac.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.=
c
> index 3fc5e346401..fc67a1be70a 100644
> --- a/hw/net/allwinner-sun8i-emac.c
> +++ b/hw/net/allwinner-sun8i-emac.c
> @@ -611,10 +611,10 @@ static uint64_t allwinner_sun8i_emac_read(void *opa=
que, hwaddr offset,
>           value =3D s->mii_data;
>           break;
>       case REG_ADDR_HIGH:         /* MAC Address High */
> -        value =3D *(((uint32_t *) (s->conf.macaddr.a)) + 1);
> +        value =3D lduw_le_p(s->conf.macaddr.a + 4);
>           break;
>       case REG_ADDR_LOW:          /* MAC Address Low */
> -        value =3D *(uint32_t *) (s->conf.macaddr.a);
> +        value =3D ldl_le_p(s->conf.macaddr.a);
>           break;
>       case REG_TX_DMA_STA:        /* Transmit DMA Status */
>           break;
> @@ -728,14 +728,10 @@ static void allwinner_sun8i_emac_write(void *opaque=
, hwaddr offset,
>           s->mii_data =3D value;
>           break;
>       case REG_ADDR_HIGH:         /* MAC Address High */
> -        s->conf.macaddr.a[4] =3D (value & 0xff);
> -        s->conf.macaddr.a[5] =3D (value & 0xff00) >> 8;
> +        stw_le_p(s->conf.macaddr.a + 4, value);
>           break;
>       case REG_ADDR_LOW:          /* MAC Address Low */
> -        s->conf.macaddr.a[0] =3D (value & 0xff);
> -        s->conf.macaddr.a[1] =3D (value & 0xff00) >> 8;
> -        s->conf.macaddr.a[2] =3D (value & 0xff0000) >> 16;
> -        s->conf.macaddr.a[3] =3D (value & 0xff000000) >> 24;
> +        stl_le_p(s->conf.macaddr.a, value);
>           break;
>       case REG_TX_DMA_STA:        /* Transmit DMA Status */
>       case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */


Applied.

Thanks



