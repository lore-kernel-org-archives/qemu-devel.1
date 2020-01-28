Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B913C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582E221739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNh41fYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582E221739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOhy-0007Gj-D0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iwOfu-0004Ky-HC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iwOft-0004b7-Co
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:04:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21675
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iwOft-0004ae-9i
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580209492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ie97vwGgpNnbq9LeP6eV17/f8uunbL/XRYOgBvuEroA=;
 b=aNh41fYqheyZZ0Yn4hLXfls0OyNVUX4qUe6P4pve4B48mawc8ZTP+rVXlmPI4y3HrJ1J5/
 CNJsX2/4cPzOkBrkKVEfsLb4Iyr/h3ZccrzRkSD5/a48qKwaLsLXiSuOfWbaEdciD/j7Zw
 jFmONYYmaUQuO2wFa3nOzwQxjKZeNqs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-g0jVNCHdOSKbmIcCDoyWEQ-1; Tue, 28 Jan 2020 06:04:49 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so7812036wrq.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 03:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ie97vwGgpNnbq9LeP6eV17/f8uunbL/XRYOgBvuEroA=;
 b=KgUVQLFJOQptsLougN3Gs4lrwijAADNpxmZncFjLS//c3r5JmeoFp5jL4F99x/9fff
 RVQRXwrvFinb1vXrYZcMCRpuDpWZlafov7EIyXezAaYq1Lnz3B0NIU2XhmanSxkZM2m/
 YfKYZ+2++h0FkgMR+eXXNC8Xy4CqyEl/t2KOYlhn/gokb+BybylHwuWde+H+8AnNJ4MZ
 noKupdlDglTtDI8cuC8OANWSzwcYRKWrW/NLVhKJKj+SvSfXZoTATjiMOrX/rSU0gisJ
 uwQVm2Ldg819BiSoZO1Q50G24f7OONrhRhINvUgqxjFRbYf7PMaKpk84NdnxLmhCHENd
 RbKw==
X-Gm-Message-State: APjAAAUbU6Q9sXbPNQft7iZJphOjLmz2euRXJn8SRqGJ1ksKobCxbltc
 cKRDktDDbDk738iiw+ecOeFIOpYKRwNP72grjwN0vurEN5QujfqojVdHFAzbB4bRFz3qMKfX7JL
 Iy4m633cQRy6xmNRO1kXl2ZyXN8hJO5w=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr27259025wrp.17.1580209488166; 
 Tue, 28 Jan 2020 03:04:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQ2OItNEA/pUjqRwtp+Yd5/VA9audTMkm8/0OecZoA2TNkvc/nsB2XdgRaKIQFy8lG3iY/p/EUwgFdiKIBkQs=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr27259007wrp.17.1580209487971; 
 Tue, 28 Jan 2020 03:04:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <a582b4412af479e0830d1ef0005a91a98bfc56cc.1579474761.git.fthain@telegraphics.com.au>
 <b47b1144-bb76-9f70-3351-86ba605e4ac3@redhat.com>
In-Reply-To: <b47b1144-bb76-9f70-3351-86ba605e4ac3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 28 Jan 2020 12:04:36 +0100
Message-ID: <CAP+75-Ud4U5=7N0SerV9JAo7m2TOiFAR+1CO2MAHdX+PRmRUVA@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] dp8393x: Have dp8393x_receive() return the
 packet size
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang <jasowang@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>
X-MC-Unique: g0jVNCHdOSKbmIcCDoyWEQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 12:03 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 1/19/20 11:59 PM, Finn Thain wrote:
> > This function re-uses its 'size' argument as a scratch variable.
> > Instead, declare a local 'size' variable for that purpose so that the
> > function result doesn't get messed up.
> >
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Laurent Vivier <laurent@vivier.eu>
> > ---
> >   hw/net/dp8393x.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> > index 2d2ace2549..ece72cbf42 100644
> > --- a/hw/net/dp8393x.c
> > +++ b/hw/net/dp8393x.c
> > @@ -757,20 +757,21 @@ static int dp8393x_receive_filter(dp8393xState *s=
, const uint8_t * buf,
> >   }
> >
> >   static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * bu=
f,
> > -                               size_t size)
> > +                               size_t pkt_size)
> >   {
> >       dp8393xState *s =3D qemu_get_nic_opaque(nc);
> >       int packet_type;
> >       uint32_t available, address;
> > -    int width, rx_len =3D size;
> > +    int width, rx_len =3D pkt_size;
> >       uint32_t checksum;
> > +    int size;
> >
> >       width =3D (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
> >
> >       s->regs[SONIC_RCR] &=3D ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_R=
CR_FAER |
> >           SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC=
);
> >
> > -    packet_type =3D dp8393x_receive_filter(s, buf, size);
> > +    packet_type =3D dp8393x_receive_filter(s, buf, pkt_size);
> >       if (packet_type < 0) {
> >           DPRINTF("packet not for netcard\n");
> >           return -1;
> > @@ -864,7 +865,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
> >       /* Done */
> >       dp8393x_update_irq(s);
> >
> > -    return size;
> > +    return pkt_size;
> >   }
> >
> >   static void dp8393x_reset(DeviceState *dev)
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

One R-b tag is enough btw ;)


