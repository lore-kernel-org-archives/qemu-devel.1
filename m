Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C23FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88722074D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWlWPlds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88722074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHf8U-00073b-0q
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 22:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHf7p-0006f2-J4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHf7m-0005ag-MI
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:53:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHf7m-0005ZJ-Eu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585277613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+vd8mbkQEagxfOgv3eNPFURB9X71oz8y9auFA29LCA=;
 b=ZWlWPldsxaCHja9PRaIHp6oUIX4jYd3eJTWNnfDKc5sxjhVLbNJ4lRnRal7p2+Vb5YvNPP
 qdckpJtpuABtakSqnM5wWQI1sksNEM7B6qniWjwmRuaImm0P5tHVRzOWiDr3BlBo5rBYRv
 3oek4t2DyBDL9gUbqEJw8jMnmE9qs4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-Yi6x6js-Ml-oALzj9glCgg-1; Thu, 26 Mar 2020 22:53:30 -0400
X-MC-Unique: Yi6x6js-Ml-oALzj9glCgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E2C0800D5A;
 Fri, 27 Mar 2020 02:53:28 +0000 (UTC)
Received: from [10.72.13.132] (ovpn-13-132.pek2.redhat.com [10.72.13.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97C6360BF7;
 Fri, 27 Mar 2020 02:53:24 +0000 (UTC)
Subject: Re: [PATCH v6 1/2] net: tulip: check frame size and r/w data length
To: Li Qiang <liq3ea@gmail.com>
References: <20200323122100.893417-1-ppandit@redhat.com>
 <20200323122100.893417-2-ppandit@redhat.com>
 <CAKXe6SKtuk7qr1dFVJoHm3LZ40OG8Nfhanj1zqdBVzAQ+Smc0w@mail.gmail.com>
 <a72da97b-dc0f-99d4-1d59-aba9da2760c9@redhat.com>
 <CAKXe6SJMc0jinC-aWqhSp=ZH3Es0rHLbV-nwq1p0_hPY_vBTDA@mail.gmail.com>
 <9f126c07-91f0-47b8-81c4-aafb9aee66ca@redhat.com>
 <CAKXe6SKHRq8_bHmHnLfWkpfnyMvyW_54NPGhKp0yaXWqJ_O8Pw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <90799fa4-f889-9eca-408d-113e097204ec@redhat.com>
Date: Fri, 27 Mar 2020 10:53:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKHRq8_bHmHnLfWkpfnyMvyW_54NPGhKp0yaXWqJ_O8Pw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/27 =E4=B8=8A=E5=8D=8810:35, Li Qiang wrote:
>
>
> Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>=20
> =E4=BA=8E2020=E5=B9=B43=E6=9C=8827=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=
=E5=8D=8810:09=E5=86=99=E9=81=93=EF=BC=9A
>
>
>     On 2020/3/24 =E4=B8=8B=E5=8D=8810:54, Li Qiang wrote:
>     >
>     >
>     > Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>
>     <mailto:jasowang@redhat.com <mailto:jasowang@redhat.com>>>
>     > =E4=BA=8E2020=E5=B9=B43=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C =E4=
=B8=8B=E5=8D=881:45=E5=86=99=E9=81=93=EF=BC=9A
>     >
>     >
>     >=C2=A0 =C2=A0 =C2=A0On 2020/3/24 =E4=B8=8A=E5=8D=889:29, Li Qiang wr=
ote:
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> P J P <ppandit@redhat.com <mailto:ppandit@redh=
at.com>
>     <mailto:ppandit@redhat.com <mailto:ppandit@redhat.com>>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:ppandit@redhat.com <mailto:ppandit@redha=
t.com>
>     <mailto:ppandit@redhat.com <mailto:ppandit@redhat.com>>>>
>     >=C2=A0 =C2=A0 =C2=A0=E4=BA=8E2020=E5=B9=B43=E6=9C=8823=E6=97=A5=E5=
=91=A8=E4=B8=80
>     >=C2=A0 =C2=A0 =C2=A0> =E4=B8=8B=E5=8D=888:24=E5=86=99=E9=81=93=EF=BC=
=9A
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0From: Prasad J Pandit <pjp@=
fedoraproject.org
>     <mailto:pjp@fedoraproject.org>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:pjp@fedoraproject.org <mailto:pjp@fedora=
project.org>>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0<mailto:pjp@fedoraproject.o=
rg
>     <mailto:pjp@fedoraproject.org> <mailto:pjp@fedoraproject.org
>     <mailto:pjp@fedoraproject.org>>>>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Tulip network driver while =
copying tx/rx buffers does
>     not check
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0frame size against r/w data=
 length. This may lead to
>     OOB buffer
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0access. Add check to avoid =
it.
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Limit iterations over descr=
iptors to avoid potential
>     infinite
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0loop issue in tulip_xmit_li=
st_update.
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Reported-by: Li Qiang <pang=
pei.lq@antfin.com
>     <mailto:pangpei.lq@antfin.com>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:pangpei.lq@antfin.com <mailto:pangpei.lq=
@antfin.com>>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0<mailto:pangpei.lq@antfin.c=
om
>     <mailto:pangpei.lq@antfin.com> <mailto:pangpei.lq@antfin.com
>     <mailto:pangpei.lq@antfin.com>>>>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Reported-by: Ziming Zhang <=
ezrakiez@gmail.com
>     <mailto:ezrakiez@gmail.com>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:ezrakiez@gmail.com <mailto:ezrakiez@gmai=
l.com>>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0<mailto:ezrakiez@gmail.com =
<mailto:ezrakiez@gmail.com>
>     <mailto:ezrakiez@gmail.com <mailto:ezrakiez@gmail.com>>>>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Reported-by: Jason Wang <ja=
sowang@redhat.com
>     <mailto:jasowang@redhat.com>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:jasowang@redhat.com <mailto:jasowang@red=
hat.com>>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0<mailto:jasowang@redhat.com
>     <mailto:jasowang@redhat.com> <mailto:jasowang@redhat.com
>     <mailto:jasowang@redhat.com>>>>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Signed-off-by: Prasad J Pan=
dit <pjp@fedoraproject.org
>     <mailto:pjp@fedoraproject.org>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:pjp@fedoraproject.org <mailto:pjp@fedora=
project.org>>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0<mailto:pjp@fedoraproject.o=
rg
>     <mailto:pjp@fedoraproject.org> <mailto:pjp@fedoraproject.org
>     <mailto:pjp@fedoraproject.org>>>>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> Tested-by: Li Qiang <liq3ea@gmail.com
>     <mailto:liq3ea@gmail.com> <mailto:liq3ea@gmail.com
>     <mailto:liq3ea@gmail.com>>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:liq3ea@gmail.com <mailto:liq3ea@gmail.co=
m>
>     <mailto:liq3ea@gmail.com <mailto:liq3ea@gmail.com>>>>
>     >=C2=A0 =C2=A0 =C2=A0> But I have a minor question....
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0---
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0hw/net/tulip.c | 36 +=
++++++++++++++++++++++++++---------
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 27 in=
sertions(+), 9 deletions(-)
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Update v3: return a value f=
rom tulip_copy_tx_buffers()
>     and avoid
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0infinite loop
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 ->
>     >=C2=A0 =C2=A0 =C2=A0>
>     https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0diff --git a/hw/net/tulip.c=
 b/hw/net/tulip.c
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0index cfac2719d3..fbe40095d=
a 100644
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0--- a/hw/net/tulip.c
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+++ b/hw/net/tulip.c
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0@@ -170,6 +170,10 @@ static=
 void
>     tulip_copy_rx_bytes(TULIPState
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0*s, struct tulip_descriptor=
 *desc)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0len =3D s->rx_frame_len;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (s->rx_frame_len + len >=3D
>     sizeof(s->rx_frame)) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> Why here is '>=3D' instead of '>'.
>     >=C2=A0 =C2=A0 =C2=A0> IIUC the total sending length can reach to
>     sizeof(s->rx_frame).
>     >=C2=A0 =C2=A0 =C2=A0> Same in the other place in this patch.
>     >
>     >
>     >=C2=A0 =C2=A0 =C2=A0Yes, this need to be fixed.
>     >
>     >
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> PS: I have planned to write a qtest case. But =
my personal
>     qemu dev
>     >=C2=A0 =C2=A0 =C2=A0> environment is broken.
>     >=C2=A0 =C2=A0 =C2=A0> I will try to write it tonight or=C2=A0tomorro=
w night.
>     >
>     >
>     >=C2=A0 =C2=A0 =C2=A0Cool, good to know this.
>     >
>     >
>     > Hi all,
>     > I have countered an interesting issue. Let's look at the
>     definition of
>     > TULIPState.
>     >
>     > =C2=A0 21 typedef struct TULIPState {
>     > =C2=A0 22 =C2=A0 =C2=A0 PCIDevice dev;
>     > =C2=A0 23 =C2=A0 =C2=A0 MemoryRegion io;
>     > =C2=A0 24 =C2=A0 =C2=A0 MemoryRegion memory;
>     > =C2=A0 25 =C2=A0 =C2=A0 NICConf c;
>     > =C2=A0 26 =C2=A0 =C2=A0 qemu_irq irq;
>     > =C2=A0 27 =C2=A0 =C2=A0 NICState *nic;
>     > =C2=A0 28 =C2=A0 =C2=A0 eeprom_t *eeprom;
>     > =C2=A0 29 =C2=A0 =C2=A0 uint32_t csr[16];
>     > =C2=A0 30
>     > =C2=A0 31 =C2=A0 =C2=A0 /* state for MII */
>     > =C2=A0 32 =C2=A0 =C2=A0 uint32_t old_csr9;
>     > =C2=A0 33 =C2=A0 =C2=A0 uint32_t mii_word;
>     > =C2=A0 34 =C2=A0 =C2=A0 uint32_t mii_bitcnt;
>     > =C2=A0 35
>     > =C2=A0 36 =C2=A0 =C2=A0 hwaddr current_rx_desc;
>     > =C2=A0 37 =C2=A0 =C2=A0 hwaddr current_tx_desc;
>     > =C2=A0 38
>     > =C2=A0 39 =C2=A0 =C2=A0 uint8_t rx_frame[2048];
>     > =C2=A0 40 =C2=A0 =C2=A0 uint8_t tx_frame[2048];
>     > =C2=A0 41 =C2=A0 =C2=A0 uint16_t tx_frame_len;
>     > =C2=A0 42 =C2=A0 =C2=A0 uint16_t rx_frame_len;
>     > =C2=A0 43 =C2=A0 =C2=A0 uint16_t rx_frame_size;
>     > =C2=A0 44
>     > =C2=A0 45 =C2=A0 =C2=A0 uint32_t rx_status;
>     > =C2=A0 46 =C2=A0 =C2=A0 uint8_t filter[16][6];
>     > =C2=A0 47 } TULIPState;
>     >
>     > Here we can see the overflow is occured after 'tx_frame'.
>     > In my quest, I have see the overflow(the s->tx_frame_len is big).
>     > However here doesn't cause SEGV in qtest.
>     > In real case, the qemu process will access the data after
>     TULIPState
>     > in heap and trigger segv.
>     > However in qtest mode I don't know how to trigger this.
>
>
>     If it's just the mangling of tx_frame_len, it won't hit SIGSEV.
>
>     I wonder maybe, somehow that large tx_frame_len is used for buffer
>     copying or other stuffs that can lead the crash.
>
>
> This is because in real qemu process, the OOB copy corrupts the head=20
> data after 'TULIPState' struct.
> And maybe later(other thread) access the corrupted data thus leading=20
> crash.


Ok, so I think ASAN can detect this crash. But I'm not sure whether or=20
not it was enabled for qtest. If not, we probably need that.

I wrote a qtest for virtio-net that can lead OOB, so it should probably=20
work for tulip but need to check.

Or if you don't want to depend on ASAN, we can check user visible status=20
after tx_frame[], but it looks to me all other fields are not visible by=20
guest.

Maybe we can reorder to place csr[] after tx_frame[] then check csr[]=20
afterwards.


> However in qtest mode, I don't remember the core code of qtest. But=20
> seems it's not a really VM? just a interface=C2=A0emulation.


If my memory is correct, it's not a VM.

Thanks


> In my case, it's backtrace is as this:
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7ffbdb7fe700 (LWP 60813)]
> 0x0000000000000000 in ?? ()
> ...
> (gdb) bt
> #0 =C2=A00x0000000000000000 in =C2=A0()
> #1 =C2=A00x0000555555a7dfa3 in qemu_set_irq (irq=3D0x5555579e0710, level=
=3D1)=20
> at hw/core/irq.c:44
> #2 =C2=A00x0000555555b2b87a in tulip_update_int (s=3D0x5555579da7c0) at=
=20
> hw/net/tulip.c:121
> #3 =C2=A00x0000555555b2cdd9 in tulip_xmit_list_update (s=3D0x5555579da7c0=
) at=20
> hw/net/tulip.c:667
> #4 =C2=A00x0000555555b2d19d in tulip_write (opaque=3D0x5555579da7c0, addr=
=3D32,=20
> data=3D931909632, size=3D4) at hw/net/tulip.c:759
> #5 =C2=A00x000055555587eed1 in memory_region_write_accessor=20
> (mr=3D0x5555579db0b0, addr=3D32, value=3D0x7ffbdb7fd6a8, size=3D4, shift=
=3D0,=20
> mask=3D4294967295, attrs=3D...) at /xxx/qemu/memory.c:483
> #6 =C2=A00x000055555587f0da in access_with_adjusted_size (addr=3D32,=20
> value=3D0x7ffbdb7fd6a8, size=3D4, access_size_min=3D4, access_size_max=3D=
4,=20
> access_fn=3D0x55555587edf2 <memory_region_write_accessor>,=20
> mr=3D0x5555579db0b0, attrs=3D...)
> =C2=A0 =C2=A0 at /xxx/qemu/memory.c:544
> #7 =C2=A00x000055555588213b in memory_region_dispatch_write=20
> (mr=3D0x5555579db0b0, addr=3D32, data=3D931909632, op=3DMO_32, attrs=3D..=
.) at=20
> /xxx/qemu/memory.c:1476
> #8 =C2=A00x000055555581fe9c in flatview_write_continue (fv=3D0x7ffbb001ea=
e0,=20
> addr=3D49184, attrs=3D..., ptr=3D0x7ffff7e13000, len=3D4, addr1=3D32, l=
=3D4,=20
> mr=3D0x5555579db0b0) at /xxx/qemu/exec.c:3125
> #9 =C2=A00x000055555581fff4 in flatview_write (fv=3D0x7ffbb001eae0,=20
> addr=3D49184, attrs=3D..., buf=3D0x7ffff7e13000, len=3D4) at /xxx/qemu/ex=
ec.c:3165
> #10 0x0000555555820368 in address_space_write (as=3D0x555556762560=20
> <address_space_io>, addr=3D49184, attrs=3D..., buf=3D0x7ffff7e13000, len=
=3D4)=20
> at /xxx/qemu/exec.c:3256
> #11 0x00005555558203da in address_space_rw (as=3D0x555556762560=20
> <address_space_io>, addr=3D49184, attrs=3D..., buf=3D0x7ffff7e13000, len=
=3D4,=20
> is_write=3Dtrue) at /xxx/qemu/exec.c:3266
> #12 0x000055555589723b in kvm_handle_io (port=3D49184, attrs=3D...,=20
> data=3D0x7ffff7e13000, direction=3D1, size=3D4, count=3D1) at=20
> /xxx/qemu/accel/kvm/kvm-all.c:2140
> #13 0x00005555558979d6 in kvm_cpu_exec (cpu=3D0x555556b1e220) at=20
> /xxx/qemu/accel/kvm/kvm-all.c:2386
> #14 0x00005555558701c5 in qemu_kvm_cpu_thread_fn (arg=3D0x555556b1e220)=
=20
> at /xxx/qemu/cpus.c:1246
> #15 0x0000555555de3ce4 in qemu_thread_start (args=3D0x555556b44040) at=20
> util/qemu-thread-posix.c:519
> #16 0x00007ffff5bb0e25 in start_thread () at /lib64/libpthread.so.0
> #17 0x00007ffff58d8f1d in clone () at /lib64/libc.so.6
>
> I will try to dig into the qtest code and hope find a way to trigger a=20
> segv in qtest.
>
> Thanks,
> Li Qiang
>
>
>     Thanks
>
>
>     >
>     > The core code like this:
>     >
>     > =C2=A0qpci_device_enable(dev);
>     > bar =3D qpci_iomap(dev, 0, NULL);
>     > =C2=A0 =C2=A0 context_pa =3D guest_alloc(alloc, sizeof(context));
>     > =C2=A0 =C2=A0 guest_pa =3D guest_alloc(alloc, 4096);
>     > memset(guest_data, 'A', sizeof(guest_data));
>     > =C2=A0 =C2=A0 context[0].status =3D 1 << 31;
>     > context[0].control =3D 0x7ff << 11 | 0x7ff;
>     > context[0].buf_addr2 =3D context_pa + sizeof(struct tulip_descripto=
r);
>     > context[0].buf_addr1 =3D guest_pa;
>     > =C2=A0 =C2=A0 for (i =3D 1; i < ARRAY_SIZE(context); ++i) {
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_pa +=3D sizeof(struct tulip_des=
criptor);
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 context[i].status =3D 1 << 31;
>     > context[i].control =3D 0x7ff << 11 | 0x7ff;
>     > context[i].buf_addr2 =3D context_pa + sizeof(struct tulip_descripto=
r);
>     > context[i].buf_addr1 =3D guest_pa;
>     > }
>     >
>     > qtest_memwrite(dev->bus->qts, context_pa, context, sizeof(context))=
;
>     > qtest_memwrite(dev->bus->qts, guest_pa, guest_data,
>     sizeof(guest_data));
>     > qpci_io_writel(dev, bar, 0x20, context_pa);
>     > qpci_io_writel(dev, bar, 0x30, 1 << 13);
>     >
>     > Paolo may give some hints?
>     >
>     > Thanks,
>     > Li Qiang
>     >
>     >=C2=A0 =C2=A0 =C2=A0Thanks
>     >
>     >
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> Thanks,
>     >=C2=A0 =C2=A0 =C2=A0> Li Qiang
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_dma_write(&s->dev, desc->buf_addr1,
>     s->rx_frame +
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(s->rx_frame_size - s->rx_frame_len), len);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s->rx_frame_len -=3D len;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0@@ -181,6 +185,10 @@ static=
 void
