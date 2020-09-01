Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BEFC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 05:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4A4208DB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 05:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3aQJGcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4A4208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCyqB-0002Z9-Q7
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 01:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCypF-0001kE-GC
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 01:27:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCypC-0003ax-S3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 01:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598938036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dme2cAToYn5CvMyOmX4zNUvc7d/FcTeFHBABtzaR5oY=;
 b=E3aQJGcGbcNkd3TDMvRwo5pvNyVQTDFYtT+P6TqU6ri3/uZK1LQkWT/UhJ3o7L9NjX7WI1
 irxBI3XZJ0b3jkcYCQLGo48cURuLaSQ1eTAPmMzGZ8in5NN87TXeV9NvdjwHbfi8ZKjrYk
 80/k/xz33hG0T1mbnQ70suT5kBDfA+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-DEiUtm2GMNSIIE3BDqeuYA-1; Tue, 01 Sep 2020 01:27:11 -0400
X-MC-Unique: DEiUtm2GMNSIIE3BDqeuYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EF66802B7E;
 Tue,  1 Sep 2020 05:27:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCFE82619E;
 Tue,  1 Sep 2020 05:27:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E8F7F991; Tue,  1 Sep 2020 07:27:08 +0200 (CEST)
Date: Tue, 1 Sep 2020 07:27:08 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] xhci: check return value from usb_packet_map
Message-ID: <20200901052708.y3iufnvuav2hurhb@sirius.home.kraxel.org>
References: <20200827115933.1851563-1-ppandit@redhat.com>
 <20200830152737.l3f42t2fvvrmdiwo@mozz.bu.edu>
 <nycvar.YSQ.7.78.906.2009011011400.306228@xnncv>
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2009011011400.306228@xnncv>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>, Alexander Bulekov <alxndr@bu.edu>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 10:19:26AM +0530, P J P wrote:
> +-- On Sun, 30 Aug 2020, Alexander Bulekov wrote --+
> | I think there is already a fix queued for this one:
> | https://www.mail-archive.com/qemu-devel@nongnu.org/msg734424.html
> 
>   Yes, it looks similar.
> 
> | > @@ -1615,7 +1615,14 @@ static int xhci_setup_packet(XHCITransfer *xfer)
> | >      xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets int_req */
> | >      usb_packet_setup(&xfer->packet, dir, ep, xfer->streamid,
> | >                       xfer->trbs[0].addr, false, xfer->int_req);
> | > -    usb_packet_map(&xfer->packet, &xfer->sgl);
> | > +    if (usb_packet_map(&xfer->packet, &xfer->sgl) < 0) {
> | > +        DPRINTF("xhci: setup packet failed: pid: 0x%x addr %d ep %d\n",
> | > +                xfer->packet.pid, ep->dev->addr, ep->nr);
> | > +        usb_packet_cleanup(&xfer->packet);
> | > +        qemu_sglist_destroy(&xfer->sgl);
> | > +        return -1;
> 
> We don't need 'usb_packet_cleanup' call? (to confirm)

Oh, didn't notice the difference.  I think we need it, otherwise we leak
iov entries in case the packet has multiple segments and only the second
(or any later) fails to map.

take care,
  Gerd


