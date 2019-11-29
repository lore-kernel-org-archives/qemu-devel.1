Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0001FC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC8921774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqQNTK2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC8921774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaioG-0007Rz-RY
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 11:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iailN-0004vO-7h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 11:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iailJ-0008Fn-PU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 11:04:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iailJ-00084u-LY
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 11:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575043489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zg8HBt8/v556Px1AquN+KYHYk63ghRTuJn/glDQ/6mE=;
 b=EqQNTK2NsenAVGHUY1pA4HimCWIXQD77str7Z2X9hVEsslJkzS5L37xmzgJVuecAvCaPsy
 wiGW+tZafR0vojB5dpbarDL620HUBcW/x1tP3tSgLyl7+Db9Fj5klFsSh5lZVKF7SfRjQY
 ZZlnQhHY+oVhQU3BsIFz4Q2rOQGt2So=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-b5rV32YROuKUG5lR_Miw9Q-1; Fri, 29 Nov 2019 11:04:48 -0500
Received: by mail-wr1-f69.google.com with SMTP id b2so14438930wrj.9
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 08:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zg8HBt8/v556Px1AquN+KYHYk63ghRTuJn/glDQ/6mE=;
 b=AF6/3kRIEoEYF+dRoshZuThv3wUS9L+IKAYc4f2gbAkT/nJoeH5bYntlFLZlh+2FMC
 ZrCxHvypwuytWFCLx6p0ECBryy8LNCS2QC5yR6/sZYdCfMoCsPaMPGsY+79L5Y9oTrMa
 KlgHccm1EXvM8pmBIsWiuDgmjBuPzYifXs8DIc437COO7zO9YWTtvTBcF7a/CB2nLIYS
 LV5xLp6d9kAjX8tr5u2F1gDRjWZuT885dO5H05FiTqt9kxt2iKLUwJ50Dq/T8uamTQ2y
 GE0yNQ0gan5K7mMoPt1Xu2DZP6V5gabW6gheLu3Hbyu4IFD+y5A5A9u0rvG+iDhbVpW7
 LnBg==
X-Gm-Message-State: APjAAAWpicN7yeJWHB5BUTANH9puW/hUN4/qKxx57xqobGtiXjVoVV3D
 vXsTFaTz+e1FgAukUuqR2dyZ8lspKOi9axiM7rRWceEwVQ/Tr9ErJ1QTfBicH6jFWCUr336Ft96
 9GhTOAXa48yU9aMP9iRUE35flZnCtA0Y=
X-Received: by 2002:a1c:46:: with SMTP id 67mr16423588wma.51.1575043485987;
 Fri, 29 Nov 2019 08:04:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJfyEo75CcdjKOhLyA64OptdO2Y3mpTLn8pYTxxAyitO8V3zyZ5m1FWbTx/f5I1lCXQwKT9LDEsgqUA/knxRE=
X-Received: by 2002:a1c:46:: with SMTP id 67mr16423551wma.51.1575043485738;
 Fri, 29 Nov 2019 08:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20191129150508.24404-1-bilalwasim676@gmail.com>
 <afe9efde-7ac1-8607-446a-8fbf10accece@redhat.com>
 <8c956ae31e8f44a2b831a5030b2448b4@SVR-IES-MBX-03.mgc.mentorg.com>
In-Reply-To: <8c956ae31e8f44a2b831a5030b2448b4@SVR-IES-MBX-03.mgc.mentorg.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 29 Nov 2019 17:04:34 +0100
Message-ID: <CAP+75-X_POJfTO=gOUu1zCPtcfnQ5yemQo0hqB_s3jy_C17o9g@mail.gmail.com>
Subject: Re: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support loopback
 mode.
To: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
X-MC-Unique: b5rV32YROuKUG5lR_Miw9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aa1ronham@gmail.com" <aa1ronham@gmail.com>,
 "jcd@tribudubois.net" <jcd@tribudubois.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "bilalwasim676@gmail.com" <bilalwasim676@gmail.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 4:59 PM Wasim, Bilal <Bilal_Wasim@mentor.com> wrote=
