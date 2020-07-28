Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F63C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E2A2074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRM8g+1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E2A2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SRk-00075n-5J
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k0SRB-0006ei-BR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:26:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k0SR9-0003Ld-MM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595953603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhpQG3bHQanOgtJrG6QvL/uY9hLzZNQiqzjSqo8L7W0=;
 b=gRM8g+1xtBUb/CBkf4H9fPJGRw3UsNbjNWNvBAnOogFLjVwEbVt7PSIyfp6gzx89V4a7lf
 jewh9bX8/l+T3S7jMfrCTqeP/Xol80voDY02vAHzQjsxsfEb7LUKMF1IAZSknmpY/6dnHQ
 fARqQPNbLAhuEKVbUvEbhet9E0qu6ns=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-y7Bxj-i1MOmoN9_6rYmklg-1; Tue, 28 Jul 2020 12:26:41 -0400
X-MC-Unique: y7Bxj-i1MOmoN9_6rYmklg-1
Received: by mail-ed1-f69.google.com with SMTP id w19so7222816edx.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qhpQG3bHQanOgtJrG6QvL/uY9hLzZNQiqzjSqo8L7W0=;
 b=fp222c4dbTM5/2Pvl9v6CKvIkji7IZYZzq6DGIxIKe4JtOdp4SdH9Y6SM+C8gzlz3/
 sKsqF3in7X0VnFX+hXzlCc7HjFXNvodHhrIpPYb0/5xt/9yOjYzwWJTwOtkwvV3d0rDv
 auyL4fIo788jG7wf0nm+dU25dtQZjGGCBXeJc3niIWDTMRK2h4AaRVOYixz/TcbvIDEu
 xA2fwwMV3fjBV36jsgy2Mto+l7Z1rjY8k7xDcwNwlm8EkA8j/2B0aVwsC4JxymHjhhNQ
 SL7CMTL1vm+yFm+z3gK3joIbkl7zd22JmAEyPIb1j8B8eLiyGj9UjXddwZPF3kYnNWFb
 RMxw==
X-Gm-Message-State: AOAM531YlUxdmRMudjLCUCQpiTflxMbcfxjTWeM6TxkWMuljCvzBtoQx
 Y5oIcTALWZtQO6CDCV52zyI3DHfelge6DwSN+RUYEO/VWGdGzPUxpUsSivoCSnH8xgfKCJi53Aq
 8SVQEsm433k1Uyiz8HYfnvtV2GtCE7eE=
X-Received: by 2002:a17:906:7855:: with SMTP id
 p21mr26171222ejm.492.1595953600177; 
 Tue, 28 Jul 2020 09:26:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl6gaY4xgoGXcz1/dlw/rkByLlpDAVKKPD8LfDMaPDOOXTdx2X3KS2Qp7xiiiOh+YCznvXdFxaLDKZQg0WUxQ=
X-Received: by 2002:a17:906:7855:: with SMTP id
 p21mr26171208ejm.492.1595953599956; 
 Tue, 28 Jul 2020 09:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200727170838.1101775-1-mcascell@redhat.com>
 <20200727170838.1101775-2-mcascell@redhat.com>
 <adb52967-d2b2-cb55-87a2-38fda18a2a0a@redhat.com>
In-Reply-To: <adb52967-d2b2-cb55-87a2-38fda18a2a0a@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 28 Jul 2020 18:26:29 +0200
Message-ID: <CAA8xKjXagrLU+DVcO3uVw6D0sJHXQ_rOd0nqEHHNcaMwG6oXRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/net_tx_pkt: add function to check
 pkt->max_raw_frags
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mcascell@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mcascell@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, ziming zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 6:06 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/7/28 =E4=B8=8A=E5=8D=881:08, Mauro Matteo Cascella wrote:
> > This patch introduces a new function in hw/net/net_tx_pkt.{c,h} to chec=
k the
> > current data fragment against the maximum number of data fragments.
>
>
> I wonder whether it's better to do the check in
> net_tx_pkt_add_raw_fragment() and fail there.

Given the assertion, I assumed the caller is responsible for the
check, but moving the check in net_tx_pkt_add_raw_fragment() totally
makes sense to me.

> Btw, I find net_tx_pkt_add_raw_fragment() does not unmap dma when
> returning to true, is this a bug?

Isn't it unmapped in net_tx_pkt_reset()?

> Thanks
>
>
> >
> > Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> > Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> > ---
> >   hw/net/net_tx_pkt.c | 5 +++++
> >   hw/net/net_tx_pkt.h | 8 ++++++++
> >   2 files changed, 13 insertions(+)
> >
> > diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> > index 9560e4a49e..d035618f2c 100644
> > --- a/hw/net/net_tx_pkt.c
> > +++ b/hw/net/net_tx_pkt.c
> > @@ -400,6 +400,11 @@ bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *=
pkt, hwaddr pa,
> >       }
> >   }
> >
> > +bool net_tx_pkt_exceed_max_fragments(struct NetTxPkt *pkt)
> > +{
> > +    return pkt->raw_frags >=3D pkt->max_raw_frags;
> > +}
> > +
> >   bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt)
> >   {
> >       return pkt->raw_frags > 0;
> > diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
> > index 4ec8bbe9bd..e2ee46ae03 100644
> > --- a/hw/net/net_tx_pkt.h
> > +++ b/hw/net/net_tx_pkt.h
> > @@ -179,6 +179,14 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pkt=
, NetClientState *nc);
> >    */
> >   bool net_tx_pkt_parse(struct NetTxPkt *pkt);
> >
> > +/**
> > +* indicates if the current data fragment exceeds max_raw_frags
> > +*
> > +* @pkt:            packet
> > +*
> > +*/
> > +bool net_tx_pkt_exceed_max_fragments(struct NetTxPkt *pkt);
> > +
> >   /**
> >   * indicates if there are data fragments held by this packet object.
> >   *
>

--=20
Mauro Matteo Cascella, Red Hat Product Security
6F78 E20B 5935 928C F0A8  1A9D 4E55 23B8 BB34 10B0


