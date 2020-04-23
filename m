Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A48BC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E0D20736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEudDT84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0D20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRa60-00018G-1w
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRa4y-0000IT-0t
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRa4x-00066V-JZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:31:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jRa4x-000665-5p
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587641498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCZZPYS+mL2wCoanowTnylkPPsQNo31ZRPCvKhJbugk=;
 b=OEudDT84aILsYVJOLlsg43UkAd+8I1YOhO9ZHD96sJdwTT8KEdXrtfzKQupgiz+Fn/tCgT
 Y0DXQyVLIc+Xp4klJNYHPZPaXFp7kcLwYqfIT0fmSAHM3c0l/emn8X7BlNolqutx30pS6q
 z0kjroqsNMG7giiBORFyd4vPAoYQzV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-NmEj-FVcMO2jy2w0N60KpQ-1; Thu, 23 Apr 2020 07:31:36 -0400
X-MC-Unique: NmEj-FVcMO2jy2w0N60KpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AC0D108BD10;
 Thu, 23 Apr 2020 11:31:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EA185D706;
 Thu, 23 Apr 2020 11:31:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 861E11753B; Thu, 23 Apr 2020 13:31:30 +0200 (CEST)
Date: Thu, 23 Apr 2020 13:31:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Subject: Re: [PATCH v2 1/2] virtio-vga: fix virtio-vga bar ordering
Message-ID: <20200423113130.idemtunts24dq3pz@sirius.home.kraxel.org>
References: <20200422215455.10244-1-anthoine.bourgeois@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200422215455.10244-1-anthoine.bourgeois@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 11:54:54PM +0200, Anthoine Bourgeois wrote:
> With virtio-vga, pci bar are reordered. Bar #2 is used for compatibility
> with stdvga. By default, bar #2 is used by virtio modern io bar.
> This bar is the last one introduce in the virtio pci bar layout and it's
> crushed by the virtio-vga reordering. So virtio-vga and
> modern-pio-notify are incompatible because virtio-vga failed to
> initialize with this option.
>=20
> This fix sets the modern io bar to the bar #5 to avoid conflict.
>=20
> Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

> ---
>  hw/display/virtio-vga.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index 2b4c2aa126..95757a6619 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -114,6 +114,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
>       */
>      vpci_dev->modern_mem_bar_idx =3D 2;
>      vpci_dev->msix_bar_idx =3D 4;
> +    vpci_dev->modern_io_bar_idx =3D 5;
> =20
>      if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
>          /*
> --=20
> 2.20.1
>=20


