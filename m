Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143FBC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31D22073A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvKfgq3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31D22073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriJ8-00048m-So
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iriID-0003S2-0Z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iriI7-0004tb-7r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:01:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25049
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iriI7-0004tN-3v
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579093258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhHfVSTcsWupZx5t9Q77V1EutuWIjWNixQEVTQNjDXQ=;
 b=EvKfgq3Y5rN2zKtIQ8c2oAq0+UFQt/uRMCRj7eJGHwGjk4aGSArI36ENqN2vFZNnrAsNmI
 s1OhEl/jbrmH6/IoL/gRl+me5FklubZhWd9WmSoi/otKRHpvNAEzwISyWoWHgqjyt2Mv33
 n6kanUXXK5XLB4S5GueludOOEaIAGJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-yhqN1cNdPdWu_fbEWrot8Q-1; Wed, 15 Jan 2020 08:00:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5235801F74;
 Wed, 15 Jan 2020 13:00:53 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B483010841AB;
 Wed, 15 Jan 2020 13:00:23 +0000 (UTC)
Subject: Re: [PATCH v12 05/13] virtio-iommu: Endpoint and domains structs and
 helpers
To: Peter Xu <peterx@redhat.com>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-6-eric.auger@redhat.com>
 <20200113202301.GD201624@xz-x1>
 <51267d84-c805-a4a1-8084-b278721a5b3f@redhat.com>
 <20200114180734.GB225163@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f3da181d-094b-a647-31ea-bdb47eab5c1b@redhat.com>
Date: Wed, 15 Jan 2020 14:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200114180734.GB225163@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yhqN1cNdPdWu_fbEWrot8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,


On 1/14/20 7:07 PM, Peter Xu wrote:
> On Tue, Jan 14, 2020 at 09:51:59AM +0100, Auger Eric wrote:
>> Hi Peter,
>=20
> Hi, Eric,
>=20
> [...]
>=20
>>>
>>>> +{
>>>> +    VirtIOIOMMUEndpoint *ep;
>>>> +
>>>> +    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
>>>> +    if (ep) {
>>>> +        return ep;
>>>> +    }
>>>> +    if (!virtio_iommu_mr(s, ep_id)) {
>>>
>>> Could I ask when this will trigger?
>>
>> This can happen when a device is attached to a domain and its RID does
>> not correspond to one of the devices protected by the iommu.

>=20
> So will it happen only because of a kernel driver bug?

Yes, at the moment, because virtio_iommu_mr() only gets called on device
attach to a domain.

The spec says:
"If the endpoint identified by endpoint doesn=E2=80=99t exist, the device M=
UST
reject the request and set status to VIRTIO_IOMMU_S_NOENT"
>=20
> Also, I think the name of "virtio_iommu_mr" is confusing on that it
> returned explicitly a MemoryRegion however it's never been used:

I use the same prototype as for smmu_iommu_mr(). Returning the iommu mr
will allow to proceed with further RID based operations like invalidations.

The same logic is used in vtd_context_device_invalidate.


>=20
> (since they're not in the same patch I'm pasting)
>=20
> static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
> {
>     uint8_t bus_n, devfn;
>     IOMMUPciBus *iommu_pci_bus;
>     IOMMUDevice *dev;
>=20
>     bus_n =3D PCI_BUS_NUM(sid);
>     iommu_pci_bus =3D iommu_find_iommu_pcibus(s, bus_n);
>     if (iommu_pci_bus) {
>         devfn =3D sid & 0xFF;
>         dev =3D iommu_pci_bus->pbdev[devfn];
>         if (dev) {
>             return &dev->iommu_mr;
>         }
>     }
>     return NULL;
> }
>=20
> Maybe "return !!dev" would be enough, then make the return a boolean?
> Then we can rename it to virtio_iommu_has_device().
>=20
> PS. I think we can also drop IOMMU_PCI_DEVFN_MAX (after all you even
> didn't use it here!) and use PCI_DEVFN_MAX, and replace 0xFF.
well intel iommu and smmu use a similar constant (PCI_DEVFN_MAX,
SMMU_PCI_DEVFN_MAX resp.). I use it in virtio_iommu_find_add_as

Thanks

Eric


>=20
> Thanks,
>=20


