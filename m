Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F9C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 08:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D7D2173E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 08:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D7D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3byR-0004ig-No
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 04:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1i3bvp-0003hb-PW
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1i3bvg-0003Wq-7J
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:06:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:33497)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1i3bvf-00039g-QB
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:06:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Aug 2019 01:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,446,1559545200"; d="scan'208";a="265249447"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga001.jf.intel.com with ESMTP; 30 Aug 2019 01:06:35 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 30 Aug 2019 01:06:35 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.112]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.204]) with mapi id 14.03.0439.000;
 Fri, 30 Aug 2019 16:06:33 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: 'Alex Williamson' <alex.williamson@redhat.com>, Kirti Wankhede
 <kwankhede@nvidia.com>
Thread-Topic: [PATCH v8 01/13] vfio: KABI for migration interface
Thread-Index: AQHVXEPM6Ds11z4g1kGhkyVJXk+n4qcQheKAgAKxOUCAABvDkA==
Date: Fri, 30 Aug 2019 08:06:32 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D553184@SHSMSX104.ccr.corp.intel.com>
References: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
 <1566845753-18993-2-git-send-email-kwankhede@nvidia.com>
 <20190828145045.20f2a7b3@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553133@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D553133@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzBlZDQxMjQtMzlmNS00NmFjLWI1ODgtZTc4ODVjZWQ2ZjNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK3U3YlhjZjRSa0t5ODM4YTZndzRIN2JCZk1wcTJ5Yk9lbDBJc0tpYlJKNlFQQlhxRm1CUktPSTltbG5nNHpFVSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH v8 01/13] vfio: KABI for migration interface
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Tian, Kevin
> Sent: Friday, August 30, 2019 3:26 PM
>=20
[...]
> > How does QEMU handle the fact that IOVAs are potentially dynamic while
> > performing the live portion of a migration?  For example, each time a
> > guest driver calls dma_map_page() or dma_unmap_page(), a
> > MemoryRegionSection pops in or out of the AddressSpace for the device
> > (I'm assuming a vIOMMU where the device AddressSpace is not
> > system_memory).  I don't see any QEMU code that intercepts that change
> > in the AddressSpace such that the IOVA dirty pfns could be recorded and
> > translated to GFNs.  The vendor driver can't track these beyond getting
> > an unmap notification since it only knows the IOVA pfns, which can be
> > re-used with different GFN backing.  Once the DMA mapping is torn down,
> > it seems those dirty pfns are lost in the ether.  If this works in QEMU=
,
> > please help me find the code that handles it.
>=20
> I'm curious about this part too. Interestingly, I didn't find any log_syn=
c
> callback registered by emulated devices in Qemu. Looks dirty pages
> by emulated DMAs are recorded in some implicit way. But KVM always
> reports dirty page in GFN instead of IOVA, regardless of the presence of
> vIOMMU. If Qemu also tracks dirty pages in GFN for emulated DMAs
>  (translation can be done when DMA happens), then we don't need
> worry about transient mapping from IOVA to GFN. Along this way we
> also want GFN-based dirty bitmap being reported through VFIO,
> similar to what KVM does. For vendor drivers, it needs to translate
> from IOVA to HVA to GFN when tracking DMA activities on VFIO
> devices. IOVA->HVA is provided by VFIO. for HVA->GFN, it can be
> provided by KVM but I'm not sure whether it's exposed now.
>=20

HVA->GFN can be done through hva_to_gfn_memslot in kvm_host.h.

Above flow works for software-tracked dirty mechanism, e.g. in
KVMGT, where GFN-based 'dirty' is marked when a guest page is=20
mapped into device mmu. IOVA->HPA->GFN translation is done=20
at that time, thus immune from further IOVA->GFN changes.

When hardware IOMMU supports D-bit in 2nd level translation (e.g.
VT-d rev3.0), there are two scenarios:

1) nested translation: guest manages 1st-level translation (IOVA->GPA)
and host manages 2nd-level translation (GPA->HPA). The 2nd-level
is not affected by guest mapping operations. So it's OK for IOMMU
driver to retrieve GFN-based dirty pages by directly scanning the 2nd-
level structure, upon request from user space.=20

2) shadowed translation (IOVA->HPA) in 2nd level: in such case the dirty
information is tied to IOVA. the IOMMU driver is expected to maintain
an internal dirty bitmap. Upon any change of IOVA->GPA notification
from VFIO, the IOMMU driver should flush dirty status of affected 2nd-level
entries to the internal GFN-based bitmap. At this time, again IOVA->HVA
->GPA translation required for GFN-based recording. When userspace=20
queries dirty bitmap, the IOMMU driver needs to flush latest 2nd-level=20
dirty status to internal bitmap, which is then copied to user space.

Given the trickiness of 2), we aim to enable 1) on intel-iommu driver.

Thanks
Kevin

