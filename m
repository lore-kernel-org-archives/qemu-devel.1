Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA9FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358A720578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDcF4ZWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358A720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsiUm-0007rH-DZ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsiU7-0007Q9-Dz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:57:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsiU5-0003Pn-RZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594108664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=smu51rxsARqdnFRQ1nsp1ekiPByyl0crm5fbsZmVpxM=;
 b=bDcF4ZWaxbCqCQcibtwp+ROEXa6jxLWkNGWc5uRu5O/bl1JehGd5GhF8UzuZ6pqYyfCQ3v
 MjkxfG2k36ooXV1mDI+DDKs+wgxYkyPZWUnIC3L7YWEUuV+VGg5ArX6V2XxgGr33ASJfCB
 PwvqWWz7b57HQDJwQ/95izCNjRdnMSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-ZdnDMRnbOfuAkFjiVLfWqA-1; Tue, 07 Jul 2020 03:57:43 -0400
X-MC-Unique: ZdnDMRnbOfuAkFjiVLfWqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDF1E461;
 Tue,  7 Jul 2020 07:57:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6979760CC0;
 Tue,  7 Jul 2020 07:57:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8DA2831E60; Tue,  7 Jul 2020 09:57:40 +0200 (CEST)
Date: Tue, 7 Jul 2020 09:57:40 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paul Zimmerman <pauldzim@gmail.com>
Subject: Re: Failure prints during format or mounting a usb storage device
Message-ID: <20200707075740.dkc76ceb7wytdoem@sirius.home.kraxel.org>
References: <BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CADBGO7-hp4Pyfn+rq9d=ZxHmpMwitv-oLjYPJmCKSH6cLHVx=w@mail.gmail.com>
 <CADBGO78-mqwapj+mdpFUO-puL0OZ_1QeBc+4yo4S9g1O4deNjg@mail.gmail.com>
 <2d312ec0-d280-c0e3-2b1e-ff9c70c3168f@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2d312ec0-d280-c0e3-2b1e-ff9c70c3168f@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sai Pavan Boddu <saipava@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vikram Garhwal <fnuv@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,
> 
> Gerd, do you know the purpose of the 'short_not_ok' parameter to
> usb_packet_setup()?

Well, some usb host controllers have a flag in the transfer control
blocks to indicate the host controller should stop processing requests
in case of a short transfer.

The usb core uses the flag to just to that (i.e. halt the endpoint on
short transfers).  It is also checked when usb-host pipelines requests
(requests queued after a short-not-ok packet can't be pipelined because
we don't know yet whenever we should continue processing the endpoint or
not).

xhci has no such flag so the flag is never set.

> The simple patch below fixes the reported problem,
> but I don't know if it could cause some other problems for XHCI.
> hcd-ehci, hcd-ohci, hcd-uhci all set the parameter conditionally,
> but hcd-xhci never sets it. I don't understand the purpose of the
> parameter myself.
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index b330e36fe6..9fb96fdd66 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -1614,7 +1614,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)
>      xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets int_req */
>      xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets int_req */
>      usb_packet_setup(&xfer->packet, dir, ep, xfer->streamid,
> -                     xfer->trbs[0].addr, false, xfer->int_req);
> +                     xfer->trbs[0].addr, dir == USB_TOKEN_IN, xfer->int_req);

I suspect this might lead to queues being halted even though they should
not.

Why does 7ad3d51ebb8a522ffcad391c4bef281245739dde look at short-not-ok?

take care,
  Gerd


