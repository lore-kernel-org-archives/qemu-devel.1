Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A82C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EA020788
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1QvNVeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EA020788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlQQ-0004AB-BH
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGlPq-0003hG-3N
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGlPo-0006FK-Ce
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:24:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGlPo-0006F3-9A
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585063467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fkcblZIC05igbUQv9i74wJ7rkrjJKZKbYfn7ue9eBo=;
 b=d1QvNVehUKMbgzEY1w63Fzp3vSewLb2d9X+uywxSt4SLZxr4Nz8rnVzVV/qvIlh+hiX3XG
 5kqG1VmqS/TM1+Qjrp2rDQ8YjE2/Rn8jhVaBn87lLVoDbODrspeg2kfkRh+T/JoYlgDrGB
 20QGuSlgVKZhmM+1pnZPdFPkocXNKco=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-WLZUs79GODeeCKkJyqcXcw-1; Tue, 24 Mar 2020 11:24:23 -0400
X-MC-Unique: WLZUs79GODeeCKkJyqcXcw-1
Received: by mail-wm1-f72.google.com with SMTP id 2so88383wmf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 08:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IdhP0Azyb9N8XwjCYSgl0InCICLcNKUv9pzwyL2JkMM=;
 b=VElzcNXEE1HV0/IGDCD5/fhcwm8yY/5HOKLcvWeWVwyF+2NJX2jvhJukExbsnz5j+m
 ZMYfzVMW//J92378j6xRIxdxGcChpzCVPU4KCbzdLIOlfhi2ydzlvXX7vU0vJ7cM/UDJ
 KxY+fz3jdD9xQwiFwMBo/ayYTwG+FQb90UqV/uxet46hrbO/LHJ6ocJ6qdGHEGJTGjyW
 y1p34kpexdv0uYLytLdHI62zcCcxYWVJbQcP+qqmmydiQcR1RIMMOmi48GY+qmJl4gEe
 JWn+ZJVd2uxeQuCOSN1UorHhvtYdNEcKu8sSBJ3N6dAn381cFGux6BUIndLSbfScZf6j
 BKLw==
X-Gm-Message-State: ANhLgQ2ItAPiVFRYw1ygVhycWK5/m+ISPpa88+ypRBRT9uOTaj0lPSMA
 FugPGpKu9ve/VJ0Y6dMgczp3EuJwvsu8XCJGrIfQR+i5fGhJIZ81HITmSMi9cDnj7ZbioLancvS
 UXMRTy1RoDoXHeJE=
X-Received: by 2002:a05:6000:105:: with SMTP id
 o5mr13814787wrx.395.1585063462196; 
 Tue, 24 Mar 2020 08:24:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtrl7VlsbssZAM5lvFzxwgBBMjHUhBO9PROYm8tMsljhkM0pNjMbfq7RE0Th1jENibR1JW2HA==
X-Received: by 2002:a05:6000:105:: with SMTP id
 o5mr13814746wrx.395.1585063461926; 
 Tue, 24 Mar 2020 08:24:21 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id s7sm28279753wri.61.2020.03.24.08.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 08:24:21 -0700 (PDT)
Date: Tue, 24 Mar 2020 11:24:16 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 07/22] intel_iommu: add set/unset_iommu_context callback
Message-ID: <20200324152416.GV127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-8-git-send-email-yi.l.liu@intel.com>
 <20200323212911.GQ127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A20041A@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A20041A@SHSMSX104.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 11:15:24AM +0000, Liu, Yi L wrote:

[...]

> > >  struct VTDIOTLBEntry {
> > > @@ -271,6 +282,8 @@ struct IntelIOMMUState {
> > >      /*
> > >       * Protects IOMMU states in general.  Currently it protects the
> > >       * per-IOMMU IOTLB cache, and context entry cache in VTDAddressS=
pace.
> > > +     * Protect the update/usage of HostIOMMUContext pointer cached i=
n
> > > +     * VTDBus->dev_icx array as array elements may be updated by hot=
plug
> >=20
> > I think the context update does not need to be updated, because they
> > should always be with the BQL, right?
>=20
> Hmmmm, maybe I used bad description. My purpose is to protect the stored
> HostIOMMUContext pointer in vIOMMU. With pci_device_set/unset_iommu_conte=
xt,
> vIOMMU have a copy of HostIOMMUContext. If VFIO container is released
> (e.g. hotpulg out device), HostIOMMUContext will alos be released. This
> will trigger the pci_device_unset_iommu_context() to clean the copy. To
> avoid using a staled HostIOMMUContext in vIOMMU, vIOMMU should have a
> lock to block the pci_device_unset_iommu_context() calling until other
> threads finished their HostIOMMUContext usage. Do you want a description
> update here or other preference?

Yeah, but hot plug/unplug will still take the BQL?

Ah btw I think it's also OK to take the lock if you want or not sure
about whether we'll always take the BQL in these paths.  But if so,
instead of adding another "Protect the ..." sentence to the comment,
would you mind list out what the lock is protecting?

  /*
   * iommu_lock protects:
   * - per-IOMMU IOTLB caches
   * - context entry caches
   * - ...
   */

Or anything better than that.  Thanks,

--=20
Peter Xu