:
>
> Thanks for the pointers philippe.. Is the patch okay to be merged without=
 it or do I need to do a re-submission with the updated username ?

If there are no review comments on your patch, I think the maintainer
taking your patch can fix this details directly, no need to resend.

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 [mailto:philmd@redhat.com]
> Sent: Friday, November 29, 2019 8:38 PM
> To: bilalwasim676@gmail.com; qemu-devel@nongnu.org
> Cc: peter.maydell@linaro.org; aa1ronham@gmail.com; jcd@tribudubois.net; q=
emu-arm@nongnu.org; Wasim, Bilal <Bilal_Wasim@mentor.com>; linux@roeck-us.n=
et; Jason Wang <jasowang@redhat.com>
> Subject: Re: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support loop=
back mode.
>
> Hi Bilal,
>
> Cc'ing Jason, the maintainer of network devices.
>
> On 11/29/19 4:05 PM, bilalwasim676@gmail.com wrote:
> > From: bwasim <bilal_wasim@mentor.com>
>
> Your git setup misses your 'user.name', you could fix it running:
>
>    git config user.name "Bilal Wasim"
>
> (eventually with the --global option).
>
> The patch looks good otherwise.
>
> Thanks!
>
> > Loopback mode only works when specific conditions (as dictated by the
> > IP guide) are met, i.e. the MII_MODE is set and the RMII_MODE is
> > cleared. If not, we simply send the packet on the output queue (for TX
> > to the host network). Tested by running a custom RTOS and TXing a ton
> > of packets. The same packets were received on the RX side..
> >
> > Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> > ---
> >   hw/net/imx_fec.c | 27 +++++++++++++++++++++++++--
> >   1 file changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c index
> > bd99236864..c51e7f7363 100644
> > --- a/hw/net/imx_fec.c
> > +++ b/hw/net/imx_fec.c
> > @@ -256,6 +256,29 @@ static const VMStateDescription vmstate_imx_eth =
=3D
> > {
> >
> >   static void imx_eth_update(IMXFECState *s);
> >
> > +/*
> > + * Function to check if the MAC is configured to run in loopback mode.
> > + * If so, invoke the "receive" routine.
> > + * Else write to the output.
> > + * */
> > +static void send_pkt(IMXFECState *s, uint8_t *frame, int frame_size)
> > +{
> > +    NetClientState *nc =3D qemu_get_queue(s->nic);
> > +
> > +    /*
> > +     * Loopback or Normal mode ?
> > +     * Per the FEC Manual: If loopback is enabled, the MII_MODE
> > +     * should be SET and the RMII_MODE should be cleared. Loopback
> > +     * will only work if this criterion is met. If not met,
> > +     * we will send the frame on the output queue. */
> > +    if ((s->regs[ENET_RCR] & ENET_RCR_LOOP) && (s->regs[ENET_RCR] & EN=
ET_RCR_MII_MODE)
> > +            && !(s->regs[ENET_RCR] & ENET_RCR_RMII_MODE)) {
> > +        nc->info->receive(nc, frame, frame_size);
> > +    } else {
> > +        qemu_send_packet(nc, frame, frame_size);
> > +    }
> > +}
> > +
> >   /*
> >    * The MII phy could raise a GPIO to the processor which in turn
> >    * could be handled as an interrpt by the OS.
> > @@ -488,7 +511,7 @@ static void imx_fec_do_tx(IMXFECState *s)
> >           frame_size +=3D len;
> >           if (bd.flags & ENET_BD_L) {
> >               /* Last buffer in frame.  */
> > -            qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_s=
ize);
> > +            send_pkt(s, (uint8_t *)&s->frame, frame_size);
> >               ptr =3D s->frame;
> >               frame_size =3D 0;
> >               s->regs[ENET_EIR] |=3D ENET_INT_TXF; @@ -586,7 +609,7 @@
> > static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
> >               }
> >               /* Last buffer in frame.  */
> >
> > -            qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_s=
ize);
> > +            send_pkt(s, (uint8_t *)&s->frame, frame_size);
> >               ptr =3D s->frame;
> >
> >               frame_size =3D 0;
> >
>


