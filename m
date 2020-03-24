Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C36C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF8E20724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQkUYzB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF8E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGcO4-0000YQ-37
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jGcND-00088M-Q6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jGcNB-0005UM-D5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:45:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jGcNB-0005Tt-3J
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585028708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+GN4mgu/bbD9lD4Ah4JPIHs/hItieI2GX5x1fRQ8mQ=;
 b=cQkUYzB3Lqt+qd543VH74AHmkCwrxFLwTwtptD1pq04i3sSXyeg7+r/6sbdgphnU3Q+Yhj
 6Cz1C8eA4R8K+bJX6iY5TpJb+ajbjNrpdzeoktV4qO75cGuflbC7upJgo5uBbFNTe6uFg3
 Hj0jAtuhg9Euex6SWjfnQmyzFhlcgn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-WvDWnoieO4CQBKUh4OCTGQ-1; Tue, 24 Mar 2020 01:45:04 -0400
X-MC-Unique: WvDWnoieO4CQBKUh4OCTGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A436149CD;
 Tue, 24 Mar 2020 05:45:02 +0000 (UTC)
Received: from [10.72.13.216] (ovpn-13-216.pek2.redhat.com [10.72.13.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 019DEBBBE1;
 Tue, 24 Mar 2020 05:44:57 +0000 (UTC)
Subject: Re: [PATCH v6 2/2] net: tulip: add .can_receive routine
To: Li Qiang <liq3ea@gmail.com>, P J P <ppandit@redhat.com>
References: <20200323122100.893417-1-ppandit@redhat.com>
 <20200323122100.893417-3-ppandit@redhat.com>
 <CAKXe6SJFTVpnShkgXPa-+sLEv0T96r9_z+ZCXaU9Wm1wF_anTg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ceca9d81-cec9-1617-ccaf-d869a72a8c65@redhat.com>
Date: Tue, 24 Mar 2020 13:44:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJFTVpnShkgXPa-+sLEv0T96r9_z+ZCXaU9Wm1wF_anTg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/24 =E4=B8=8A=E5=8D=8810:04, Li Qiang wrote:
>
>
> P J P <ppandit@redhat.com <mailto:ppandit@redhat.com>> =E4=BA=8E2020=E5=
=B9=B43=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=80=20
> =E4=B8=8B=E5=8D=888:25=E5=86=99=E9=81=93=EF=BC=9A
>
>     From: Prasad J Pandit <pjp@fedoraproject.org
>     <mailto:pjp@fedoraproject.org>>
>
>     Define .can_receive routine to do sanity checks before receiving
>     packet data. And call qemu_flush_queued_packets to flush queued
>     packets once they are read in tulip_receive().
>
>     Suggested-by: Jason Wang <jasowang@redhat.com
>     <mailto:jasowang@redhat.com>>
>     Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org
>     <mailto:pjp@fedoraproject.org>>
>     ---
>     =C2=A0hw/net/tulip.c | 17 ++++++++++++++++-
>     =C2=A01 file changed, 16 insertions(+), 1 deletion(-)
>
>     Update v6: merge earlier patch 2 & 3 into one
>     =C2=A0 ->
>     https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06868.html
>
>     diff --git a/hw/net/tulip.c b/hw/net/tulip.c
>     index fbe40095da..8d8c9519e7 100644
>     --- a/hw/net/tulip.c
>     +++ b/hw/net/tulip.c
>     @@ -229,6 +229,18 @@ static bool tulip_filter_address(TULIPState
>     *s, const uint8_t *addr)
>     =C2=A0 =C2=A0 =C2=A0return ret;
>     =C2=A0}
>
>     +static int
>     +tulip_can_receive(NetClientState *nc)
>     +{
>     +=C2=A0 =C2=A0 TULIPState *s =3D qemu_get_nic_opaque(nc);
>     +
>     +=C2=A0 =C2=A0 if (s->rx_frame_len || tulip_rx_stopped(s)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 return true;
>     +}
>     +
>     =C2=A0static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf,
>     size_t size)
>     =C2=A0{
>     =C2=A0 =C2=A0 =C2=A0struct tulip_descriptor desc;
>     @@ -236,7 +248,7 @@ static ssize_t tulip_receive(TULIPState *s,
>     const uint8_t *buf, size_t size)
>     =C2=A0 =C2=A0 =C2=A0trace_tulip_receive(buf, size);
>
>     =C2=A0 =C2=A0 =C2=A0if (size < 14 || size > sizeof(s->rx_frame) - 4
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 || s->rx_frame_len || tulip_rx_stopped(s=
)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !tulip_can_receive(s->nic->ncs)) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     =C2=A0 =C2=A0 =C2=A0}
>
>     @@ -275,6 +287,8 @@ static ssize_t tulip_receive(TULIPState *s,
>     const uint8_t *buf, size_t size)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_write(s, s->current_rx_d=
esc, &desc);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_next_rx_descriptor(s, &desc);
>     =C2=A0 =C2=A0 =C2=A0} while (s->rx_frame_len);
>     +
>     +=C2=A0 =C2=A0 qemu_flush_queued_packets(qemu_get_queue(s->nic));
>
>
>
> Hi Prasad ans Jason,
> I want to know why here we need call 'qemu_flush_queued_packets'.
> AFAICS, the other networking card emulation need no this.


Right, I thought we need this because rx_frame_len is checked in=20
tulip_can_receive().

But not I think it's unnecessary. According to kernel driver code, the=20
rx is not necessarily stopped when rx buffer is overrun, e.g,=20
tulip_rx_refill() only toggle the doorbell when chip is LC82C168. But=20
own emulation did DC21143.

This means using can_receive() is wrong.

So I think we can drop this patch.

Thanks for the checking and sorry for the wrong suggestion.


>
> Thanks,
> Li Qiang
>
>     =C2=A0 =C2=A0 =C2=A0return size;
>     =C2=A0}
>
>     @@ -288,6 +302,7 @@ static NetClientInfo net_tulip_info =3D {
>     =C2=A0 =C2=A0 =C2=A0.type =3D NET_CLIENT_DRIVER_NIC,
>     =C2=A0 =C2=A0 =C2=A0.size =3D sizeof(NICState),
>     =C2=A0 =C2=A0 =C2=A0.receive =3D tulip_receive_nc,
>     +=C2=A0 =C2=A0 .can_receive =3D tulip_can_receive,
>     =C2=A0};
>
>     =C2=A0static const char *tulip_reg_name(const hwaddr addr)
>     --=20
>     2.25.1
>
>


