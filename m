Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69538C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32482206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhHji87v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32482206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLP1Y-0007Df-9l
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jLOrr-0005JK-Uv
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jLOrq-00084V-4v
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:20:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jLOrq-000843-08
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586168433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kj9ZaVkXiu8/l+MCZwlSkv4VvTr9UyVeORcUDjYZrMY=;
 b=fhHji87vIaYY2uDnuJXNcqfFM5LGkY/f/8Yby5LJ76xIoeVokEaa6cIm101xIYtiCJGK5D
 dScxOltihD6XTJC8O1ZeNYgMIJni+lsW3LW+9hD0lu8hBZ12XQiSF6dpsPWrljoMHUoVbn
 2uY54OYm/xqkndhUB/l7iVogBdLbh5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-R3QftrRDNPO8FTgfsUelPw-1; Mon, 06 Apr 2020 06:20:31 -0400
X-MC-Unique: R3QftrRDNPO8FTgfsUelPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB66418B644C;
 Mon,  6 Apr 2020 10:20:29 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18C3E96B7B;
 Mon,  6 Apr 2020 10:20:17 +0000 (UTC)
Subject: Re: [PATCH v2 09/22] vfio/common: init HostIOMMUContext per-container
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-10-git-send-email-yi.l.liu@intel.com>
 <55a767fb-ed98-bc30-5de1-0791f1ce8642@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A222FCD@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b9f3a991-cfb9-dcf4-f0e6-00e348a94827@redhat.com>
Date: Mon, 6 Apr 2020 12:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A222FCD@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "Wu,
 Hao" <hao.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yi,

On 4/6/20 9:12 AM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Wednesday, April 1, 2020 3:51 PM
>> To: Liu, Yi L <yi.l.liu@intel.com>; qemu-devel@nongnu.org;
>> Subject: Re: [PATCH v2 09/22] vfio/common: init HostIOMMUContext per-container
>>
>> Hi Yi,
>>
>> On 3/30/20 6:24 AM, Liu Yi L wrote:
>>> In this patch, QEMU firstly gets iommu info from kernel to check the
>>> supported capabilities by a VFIO_IOMMU_TYPE1_NESTING iommu. And inits
>>> HostIOMMUContet instance.
>>>
>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Yi Sun <yi.y.sun@linux.intel.com>
>>> Cc: David Gibson <david@gibson.dropbear.id.au>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>>> ---
>>>  hw/vfio/common.c | 99
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 99 insertions(+)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
>>> 5f3534d..44b142c 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1226,10 +1226,89 @@ static int
>> vfio_host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx,
>>>      return 0;
>>>  }
>>>
>>> +/**
>>> + * Get iommu info from host. Caller of this funcion should free
>>> + * the memory pointed by the returned pointer stored in @info
>>> + * after a successful calling when finished its usage.
>>> + */
>>> +static int vfio_get_iommu_info(VFIOContainer *container,
>>> +                         struct vfio_iommu_type1_info **info) {
>>> +
>>> +    size_t argsz = sizeof(struct vfio_iommu_type1_info);
>>> +
>>> +    *info = g_malloc0(argsz);
>>> +
>>> +retry:
>>> +    (*info)->argsz = argsz;
>>> +
>>> +    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
>>> +        g_free(*info);
>>> +        *info = NULL;
>>> +        return -errno;
>>> +    }
>>> +
>>> +    if (((*info)->argsz > argsz)) {
>>> +        argsz = (*info)->argsz;
>>> +        *info = g_realloc(*info, argsz);
>>> +        goto retry;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static struct vfio_info_cap_header *
>>> +vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t
>>> +id) {
>>> +    struct vfio_info_cap_header *hdr;
>>> +    void *ptr = info;
>>> +
>>> +    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
>>> +        if (hdr->id == id) {
>>> +            return hdr;
>>> +        }
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +static int vfio_get_nesting_iommu_cap(VFIOContainer *container,
>>> +                   struct vfio_iommu_type1_info_cap_nesting
>>> +*cap_nesting) {
>>> +    struct vfio_iommu_type1_info *info;
>>> +    struct vfio_info_cap_header *hdr;
>>> +    struct vfio_iommu_type1_info_cap_nesting *cap;
>>> +    int ret;
>>> +
>>> +    ret = vfio_get_iommu_info(container, &info);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    hdr = vfio_get_iommu_info_cap(info,
>>> +                        VFIO_IOMMU_TYPE1_INFO_CAP_NESTING);
>>> +    if (!hdr) {
>>> +        g_free(info);
>>> +        return -errno;
>>> +    }
>>> +
>>> +    cap = container_of(hdr,
>>> +                struct vfio_iommu_type1_info_cap_nesting, header);
>>> +    *cap_nesting = *cap;
>>> +
>>> +    g_free(info);
>>> +    return 0;
>>> +}
>>> +
>>>  static int vfio_init_container(VFIOContainer *container, int group_fd,
>>>                                 Error **errp)  {
>>>      int iommu_type, ret;
>>> +    uint64_t flags = 0;
>>>
>>>      iommu_type = vfio_get_iommu_type(container, errp);
>>>      if (iommu_type < 0) {
>>> @@ -1257,6 +1336,26 @@ static int vfio_init_container(VFIOContainer
>> *container, int group_fd,
>>>          return -errno;
>>>      }
>>>
>>> +    if (iommu_type == VFIO_TYPE1_NESTING_IOMMU) {
>>> +        struct vfio_iommu_type1_info_cap_nesting nesting = {
>>> +                                         .nesting_capabilities = 0x0,
>>> +                                         .stage1_formats = 0, };
>>> +
>>> +        ret = vfio_get_nesting_iommu_cap(container, &nesting);
>>> +        if (ret) {
>>> +            error_setg_errno(errp, -ret,
>>> +                             "Failed to get nesting iommu cap");
>>> +            return ret;
>>> +        }
>>> +
>>> +        flags |= (nesting.nesting_capabilities & VFIO_IOMMU_PASID_REQS) ?
>>> +                 HOST_IOMMU_PASID_REQUEST : 0;
>> I still don't get why you can't transform your iommu_ctx into a  pointer and do
>> container->iommu_ctx = g_new0(HostIOMMUContext, 1);
>> then
>> host_iommu_ctx_init(container->iommu_ctx, flags);
>>
>> looks something similar to (hw/vfio/common.c). You may not even need to use a
>> derived VFIOHostIOMMUContext object (As only VFIO does use that object)? Only
>> the ops do change, no new field?
>>         region->mem = g_new0(MemoryRegion, 1);
>>         memory_region_init_io(region->mem, obj, &vfio_region_ops,
>>                               region, name, region->size);
> 
> In this way, the vfio hook can easily get the VFIOContainer from
> HostIOMMUContext when call in the hook provided by vfio. e.g. the
> one below.
OK I get it. However in memory_region_init_io(), you also pass the
owner, eg. region so I think you could do the same. no?

Thanks

Eric
> 
> +static int vfio_host_iommu_ctx_pasid_alloc(HostIOMMUContext *iommu_ctx,
> +                                           uint32_t min, uint32_t max,
> +                                           uint32_t *pasid)
> +{
> +    VFIOContainer *container = container_of(iommu_ctx,
> +                                            VFIOContainer, iommu_ctx);
>  
> Regards,
> Yi Liu
> 


