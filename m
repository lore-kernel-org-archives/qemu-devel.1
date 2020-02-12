Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05A2C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3512073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7lLUhNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3512073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1qYj-0002ll-SR
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 06:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1qXk-0001ut-77
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1qXj-0002Pp-6w
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:51:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1qXj-0002PV-37
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581508258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wbp6OYHT+ZYdi4EsCHYy54SXQdNb+4rYVUbEAVx189Q=;
 b=O7lLUhNUFAyoNoyYDe06V6zVNhqpj1eWnN2+qrTWGzHXnoLjniDFel7x3e5JMOZNj531y7
 kmatfa0XPTf6rlLJFbrzQR8zvskoaS7UeVG4x5NKvUveyFLnxFOOJ+VKaBHGxLWRbEL2OJ
 Kk8PwDm4WcxY6gpHvCqnK2C1JacDW0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-FsIYVDKLPMKL5g8tx3QhxQ-1; Wed, 12 Feb 2020 06:50:54 -0500
X-MC-Unique: FsIYVDKLPMKL5g8tx3QhxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CA3418FE868;
 Wed, 12 Feb 2020 11:50:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C16A5C102;
 Wed, 12 Feb 2020 11:50:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 864519D6B; Wed, 12 Feb 2020 12:50:51 +0100 (CET)
Date: Wed, 12 Feb 2020 12:50:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [RFC PATCH v3 2/2] virtio-gpu: add the ability to export resources
Message-ID: <20200212115051.woveg4nxgd4f7o73@sirius.home.kraxel.org>
References: <20200207074033.172289-1-stevensd@chromium.org>
 <20200207074033.172289-3-stevensd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207074033.172289-3-stevensd@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 virtio-comment@lists.oasis-open.org,
 =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 04:40:33PM +0900, David Stevens wrote:
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  virtio-gpu.tex | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/virtio-gpu.tex b/virtio-gpu.tex
> index af4ca61..e950ad3 100644
> --- a/virtio-gpu.tex
> +++ b/virtio-gpu.tex
> @@ -186,12 +186,16 @@ \subsubsection{Device Operation: Request header}\label{sec:Device Types / GPU De
>          VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
>          VIRTIO_GPU_CMD_MOVE_CURSOR,
>  
> +        /* misc commands */
> +        VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID = 0x0400,

I'd suggest to move that to the "2d commands" section (which isn't
really "2d" but more "not 3d").

We also need a feature flag signaling support for the new command.

Otherwise this looks ok to me.

Are there any patches and/or attempts to merge/discuss upstream?
Specifically for handling the uuids for dma-bufs in linux (guest side)?
I suspect there will be some discussions on this and having at least
some plan upstream can agree on would be good.

cheers,
  Gerd


