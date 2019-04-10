Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863ACC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598C12083E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598C12083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hECoO-0001Jv-0v
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 08:58:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hECmx-0000cM-3p
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hECmw-0003LM-3X
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:57:15 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:49743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hECmv-0003Jr-Nx; Wed, 10 Apr 2019 08:57:14 -0400
X-IronPort-AV: E=Sophos;i="5.60,332,1549929600"; d="scan'208";a="83215141"
Date: Wed, 10 Apr 2019 13:57:08 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul.durrant@citrix.com>
Message-ID: <20190410125708.GE1435@perard.uk.xensource.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-3-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190408151617.13025-3-paul.durrant@citrix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 162.221.156.55
Subject: Re: [Qemu-devel] [PATCH 2/3] xen-bus: allow AioContext to be
 specified for each event channel
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410125708.F_UnuYyni3qkmrFu4SgQbBKLlvr-fMsIXAsuk9bL1KE@z>

On Mon, Apr 08, 2019 at 04:16:16PM +0100, Paul Durrant wrote:
> This patch adds an AioContext parameter to xen_device_bind_event_channel()
> and then uses aio_set_fd_handler() to set the callback rather than
> qemu_set_fd_handler().
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> @@ -943,6 +944,7 @@ static void xen_device_event(void *opaque)
>  }
>  
>  XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
> +                                               AioContext *ctx,
>                                                 unsigned int port,
>                                                 XenEventHandler handler,
>                                                 void *opaque, Error **errp)
> @@ -968,8 +970,9 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
>      channel->handler = handler;
>      channel->opaque = opaque;
>  
> -    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), xen_device_event, NULL,
> -                        channel);
> +    channel->ctx = ctx;
> +    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), false,
> +                       xen_device_event, NULL, NULL, channel);

I wonder if the `'is_external' parameter of aio_set_fd_handler shoud be
`true' here, instead. That flag seems to be used when making a snapshot
of a blockdev, for example.

That was introduced by:
dca21ef23ba48f6f1428c59f295a857e5dc203c8^..c07bc2c1658fffeee08eb46402b2f66d55b07586

What do you think?


-- 
Anthony PERARD

