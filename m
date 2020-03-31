Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A3DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB6C206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqdVt9/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB6C206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJBv9-0001NB-Cu
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jJBth-0008Kz-VW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jJBtg-0005W6-H7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:05:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jJBtg-0005VA-DF
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585641919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Law9c0/JcqFOfhzWbV+HtEXkfNUXATHQp7uoDMhrCEQ=;
 b=MqdVt9/9a1iQoNqnbswHwR7m0CDeWi5FUAf36Bcbg8vJ3OihMgHkTBGkJI3tEXoc1YIXHr
 wW0cqpRg1UNd3l7nzxA+ufPfUSGuK25JG7D/2Vt5QDjkTql7It75T8L3ovMfzvYdE1x8oY
 oNPN0xwBDaEwIugTWzk78SgTsQzYQU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-yXmGvD9YPampLoE9LJD13g-1; Tue, 31 Mar 2020 04:05:16 -0400
X-MC-Unique: yXmGvD9YPampLoE9LJD13g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E92951005514;
 Tue, 31 Mar 2020 08:05:13 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 541D610016EB;
 Tue, 31 Mar 2020 08:04:59 +0000 (UTC)
Subject: Re: [RFC v6 09/24] vfio: Force nested if iommu requires it
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
 <20200320165840.30057-10-eric.auger@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A21A69E@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <33fab5b6-b217-3b87-9207-b5653c268fe3@redhat.com>
Date: Tue, 31 Mar 2020 10:04:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A21A69E@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "tnowicki@marvell.com" <tnowicki@marvell.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "bbhushan2@marvell.com" <bbhushan2@marvell.com>,
 "will@kernel.org" <will@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yi,

On 3/31/20 8:34 AM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Saturday, March 21, 2020 12:58 AM
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-devel@nongnu.org;
>> Subject: [RFC v6 09/24] vfio: Force nested if iommu requires it
>>
>> In case we detect the address space is translated by
>> a virtual IOMMU which requires HW nested paging to
>> integrate with VFIO, let's set up the container with
>> the VFIO_TYPE1_NESTING_IOMMU iommu_type.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v4 -> v5:
>> - fail immediatly if nested is wanted but not supported
>>
>> v2 -> v3:
>> - add "nested only is selected if requested by @force_nested"
>>   comment in this patch
>> ---
>>  hw/vfio/common.c | 36 ++++++++++++++++++++++++++++--------
>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 0b3593b3c0..ac417b5dbd 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1155,27 +1155,38 @@ static void vfio_put_address_space(VFIOAddressSpace
>> *space)
>>   * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
>>   */
>>  static int vfio_get_iommu_type(VFIOContainer *container,
>> +                               bool want_nested,
>>                                 Error **errp)
>>  {
>> -    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
>> +    int iommu_types[] = { VFIO_TYPE1_NESTING_IOMMU,
>> +                          VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
>>                            VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
>> -    int i;
>> +    int i, ret = -EINVAL;
>>
>>      for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
>>          if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
>> -            return iommu_types[i];
>> +            if (iommu_types[i] == VFIO_TYPE1_NESTING_IOMMU && !want_nested) {
>> +                continue;
>> +            }
>> +            ret = iommu_types[i];
>> +            break;
>>          }
>>      }
>> -    error_setg(errp, "No available IOMMU models");
>> -    return -EINVAL;
>> +    if (ret < 0) {
>> +        error_setg(errp, "No available IOMMU models");
>> +    } else if (want_nested && ret != VFIO_TYPE1_NESTING_IOMMU) {
>> +        error_setg(errp, "Nested mode requested but not supported");
>> +        ret = -EINVAL;
>> +    }
>> +    return ret;
>>  }
>>
>>  static int vfio_init_container(VFIOContainer *container, int group_fd,
>> -                               Error **errp)
>> +                               bool want_nested, Error **errp)
>>  {
>>      int iommu_type, ret;
>>
>> -    iommu_type = vfio_get_iommu_type(container, errp);
>> +    iommu_type = vfio_get_iommu_type(container, want_nested, errp);
>>      if (iommu_type < 0) {
>>          return iommu_type;
>>      }
>> @@ -1211,6 +1222,14 @@ static int vfio_connect_container(VFIOGroup *group,
>> AddressSpace *as,
>>      VFIOContainer *container;
>>      int ret, fd;
>>      VFIOAddressSpace *space;
>> +    IOMMUMemoryRegion *iommu_mr;
>> +    bool nested = false;
>> +
>> +    if (as != &address_space_memory && memory_region_is_iommu(as->root)) {
> 
> I tried on my side. For virtual VT-d, it doesn't work as in intel_iommu,
> we have a dynamic switch mechanism. Thus that, the
> memory_region_is_iommu(as->root) won't return true as expected. I'm afraid
> it doesn't work for virtual VT-d.  So firstly, I'm wondering if
> as != &address_space_memory is enough.

(as != &address_space_memory) should be sufficient to tell that a vIOMMU
is being used. But then, for example, you don't want to set nested
paging for the virtio-iommu because virtio-iommu/VFIO uses notify-on-my
(CM similar implementation). That's why I devised an attribute to
retrieve the vIOMMU need for nested.

 Secondly, I'm considering if it is
> good to let vfio_get_group() caller to provide a hint whether vIOMMU is
> exposed. e.g. vfio_realize() in vfio/pci.c could figure out whether vIOMMU
> is set easily. Thoughts?
Sorry I don't get your point here. Why is it easier to figure out
whether vIOMMU is set in vfio_realize()?

pci_device_iommu_address_space(pdev) !=  &address_space_memory
does determine whether a vIOMMU is in place, no?

Thanks

Eric
> 
> Regards,
> Yi Liu
> 


