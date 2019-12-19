Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF96C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6BC20684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkLh3MXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6BC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihw5l-0005Xn-S1
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ihvva-0000AJ-1o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ihvvX-0001OJ-Iv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:33:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ihvvX-0001Lm-CN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TK4RywertGHU5YvngQqidrycj5zwSBQzF1+NiySvZmY=;
 b=IkLh3MXYoooAUK6HIBAgqQTC+VwQYviky9kriXPmzg8HuIhE71lpYEq3wlBIQ/YM5jEhze
 PUFUG9lK+yGLOnWkbt6d1LtAfxoHfgTDltPAXMaLUAxyv7uLs6Av4Pk/il2kvvSqMRZcaM
 YVJvE+D+BObPn9duOrPjpNwLJXyEgO8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-CDxVGYiRMlCipkBidCqlaQ-1; Thu, 19 Dec 2019 08:33:14 -0500
Received: by mail-qk1-f200.google.com with SMTP id g28so3604339qkl.6
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+VFciNyicxTJ/a/4QmIxoALs8sCDRyGU5BBU/c2HPL0=;
 b=r47MsRQf2ypfIRUgMa93klK5EmLTXQ/YqNmUe9FAgLlhui/cDysW2mZCM6OukAsWMN
 ABfaiYtZqoiRPXOXBAlUErJjffZFhykRNS6OSJhihULrFUSyMfsGPqhVbxDIIYlfn4Ce
 OWguSWDMbs+jJAfzm66AW6Pyk8R8pEkQmc3huFEnOYgDeU7eW7QweQDZ3cShoT1PluzO
 K2eWikx6gd34bS4fEYyEi8hPRlV6TBVXHYv+N3M+8WCbmWOw2/0Q615sbR8j2ghn4F0D
 DGXjxpRXV3Q4oPlJR/mg7J6u9pxvFbcRoRCSH92hjoVfTdch6k/AYOTV3ddmeBCQh0Bg
 Sc5w==
X-Gm-Message-State: APjAAAXEMa3+IPxJnrKD1AYSd9FRoT3CvSwRAHD2FF4M4foRKlbE1PAd
 /zIFGhEciB2/qXqtvT3R3v1noH2vI39z79M0rpm3CnPDy7ErmebNVrdbSfI1F1uBNgdMIlUnMnU
 A/sey5HibZAn1zfg=
X-Received: by 2002:ac8:461a:: with SMTP id p26mr6702212qtn.317.1576762390803; 
 Thu, 19 Dec 2019 05:33:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+Y10/rRZvyBzfotd49vjBuDPt/SmkpwCsOiXKB3hnaDeEBf6axwtUUnl1kQv4fFZv7T7trQ==
X-Received: by 2002:ac8:461a:: with SMTP id p26mr6702178qtn.317.1576762390528; 
 Thu, 19 Dec 2019 05:33:10 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::2])
 by smtp.gmail.com with ESMTPSA id j7sm1735320qkd.46.2019.12.19.05.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:33:09 -0800 (PST)
Date: Thu, 19 Dec 2019 08:33:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20191219133308.GA4246@xz-x1>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-9-eric.auger@redhat.com>
 <20191210193342.GJ3352@xz-x1>
 <44c0041d-68ad-796f-16cc-4bab7ba0f164@redhat.com>
MIME-Version: 1.0
In-Reply-To: <44c0041d-68ad-796f-16cc-4bab7ba0f164@redhat.com>
X-MC-Unique: CDxVGYiRMlCipkBidCqlaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 11:30:40AM +0100, Auger Eric wrote:
> Hi Peter,
> On 12/10/19 8:33 PM, Peter Xu wrote:
> > On Fri, Nov 22, 2019 at 07:29:31PM +0100, Eric Auger wrote:
> >> This patch implements the translate callback
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >>
> >> v10 -> v11:
> >> - take into account the new value struct and use
> >>   g_tree_lookup_extended
> >> - switched to error_report_once
> >>
> >> v6 -> v7:
> >> - implemented bypass-mode
> >>
> >> v5 -> v6:
> >> - replace error_report by qemu_log_mask
> >>
> >> v4 -> v5:
> >> - check the device domain is not NULL
> >> - s/printf/error_report
> >> - set flags to IOMMU_NONE in case of all translation faults
> >> ---
> >>  hw/virtio/trace-events   |  1 +
> >>  hw/virtio/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++++++++=
-
> >>  2 files changed, 63 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> >> index f25359cee2..de7cbb3c8f 100644
> >> --- a/hw/virtio/trace-events
> >> +++ b/hw/virtio/trace-events
> >> @@ -72,3 +72,4 @@ virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc end=
point=3D%d"
> >>  virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=3D%d"
> >>  virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
> >>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
> >> +virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, ui=
nt32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
> >> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> >> index f0a56833a2..a83666557b 100644
> >> --- a/hw/virtio/virtio-iommu.c
> >> +++ b/hw/virtio/virtio-iommu.c
> >> @@ -412,19 +412,80 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMM=
UMemoryRegion *mr, hwaddr addr,
> >>                                              int iommu_idx)
> >>  {
> >>      IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> >> +    viommu_interval interval, *mapping_key;
> >> +    viommu_mapping *mapping_value;
> >> +    VirtIOIOMMU *s =3D sdev->viommu;
> >> +    viommu_endpoint *ep;
> >> +    bool bypass_allowed;
> >>      uint32_t sid;
> >> +    bool found;
> >> +
> >> +    interval.low =3D addr;
> >> +    interval.high =3D addr + 1;
> >> =20
> >>      IOMMUTLBEntry entry =3D {
> >>          .target_as =3D &address_space_memory,
> >>          .iova =3D addr,
> >>          .translated_addr =3D addr,
> >> -        .addr_mask =3D ~(hwaddr)0,
> >> +        .addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1,
> >>          .perm =3D IOMMU_NONE,
> >>      };
> >> =20
> >> +    bypass_allowed =3D virtio_has_feature(s->acked_features,
> >> +                                        VIRTIO_IOMMU_F_BYPASS);
> >> +
> >=20
> > Would it be easier to check bypass_allowed here once and then drop the
> > latter [1] and [2] check?
> bypass_allowed does not mean you systematically bypass. You bypass if
> the SID is unknown or if the device is not attached to any domain.
> Otherwise you translate. But maybe I miss your point.

Ah ok, then could I ask how will this VIRTIO_IOMMU_F_BYPASS be used?
For example, I think VT-d defines passthrough in a totally different
way in that the PT mark will be stored in the per-device context
entries, then we can allow a specific device to be pass-through when
doing DMA.  That information is explicit (e.g., unknown SID will
always fail the DMA), and per-device.

Here do you mean that you just don't put a device into any domain to
show it wants to use PT?  Then I'm not sure how do you identify
whether this is a legal PT or a malicious device (e.g., an unknown
device that even does not have any driver bound to it, which will also
satisfy "unknown SID" and "not attached to any domain", iiuc).

Thanks,

--=20
Peter Xu


