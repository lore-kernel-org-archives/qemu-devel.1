Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B43DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4761324656
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Amnn+wbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4761324656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itxCQ-00073R-Do
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 12:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1itxBV-0006Lg-1J
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1itxBO-0008DH-Rs
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:19:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1itxBO-0008Cz-OF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579627157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvVRsKsB90XNpD0qnTiA6bM1f1G9PVbsMxm8pLGmF7M=;
 b=Amnn+wbij1vBZ/rAWDeSLzz3hhuUAqVctH3GSkrU5/acLLHEUaHGtNijD8B6qsI5Yky0Iy
 jArz/4fSL5hXcGZBpbGZSvkyKicDso52yEzScCBo7Svva0xWej7FCelN2QB8bB8UNqJRD6
 /kqBXUJ+7eXZQflbnZ69hWdf5+3POUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-LYZVbnPvOlSRO3G8u5Pe7w-1; Tue, 21 Jan 2020 12:19:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E25E1005512;
 Tue, 21 Jan 2020 17:19:12 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02BF086420;
 Tue, 21 Jan 2020 17:19:11 +0000 (UTC)
Date: Tue, 21 Jan 2020 10:19:11 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: question about handling MSI-X by VFIO
Message-ID: <20200121101911.64701afd@w520.home>
In-Reply-To: <MN2PR02MB6205CD9F680E4E7AEA7E5E518B0D0@MN2PR02MB6205.namprd02.prod.outlook.com>
References: <MN2PR02MB6205CD9F680E4E7AEA7E5E518B0D0@MN2PR02MB6205.namprd02.prod.outlook.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: LYZVbnPvOlSRO3G8u5Pe7w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 13:36:26 +0000
Thanos Makatos <thanos.makatos@nutanix.com> wrote:

> I'm passing through a virtual PCI device to a QEMU guest via VFIO/mdev and I
> notice that MSI-X interrupts are disabled in the device (MSIXCAP.MXC.MXE is
> zero) and the BARs containing the table and PBA (4 and 5 in my case) are never
> accessed.  However, whenever I fire an MSI-X interrupt from the virtual device
> (although I'm not supposed to do so as they're disabled), the guest seems to
> correctly receive it. I've started looking at hw/vfio/pci.c and it seems that
> VFIO handles MSI-X interrupts there, including masking etc?

Yes, the vector table and PBA are emulated in QEMU, the latter lazily
only when vectors are masked, iirc.  The backing device vector table
should never be directly accessed by the user (it can be, but you can
just discard those accesses), MSI-X is configured via the
VFIO_DEVICE_SET_IRQS ioctl, which configures the eventfd through which
an mdev driver would trigger an MSI.  When you say that you "fire and
MSI-X interrupt from the virtual device" does this mean that you're
signaling via one of these eventfds?  It looks to me like emulating the
MSI-X enable bit in the MSI-X capability is probably the responsibility
of the mdev vendor driver.  With vfio-pci the VFIO_DEVICE_SET_IRQS ioctl
would enable MSI-X on the physical device and the MSI-X capability seen
by the user would reflect that.  Are you missing a bit of code that
updates the mdev config space as part of the SET_IRQS ioctl?  Thanks,

Alex


