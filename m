Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200FCC2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE82D22314
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPKUa9Ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE82D22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izxbG-000852-0h
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 01:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izxaQ-0007YJ-UA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izxaP-0002If-Od
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:57:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izxaP-0002GW-K3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581058677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWj/vNhqAr0t9JgmgoLmiFfCYKHuaZFrdeT1hwvr0n0=;
 b=ZPKUa9GaMejFxc7/sY/wVhW5l7UY1L6I2Dbu2OJgHNMGU6DPzX3lXj3LrWR2s+P8nx1Ghk
 WMCyHmxSqsKaMXBebONpm312NVzoO6dtHM1aGxps49rFi6XzK/ANn4TF5H1OyRqfwlmFtQ
 gFWlBBXuM7EFL8PoT1tvr/iJIzSZ2Zc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-yxQZ5NovOCiT8qMl8kct2Q-1; Fri, 07 Feb 2020 01:57:55 -0500
Received: by mail-qt1-f199.google.com with SMTP id n4so1070023qtv.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 22:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TUNuR2r+y685tFsDThOQZUJUYr4Eav5KWfsns+sA2F8=;
 b=pPzdpFP5JjzEZbOWbKeACImo2qhDhUU0lfDZDsCuutZDge1f4WiL0wC6GFYe6xtFSg
 NmraQ7OnVetIrh04tN5ybVg9JVZIlGEsi/QrSHPZo75BpKzEbP3g+XdvniPzqeTzMJ16
 GbnY21d+PRAcyZTabwAr/JaUzkIrR18uCc+eHmjituHaDfzDlvS2i+j9I88/ovReTAQF
 T7TPWewRshgyCPiCZ3gG4VNM5FfY128pcZFq5KeiCWF4PSIzYMe2LctFIfIEk6zgdQd2
 Fu10psDbTZzjx2EhNpjoOxKdkmzv0vX9iwadrxMbri1IrYLXwpwpBeQoy3xAvHwttbmI
 GhqQ==
X-Gm-Message-State: APjAAAWrpKtiC36i8sZyd3Z16jsjNEPE/HOeoWm7WOYNAtBiznSMcFrL
 alHF3gBsxRhaC4b2S05Vq95GPxwhfB2Waq3dgWVAC8W4D3QO6q/tDXZulGLfr4OlDnUC4ArfaNr
 LJGSF0qblh3a/uxo=
X-Received: by 2002:a37:de0b:: with SMTP id h11mr5818940qkj.274.1581058674737; 
 Thu, 06 Feb 2020 22:57:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtSupe5HOeYGhFJhPCE3KAyae4ByKD7b4Wo2UrZksz8hMIfG/dD2rBd+BWjt8XeygQ0oLDNA==
X-Received: by 2002:a37:de0b:: with SMTP id h11mr5818925qkj.274.1581058674505; 
 Thu, 06 Feb 2020 22:57:54 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id f17sm947526qtq.19.2020.02.06.22.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 22:57:53 -0800 (PST)
Date: Fri, 7 Feb 2020 01:57:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] spapr: Enable virtio iommu_platform=on by default
Message-ID: <20200207015435-mutt-send-email-mst@kernel.org>
References: <20200207043055.218856-1-david@gibson.dropbear.id.au>
 <20200207043055.218856-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
In-Reply-To: <20200207043055.218856-3-david@gibson.dropbear.id.au>
X-MC-Unique: yxQZ5NovOCiT8qMl8kct2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pair@us.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, mdroth@us.ibm.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 03:30:55PM +1100, David Gibson wrote:
> Traditionally, virtio devices don't do DMA by the usual path on the
> guest platform.  In particular they usually bypass any virtual IOMMU
> the guest has, using hypervisor magic to access untranslated guest
> physical addresses.
>=20
> There's now the optional iommu_platform flag which can tell virtio
> devices to use the platform's normal DMA path, including any IOMMUs.
> That flag was motiviated for the case of hardware virtio
> implementations, but there are other reasons to want it.
>=20
> Specifically, the fact that the virtio device doesn't use vIOMMU
> translation means that virtio devices are unsafe to pass to nested
> guests, or to use with VFIO userspace drivers inside the guest.  This
> is particularly noticeable on the pseries platform which *always* has
> a guest-visible vIOMMU.
>=20
> Not using the normal DMA path also causes difficulties for the guest
> side driver when using the upcoming POWER Secure VMs (a.k.a. PEF).
> While it's theoretically possible to handle this on the guest side,
> it's really fiddly.  Given the other problems with the non-translated
> virtio device, let's just enable vIOMMU translation for virtio devices
> by default in the pseries-5.0 (and later) machine types.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Worth noting that since iommu_platform is mandatory for guests,
this disables support for guests older than Linux 4.8.


> ---
>  hw/ppc/spapr.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 216d3b34dc..78e031e80a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4518,6 +4518,7 @@ static void spapr_machine_5_0_class_options(Machine=
Class *mc)
>       * default behaviour for virtio */
>      static GlobalProperty compat[] =3D {
>          { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> +        { TYPE_VIRTIO_DEVICE, "iommu_platform", "on", },
>      };
> =20
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> @@ -4533,6 +4534,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>      static GlobalProperty compat[] =3D {
>          { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
> +        { TYPE_VIRTIO_DEVICE, "iommu_platform", "off", },
>      };
> =20
>      spapr_machine_5_0_class_options(mc);
> --=20
> 2.24.1


