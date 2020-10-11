Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D68C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 06:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDA6207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 06:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuSV1U+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDA6207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRV9j-0007LA-Ed
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 02:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kRV8H-0006tG-19
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 02:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kRV8D-0007W0-N4
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 02:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602398816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9DBg94y3dH4K7OJQw3QhobflJnhMnjEF2bmY+pjq5A=;
 b=PuSV1U+QRPjOYk/wwIpwbWsQRNGDGiX1possCZJQGqC3spywQHbB0dtn3PwALbFXQ4gxga
 /HCf/CUvxg3OgCbkLfqjxIOS30/HP60oWAElvpQ24lM2soeT12P7Iquxec5pWBhyDXEjjT
 LvYeA3R4euQb5PDVC5110uqXEBaJwaw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-OePzk-PBMIGC9O7pViDmAg-1; Sun, 11 Oct 2020 02:46:54 -0400
X-MC-Unique: OePzk-PBMIGC9O7pViDmAg-1
Received: by mail-wm1-f69.google.com with SMTP id g71so1065594wmg.2
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 23:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=e9DBg94y3dH4K7OJQw3QhobflJnhMnjEF2bmY+pjq5A=;
 b=oddj3Mx1Lmsp5R51cPB2My47K3zhhtA3bBncfppffVhRoltiSdZClNhQe5oOcWxDJ7
 tfrLNs2wk+LL2xAV5kUzrvqq0scrTnoCRfogHTBlCipF9O7ngF+b9IG52KAiNJmPrnEB
 s/1HAtZs7r2ZFBDwMrs6Y53zuFE8t0FbJsHTn+eJQL6QHFcbdUXvBTYVz8PvXzFijf3T
 mDJ+kj8EMaTDh04lIuRKw81/4AGw+0vtJqp6qbYO2okwHZkqf55AVAs8U8ALggqaO6Z7
 0cAhdjZ4JwRWX+cWZFZssl39XiNJZTwPOY8N7r5AVE4aotuwbOIhwKOKlirs1bXSiFIw
 g5CQ==
X-Gm-Message-State: AOAM53285EP0o3K/4nVBGrnD4+foSlobD+YSYJ/I893qZg4/HLfPks0R
 OmBkTFkDygxlUWXQcvF8GHnBaVDCMNepFLIStVHfLUE5dZqRiqtg8OdEo63X0qenxXPtaGN1dS6
 q4Moh9XGlgirCI8s=
X-Received: by 2002:a1c:a513:: with SMTP id o19mr5421310wme.130.1602398813180; 
 Sat, 10 Oct 2020 23:46:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM5mr9XODNM/0FDfdYSqdgaQBm+SlNnogDVtVm9qnwQtawYEdi+JIuDir297EELqzQhHaTMQ==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr5421290wme.130.1602398812957; 
 Sat, 10 Oct 2020 23:46:52 -0700 (PDT)
Received: from redhat.com (bzq-79-179-76-41.red.bezeqint.net. [79.179.76.41])
 by smtp.gmail.com with ESMTPSA id
 j5sm14175503wrx.88.2020.10.10.23.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 23:46:52 -0700 (PDT)
Date: Sun, 11 Oct 2020 02:46:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/3] vhost: Use vhost_get_used_size() in
 vhost_vring_set_addr()
Message-ID: <20201011024636-mutt-send-email-mst@kernel.org>
References: <160171888144.284610.4628526949393013039.stgit@bahia.lan>
 <160171932300.284610.11846106312938909461.stgit@bahia.lan>
 <5fc896c6-e60d-db0b-f7b0-5b6806d70b8e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5fc896c6-e60d-db0b-f7b0-5b6806d70b8e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 02:10:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 virtualization@lists.linux-foundation.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 10, 2020 at 10:32:13AM +0800, Jason Wang wrote:
> 
> On 2020/10/3 下午6:02, Greg Kurz wrote:
> > The open-coded computation of the used size doesn't take the event
> > into account when the VIRTIO_RING_F_EVENT_IDX feature is present.
> > Fix that by using vhost_get_used_size().
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   drivers/vhost/vhost.c |    3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index c3b49975dc28..9d2c225fb518 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1519,8 +1519,7 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
> >   		/* Also validate log access for used ring if enabled. */
> >   		if ((a.flags & (0x1 << VHOST_VRING_F_LOG)) &&
> >   			!log_access_ok(vq->log_base, a.log_guest_addr,
> > -				sizeof *vq->used +
> > -				vq->num * sizeof *vq->used->ring))
> > +				       vhost_get_used_size(vq, vq->num)))
> >   			return -EINVAL;
> >   	}
> > 
> > 
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Linus already merged this, I can't add your ack, sorry!


