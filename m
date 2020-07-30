Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A797BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729402082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRwhST5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729402082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1C0i-0007Mj-QA
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 13:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k1Bzz-0006up-Lu
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:05:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k1Bzx-0000CJ-0t
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596128739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHhlU00ch/46XLnJVndF3PH4fX809S6xohN8VPGEK/o=;
 b=jRwhST5UbMBVUFfpSDM0ylAvilHiF+blBhoGzeTrC9JymAqANB91hHYlixylfqMaTdOaID
 xuA8QYkGJUx8RC6ZQWSplvvFbJzgz+2Ifi/M/n89PCNmaNZ3/CdnjrmCRP+JrZY5mvyftl
 Vab1ZsEuJf7S6Y5yJCk9ZWKDVnys1ug=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-qG2EM-yWOLa124I2ALdrtA-1; Thu, 30 Jul 2020 13:05:37 -0400
X-MC-Unique: qG2EM-yWOLa124I2ALdrtA-1
Received: by mail-ej1-f72.google.com with SMTP id l7so4457543ejr.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 10:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dHhlU00ch/46XLnJVndF3PH4fX809S6xohN8VPGEK/o=;
 b=VVYnAjNDFpej3w3uYyO+3S8BcbDk5FR7Q7oPLg3zqNCnmkwFJGhzrMFUivIS9hwl1w
 WBhVS80Xkiulgcp6/anuNNH9f1k16gfkqrxxusw9p2rJ+o1Gn4f5VIvR27thw8XiCTB+
 SubnO2pIiNemHQaa7U+iRL0OWYY5q/WsUjTjmIqiMnHcrGKDEwjoMDgvrPxHIpAe5crr
 f0Iu5TWg2B+8jxIpG85IjwaLtnWxbRnERTfWukuXevLLB/VWb8sJzjys30RhsS8qMm9y
 tNcdUgK2LQXTIq/xxr4s5Cix12fRw+UvASTIPIIOUu5w/YmUC0HGK1e1vtf7qM8CkZyz
 glKQ==
X-Gm-Message-State: AOAM5315HnysSwa6D/W+s5J8bOYHeJC3X6BSk3gMJG2WBnF9Shm0vriP
 ICLEUIRZ1slzC0YPVrL94JcY0jCTYUq5IZKdQVxEaQ1EbyRUQOdjYbNADwpTDW5SScZ5TFPvnwL
 WszScn4v08AVLVcpkEhtEyQ4XDPReLuE=
X-Received: by 2002:a17:906:b6d0:: with SMTP id
 ec16mr97227ejb.94.1596128734274; 
 Thu, 30 Jul 2020 10:05:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbbbIB3RoVRNqK+rkJww6CMG/+hh/2l4DRlzmEEbCwlQLbUfegN4Nd0DVHBJC5gjArEnpq2L7t9kDq2/Lta4g=
X-Received: by 2002:a17:906:b6d0:: with SMTP id
 ec16mr97200ejb.94.1596128734033; 
 Thu, 30 Jul 2020 10:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200727170838.1101775-1-mcascell@redhat.com>
 <20200727170838.1101775-2-mcascell@redhat.com>
 <adb52967-d2b2-cb55-87a2-38fda18a2a0a@redhat.com>
 <CAA8xKjXagrLU+DVcO3uVw6D0sJHXQ_rOd0nqEHHNcaMwG6oXRA@mail.gmail.com>
 <3672bcc5-329f-0cc6-a505-e5b21a316a20@redhat.com>
In-Reply-To: <3672bcc5-329f-0cc6-a505-e5b21a316a20@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Thu, 30 Jul 2020 19:05:23 +0200
Message-ID: <CAA8xKjWoyTPEbW=xdKqtTHHn2krKssif9t6nEeWGDQLt7KmCvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/net_tx_pkt: add function to check
 pkt->max_raw_frags
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mcascell@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
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

On Thu, Jul 30, 2020 at 7:28 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/7/29 =E4=B8=8A=E5=8D=8812:26, Mauro Matteo Cascella wrote:
> > On Tue, Jul 28, 2020 at 6:06 AM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On 2020/7/28 =E4=B8=8A=E5=8D=881:08, Mauro Matteo Cascella wrote:
> >>> This patch introduces a new function in hw/net/net_tx_pkt.{c,h} to ch=
eck the
> >>> current data fragment against the maximum number of data fragments.
> >>
> >> I wonder whether it's better to do the check in
> >> net_tx_pkt_add_raw_fragment() and fail there.
> > Given the assertion, I assumed the caller is responsible for the
> > check, but moving the check in net_tx_pkt_add_raw_fragment() totally
> > makes sense to me.
>
>
> Want to send a new version for this?

Sure, I'll send a new version. Thank you.

>
> >
> >> Btw, I find net_tx_pkt_add_raw_fragment() does not unmap dma when
> >> returning to true, is this a bug?
> > Isn't it unmapped in net_tx_pkt_reset()?
>
>
> Probably but see how it was used in e1000e, the net_tx_pkt_reset() is
> only called when eop is set. Is this a bug?

Yeah it all depends on E1000_TXD_CMD_EOP. Besides, if not set,
e1000e_tx_pkt_send() would never be called. Honestly, I don't know if
this is a reasonable scenario or not.

> Thanks
>
> >
> >> Thanks
> >>
> >>
> >>> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> >>> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> >>> ---
> >>>    hw/net/net_tx_pkt.c | 5 +++++
> >>>    hw/net/net_tx_pkt.h | 8 ++++++++
> >>>    2 files changed, 13 insertions(+)
> >>>
> >>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> >>> index 9560e4a49e..d035618f2c 100644
> >>> --- a/hw/net/net_tx_pkt.c
> >>> +++ b/hw/net/net_tx_pkt.c
> >>> @@ -400,6 +400,11 @@ bool net_tx_pkt_add_raw_fragment(struct NetTxPkt=
 *pkt, hwaddr pa,
> >>>        }
> >>>    }
> >>>
> >>> +bool net_tx_pkt_exceed_max_fragments(struct NetTxPkt *pkt)
> >>> +{
> >>> +    return pkt->raw_frags >=3D pkt->max_raw_frags;
> >>> +}
> >>> +
> >>>    bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt)
> >>>    {
> >>>        return pkt->raw_frags > 0;
> >>> diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
> >>> index 4ec8bbe9bd..e2ee46ae03 100644
> >>> --- a/hw/net/net_tx_pkt.h
> >>> +++ b/hw/net/net_tx_pkt.h
> >>> @@ -179,6 +179,14 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *p=
kt, NetClientState *nc);
> >>>     */
> >>>    bool net_tx_pkt_parse(struct NetTxPkt *pkt);
> >>>
> >>> +/**
> >>> +* indicates if the current data fragment exceeds max_raw_frags
> >>> +*
> >>> +* @pkt:            packet
> >>> +*
> >>> +*/
> >>> +bool net_tx_pkt_exceed_max_fragments(struct NetTxPkt *pkt);
> >>> +
> >>>    /**
> >>>    * indicates if there are data fragments held by this packet object=
.
> >>>    *
>

--
Mauro Matteo Cascella, Red Hat Product Security
6F78 E20B 5935 928C F0A8  1A9D 4E55 23B8 BB34 10B0


