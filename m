Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4100C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DFF20842
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="ns00dkns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DFF20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=o2online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2T0-00067k-RJ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rsta2@o2online.de>) id 1iw2S9-0004ug-Mn
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rsta2@o2online.de>) id 1iw2S8-0005WV-Ce
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:21:13 -0500
Received: from mail229c50.megamailservers.eu ([91.136.10.239]:48592
 helo=mail36c50.megamailservers.eu)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rsta2@o2online.de>)
 id 1iw2S4-0005Hp-GI; Mon, 27 Jan 2020 06:21:09 -0500
X-Authenticated-User: 017626146082@o2online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
 s=maildub; t=1580124057;
 bh=5mxXBJF9kNB9eZK7UMToWMAhB9cHOuCiUWMIAMBkDEE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ns00dknsXHxc7zBOScGQhovq+E4ZEaTYE14DO67gI9c2+QHz3vmn4fXh15ZGo/nR0
 mgGiuue6wCn19KhpdCM7tvXgwZWbmTPVtUREQoMjZga6geK1s6jdn7l0coya5CMaX2
 +2Tnn0RSwdvBWGqKdxijTV3dWFTQb6r5yYLgNTh4=
Feedback-ID: rsta2@o2online.
Received: from desktop2.localnet (178-21-1-177.ilmprovider.net [178.21.1.177])
 (authenticated bits=0)
 by mail36c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 00RBKsAD013615
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Jan 2020 11:20:56 +0000
From: Rene Stange <rsta2@o2online.de>
To: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] bcm2835_dma: Fix TD mode
Date: Mon, 27 Jan 2020 12:20:54 +0100
Message-ID: <2852675.bWBgnKVUkk@desktop2>
In-Reply-To: <9d885f77-0bb2-2ab6-cf46-400a0bc2deb8@redhat.com>
References: <5099495.CBsx362VbF@desktop2>
 <9d885f77-0bb2-2ab6-cf46-400a0bc2deb8@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-CTCH-RefID: str=0001.0A0B020C.5E2EC799.005C, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC: 0
X-CHA: v=2.3 cv=bd8Vr9HB c=1 sm=1 tr=0 a=oFQkuSNlBNCQRuITVo1IXg==:117
 a=oFQkuSNlBNCQRuITVo1IXg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=8nJEP1OIZ-IA:10 a=7CQSdrXTAAAA:8 a=rTsyARspAAAA:20 a=20KFwNOVAAAA:8
 a=vxNqc9rRQqJLtr7q4cgA:9 a=6w-0JV3Zq0mKVwE1:21 a=zxFjX95f0CasTnp2:21
 a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 91.136.10.239
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

I'm running an example program for my Circle bare metal framework for the
Raspberry Pi using the LittlevGL graphics library. It uses the TD DMA mode =
to
transfer pixel data to the screen buffer (10 lines at a time). Without the
given patch applied to QEMU only the first pixel line of each transfer is
shown in TigerVNC viewer, after applying it, a solid image is shown.

You can reproduce the problem on a 64-bit Linux machine as follows. The "se=
d"
command modifies the example program, so that it doesn't try to access the
(not available) USB HCI controller of the Raspberry Pi 3.

Regards,

Rene


cd
mkdir dma-test
cd dma-test/
wget https://developer.arm.com/-/media/Files/downloads/gnu-a/8.3-2019.03/bi=
nrel/gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz
tar xJf gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz
git clone https://github.com/rsta2/circle.git
cd circle
git submodule update --init
echo "AARCH =3D 64" > Config.mk
echo "RASPPI =3D 3" >> Config.mk
echo "PREFIX64 =3D ~/dma-test/gcc-arm-8.3-2019.03-x86_64-aarch64-elf/bin/aa=
rch64-elf-" >> Config.mk
=2E/makeall
cd addon/littlevgl/
make
cd sample/
sed -i -e "s/bOK =3D m_USBHCI/\/\/bOK =3D m_USBHCI/" kernel.cpp
make
qemu-system-aarch64 -M raspi3 -kernel kernel8.img


On Monday, 27 January 2020, 09:29:59 CET, Philippe Mathieu-Daud=E9 <philmd@=
redhat.com> wrote:
> Hi Rene,
>=20
> On 1/24/20 6:55 PM, Rene Stange wrote:
> > TD (two dimensions) DMA mode did not work, because the xlen variable has
> > not been re-initialized before each additional ylen run through in
> > bcm2835_dma_update(). Furthermore ylen has to be increased by one after
> > reading it from the TXFR_LEN register, because a value of zero has to
> > result in one run through of the ylen loop. Both issues have been fixed.
>=20
> What were you running, how can we reproduce?
>=20
> >=20
> > Signed-off-by: Rene Stange <rsta2@o2online.de>
> > ---
> >   hw/dma/bcm2835_dma.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
> > index 1e458d7fba..0881c9506e 100644
> > --- a/hw/dma/bcm2835_dma.c
> > +++ b/hw/dma/bcm2835_dma.c
> > @@ -54,7 +54,7 @@
> >   static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
> >   {
> >       BCM2835DMAChan *ch =3D &s->chan[c];
> > -    uint32_t data, xlen, ylen;
> > +    uint32_t data, xlen, xlen_td, ylen;
> >       int16_t dst_stride, src_stride;
> >  =20
> >       if (!(s->enable & (1 << c))) {
> > @@ -72,13 +72,13 @@ static void bcm2835_dma_update(BCM2835DMAState *s, =
unsigned c)
> >  =20
> >           if (ch->ti & BCM2708_DMA_TDMODE) {
> >               /* 2D transfer mode */
> > -            ylen =3D (ch->txfr_len >> 16) & 0x3fff;
> > -            xlen =3D ch->txfr_len & 0xffff;
> > +            ylen =3D ((ch->txfr_len >> 16) & 0x3fff) + 1;
> > +            xlen_td =3D xlen =3D ch->txfr_len & 0xffff;
> >               dst_stride =3D ch->stride >> 16;
> >               src_stride =3D ch->stride & 0xffff;
> >           } else {
> >               ylen =3D 1;
> > -            xlen =3D ch->txfr_len;
> > +            xlen_td =3D xlen =3D ch->txfr_len;
> >               dst_stride =3D 0;
> >               src_stride =3D 0;
> >           }
> > @@ -117,6 +117,7 @@ static void bcm2835_dma_update(BCM2835DMAState *s, =
unsigned c)
> >               if (--ylen !=3D 0) {
> >                   ch->source_ad +=3D src_stride;
> >                   ch->dest_ad +=3D dst_stride;
> > +                xlen =3D xlen_td;
> >               }
> >           }
> >           ch->cs |=3D BCM2708_DMA_END;
> >=20
>=20
>=20




