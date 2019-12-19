Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFBD227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHrepha4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFBD227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0JI-0001wD-4m
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ii0Gl-0007Dp-Di
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ii0Gk-0005jb-3c
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:11:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34949
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ii0Gj-0005dS-Qz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576779084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6pbrKZ+N3J8EgOEAGNWuIizLRnL3QASgl8e3eexOCs=;
 b=DHrepha4rthFacIa/46JRZZ7aH5NS6cyv/2MXI2qO3JK18guiDXfY2bBEXwf8voiCvp0/G
 N8jmtvsUYxWctOHGGfHNN+ESOvozkcwkk6ouyOpQ0YRcHYQxYymWYiZ9F81NcQ0HMQABqh
 CU+e6AGnybsyR0JiK3yUGxZvWbH124g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-vwIQXQheNmuIBjzxexoFXA-1; Thu, 19 Dec 2019 13:11:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48206801E7E;
 Thu, 19 Dec 2019 18:11:19 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 727165C1B0;
 Thu, 19 Dec 2019 18:11:10 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 04/20] virtio-iommu: Add the iommu regions
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-5-eric.auger@redhat.com>
 <20191210163440.GC277340@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1bf85182-19dd-5e84-dbb7-1734be927e82@redhat.com>
Date: Thu, 19 Dec 2019 19:11:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191210163440.GC277340@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vwIQXQheNmuIBjzxexoFXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 12/10/19 5:34 PM, Jean-Philippe Brucker wrote:
> Two small things below, but looks good overall
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> On Fri, Nov 22, 2019 at 07:29:27PM +0100, Eric Auger wrote:
>> +static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>> +                                              int devfn)
>> +{
>> +    VirtIOIOMMU *s = opaque;
>> +    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
>> +    static uint32_t mr_index;
>> +    IOMMUDevice *sdev;
>> +
>> +    if (!sbus) {
>> +        sbus = g_malloc0(sizeof(IOMMUPciBus) +
>> +                         sizeof(IOMMUDevice *) * IOMMU_PCI_DEVFN_MAX);
>> +        sbus->bus = bus;
>> +        g_hash_table_insert(s->as_by_busptr, bus, sbus);
>> +    }
>> +
>> +    sdev = sbus->pbdev[devfn];
>> +    if (!sdev) {
>> +        char *name = g_strdup_printf("%s-%d-%d",
>> +                                     TYPE_VIRTIO_IOMMU_MEMORY_REGION,
>> +                                     mr_index++, devfn);
>> +        sdev = sbus->pbdev[devfn] = g_malloc0(sizeof(IOMMUDevice));
>> +
>> +        sdev->viommu = s;
>> +        sdev->bus = bus;
>> +        sdev->devfn = devfn;
> 
> It might be better to store the endpoint ID in IOMMUDevice, then you could
> get rid of virtio_iommu_get_sid(), and remove a tiny bit of overhead in
> virtio_iommu_translate(). But I doubt it's significant.
virtio_iommu_find_add_as() gets called on PCI bus enumeration. At that
point, the bus number may not be resolved. So I cannot retrieve and set
the bus_number in this function.

When virtio_iommu_get_sid() is called we are sure pci_bus_num(dev->bus)
returns a correct value.
> 
> [...]
>> +static const TypeInfo virtio_iommu_memory_region_info = {
>> +    .parent = TYPE_IOMMU_MEMORY_REGION,
>> +    .name = TYPE_VIRTIO_IOMMU_MEMORY_REGION,
>> +    .class_init = virtio_iommu_memory_region_class_init,
>> +};
>> +
>> +
> 
> nit: newline.
Thanks

Eric
> 
> Thanks,
> Jean 
> 



