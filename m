Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C4C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B3D20578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNlE9d1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B3D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt9E-00037o-OC
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1jtsxI-0004wF-G0
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:20:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35661
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1jtsxG-0002qo-KM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594387241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqszcgvdPDw8SpORCSiqDEUSYgctVFGgYc2o/0RFKDY=;
 b=eNlE9d1gXUYEFDK7WLGlhjQ5020il0zUnfqKDfuodhDNtStCKo4uEEOLQrc/YsDgYg2cBE
 FI0ncuf2WuCI3y4WjL6hi08V6jknKGPe9gsNLNcLJQ7xVD/tb0HIjsenYFyBZgb5xMtJXq
 8/7d0EUrY44eO2Q0nvny274Y1Kj3X6U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-PqE6Cc73O5eS-O0wSQrkvQ-1; Fri, 10 Jul 2020 09:20:40 -0400
X-MC-Unique: PqE6Cc73O5eS-O0wSQrkvQ-1
Received: by mail-ej1-f69.google.com with SMTP id do21so6475040ejc.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 06:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mqszcgvdPDw8SpORCSiqDEUSYgctVFGgYc2o/0RFKDY=;
 b=clg04SUZ2evgwPbTQ3MTIDFEhKZW8Masyv6jmYK07s4M3JjWwizNjSeYy08X9tmGrf
 bQ8Hio3NgaGoQLoPshJZKBRbtffkWh4Aneb9pgFN45K1wjoTEMPkN+HxzlFMVkCFxmF1
 H58kAOgT3lwmaV8VuPncD5wTbfdkev+DmC8i8RdRvJ8SP+rfZ0vw7JcSgeWvLQL7dUsw
 0PGWl2LZmh5p/aUozKDudw76aURAlHHapI/bLTnFMUxyRUr6vUFY0TodO6wn954r7xaF
 qhfJhYQkjOZsBM9zV7Ulexf2ZbJ3hojJ/IU3BqwOBijBgHIdWi1MAQD3TDtnQOA+sCcD
 FMhg==
X-Gm-Message-State: AOAM532AcxzUWnEvfIqaSKb8W4dsu9eiMlM88K34s5Mq28b5YeUZbSSR
 W7/9ZB9WpHztWe9socuD0aD7Vi3Z5NV8wMGQpsK+ih5kw21XkA0qXOpRojzCQSRkCQ23pNTEU8w
 9GVksZ3yvnGBnZ0HQn0ixAwlankmCf+0=
X-Received: by 2002:a05:6402:3048:: with SMTP id
 bu8mr79773116edb.367.1594387239171; 
 Fri, 10 Jul 2020 06:20:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNzwyO5TJsS623hQd2fQfBWh5e36L3OtMEClpuVshBhJUtYEaXpfIuTVuht6gcpihNkSxHWU8L+MONMvBPuxs=
X-Received: by 2002:a05:6402:3048:: with SMTP id
 bu8mr79773092edb.367.1594387238825; 
 Fri, 10 Jul 2020 06:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200710085417.638904-1-mcascell@redhat.com>
 <CAFEAcA-pRXOz5JVcwHa8=oaeogwaOK0YVXYQiJUpdM_rFZ+QTA@mail.gmail.com>
In-Reply-To: <CAFEAcA-pRXOz5JVcwHa8=oaeogwaOK0YVXYQiJUpdM_rFZ+QTA@mail.gmail.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Fri, 10 Jul 2020 15:20:28 +0200
Message-ID: <CAA8xKjWpU_e5wPoT0jQWx9kFG-A_iO8MioMAqS-raDSPG3nX1A@mail.gmail.com>
Subject: Re: [PATCH] hw/net/ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
To: Peter Maydell <peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mcascell@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, ziming zhang <ezrakiez@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 1:33 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 10 Jul 2020 at 09:56, Mauro Matteo Cascella <mcascell@redhat.com> wrote:
> >
> > An integer overflow issue was reported by Mr. Ziming Zhang, CC'd here. It
> > occurs while inserting the VLAN tag in packets whose length is less than
> > 12 bytes, as (len-12) is passed to memmove() without proper checking.
> > This patch is intended to fix this issue by checking the minimum
> > Ethernet frame size during packet transmission.
> >
> > Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> > Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> > ---
> >  hw/net/ftgmac100.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> > index 043ba61b86..bcf4d84aea 100644
> > --- a/hw/net/ftgmac100.c
> > +++ b/hw/net/ftgmac100.c
> > @@ -238,6 +238,11 @@ typedef struct {
> >   */
> >  #define FTGMAC100_MAX_FRAME_SIZE    9220
> >
> > +/*
> > + * Min frame size
> > + */
> > +#define FTGMAC100_MIN_FRAME_SIZE    64
> > +
> >  /* Limits depending on the type of the frame
> >   *
> >   *   9216 for Jumbo frames (+ 4 for VLAN)
> > @@ -507,6 +512,15 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
> >          }
> >
> >          len = FTGMAC100_TXDES0_TXBUF_SIZE(bd.des0);
> > +
> > +        /* drop small packets */
> > +        if (bd.des0 & FTGMAC100_TXDES0_FTS &&
> > +            len < FTGMAC100_MIN_FRAME_SIZE) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too small: %d bytes\n",
> > +                          __func__, len);
> > +            break;
> > +        }
> > +
>
> Andrew, Cedric: do you have the datasheet for this devic? Do you
> know if we should also be flagging the error back to the
> guest somehow?
>
> I think a 'break' here means we'll never update the
> descriptor flags to hand it back to the guest, which
> is probably not what the hardware does.
>
> thanks
> -- PMM
>

I thought of setting FTGMAC100_INT_XPKT_LOST, but not sure if this is
the most appropriate flag here.

Regards,
Mauro


