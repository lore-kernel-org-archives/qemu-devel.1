Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16591C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7599206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eit4hSy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7599206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJlg-0001fZ-V2
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 04:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ijJks-00018J-QP
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ijJkq-0003rX-A3
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:11:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32698
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ijJkp-0003kP-UK
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577092314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/xlkTrstnlRNO4FHVwyPI1ENajclFfywGWkCwYYhL8=;
 b=Eit4hSy9tg++TF/RK5CnRU04vqMS9Cqn1XS1nZ8eI91j+zhPDdrB90ng4WXcX9PIYA3Cau
 ypAi3bPXMCoKAbvK3bbAkcAYhxTg7b1lmHBt23p3s3mTC94k1UboqS4kCDLg73YAFYXzO9
 NP8+01S8eZs19zaEOvY1WIk7sAopa/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-msKCyRmkPfiF8ozY0gdOAw-1; Mon, 23 Dec 2019 04:11:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA48D189DF40;
 Mon, 23 Dec 2019 09:11:51 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCED260BE0;
 Mon, 23 Dec 2019 09:11:41 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 05/20] virtio-iommu: Endpoint and domains
 structs and helpers
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-6-eric.auger@redhat.com>
 <20191210163716.GD277340@myrica>
 <28597404-b9ac-8c16-e9e8-ad5793f2f5a3@redhat.com>
 <20191220170028.GB2626852@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <fe993994-1b69-cf47-4f9a-88572e275a3e@redhat.com>
Date: Mon, 23 Dec 2019 10:11:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191220170028.GB2626852@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: msKCyRmkPfiF8ozY0gdOAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 12/20/19 6:00 PM, Jean-Philippe Brucker wrote:
> On Thu, Dec 19, 2019 at 07:31:08PM +0100, Auger Eric wrote:
>> Hi Jean,
>>
>> On 12/10/19 5:37 PM, Jean-Philippe Brucker wrote:
>>> On Fri, Nov 22, 2019 at 07:29:28PM +0100, Eric Auger wrote:
>>>> +typedef struct viommu_domain {
>>>> +    uint32_t id;
>>>> +    GTree *mappings;
>>>> +    QLIST_HEAD(, viommu_endpoint) endpoint_list;
>>>> +} viommu_domain;
>>>> +
>>>> +typedef struct viommu_endpoint {
>>>> +    uint32_t id;
>>>> +    viommu_domain *domain;
>>>> +    QLIST_ENTRY(viommu_endpoint) next;
>>>> +} viommu_endpoint;
>>>
>>> There might be a way to merge viommu_endpoint and the IOMMUDevice
>>> structure introduced in patch 4, since they both represent one endpoint.
>>> Maybe virtio_iommu_find_add_pci_as() could add the IOMMUDevice to
>>> s->endpoints, and IOMMUDevice could store the endpoint ID rather than bus
>>> and devfn.
>>
>> On PCI bus enumeration we locally store the PCI bus hierarchy under the
>> form of GHashTable of IOMMUDevice indexed by iommu_pci_bus pointer.
>> Those are all the devices attached to the downstream buses. We also use
>> an array of iommu pci bus pointers indexed by bus number that is lazily
>> populated due to the fact, at enumeration time we do know the bus number
>> yet. As you pointed, I haven't used the array of iommu pci bus pointers
>> indexed by bus number in this series and I should actually. Currently I
>> am not checking on attach that the sid effectively corresponds to a sid
>> protected by this iommu. I will add this in my next version. The above
>> structures are used in intel_iommu and smmu code as well and I think
>> eventually this may be factorized a common base class..
>>
>> on the other hand the gtree of viommu_endpoint - soon renamed in
>> CamelCase form ;-) - corresponds to the EPs that are actually attached
>> to any domain. It is indexed by sid and not by bus pointer. This is more
>> adapted to the virtio-iommu case.
>>
>> So, despite your suggestion, I am tempted to keep the different
>> structures as the first ones are common to all iommu emulation code and
>> the last is adapted to the virtio-iommu operations.
>>
>> Thoughts?
> 
> Makes sense, it seems better to keep them separate. I had missed that the
> PCI bus number is resolved later, and started to move the endpoint ID into
> IOMMUDevice when adding MMIO support, but I'll need to revisit this.
> 
> I'll be off for two weeks, have a nice holiday!

Thanks, you too.

Merry Christmas! :-)

Eric
> 
> Thanks,
> Jean
> 


