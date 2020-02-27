Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6B1C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2BE2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+UAdgW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2BE2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MFK-0005xq-Fo
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j7MEf-0005Yd-Lt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j7MEe-00089L-OQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:42:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56051
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j7MEe-00089F-KS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582821724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GmoEBiYgx1Vq5pcjXk3mPh15wjuWxLf8vdZQRv2//w=;
 b=J+UAdgW0QyXBcvlnf86aF5gWpqWbuj1oeCynPEDt4ctwQ+c6Vxi3KHnUA3CIgBZnY4VaUj
 YmJ7JNJ+ACss2dEGelvioljg9V8XG0w7xU5oEnGuSS2abSLtYdsEtpH0HOabq78mJxT6v7
 xPF97SkZnGXmnd2K7wNjf95Jokw1bb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-0GBmoGU-Os2poHGCVxyXCg-1; Thu, 27 Feb 2020 11:42:02 -0500
X-MC-Unique: 0GBmoGU-Os2poHGCVxyXCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0627C1005516
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 16:42:01 +0000 (UTC)
Received: from gondolin (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2580C19C58;
 Thu, 27 Feb 2020 16:41:51 +0000 (UTC)
Date: Thu, 27 Feb 2020 17:41:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/5] vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi()
 for irqfds
Message-ID: <20200227174148.34707be7.cohuck@redhat.com>
In-Reply-To: <20200226225048.216508-3-peterx@redhat.com>
References: <20200226225048.216508-1-peterx@redhat.com>
 <20200226225048.216508-3-peterx@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 17:50:45 -0500
Peter Xu <peterx@redhat.com> wrote:

> VFIO is currently the only one left that is not using the generic
> function (kvm_irqchip_add_irqfd_notifier_gsi()) to register irqfds.
> Let VFIO use the common framework too.
> 
> Follow up patches will introduce extra features for kvm irqfd, so that
> VFIO can easily leverage that after the switch.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/pci.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


