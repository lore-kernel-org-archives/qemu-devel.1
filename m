Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C978C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2783B2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew47/4tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaYC-0007Rs-Di
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyaXc-0006uS-5K
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyaXZ-0002QS-Qm
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:09:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyaXZ-0002Pa-JM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580731761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d2Vi1xDuX/gFJh7zRcobZSL0PtFIJhZnK14ZrqT7Qx4=;
 b=ew47/4tccexIQgOJbReh4nLGRAnweFJ35AShtWC3pqyAd4u1NPmCyHroofVH0Yw+Jx+YZn
 m1V46LBOLOjFRn/UY1ENo/DyYl4FQynvv9OluSBmqSM8AO+yXS43d1hZKE9ElTxQLAKn+C
 CRWvgv7GP0KEht6DOgJi1U/CJmwVzSw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-WzmnPvoiNmygvDTY22RIpQ-1; Mon, 03 Feb 2020 07:09:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id m15so3878191wrs.22
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 04:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H8DX1PeyL1BIsOQfdq2upYmkDOkFIPyHF5fU3dbzCCk=;
 b=gJ5ZH9boP2g2mVV65YOyTATyyvREKygl3reb7bk3ua+owR1eN6z/z71/GINnOtS670
 gxMVXrod/BBF9KHaWGkh0jk+f3Z6zZfaGM63cnwb5PZ9Gv/jsxmaqC8AsmLhG3BCEAlX
 VNAq59gpZMnMsbBDCsUvL6U3nSvRIJEDnSp1b9BlXS/wsH7e2bUn+/5+tSzRKZcAvhtN
 xTxS098SxnnBYM2ukteZbrNc9fUEwWpNCszo9EGDSpX1fEXZIaDupGzdWvnmgS+SxhkS
 1Xp1ofnF7T8G1a6W50ZEnHmNSaH1b+OHOIcsKPM+9/He26GEYIrMLRk5PawIbg38u/qw
 bLgg==
X-Gm-Message-State: APjAAAW0i/jz6gjti5Fwzvh4BYN6EF78PpTPdAzUuVqyhcIrTBSr9cWP
 OeoELtHej+ucuNokthibI6aAOZHXti6flGJdsZt4j88ZH6Fl66FoHAShWW9nAwJH23tlq/Mli2S
 wm1RZ4IG5+0I1jRk=
X-Received: by 2002:a1c:e2c3:: with SMTP id z186mr28841084wmg.70.1580731743457; 
 Mon, 03 Feb 2020 04:09:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmPCC0+nNeCruhMk7gnQsBlxz5Otmy01SiP11ziZNohCCR/oz+OmW1TW/N/ufg0CQP9Ok9UA==
X-Received: by 2002:a1c:e2c3:: with SMTP id z186mr28841054wmg.70.1580731743174; 
 Mon, 03 Feb 2020 04:09:03 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id n3sm24580933wrs.8.2020.02.03.04.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 04:09:02 -0800 (PST)
Subject: Re: [PATCH] bcm2835_dma: Fix TD mode
To: Rene Stange <rsta2@o2online.de>
References: <5099495.CBsx362VbF@desktop2>
 <9d885f77-0bb2-2ab6-cf46-400a0bc2deb8@redhat.com>
 <2852675.bWBgnKVUkk@desktop2>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0882149e-b88d-80c9-0b2b-92b88f000cfc@redhat.com>
Date: Mon, 3 Feb 2020 13:09:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2852675.bWBgnKVUkk@desktop2>
Content-Language: en-US
X-MC-Unique: WzmnPvoiNmygvDTY22RIpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Rene,

On 1/27/20 12:20 PM, Rene Stange wrote:
> Hi Philippe,
>=20
> I'm running an example program for my Circle bare metal framework for the
> Raspberry Pi using the LittlevGL graphics library. It uses the TD DMA mod=
e to
> transfer pixel data to the screen buffer (10 lines at a time). Without th=
e
> given patch applied to QEMU only the first pixel line of each transfer is
> shown in TigerVNC viewer, after applying it, a solid image is shown.
>=20
> You can reproduce the problem on a 64-bit Linux machine as follows. The "=
sed"
> command modifies the example program, so that it doesn't try to access th=
e
> (not available) USB HCI controller of the Raspberry Pi 3.
>=20
> Regards,
>=20
> Rene
>=20
>=20
> cd
> mkdir dma-test
> cd dma-test/
> wget https://developer.arm.com/-/media/Files/downloads/gnu-a/8.3-2019.03/=
binrel/gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz
> tar xJf gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz
> git clone https://github.com/rsta2/circle.git
> cd circle
> git submodule update --init
> echo "AARCH =3D 64" > Config.mk
> echo "RASPPI =3D 3" >> Config.mk
> echo "PREFIX64 =3D ~/dma-test/gcc-arm-8.3-2019.03-x86_64-aarch64-elf/bin/=
aarch64-elf-" >> Config.mk
> ./makeall
> cd addon/littlevgl/
> make
> cd sample/
> sed -i -e "s/bOK =3D m_USBHCI/\/\/bOK =3D m_USBHCI/" kernel.cpp
> make
> qemu-system-aarch64 -M raspi3 -kernel kernel8.img
>=20
>=20
> On Monday, 27 January 2020, 09:29:59 CET, Philippe Mathieu-Daud=E9 <philm=
d@redhat.com> wrote:
>> Hi Rene,
>>
>> On 1/24/20 6:55 PM, Rene Stange wrote:
>>> TD (two dimensions) DMA mode did not work, because the xlen variable ha=
s
>>> not been re-initialized before each additional ylen run through in
>>> bcm2835_dma_update(). Furthermore ylen has to be increased by one after
>>> reading it from the TXFR_LEN register, because a value of zero has to
>>> result in one run through of the ylen loop. Both issues have been fixed=
.

