Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D25C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4545D2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwsdPZsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4545D2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvIi-00055d-Fd
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJvIA-0004gj-Hz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJvI8-0003hK-Gq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:33:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJvI8-0003dk-7w
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585816415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vF5jPTjMAXWG5nK+NfmmXnNhmeLxxH3USCdZc5XlsGU=;
 b=GwsdPZsVvbtujt7kO1djmf42wZyOpDGq32vWoHbPoC9IC6cJuAmuhOItIYIQcnm8Tx+CgE
 w54XV/wMtWwIi6tB0MppSA6g92jt2vV7ZsPWUdmEzWcWocwOrSgLUFtmeZ3gvNjzZny0Dl
 wPnbZgcq5LRqSUKqPBID42Zfxd6gfrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-sX4YZp29N12m13l0esWiOQ-1; Thu, 02 Apr 2020 04:33:29 -0400
X-MC-Unique: sX4YZp29N12m13l0esWiOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A5C310CE7AC;
 Thu,  2 Apr 2020 08:33:27 +0000 (UTC)
Received: from [10.72.13.209] (ovpn-13-209.pek2.redhat.com [10.72.13.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAA7F261D5;
 Thu,  2 Apr 2020 08:33:04 +0000 (UTC)
Subject: Re: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing to
 VMs
To: Liu Yi L <yi.l.liu@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, peterx@redhat.com
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <984e6f47-2717-44fb-7ff2-95ca61d1858f@redhat.com>
Date: Thu, 2 Apr 2020 16:33:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, kvm@vger.kernel.org,
 mst@redhat.com, jun.j.tian@intel.com, eric.auger@redhat.com,
 yi.y.sun@intel.com, pbonzini@redhat.com, david@gibson.dropbear.id.au,
 hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/30 =E4=B8=8B=E5=8D=8812:24, Liu Yi L wrote:
> Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on
> Intel platforms allows address space sharing between device DMA and
> applications. SVA can reduce programming complexity and enhance securit=
y.
>
> This QEMU series is intended to expose SVA usage to VMs. i.e. Sharing
> guest application address space with passthru devices. This is called
> vSVA in this series. The whole vSVA enabling requires QEMU/VFIO/IOMMU
> changes.
>
> The high-level architecture for SVA virtualization is as below, the key
> design of vSVA support is to utilize the dual-stage IOMMU translation (
> also known as IOMMU nesting translation) capability in host IOMMU.
>
>      .-------------.  .---------------------------.
>      |   vIOMMU    |  | Guest process CR3, FL only|
>      |             |  '---------------------------'
>      .----------------/
>      | PASID Entry |--- PASID cache flush -
>      '-------------'                       |
>      |             |                       V
>      |             |                CR3 in GPA
>      '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>        v        v                          v
> Host
>      .-------------.  .----------------------.
>      |   pIOMMU    |  | Bind FL for GVA-GPA  |
>      |             |  '----------------------'
>      .----------------/  |
>      | PASID Entry |     V (Nested xlate)
>      '----------------\.------------------------------.
>      |             ||SL for GPA-HPA, default domain|
>      |             |   '------------------------------'
>      '-------------'
> Where:
>   - FL =3D First level/stage one page tables
>   - SL =3D Second level/stage two page tables
>
> The complete vSVA kernel upstream patches are divided into three phases=
:
>      1. Common APIs and PCI device direct assignment
>      2. IOMMU-backed Mediated Device assignment
>      3. Page Request Services (PRS) support
>
> This QEMU patchset is aiming for the phase 1 and phase 2. It is based
> on the two kernel series below.
> [1] [PATCH V10 00/11] Nested Shared Virtual Address (SVA) VT-d support:
> https://lkml.org/lkml/2020/3/20/1172
> [2] [PATCH v1 0/8] vfio: expose virtual Shared Virtual Addressing to VM=
s
> https://lkml.org/lkml/2020/3/22/116
>
> There are roughly two parts:
>   1. Introduce HostIOMMUContext as abstract of host IOMMU. It provides =
explicit
>      method for vIOMMU emulators to communicate with host IOMMU. e.g. p=
ropagate
>      guest page table binding to host IOMMU to setup dual-stage DMA tra=
nslation
>      in host IOMMU and flush iommu iotlb.
>   2. Setup dual-stage IOMMU translation for Intel vIOMMU. Includes
>      - Check IOMMU uAPI version compatibility and VFIO Nesting capabili=
ties which
>        includes hardware compatibility (stage 1 format) and VFIO_PASID_=
REQ
>        availability. This is preparation for setting up dual-stage DMA =
translation
>        in host IOMMU.
>      - Propagate guest PASID allocation and free request to host.
>      - Propagate guest page table binding to host to setup dual-stage I=
OMMU DMA
>        translation in host IOMMU.
>      - Propagate guest IOMMU cache invalidation to host to ensure iotlb
>        correctness.
>
> The complete QEMU set can be found in below link:
> https://github.com/luxis1999/qemu.git: sva_vtd_v10_v2


Hi Yi:

I could not find the branch there.

Thanks


