Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD98C2D0E7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEFE2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCjliRxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEFE2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHeRa-0007Pr-NX
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 22:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHeQt-0006wu-LQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHeQr-0002GQ-C7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:09:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHeQr-0002FG-7K
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585274952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75E/zyv97xOeFKGuHFpOjsRIs4NZe+i5K98VvCt3Ae8=;
 b=HCjliRxkfEvasH9J3It2SIYPWFm/XCpVFS9emIWnh3MtMPeB5fqHUqFQaY27Y4YDqNTDsL
 8qNlahKw0osAoxyohnPCmeyPdEavD2KkVEQtYwgEKuz5lMuYdG7vFrf+t6i7Qec4V6exNQ
 VmIDthDbaXVZGoNDFUZMVP5KuCj8Nfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-7rZrnGywMh-PVrFiZNcSAA-1; Thu, 26 Mar 2020 22:09:08 -0400
X-MC-Unique: 7rZrnGywMh-PVrFiZNcSAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24311189D6CF;
 Fri, 27 Mar 2020 02:09:07 +0000 (UTC)
Received: from [10.72.13.132] (ovpn-13-132.pek2.redhat.com [10.72.13.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9E535C1D6;
 Fri, 27 Mar 2020 02:09:02 +0000 (UTC)
Subject: Re: [PATCH v6 1/2] net: tulip: check frame size and r/w data length
To: Li Qiang <liq3ea@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200323122100.893417-1-ppandit@redhat.com>
 <20200323122100.893417-2-ppandit@redhat.com>
 <CAKXe6SKtuk7qr1dFVJoHm3LZ40OG8Nfhanj1zqdBVzAQ+Smc0w@mail.gmail.com>
 <a72da97b-dc0f-99d4-1d59-aba9da2760c9@redhat.com>
 <CAKXe6SJMc0jinC-aWqhSp=ZH3Es0rHLbV-nwq1p0_hPY_vBTDA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9f126c07-91f0-47b8-81c4-aafb9aee66ca@redhat.com>
Date: Fri, 27 Mar 2020 10:09:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJMc0jinC-aWqhSp=ZH3Es0rHLbV-nwq1p0_hPY_vBTDA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/24 =E4=B8=8B=E5=8D=8810:54, Li Qiang wrote:
>
>
> Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>=20
> =E4=BA=8E2020=E5=B9=B43=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=
=E5=8D=881:45=E5=86=99=E9=81=93=EF=BC=9A
>
>
>     On 2020/3/24 =E4=B8=8A=E5=8D=889:29, Li Qiang wrote:
>     >
>     >
>     > P J P <ppandit@redhat.com <mailto:ppandit@redhat.com>
>     <mailto:ppandit@redhat.com <mailto:ppandit@redhat.com>>>
>     =E4=BA=8E2020=E5=B9=B43=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=80
>     > =E4=B8=8B=E5=8D=888:24=E5=86=99=E9=81=93=EF=BC=9A
>     >
>     >=C2=A0 =C2=A0 =C2=A0From: Prasad J Pandit <pjp@fedoraproject.org
>     <mailto:pjp@fedoraproject.org>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:pjp@fedoraproject.org <mailto:pjp@fedora=
project.org>>>
>     >
>     >=C2=A0 =C2=A0 =C2=A0Tulip network driver while copying tx/rx buffers=
 does not check
>     >=C2=A0 =C2=A0 =C2=A0frame size against r/w data length. This may lea=
d to OOB buffer
>     >=C2=A0 =C2=A0 =C2=A0access. Add check to avoid it.
>     >
>     >=C2=A0 =C2=A0 =C2=A0Limit iterations over descriptors to avoid poten=
tial infinite
>     >=C2=A0 =C2=A0 =C2=A0loop issue in tulip_xmit_list_update.
>     >
>     >=C2=A0 =C2=A0 =C2=A0Reported-by: Li Qiang <pangpei.lq@antfin.com
>     <mailto:pangpei.lq@antfin.com>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:pangpei.lq@antfin.com <mailto:pangpei.lq=
@antfin.com>>>
>     >=C2=A0 =C2=A0 =C2=A0Reported-by: Ziming Zhang <ezrakiez@gmail.com
>     <mailto:ezrakiez@gmail.com>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:ezrakiez@gmail.com <mailto:ezrakiez@gmai=
l.com>>>
>     >=C2=A0 =C2=A0 =C2=A0Reported-by: Jason Wang <jasowang@redhat.com
>     <mailto:jasowang@redhat.com>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:jasowang@redhat.com <mailto:jasowang@red=
hat.com>>>
>     >=C2=A0 =C2=A0 =C2=A0Signed-off-by: Prasad J Pandit <pjp@fedoraprojec=
t.org
>     <mailto:pjp@fedoraproject.org>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:pjp@fedoraproject.org <mailto:pjp@fedora=
project.org>>>
>     >
>     >
>     >
>     > Tested-by: Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>
>     <mailto:liq3ea@gmail.com <mailto:liq3ea@gmail.com>>>
>     > But I have a minor question....
>     >
>     >=C2=A0 =C2=A0 =C2=A0---
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0hw/net/tulip.c | 36 ++++++++++++++++++++++=
+++++---------
>     >=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 27 insertions(+), 9 deleti=
ons(-)
>     >
>     >=C2=A0 =C2=A0 =C2=A0Update v3: return a value from tulip_copy_tx_buf=
fers() and avoid
>     >=C2=A0 =C2=A0 =C2=A0infinite loop
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 ->
>     > https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
>     >
>     >=C2=A0 =C2=A0 =C2=A0diff --git a/hw/net/tulip.c b/hw/net/tulip.c
>     >=C2=A0 =C2=A0 =C2=A0index cfac2719d3..fbe40095da 100644
>     >=C2=A0 =C2=A0 =C2=A0--- a/hw/net/tulip.c
>     >=C2=A0 =C2=A0 =C2=A0+++ b/hw/net/tulip.c
>     >=C2=A0 =C2=A0 =C2=A0@@ -170,6 +170,10 @@ static void tulip_copy_rx_b=
ytes(TULIPState
>     >=C2=A0 =C2=A0 =C2=A0*s, struct tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
len =3D s->rx_frame_len;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s->rx_frame_len=
 + len >=3D sizeof(s->rx_frame)) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retur=
n;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     >
>     >
>     >
>     > Why here is '>=3D' instead of '>'.
>     > IIUC the total sending length can reach to sizeof(s->rx_frame).
>     > Same in the other place in this patch.
>
>
>     Yes, this need to be fixed.
>
>
>     >
>     > PS: I have planned to write a qtest case. But my personal qemu dev
>     > environment is broken.
>     > I will try to write it tonight or=C2=A0tomorrow night.
>
>
>     Cool, good to know this.
>
>
> Hi all,
> I have countered an interesting issue. Let's look at the definition of=20
> TULIPState.
>
> =C2=A0 21 typedef struct TULIPState {
> =C2=A0 22 =C2=A0 =C2=A0 PCIDevice dev;
> =C2=A0 23 =C2=A0 =C2=A0 MemoryRegion io;
> =C2=A0 24 =C2=A0 =C2=A0 MemoryRegion memory;
> =C2=A0 25 =C2=A0 =C2=A0 NICConf c;
> =C2=A0 26 =C2=A0 =C2=A0 qemu_irq irq;
> =C2=A0 27 =C2=A0 =C2=A0 NICState *nic;
> =C2=A0 28 =C2=A0 =C2=A0 eeprom_t *eeprom;
> =C2=A0 29 =C2=A0 =C2=A0 uint32_t csr[16];
> =C2=A0 30
> =C2=A0 31 =C2=A0 =C2=A0 /* state for MII */
> =C2=A0 32 =C2=A0 =C2=A0 uint32_t old_csr9;
> =C2=A0 33 =C2=A0 =C2=A0 uint32_t mii_word;
> =C2=A0 34 =C2=A0 =C2=A0 uint32_t mii_bitcnt;
> =C2=A0 35
> =C2=A0 36 =C2=A0 =C2=A0 hwaddr current_rx_desc;
> =C2=A0 37 =C2=A0 =C2=A0 hwaddr current_tx_desc;
> =C2=A0 38
> =C2=A0 39 =C2=A0 =C2=A0 uint8_t rx_frame[2048];
> =C2=A0 40 =C2=A0 =C2=A0 uint8_t tx_frame[2048];
> =C2=A0 41 =C2=A0 =C2=A0 uint16_t tx_frame_len;
> =C2=A0 42 =C2=A0 =C2=A0 uint16_t rx_frame_len;
> =C2=A0 43 =C2=A0 =C2=A0 uint16_t rx_frame_size;
> =C2=A0 44
> =C2=A0 45 =C2=A0 =C2=A0 uint32_t rx_status;
> =C2=A0 46 =C2=A0 =C2=A0 uint8_t filter[16][6];
> =C2=A0 47 } TULIPState;
>
> Here we can see the overflow is occured after 'tx_frame'.
> In my quest, I have see the overflow(the s->tx_frame_len is big).
> However here doesn't cause SEGV in qtest.
> In real case, the qemu process will access the data after TULIPState=20
> in heap and trigger segv.
> However in qtest mode I don't know how to trigger this.


If it's just the mangling of tx_frame_len, it won't hit SIGSEV.

I wonder maybe, somehow that large tx_frame_len is used for buffer=20
copying or other stuffs that can lead the crash.

Thanks


>
> The core code like this:
>
> =C2=A0qpci_device_enable(dev);
> bar =3D qpci_iomap(dev, 0, NULL);
> =C2=A0 =C2=A0 context_pa =3D guest_alloc(alloc, sizeof(context));
> =C2=A0 =C2=A0 guest_pa =3D guest_alloc(alloc, 4096);
> memset(guest_data, 'A', sizeof(guest_data));
> =C2=A0 =C2=A0 context[0].status =3D 1 << 31;
> context[0].control =3D 0x7ff << 11 | 0x7ff;
> context[0].buf_addr2 =3D context_pa + sizeof(struct tulip_descriptor);
> context[0].buf_addr1 =3D guest_pa;
> =C2=A0 =C2=A0 for (i =3D 1; i < ARRAY_SIZE(context); ++i) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_pa +=3D sizeof(struct tulip_descripto=
r);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 context[i].status =3D 1 << 31;
> context[i].control =3D 0x7ff << 11 | 0x7ff;
> context[i].buf_addr2 =3D context_pa + sizeof(struct tulip_descriptor);
> context[i].buf_addr1 =3D guest_pa;
> }
>
> qtest_memwrite(dev->bus->qts, context_pa, context, sizeof(context));
> qtest_memwrite(dev->bus->qts, guest_pa, guest_data, sizeof(guest_data));
> qpci_io_writel(dev, bar, 0x20, context_pa);
> qpci_io_writel(dev, bar, 0x30, 1 << 13);
>
> Paolo may give some hints?
>
> Thanks,
> Li Qiang
>
>     Thanks
>
>
>     >
>     > Thanks,
>     > Li Qiang
>     >
>     >
>     >
>     >
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_write(=
&s->dev, desc->buf_addr1, s->rx_frame +
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(s->rx_frame_size - s->rx_frame_len), len);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->rx_frame_le=
n -=3D len;
>     >=C2=A0 =C2=A0 =C2=A0@@ -181,6 +185,10 @@ static void tulip_copy_rx_b=
ytes(TULIPState
>     >=C2=A0 =C2=A0 =C2=A0*s, struct tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
len =3D s->rx_frame_len;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s->rx_frame_len=
 + len >=3D sizeof(s->rx_frame)) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retur=
n;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_write(=
&s->dev, desc->buf_addr2, s->rx_frame +
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(s->rx_frame_size - s->rx_frame_len), len);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->rx_frame_le=
n -=3D len;
>     >=C2=A0 =C2=A0 =C2=A0@@ -227,7 +235,8 @@ static ssize_t tulip_receive=
(TULIPState *s,
>     >=C2=A0 =C2=A0 =C2=A0const uint8_t *buf, size_t size)
>     >
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0trace_tulip_receive(buf, siz=
e);
>     >
>     >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (size < 14 || size > 2048 || s=
->rx_frame_len ||
>     >=C2=A0 =C2=A0 =C2=A0tulip_rx_stopped(s)) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (size < 14 || size > sizeof(s-=
>rx_frame) - 4
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || s->rx_frame_len =
|| tulip_rx_stopped(s)) {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >
>     >=C2=A0 =C2=A0 =C2=A0@@ -275,7 +284,6 @@ static ssize_t
>     tulip_receive_nc(NetClientState
>     >=C2=A0 =C2=A0 =C2=A0*nc,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0return tulip_receive(qemu_ge=
t_nic_opaque(nc), buf, size);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0}
>     >
>     >=C2=A0 =C2=A0 =C2=A0-
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0static NetClientInfo net_tulip_info =3D {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0.type =3D NET_CLIENT_DRIVER_=
NIC,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0.size =3D sizeof(NICState),
>     >=C2=A0 =C2=A0 =C2=A0@@ -558,7 +566,7 @@ static void tulip_tx(TULIPSt=
ate *s, struct
>     >=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s->csr[6]=
 >> CSR6_OM_SHIFT) & CSR6_OM_MASK) {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* Internal or external Loopback */
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
tulip_receive(s, s->tx_frame, s->tx_frame_len);
>     >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (s->tx_fr=
ame_len <=3D sizeof(s->tx_frame)) {
>     > =C2=A0qemu_send_packet(qemu_get_queue(s->nic),
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0s->tx_frame, s->tx_frame_len);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0@@ -570,23 +578,31 @@ static void tulip_tx(TULIP=
State *s, struct
>     >=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0}
>     >
>     >=C2=A0 =C2=A0 =C2=A0-static void tulip_copy_tx_buffers(TULIPState *s=
, struct
>     >=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0+static int tulip_copy_tx_buffers(TULIPState *s,=
 struct
>     >=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0{
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int len1 =3D (desc->control =
>> TDES1_BUF1_SIZE_SHIFT) &
>     >=C2=A0 =C2=A0 =C2=A0TDES1_BUF1_SIZE_MASK;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int len2 =3D (desc->control =
>> TDES1_BUF2_SIZE_SHIFT) &
>     >=C2=A0 =C2=A0 =C2=A0TDES1_BUF2_SIZE_MASK;
>     >
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s->tx_frame_len + len1 >=3D s=
izeof(s->tx_frame)) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (len1) {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_read(&=
s->dev, desc->buf_addr1,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
s->tx_frame + s->tx_frame_len, len1);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_frame_le=
n +=3D len1;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s->tx_frame_len + len2 >=3D s=
izeof(s->tx_frame)) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (len2) {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_read(&=
s->dev, desc->buf_addr2,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
s->tx_frame + s->tx_frame_len, len2);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_frame_le=
n +=3D len2;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0desc->status =3D (len1 + len=
2) ? 0 : 0x7fffffff;
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 return 0;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0}
>     >
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0static void tulip_setup_filter_addr(TULIPS=
tate *s, uint8_t
>     *buf,
>     >=C2=A0 =C2=A0 =C2=A0int n)
>     >=C2=A0 =C2=A0 =C2=A0@@ -651,13 +667,15 @@ static uint32_t tulip_ts(T=
ULIPState *s)
>     >
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0static void tulip_xmit_list_update(TULIPSt=
ate *s)
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0{
>     >=C2=A0 =C2=A0 =C2=A0+#define TULIP_DESC_MAX 128
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint8_t i =3D 0;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0struct tulip_descriptor desc=
;
>     >
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (tulip_ts(s) !=3D CSR5_TS=
_SUSPENDED) {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >
>     >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 for (;;) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 for (i =3D 0; i < TULIP_DESC_MAX;=
 i++) {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_rea=
d(s, s->current_tx_desc, &desc);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_dump_tx_=
descriptor(s, &desc);
>     >
>     >=C2=A0 =C2=A0 =C2=A0@@ -675,10 +693,10 @@ static void
>     >=C2=A0 =C2=A0 =C2=A0tulip_xmit_list_update(TULIPState *s)
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0s->tx_frame_len =3D 0;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}
>     >
>     >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip=
_copy_tx_buffers(s, &desc);
>     >=C2=A0 =C2=A0 =C2=A0-
>     >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (d=
esc.control & TDES1_LS) {
>     >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tulip_tx(s, &desc);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!=
tulip_copy_tx_buffers(s, &desc)) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (desc.control & TDES1_LS) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tulip_tx(s, &desc);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_wri=
te(s, s->current_tx_desc, &desc);
>     >=C2=A0 =C2=A0 =C2=A0--
>     >=C2=A0 =C2=A0 =C2=A02.25.1
>     >
>     >
>