>     tulip_copy_rx_bytes(TULIPState
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0*s, struct tulip_descriptor=
 *desc)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0len =3D s->rx_frame_len;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (s->rx_frame_len + len >=3D
>     sizeof(s->rx_frame)) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_dma_write(&s->dev, desc->buf_addr2,
>     s->rx_frame +
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(s->rx_frame_size - s->rx_frame_len), len);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s->rx_frame_len -=3D len;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0@@ -227,7 +235,8 @@ static =
ssize_t
>     tulip_receive(TULIPState *s,
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0const uint8_t *buf, size_t =
size)
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0trace_t=
ulip_receive(buf, size);
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (size < 1=
4 || size > 2048 || s->rx_frame_len ||
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0tulip_rx_stopped(s)) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (size < 1=
4 || size > sizeof(s->rx_frame) - 4
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 || s->rx_frame_len || tulip_rx_stopped(s)) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return 0;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0@@ -275,7 +284,6 @@ static =
ssize_t
>     >=C2=A0 =C2=A0 =C2=A0tulip_receive_nc(NetClientState
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0*nc,
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0return =
tulip_receive(qemu_get_nic_opaque(nc),
>     buf, size);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0-
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0static NetClientInfo =
net_tulip_info =3D {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0.type =
=3D NET_CLIENT_DRIVER_NIC,
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0.size =
=3D sizeof(NICState),
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0@@ -558,7 +566,7 @@ static =
void tulip_tx(TULIPState
>     *s, struct
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if ((s->csr[6] >> CSR6_OM_SHIFT) &
>     CSR6_OM_MASK) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* Internal or external Loopback */
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0tulip_receive(s, s->tx_frame,
>     s->tx_frame_len);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } else {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } else if (s->tx_frame_len <=3D
>     sizeof(s->tx_frame)) {
>     >=C2=A0 =C2=A0 =C2=A0> =C2=A0qemu_send_packet(qemu_get_queue(s->nic),
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_frame, s->tx_frame_len);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0@@ -570,23 +578,31 @@ stati=
c void tulip_tx(TULIPState
>     *s, struct
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0-static void tulip_copy_tx_=
buffers(TULIPState *s, struct
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+static int tulip_copy_tx_b=
uffers(TULIPState *s, struct
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0{
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int len=
1 =3D (desc->control >> TDES1_BUF1_SIZE_SHIFT) &
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0TDES1_BUF1_SIZE_MASK;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int len=
2 =3D (desc->control >> TDES1_BUF2_SIZE_SHIFT) &
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0TDES1_BUF2_SIZE_MASK;
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s->tx_fr=
ame_len + len1 >=3D sizeof(s->tx_frame)) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (len=
1) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_dma_read(&s->dev, desc->buf_addr1,
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0s->tx_frame + s->tx_frame_len, len1);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s->tx_frame_len +=3D len1;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s->tx_fr=
ame_len + len2 >=3D sizeof(s->tx_frame)) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (len=
2) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_dma_read(&s->dev, desc->buf_addr2,
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0s->tx_frame + s->tx_frame_len, len2);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s->tx_frame_len +=3D len2;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0desc->s=
tatus =3D (len1 + len2) ? 0 : 0x7fffffff;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 return 0;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0static void tulip_set=
up_filter_addr(TULIPState *s,
>     uint8_t
>     >=C2=A0 =C2=A0 =C2=A0*buf,
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0int n)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0@@ -651,13 +667,15 @@ stati=
c uint32_t
>     tulip_ts(TULIPState *s)
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0static void tulip_xmi=
t_list_update(TULIPState *s)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0{
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+#define TULIP_DESC_MAX 128
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint8_t i =
=3D 0;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0struct =
tulip_descriptor desc;
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (tul=
ip_ts(s) !=3D CSR5_TS_SUSPENDED) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 for (;;) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 for (i =3D 0=
; i < TULIP_DESC_MAX; i++) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tulip_desc_read(s, s->current_tx_desc, &desc);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tulip_dump_tx_descriptor(s, &desc);
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0@@ -675,10 +693,10 @@ stati=
c void
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0tulip_xmit_list_update(TULI=
PState *s)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->tx_frame_len =3D 0;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tulip_copy_tx_buffers(s, &desc);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0-
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (desc.control & TDES1_LS) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip_tx(s, &desc);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (!tulip_copy_tx_buffers(s, &desc)) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.control & TDES1_LS) {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip_tx(s, &desc);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tulip_desc_write(s, s->current_tx_desc, &desc);
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0--
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A02.25.1
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >
>


