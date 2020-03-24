Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E61C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E3320724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hqf/ohbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E3320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGcP2-0001WG-JL
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jGcNu-0000eG-J0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jGcNs-0005s0-Q4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:45:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jGcNs-0005rm-LW
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585028752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=frpRYlNVcLvG8o90cCp+flqzdNWiWTUqFSuF/XGcjaI=;
 b=Hqf/ohbrFpcjR2yrH1RZw15nGCISxdteYRu8GGvfwYzPEPahOVLh1lSfrxKjqO4GeqBaxU
 /ewJF0hQFapocNEYDQcOtCLL1CTIoBcHooqLUJoWDYQrFi81x3IqOldPD7M76KWhjDbSx/
 qYVh4yHzsnV5T0wL0m4whJ8jE0gNWp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-GnN6unefNWyAm_2V-WA3GA-1; Tue, 24 Mar 2020 01:45:47 -0400
X-MC-Unique: GnN6unefNWyAm_2V-WA3GA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EDEC1922960;
 Tue, 24 Mar 2020 05:45:46 +0000 (UTC)
Received: from [10.72.13.216] (ovpn-13-216.pek2.redhat.com [10.72.13.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5416E1BC6D;
 Tue, 24 Mar 2020 05:45:42 +0000 (UTC)
Subject: Re: [PATCH v6 1/2] net: tulip: check frame size and r/w data length
To: Li Qiang <liq3ea@gmail.com>, P J P <ppandit@redhat.com>
References: <20200323122100.893417-1-ppandit@redhat.com>
 <20200323122100.893417-2-ppandit@redhat.com>
 <CAKXe6SKtuk7qr1dFVJoHm3LZ40OG8Nfhanj1zqdBVzAQ+Smc0w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a72da97b-dc0f-99d4-1d59-aba9da2760c9@redhat.com>
Date: Tue, 24 Mar 2020 13:45:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKtuk7qr1dFVJoHm3LZ40OG8Nfhanj1zqdBVzAQ+Smc0w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <pangpei.lq@antfin.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/24 =E4=B8=8A=E5=8D=889:29, Li Qiang wrote:
>
>
> P J P <ppandit@redhat.com <mailto:ppandit@redhat.com>> =E4=BA=8E2020=E5=
=B9=B43=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=80=20
> =E4=B8=8B=E5=8D=888:24=E5=86=99=E9=81=93=EF=BC=9A
>
>     From: Prasad J Pandit <pjp@fedoraproject.org
>     <mailto:pjp@fedoraproject.org>>
>
>     Tulip network driver while copying tx/rx buffers does not check
>     frame size against r/w data length. This may lead to OOB buffer
>     access. Add check to avoid it.
>
>     Limit iterations over descriptors to avoid potential infinite
>     loop issue in tulip_xmit_list_update.
>
>     Reported-by: Li Qiang <pangpei.lq@antfin.com
>     <mailto:pangpei.lq@antfin.com>>
>     Reported-by: Ziming Zhang <ezrakiez@gmail.com
>     <mailto:ezrakiez@gmail.com>>
>     Reported-by: Jason Wang <jasowang@redhat.com
>     <mailto:jasowang@redhat.com>>
>     Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org
>     <mailto:pjp@fedoraproject.org>>
>
>
>
> Tested-by: Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>>
> But I have a minor question....
>
>     ---
>     =C2=A0hw/net/tulip.c | 36 +++++++++++++++++++++++++++---------
>     =C2=A01 file changed, 27 insertions(+), 9 deletions(-)
>
>     Update v3: return a value from tulip_copy_tx_buffers() and avoid
>     infinite loop
>     =C2=A0 ->
>     https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
>
>     diff --git a/hw/net/tulip.c b/hw/net/tulip.c
>     index cfac2719d3..fbe40095da 100644
>     --- a/hw/net/tulip.c
>     +++ b/hw/net/tulip.c
>     @@ -170,6 +170,10 @@ static void tulip_copy_rx_bytes(TULIPState
>     *s, struct tulip_descriptor *desc)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D s->rx_frame_l=
en;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s->rx_frame_len + len >=3D sizeof(s-=
>rx_frame)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
>
>
> Why here is '>=3D' instead of '>'.
> IIUC the total sending length can reach to sizeof(s->rx_frame).
> Same in the other place in this patch.


Yes, this need to be fixed.


>
> PS: I have planned to write a qtest case. But my personal qemu dev=20
> environment is broken.
> I will try to write it tonight or=C2=A0tomorrow night.


Cool, good to know this.

Thanks


>
> Thanks,
> Li Qiang
>
>
>
>
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_write(&s->dev, desc->buf_ad=
dr1, s->rx_frame +
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s->rx_frame_size - s=
->rx_frame_len), len);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->rx_frame_len -=3D len;
>     @@ -181,6 +185,10 @@ static void tulip_copy_rx_bytes(TULIPState
>     *s, struct tulip_descriptor *desc)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D s->rx_frame_l=
en;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s->rx_frame_len + len >=3D sizeof(s-=
>rx_frame)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_write(&s->dev, desc->buf_ad=
dr2, s->rx_frame +
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s->rx_frame_size - s=
->rx_frame_len), len);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->rx_frame_len -=3D len;
>     @@ -227,7 +235,8 @@ static ssize_t tulip_receive(TULIPState *s,
>     const uint8_t *buf, size_t size)
>
>     =C2=A0 =C2=A0 =C2=A0trace_tulip_receive(buf, size);
>
>     -=C2=A0 =C2=A0 if (size < 14 || size > 2048 || s->rx_frame_len ||
>     tulip_rx_stopped(s)) {
>     +=C2=A0 =C2=A0 if (size < 14 || size > sizeof(s->rx_frame) - 4
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 || s->rx_frame_len || tulip_rx_stopped(s=
)) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     =C2=A0 =C2=A0 =C2=A0}
>
>     @@ -275,7 +284,6 @@ static ssize_t tulip_receive_nc(NetClientState
>     *nc,
>     =C2=A0 =C2=A0 =C2=A0return tulip_receive(qemu_get_nic_opaque(nc), buf=
, size);
>     =C2=A0}
>
>     -
>     =C2=A0static NetClientInfo net_tulip_info =3D {
>     =C2=A0 =C2=A0 =C2=A0.type =3D NET_CLIENT_DRIVER_NIC,
>     =C2=A0 =C2=A0 =C2=A0.size =3D sizeof(NICState),
>     @@ -558,7 +566,7 @@ static void tulip_tx(TULIPState *s, struct
>     tulip_descriptor *desc)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s->csr[6] >> CSR6_OM_SHIFT) & =
CSR6_OM_MASK) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Internal or extern=
al Loopback */
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_receive(s, s->t=
x_frame, s->tx_frame_len);
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (s->tx_frame_len <=3D sizeof(s=
->tx_frame)) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_send_packet(qemu=
_get_queue(s->nic),
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_f=
rame, s->tx_frame_len);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     @@ -570,23 +578,31 @@ static void tulip_tx(TULIPState *s, struct
>     tulip_descriptor *desc)
>     =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0}
>
>     -static void tulip_copy_tx_buffers(TULIPState *s, struct
>     tulip_descriptor *desc)
>     +static int tulip_copy_tx_buffers(TULIPState *s, struct
>     tulip_descriptor *desc)
>     =C2=A0{
>     =C2=A0 =C2=A0 =C2=A0int len1 =3D (desc->control >> TDES1_BUF1_SIZE_SH=
IFT) &
>     TDES1_BUF1_SIZE_MASK;
>     =C2=A0 =C2=A0 =C2=A0int len2 =3D (desc->control >> TDES1_BUF2_SIZE_SH=
IFT) &
>     TDES1_BUF2_SIZE_MASK;
>
>     +=C2=A0 =C2=A0 if (s->tx_frame_len + len1 >=3D sizeof(s->tx_frame)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>     +=C2=A0 =C2=A0 }
>     =C2=A0 =C2=A0 =C2=A0if (len1) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_read(&s->dev, desc->buf_add=
r1,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_frame + s->tx_f=
rame_len, len1);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_frame_len +=3D len1;
>     =C2=A0 =C2=A0 =C2=A0}
>
>     +=C2=A0 =C2=A0 if (s->tx_frame_len + len2 >=3D sizeof(s->tx_frame)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>     +=C2=A0 =C2=A0 }
>     =C2=A0 =C2=A0 =C2=A0if (len2) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_read(&s->dev, desc->buf_add=
r2,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_frame + s->tx_f=
rame_len, len2);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_frame_len +=3D len2;
>     =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0desc->status =3D (len1 + len2) ? 0 : 0x7fffffff;
>     +
>     +=C2=A0 =C2=A0 return 0;
>     =C2=A0}
>
>     =C2=A0static void tulip_setup_filter_addr(TULIPState *s, uint8_t *buf=
,
>     int n)
>     @@ -651,13 +667,15 @@ static uint32_t tulip_ts(TULIPState *s)
>
>     =C2=A0static void tulip_xmit_list_update(TULIPState *s)
>     =C2=A0{
>     +#define TULIP_DESC_MAX 128
>     +=C2=A0 =C2=A0 uint8_t i =3D 0;
>     =C2=A0 =C2=A0 =C2=A0struct tulip_descriptor desc;
>
>     =C2=A0 =C2=A0 =C2=A0if (tulip_ts(s) !=3D CSR5_TS_SUSPENDED) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>     =C2=A0 =C2=A0 =C2=A0}
>
>     -=C2=A0 =C2=A0 for (;;) {
>     +=C2=A0 =C2=A0 for (i =3D 0; i < TULIP_DESC_MAX; i++) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_read(s, s->current_tx_de=
sc, &desc);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_dump_tx_descriptor(s, &desc);
>
>     @@ -675,10 +693,10 @@ static void
>     tulip_xmit_list_update(TULIPState *s)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_f=
rame_len =3D 0;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip_copy_tx_buffers(s, &=
desc);
>     -
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.control & TDES1_L=
S) {
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip_tx(s, =
&desc);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tulip_copy_tx_buffers=
(s, &desc)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.con=
trol & TDES1_LS) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tulip_tx(s, &desc);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_write(s, s->current_tx_d=
esc, &desc);
>     --=20
>     2.25.1
>
>


