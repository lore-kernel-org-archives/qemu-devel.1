Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11FAC35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 05:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B00120714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 05:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftdRC2Aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B00120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j66lv-0000Ka-Ns
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 00:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j66l4-0007y6-Vf
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 00:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j66l2-0003u4-O5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 00:58:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j66l2-0003tj-Jn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 00:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582523900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gRXmgbQazFFThvKRyzKcN9eDV0VuhjoAxzy+U4iDSY=;
 b=ftdRC2Aa1meDeUJ5rHrKX13nwx3eaA6V1sQ2tTgX9nARTIEpislEWylOy9RsCKeHd5o1Ml
 RWuW8drdvL69aicCJI4mFjhTcBA9c0O0XCpPR/0OO/vQujxvp6xnfZHCbEWNlYEADy5WNX
 7Qd4Zqb9QZv0Rxu8V0svnXq7pONonVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-6rDDiVXWN46Mk3vfUAW-iA-1; Mon, 24 Feb 2020 00:58:14 -0500
X-MC-Unique: 6rDDiVXWN46Mk3vfUAW-iA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 131D5100550E;
 Mon, 24 Feb 2020 05:58:13 +0000 (UTC)
Received: from [10.72.13.147] (ovpn-13-147.pek2.redhat.com [10.72.13.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02DB55D9CD;
 Mon, 24 Feb 2020 05:58:09 +0000 (UTC)
Subject: Re: [PATCH v2] net: tulip: check frame size and r/w data length
To: P J P <ppandit@redhat.com>, Sven Schnelle <svens@stackframe.org>
References: <20200217113804.341836-1-ppandit@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e63fe1bb-e77f-1813-6cc7-9763c82c1046@redhat.com>
Date: Mon, 24 Feb 2020 13:58:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200217113804.341836-1-ppandit@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Li Qiang <pangpei.lq@antfin.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Ziming Zhang <ezrakiez@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/17 =E4=B8=8B=E5=8D=887:38, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Tulip network driver while copying tx/rx buffers does not check
> frame size against r/w data length. This may lead to OOB buffer
> access. Add check to avoid it.
>
> Reported-by: Li Qiang <pangpei.lq@antfin.com>
> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/net/tulip.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>
> Update v2: retain earlier len[12] & s->rx_frame_len checks
>    -> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04160.html
>
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index cfac2719d3..ea4fd371e3 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -170,6 +170,10 @@ static void tulip_copy_rx_bytes(TULIPState *s, struc=
t tulip_descriptor *desc)
>           } else {
>               len =3D s->rx_frame_len;
>           }
> +
> +        if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) {
> +            return;
> +        }


What's the goal of this checking?


>           pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
>               (s->rx_frame_size - s->rx_frame_len), len);
>           s->rx_frame_len -=3D len;
> @@ -181,6 +185,10 @@ static void tulip_copy_rx_bytes(TULIPState *s, struc=
t tulip_descriptor *desc)
>           } else {
>               len =3D s->rx_frame_len;
>           }
> +
> +        if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) {
> +            return;
> +        }
>           pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
>               (s->rx_frame_size - s->rx_frame_len), len);
>           s->rx_frame_len -=3D len;
> @@ -227,7 +235,8 @@ static ssize_t tulip_receive(TULIPState *s, const uin=
t8_t *buf, size_t size)
>  =20
>       trace_tulip_receive(buf, size);
>  =20
> -    if (size < 14 || size > 2048 || s->rx_frame_len || tulip_rx_stopped(=
s)) {
> +    if (size < 14 || size > sizeof(s->rx_frame) - 4
> +        || s->rx_frame_len || tulip_rx_stopped(s)) {
>           return 0;


It's better to move those checks in .can_receive().


>       }
>  =20
> @@ -558,7 +567,7 @@ static void tulip_tx(TULIPState *s, struct tulip_desc=
riptor *desc)
>           if ((s->csr[6] >> CSR6_OM_SHIFT) & CSR6_OM_MASK) {
>               /* Internal or external Loopback */
>               tulip_receive(s, s->tx_frame, s->tx_frame_len);
> -        } else {
> +        } else if (s->tx_frame_len < sizeof(s->tx_frame)) {


Should we use <=3D here?


>               qemu_send_packet(qemu_get_queue(s->nic),
>                   s->tx_frame, s->tx_frame_len);
>           }
> @@ -575,12 +584,18 @@ static void tulip_copy_tx_buffers(TULIPState *s, st=
ruct tulip_descriptor *desc)
>       int len1 =3D (desc->control >> TDES1_BUF1_SIZE_SHIFT) & TDES1_BUF1_=
SIZE_MASK;
>       int len2 =3D (desc->control >> TDES1_BUF2_SIZE_SHIFT) & TDES1_BUF2_=
SIZE_MASK;
>  =20
> +    if (s->tx_frame_len + len1 >=3D sizeof(s->tx_frame)) {
> +        return;
> +    }


I think it's better to add a return value here to make sure caller=20
tulip_xmit_list_update() can exit the loop early


>       if (len1) {
>           pci_dma_read(&s->dev, desc->buf_addr1,
>               s->tx_frame + s->tx_frame_len, len1);
>           s->tx_frame_len +=3D len1;
>       }
>  =20
> +    if (s->tx_frame_len + len2 >=3D sizeof(s->tx_frame)) {
> +        return;
> +    }
>       if (len2) {
>           pci_dma_read(&s->dev, desc->buf_addr2,
>               s->tx_frame + s->tx_frame_len, len2);


One more thing.

It looks to me there could be a user trigger-able infinite loop in=20
tun_list_update() through always set TDES0_OWN in its descriptors?

Thanks



