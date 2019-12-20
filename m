Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02426C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C264620716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5gM0qUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C264620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLVK-0005Rg-SG
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iiLUd-0004wy-Dk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iiLUb-0004cg-0s
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iiLUa-0004as-Ra
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576860667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgDeFh4F3QrW0JWVNUfCDpbGQwy2NPJTa62L0c+x87Q=;
 b=S5gM0qUQ6jqgcNGbFTmAYmFxilWFd/gocFEFfY+EKX85IQ657GgiRp9cQ5D4gd1gei18am
 yNdsB8HyV+KwCWAlhux23K30C6NYpsbdkAe20VgVyOrifIGFqUyQagXGRfcaw/v43L6l5x
 MlgTxF1MPqnPXEH7OD5I05v3eCRPkSs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-fRw-7fAcNxi89i1l1DQMVg-1; Fri, 20 Dec 2019 11:51:04 -0500
Received: by mail-qk1-f200.google.com with SMTP id d1so6277965qkk.15
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 08:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dqOt5cZrKPUthXykYWOf9AFQe5eQNRQAfjnOmuE7SuI=;
 b=TZs4rFbBqSEHcvE2q95ByeCOC2zIlsfcogwxBvmjwYSMlx8h5Ia1E7OU5wsacFF0Vk
 Uz4f7SVN+mAzXWRzLgQKgfe7ei932lDozf7DHBkt61LhESMFVwMB/fzRqK7sP9dFRcSS
 +0Kl8bLUeLJRbghCWfuhLWJGRen2A/TND9/NjkMB5TQ6aqPM3CnaoiOpT/WplQNCfK/7
 h4Y3XZkqw1UvPK9lldhUI6uIaxAcqNt1NSU1I/v2NFk2lP4yB0GnhTe/VSmGzX0kQAgP
 86HQdH1u2a3Yj0JbcAy9RnaPwyf/ZFV9QjHgOS9FIma1dVsedkbCXZKBmVu9PAojsqc7
 DOMQ==
X-Gm-Message-State: APjAAAXWuwsXoYRYmuj3CXAG0ICE1cAABBfiviMj5ER+aTIGDcmDv2ui
 0TXU7JNwAXg9KgTIxTjRFG/r3x+BXkaNw+QkuaCbH2Em7YxxwybV5A8WQzEfMJ7hIpCIcgWX2zG
 E0z88BZG71a7wtU4=
X-Received: by 2002:ac8:64a:: with SMTP id e10mr12270089qth.292.1576860663551; 
 Fri, 20 Dec 2019 08:51:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLZHgYuZYFF7vIQT83vdhv5/yqOfH04evSC0QflDwKBTzxOmKBg0YYa7iSmUMAIAOWmeNzRQ==
X-Received: by 2002:ac8:64a:: with SMTP id e10mr12270058qth.292.1576860663224; 
 Fri, 20 Dec 2019 08:51:03 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id 2sm3002867qkv.98.2019.12.20.08.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 08:51:02 -0800 (PST)
Date: Fri, 20 Dec 2019 11:51:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20191220165100.GA3780@xz-x1>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-9-eric.auger@redhat.com>
 <20191210193342.GJ3352@xz-x1>
 <44c0041d-68ad-796f-16cc-4bab7ba0f164@redhat.com>
 <20191219133308.GA4246@xz-x1>
 <9d58b293-ada0-353e-bba2-ad1f538dfc62@redhat.com>
 <20191219144936.GB50561@xz-x1>
 <9ec9d0d5-062b-f96b-c72c-4d15865ff9a1@redhat.com>
 <20191220162642.GA2626852@myrica>
MIME-Version: 1.0
In-Reply-To: <20191220162642.GA2626852@myrica>
X-MC-Unique: fRw-7fAcNxi89i1l1DQMVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 Auger Eric <eric.auger@redhat.com>, bharatb.linux@gmail.com,
 qemu-arm@nongnu.org, dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 05:26:42PM +0100, Jean-Philippe Brucker wrote:
> There is at the virtio transport level: the driver sets status to
> FEATURES_OK once it accepted the feature bits, and to DRIVER_OK once its
> fully operational. The virtio-iommu spec says:
>=20
>   If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
>   device SHOULD NOT let endpoints access the guest-physical address space=
.
>=20
> So before features negotiation, there is no access. Afterwards it depends
> if the VIRTIO_IOMMU_F_BYPASS has been accepted by the driver.

Before enabling virtio-iommu device, should we still let the devices
to access the whole system address space?  I believe that's at least
what Intel IOMMUs are doing.  From code-wise, its:

    if (likely(s->dmar_enabled)) {
        success =3D vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->dev=
fn,
                                         addr, flag & IOMMU_WO, &iotlb);
    } else {
        /* DMAR disabled, passthrough, use 4k-page*/
        iotlb.iova =3D addr & VTD_PAGE_MASK_4K;
        iotlb.translated_addr =3D addr & VTD_PAGE_MASK_4K;
        iotlb.addr_mask =3D ~VTD_PAGE_MASK_4K;
        iotlb.perm =3D IOMMU_RW;
        success =3D true;
    }

From hardware-wise, an IOMMU should be close to transparent if you
never enable it, imho.

Otherwise I'm confused on how a guest (with virtio-iommu) could boot
with a normal BIOS that does not contain a virtio-iommu driver.  For
example, what if the BIOS needs to read some block sectors (as you
mentioned)?

> > >   - This flag is a must for all virtio-iommu emulation, right?
> > >     (otherwise I can't see how system bootstraps..)
>=20
> What do you mean by system bootstrap?

Sorry, I meant when the system boots before the OS.

>=20
> One thing I've been wondering, and may be related, is how to handle a
> bootloader that wants to read for example an initrd from a virtio-block
> device that's behind the IOMMU.

My understanding is that virtio devices are special in that they can
use the VIRTIO_F_IOMMU_PLATFORM flag to bypass any vIOMMU (though, I
don't think that'll work when virtio hardwares comes to the
world.. because they can't really bypass the IOMMU hardware).

> Either we allow the device to let any DMA
> bypass the device until FEATURES_OK, which is a source of vulnerabilities
> [1], or we have to implement some support for the virtio-iommu in the
> BIOS. Again the F_BYPASS bit would help for this, since all the BIOS has
> to do is set it on boot. However, F_BYPASS is optional, and more complex
> support is needed for setting up identity mappings.
>=20
> [1] See "IOMMU protection against I/O attacks: a vulnerability and a proo=
f
> of concept" by Morgan et al, where a malicious device bypassing the IOMMU
> overwrites the IOMMU configuration as it is being created by the OS.
> Arguably we're not too concerned about malicious devices at the moment,
> but I'm not comfortable relaxing this.
>=20
> > >   - Should this flag be gone right after OS starts (otherwise I think
> > >     we still have the issue that any malicious device can be seen as
> > >     in PT mode as default)?  How is that done?
>=20
> Yes bypass mode assumes that devices and drivers aren't malicious, and th=
e
> IOMMU is only used for things like assigning devices to guest userspace,
> or having large contiguous DMA buffers.

Yes I agree.  However again when the BYPASS flag was introduced, have
you thought of introducing that flag per-device?  IMHO that could be
better because you have a finer granularity on controlling all these,
so you'll be able to reject malicious devices but at the meantime
grant permission to trusted devices.

Thanks,

--=20
Peter Xu


