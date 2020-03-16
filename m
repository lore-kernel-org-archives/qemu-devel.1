Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3334C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8A720658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDCoMVnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8A720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDunr-0004kT-Qg
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jDtay-0000cE-7J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jDtav-0001z1-Q2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:32:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26117)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jDtav-0001uF-LD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584379924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zXe/Cypv6iQt9TRbMdAATGCxdNG99ZrItay448Obtc=;
 b=LDCoMVnD4kX7N8aJwVwhFgPflKaY73D6baaEJWQ2z+eNgAtigTWzL3Ohuu30A6947WSbVw
 HrHKhCdkhRtrx9x7XfQNg/C8KA8tnW+d+le2hTsA/yKQhiYptB9roInA3Pl9jrKjEdOGWC
 9DtC9ucZ3kAFFWEJFNxesou2uwQQKqk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-bxrWPdrgNNKofLLWC9os-A-1; Mon, 16 Mar 2020 13:32:02 -0400
X-MC-Unique: bxrWPdrgNNKofLLWC9os-A-1
Received: by mail-qt1-f197.google.com with SMTP id w3so17940033qtc.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=spPuwoYunkpmdwPPr04o6nutT9ci5GMlz/2rV3S0aG4=;
 b=ahWIveoVchH5+FiiBX74nEXx4lyfcq0Rf4f8MI8uzCFMhKndsZxh6fFwKMxckLMWwK
 21XLfsRiXChAEPFbSz0hOiUTAK0qEOHDiANeQ/UugzlV3Tf5DwHHbskTgJV13hEoaax5
 mUJwKb932JhrSSRGwgE2OF5nBfthb8lKUk3rA8Rikxy5/rcIZgp52jNvn75j1oCuoI+3
 byidoJOjQSkPeILKALy6xH9IH7tH72+oFjm2MVfd5lU1sZSiT8FKP/eo/86OoBzCUdMG
 W7QquBOEm+dV3WwiZGRMEJMDjc8ntzH0wlGppNnqPUKGDffB4kMTMuT2uXtBQptTAUqA
 PKAA==
X-Gm-Message-State: ANhLgQ2HoC4CuC0qEXFscIbbU5DJGSrPHzSTQCBWkQUH1w/SkwuU8vFz
 A/hSL0zrsuJ5KV3luZ/7DXlFJSSj4lPSIzYBesbf08SDQ6uH6xV3oIAdXvPi1KVXhT0YYXWsEkm
 VaJIba5bcwNoXjIM=
X-Received: by 2002:a05:6214:188e:: with SMTP id
 cx14mr877639qvb.187.1584379921779; 
 Mon, 16 Mar 2020 10:32:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsWuMjJvp/Ur6iTw7+bb6SJ4PFCdvKYwHdCx0qMP/ekQ/if+1Ts89B1jhy7zrNuOObB5BIZAA==
X-Received: by 2002:a05:6214:188e:: with SMTP id
 cx14mr877608qvb.187.1584379921454; 
 Mon, 16 Mar 2020 10:32:01 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id l18sm169395qke.132.2020.03.16.10.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:32:00 -0700 (PDT)
