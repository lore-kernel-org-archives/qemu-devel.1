Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654AEC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 17:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345F8206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 17:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4BgJXbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345F8206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO3L8-0006NR-CP
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 13:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rfried.dev@gmail.com>) id 1jO3JM-0004bR-Lq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 13:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1jO3JL-0002YE-NK
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 13:55:56 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:32825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1jO3JL-0002Xs-Io; Mon, 13 Apr 2020 13:55:55 -0400
Received: by mail-oi1-x244.google.com with SMTP id m14so8097761oic.0;
 Mon, 13 Apr 2020 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VAdyFs9r0/gZz18mjGUbpgOaEnV1ZeOOeqfCOurBTaM=;
 b=f4BgJXbLNtCTw+dttcq2KbgJLeP1V7idJVF8jWdIpJzISaaaUWk5oVz0UISYpbBHnA
 GdthRK9vBZQ5kmwSr5SiZ0VOsNcS4LldvbePR03ynyXREk52cjmmZvEQQoT1kBg+oeNK
 R/4hORBIX1kQHwaOo5+zvZpgmlxmeXUn+KZT2QlL7gubY9W8e0aVZ1lqv3dfdhfDelrD
 98xNQ2B4sxbemwVXBV7VvMYxYRffq4+4Kbqbwcjr1NDvhnmHFN611CeKyq/Js9hQbBE7
 2ePennq1SwAkdnU0EjVmVm3os7Lm0eeU2f1UwGqxgCByalasBSsxbDkIHBQPP33TUWFN
 tVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VAdyFs9r0/gZz18mjGUbpgOaEnV1ZeOOeqfCOurBTaM=;
 b=bw/tHk1XMiuLXWDQpwUO/4buL4Hlt89ioD/smqG7IpBpxFIZeu7toT1afsNPsPJPC0
 K31z/ULpcxIZT6Fc/BrSX2bTTfHn1OLf8i2EfZUArJ0b6zvgN5lsgBCz4Xz7knEdPgiq
 PfGZjGLG/UwXD+Pp4PEwlzcVQeFHvGwbFege9lsPNp0HuIHx/hMk2Mi5Yxwj1cEgk9fF
 s2M8eTAEUKouOQC7nGQyQzkE7GYsjh0OKkKxbxeYsginfkQnzTeJ0KsusufLKWZqdfTt
 V9QEFjt99TRl7gGj1SSH4nWSqx0AgXtqaPtGX+cFYb3KICSlCZ/twWj3H5FDyEg4pacM
 3v+A==
X-Gm-Message-State: AGi0PuZn5obAM9+0i03sDbpP4N0m0pDOb1UcE+H5sFw8i33NezCrJaFH
 jT4vHKFBmLu1b+Aqkhjn33o6e6nuLGrEgGW+Kbg=
X-Google-Smtp-Source: APiQypK2l70Y8eZ9nhJBYM7gpPJv74RdUPyzTx/JJLmAVeO5eYGxFmGLpFx2TawYB1EAJGeQVrWP7z2d9HrA/hmpoAE=
X-Received: by 2002:aca:c691:: with SMTP id w139mr6934827oif.147.1586800554871; 
 Mon, 13 Apr 2020 10:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190716105951.25446-1-rfried.dev@gmail.com>
 <f6b7308b-f642-a691-eb97-1d74360aebac@redhat.com>
In-Reply-To: <f6b7308b-f642-a691-eb97-1d74360aebac@redhat.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Mon, 13 Apr 2020 20:55:45 +0300
Message-ID: <CAGi-RUJ7u3GEPcQBSEgCe5AfEj36myQhKEmDkVSRdkvzuoissA@mail.gmail.com>
Subject: Re: [PATCH v2] net: cadence_gem: clear RX control descriptor
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi.
Just noticed that this patch didn't hit master.
Got lost ?

Thanks,
Ramon.

On Tue, Jul 16, 2019 at 2:58 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/7/16 =E4=B8=8B=E5=8D=886:59, Ramon Fried wrote:
> > The RX ring descriptors control field is used for setting
> > SOF and EOF (start of frame and end of frame).
> > The SOF and EOF weren't cleared from the previous descriptors,
> > causing inconsistencies in ring buffer.
> > Fix that by clearing the control field of every descriptors we're
> > processing.
> >
> > Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > ---
> > v2:
> >    * change function name to rx_desc_clear_control as proposed by
> >      Jason Wang
> >    * Move the function call above the comment, as proposed by
> >      Philippe Mathieu-Daud=C3=A9
> >
> >   hw/net/cadence_gem.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index ecee22525c..cca3ce7f56 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -406,6 +406,11 @@ static inline void rx_desc_set_sof(uint32_t *desc)
> >       desc[1] |=3D DESC_1_RX_SOF;
> >   }
> >
> > +static inline void rx_desc_clear_control(uint32_t *desc)
> > +{
> > +    desc[1]  =3D 0;
> > +}
> > +
> >   static inline void rx_desc_set_eof(uint32_t *desc)
> >   {
> >       desc[1] |=3D DESC_1_RX_EOF;
> > @@ -993,6 +998,8 @@ static ssize_t gem_receive(NetClientState *nc, cons=
t uint8_t *buf, size_t size)
> >           rxbuf_ptr +=3D MIN(bytes_to_copy, rxbufsize);
> >           bytes_to_copy -=3D MIN(bytes_to_copy, rxbufsize);
> >
> > +        rx_desc_clear_control(s->rx_desc[q]);
> > +
> >           /* Update the descriptor.  */
> >           if (first_desc) {
> >               rx_desc_set_sof(s->rx_desc[q]);
>
>
> Applied.
>
> Thanks
>

