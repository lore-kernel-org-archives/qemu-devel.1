Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1E4C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE46E2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7+MtM7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE46E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Yt5-0002Ui-Va
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1YsL-00023E-J7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1YsI-0004SK-CF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:59:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32071
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1YsH-0004QD-0m
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581440338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmEyefjPU4Rcw+cm701FUSOvWRfrtLQXR8l/ENdeeVA=;
 b=e7+MtM7XE54F2RbmlqaDmAhRqAtvEivVX0IL2dC4L8NekevTG+5yWimPzQzOO/PilsT1/g
 v4U3bNU5asQ4nw3wdjnbDkFdC1mhWjm3c8RP5ssOscX1fMnv/AkduiEilEWb62RXpz0UB/
 AKXjvVl1ng1jZzd8niz123p181wtXsA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-GdXapIR7M-eXaY05izdbWA-1; Tue, 11 Feb 2020 11:58:47 -0500
Received: by mail-qk1-f198.google.com with SMTP id c77so525467qke.7
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 08:58:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y3V+nkHLeOz4JQ099NB1biGKPHWEnceBkoow8w0YGk8=;
 b=Hf0rxfzIe+2GC7Qdz+2BrtCN48tC2NbxPGMzDfaB5f5bjvjAPpbw7jDOCkNmB/rIny
 y3+STHPFKzywFfFLJHU08SdllMBmmhmROD+lvAdzsTx/0QyHt7hKva4EfX/sitqa+cew
 bYxL6diTk6z8MxH9gf7CbBC0s3wyZS8Ik5/pw17+dsDyuRDyJD+656dKvyow59DzpjHT
 7TkzGn5swE4i8ZCZgT3MsCrksjxHamPTEy3U1LqjkZvdJ4IDnkXA2kGHA+3opFfq9Mcs
 0V18LMo87efUCvewmUalTAljIaD+nrt+O7UNLss8Fsk468R+OlFqRJhLDc73oBVCU8RM
 QIAA==
X-Gm-Message-State: APjAAAVpslyhw88iPtfMDFdwvXc/Rnq9ZvGPr4yaA/ja5uqrghnWP0KN
 i27rxyKCe7ARwHdZ+c19cukmfqE9GXSvBTIaoErn1z+WRFL9SaSInt5tgyTsmtDMtzviQs+iJd6
 yvw0bML296lPi29E=
X-Received: by 2002:ad4:58b3:: with SMTP id ea19mr3818876qvb.80.1581440326792; 
 Tue, 11 Feb 2020 08:58:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6WqLBlAKM/iCoc2pbfi9NA2KQCOkbT7LG18iuT/xB4amgNLBWMcmfTAyoYSiUyajtafWBUg==
X-Received: by 2002:ad4:58b3:: with SMTP id ea19mr3818859qvb.80.1581440326526; 
 Tue, 11 Feb 2020 08:58:46 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id k50sm2554891qtc.90.2020.02.11.08.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 08:58:45 -0800 (PST)
Date: Tue, 11 Feb 2020 11:58:43 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Message-ID: <20200211165843.GG984290@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-4-git-send-email-yi.l.liu@intel.com>
 <20200131040644.GG15210@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A199306@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A199306@SHSMSX104.ccr.corp.intel.com>
X-MC-Unique: GdXapIR7M-eXaY05izdbWA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 11:42:13AM +0000, Liu, Yi L wrote:
> > I'm not very clear on the relationship betwen an IOMMUContext and a
> > DualStageIOMMUObject.  Can there be many IOMMUContexts to a
> > DualStageIOMMUOBject?  The other way around?  Or is it just
> > zero-or-one DualStageIOMMUObjects to an IOMMUContext?
>=20
> It is possible. As the below patch shows, DualStageIOMMUObject is per vfi=
o
> container. IOMMUContext can be either per-device or shared across devices=
,
> it depends on vendor specific vIOMMU emulators.

Is there an example when an IOMMUContext can be not per-device?

It makes sense to me to have an object that is per-container (in your
case, the DualStageIOMMUObject, IIUC), then we can connect that object
to a device.  However I'm a bit confused on why we've got two abstract
layers (the other one is IOMMUContext)?  That was previously for the
whole SVA new APIs, now it's all moved over to the other new object,
then IOMMUContext only register/unregister... Can we put the reg/unreg
procedures into DualStageIOMMUObject as well?  Then we drop the
IOMMUContext (or say, keep IOMMUContext and drop DualStageIOMMUObject
but let IOMMUContext to be per-vfio-container, the major difference is
the naming here, say, PASID allocation does not seem to be related to
dual-stage at all).

Besides that, not sure I read it right... but even with your current
series, the container->iommu_ctx will always only be bound to the
first device created within that container, since you've got:

    group =3D vfio_get_group(groupid, pci_device_iommu_address_space(pdev),
                           pci_device_iommu_context(pdev), errp);

And:

    if (vfio_connect_container(group, as, iommu_ctx, errp)) {
        error_prepend(errp, "failed to setup container for group %d: ",
                      groupid);
        goto close_fd_exit;
    }

The iommu_ctx will be set to container->iommu_ctx if there's no
existing container.

> [RFC v3 10/25] vfio: register DualStageIOMMUObject to vIOMMU
> https://www.spinics.net/lists/kvm/msg205198.html
>=20
> Take Intel vIOMMU as an example, there is a per device structure which
> includes IOMMUContext instance and a DualStageIOMMUObject pointer.
>=20
> +struct VTDIOMMUContext {
> +    VTDBus *vtd_bus;
> +    uint8_t devfn;
> +    IOMMUContext iommu_context;
> +    DualStageIOMMUObject *dsi_obj;
> +    IntelIOMMUState *iommu_state;
> +};
> https://www.spinics.net/lists/kvm/msg205196.html
>=20
> I think this would leave space for vendor specific vIOMMU emulators to
> design their own relationship between an IOMMUContext and a
> DualStageIOMMUObject.

--=20
Peter Xu