Date: Mon, 16 Mar 2020 13:31:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200316173158.GA184827@xz-x1>
References: <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
 <20200313112902-mutt-send-email-mst@kernel.org>
 <20200313163122.GB95517@xz-x1>
 <20200316175737.365d7b32.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200316175737.365d7b32.pasic@linux.ibm.com>
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 05:57:37PM +0100, Halil Pasic wrote:
> On Fri, 13 Mar 2020 12:31:22 -0400
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Fri, Mar 13, 2020 at 11:29:59AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Mar 13, 2020 at 01:44:46PM +0100, Halil Pasic wrote:
> > > > [..]
> > > > > >=20
> > > > > > CCing Tom. @Tom does vhost-vsock work for you with SEV and curr=
ent qemu?
> > > > > >=20
> > > > > > Also, one can specify iommu_platform=3Don on a device that ain'=
t a part of
> > > > > > a secure-capable VM, just for the fun of it. And that breaks
> > > > > > vhost-vsock. Or is setting iommu_platform=3Don only valid if
> > > > > > qemu-system-s390x is protected virtualization capable?
> > > > > >=20
> > > > > > BTW, I don't have a strong opinion on the fixes tag. We current=
ly do not
> > > > > > recommend setting iommu_platform, and thus I don't think we car=
e too
> > > > > > much about past qemus having problems with it.
> > > > > >=20
> > > > > > Regards,
> > > > > > Halil
> > > > >=20
> > > > >=20
> > > > > Let's just say if we do have a Fixes: tag we want to set it corre=
ctly to
> > > > > the commit that needs this fix.
> > > > >=20
> > > >=20
> > > > I finally did some digging regarding the performance degradation. F=
or
> > > > s390x the performance degradation on vhost-net was introduced by co=
mmit
> > > > 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Before
> > > > IOMMUTLBEntry.addr_mask used to be based on plen, which in turn was
> > > > calculated as the rest of the memory regions size (from address), a=
nd
> > > > covered most of the guest address space. That is we didn't have a w=
hole
> > > > lot of IOTLB API overhead.
> > > >=20
> > > > With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0xfff w=
hich comes
> > > > as ~TARGET_PAGE_MASK from flatview_do_translate(). To have things w=
orking
> > > > properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the lev=
el of
> > > > 076a93d797 and 076a93d797~1.
> > >=20
> > > Peter, what's your take on this one?
> >=20
> > Commit 076a93d797 was one of the patchset where we want to provide
> > sensible IOTLB entries and also that should start to work with huge
> > pages.  Frankly speaking after a few years I forgot the original
> > motivation of that whole thing, but IIRC there's a patch that was
> > trying to speedup especially for vhost but I noticed it's not merged:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00574.html

[1]

> >=20
>=20
> From the looks of it, I don't think we would have seen that big
> performance degradation had this patch been included. I can give
> it a spin if you like. Shall I?
>=20
> > Regarding to the current patch, I'm not sure I understand it
> > correctly, but is that performance issue only happens when (1) there's
> > no intel-iommu device, and (2) there is iommu_platform=3Don specified
> > for the vhost backend?
> >=20
>=20
> I can confirm, that your description covers my scenario. I didn't
> investigate what happens when we have an intel-iommu, because s390 does
> not do intel-iommu. I can also confirm that no performance degradation
> is observed when the virtio-net has iommu_platform=3Doff. The property
> iommu_platform is a virtio device (and not a backend) level property.
> =20
>=20
> > If so, I'd confess I am not too surprised if this fails the boot with
> > vhost-vsock because after all we speicified iommu_platform=3Don
> > explicitly in the cmdline, so if we want it to work we can simply
> > remove that iommu_platform=3Don when vhost-vsock doesn't support it
> > yet...  I thougth iommu_platform=3Don was added for that case - when we
> > want to force IOMMU to be enabled from host side, and it should always
> > be used with a vIOMMU device.
> >=20
>=20
> The problem is that the virtio feature bit F_ACCESS_PLATFORM, which is
> directly controlled by the iommu_platform proprerty stands for two things
> 1) need to do IOVA translation
> 2) the access of the device to the guests RAM is restricted.
>=20
> There are cases where 2) does apply and 1) does not. We need to specify
> iommu_platform=3Don to make the virtio implementation in the guest use
> the dma api, because we need to grant access to memory as required. But
> we don't need translation and we don't have a vIOMMU.

I see the point of this patch now.  I'm still unclear on how s390
works for DMA protection, but it seems totally different from the
IOMMU model on x86/arm.  Considering this, please ignore above patch
[1] because that's hackish in all cases to play with iotlb caches, and
current patch should be much better (and easier) IMHO.

Thanks,

--=20
Peter Xu