So we have 2 fixes in 1 patch. I'd rather see 2 different commits:

1: Fix the ylen loop

-- >8 --
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -70,14 +70,14 @@ static void bcm2835_dma_update(BCM2835DMAState *s,=20
unsigned c)
          ch->stride =3D ldl_le_phys(&s->dma_as, ch->conblk_ad + 16);
          ch->nextconbk =3D ldl_le_phys(&s->dma_as, ch->conblk_ad + 20);

+        ylen =3D 1;
          if (ch->ti & BCM2708_DMA_TDMODE) {
              /* 2D transfer mode */
-            ylen =3D (ch->txfr_len >> 16) & 0x3fff;
+            ylen +=3D (ch->txfr_len >> 16) & 0x3fff;
              xlen =3D ch->txfr_len & 0xffff;
              dst_stride =3D ch->stride >> 16;
              src_stride =3D ch->stride & 0xffff;
          } else {
-            ylen =3D 1;
              xlen =3D ch->txfr_len;
              dst_stride =3D 0;
              src_stride =3D 0;
---

2: re-initialized xlen:

-- >8 --
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -54,7 +54,7 @@
  static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
  {
      BCM2835DMAChan *ch =3D &s->chan[c];
-    uint32_t data, xlen, ylen;
+    uint32_t data, xlen, xlen_td, ylen;
      int16_t dst_stride, src_stride;

      if (!(s->enable & (1 << c))) {
@@ -82,6 +82,7 @@ static void bcm2835_dma_update(BCM2835DMAState *s,=20
unsigned c)
              dst_stride =3D 0;
              src_stride =3D 0;
          }
+        xlen_td =3D xlen;

          while (ylen !=3D 0) {
              /* Normal transfer mode */
@@ -117,6 +118,7 @@ static void bcm2835_dma_update(BCM2835DMAState *s,=20
unsigned c)
              if (--ylen !=3D 0) {
                  ch->source_ad +=3D src_stride;
                  ch->dest_ad +=3D dst_stride;
+                xlen =3D xlen_td;
              }
          }
          ch->cs |=3D BCM2708_DMA_END;
---

What do you think? If this sounds good to you, do you mind sending a v2=20
with the 2 patches?

Thanks,

Phil.

>>
>> What were you running, how can we reproduce?
>>
>>>
>>> Signed-off-by: Rene Stange <rsta2@o2online.de>
>>> ---
>>>    hw/dma/bcm2835_dma.c | 9 +++++----
>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
>>> index 1e458d7fba..0881c9506e 100644
>>> --- a/hw/dma/bcm2835_dma.c
>>> +++ b/hw/dma/bcm2835_dma.c
>>> @@ -54,7 +54,7 @@
>>>    static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
>>>    {
>>>        BCM2835DMAChan *ch =3D &s->chan[c];
>>> -    uint32_t data, xlen, ylen;
>>> +    uint32_t data, xlen, xlen_td, ylen;
>>>        int16_t dst_stride, src_stride;
>>>   =20
>>>        if (!(s->enable & (1 << c))) {
>>> @@ -72,13 +72,13 @@ static void bcm2835_dma_update(BCM2835DMAState *s, =
unsigned c)
>>>   =20
>>>            if (ch->ti & BCM2708_DMA_TDMODE) {
>>>                /* 2D transfer mode */
>>> -            ylen =3D (ch->txfr_len >> 16) & 0x3fff;
>>> -            xlen =3D ch->txfr_len & 0xffff;
>>> +            ylen =3D ((ch->txfr_len >> 16) & 0x3fff) + 1;
>>> +            xlen_td =3D xlen =3D ch->txfr_len & 0xffff;
>>>                dst_stride =3D ch->stride >> 16;
>>>                src_stride =3D ch->stride & 0xffff;
>>>            } else {
>>>                ylen =3D 1;
>>> -            xlen =3D ch->txfr_len;
>>> +            xlen_td =3D xlen =3D ch->txfr_len;
>>>                dst_stride =3D 0;
>>>                src_stride =3D 0;
>>>            }
>>> @@ -117,6 +117,7 @@ static void bcm2835_dma_update(BCM2835DMAState *s, =
unsigned c)
>>>                if (--ylen !=3D 0) {
>>>                    ch->source_ad +=3D src_stride;
>>>                    ch->dest_ad +=3D dst_stride;
>>> +                xlen =3D xlen_td;
>>>                }
>>>            }
>>>            ch->cs |=3D BCM2708_DMA_END;
>>>
>>
>>
>=20
>=20
>=20


