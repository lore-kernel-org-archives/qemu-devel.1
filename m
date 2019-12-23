Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C33C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE90206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epPGXEZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE90206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJoM-0003wU-Mh
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 04:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ijJnM-0003Kh-Kf
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ijJnL-0006tu-GL
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:14:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35565
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ijJnL-0006qb-Bw
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577092470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbQBLxoCEwlwW3ReN5aW2HRPYMTYuCRL7C8tlTZoOLM=;
 b=epPGXEZc4ya6ZEqRa4VjaGvzvoqSEH8hMAfuAXLmu0xl2vBN6moCxNJZUaFwCYr5ed5wGY
 7ViNdSSYmPyWdObnqw1xPfxGZ+vzzZ9CCoHPeWb7q4dEnK4La5TCWfwWaVBA485n9hsWTM
 4LO+XJjMVElECDERnfYOWAzdiXDgVyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-1rjFu8BaP1OQ4D2Lz402PA-1; Mon, 23 Dec 2019 04:14:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4738DB60;
 Mon, 23 Dec 2019 09:14:27 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A0F95D9D6;
 Mon, 23 Dec 2019 09:14:11 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 06/20] virtio-iommu: Implement attach/detach
 command
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-7-eric.auger@redhat.com>
 <20191210164156.GE277340@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <531cb6d7-6a2b-1278-a4d2-f4ea11442967@redhat.com>
Date: Mon, 23 Dec 2019 10:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191210164156.GE277340@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 1rjFu8BaP1OQ4D2Lz402PA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 12/10/19 5:41 PM, Jean-Philippe Brucker wrote:
> On Fri, Nov 22, 2019 at 07:29:29PM +0100, Eric Auger wrote:
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 235bde2203..138d5b2a9c 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -77,11 +77,12 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>>  static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
>>  {
>>      QLIST_REMOVE(ep, next);
>> +    g_tree_unref(ep->domain->mappings);
>>      ep->domain = NULL;
>>  }
>>  
>> -viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_id);
>> -viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_id)
>> +static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>> +                                                  uint32_t ep_id)
>>  {
>>      viommu_endpoint *ep;
>>  
>> @@ -102,15 +103,14 @@ static void virtio_iommu_put_endpoint(gpointer data)
>>  
>>      if (ep->domain) {
>>          virtio_iommu_detach_endpoint_from_domain(ep);
>> -        g_tree_unref(ep->domain->mappings);
>>      }
>>  
>>      trace_virtio_iommu_put_endpoint(ep->id);
>>      g_free(ep);
>>  }
>>  
>> -viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id);
>> -viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id)
>> +static viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s,
>> +                                              uint32_t domain_id)
> 
> Looks like the above change belong to patch 5?
virtio_iommu_get_domain was not used yet in last patch. I turn it into
static now it gets used.
> 
>>  {
>>      viommu_domain *domain;
>>  
>> @@ -137,7 +137,6 @@ static void virtio_iommu_put_domain(gpointer data)
>>      QLIST_FOREACH_SAFE(iter, &domain->endpoint_list, next, tmp) {
>>          virtio_iommu_detach_endpoint_from_domain(iter);
>>      }
>> -    g_tree_destroy(domain->mappings);
> 
> When created by virtio_iommu_get_domain(), mappings has one reference.
> Then for each attach (including the first one) an additional reference is
> taken, and freed by virtio_iommu_detach_endpoint_from_domain(). So I think
> there are two problems:
> 
> * virtio_iommu_put_domain() drops one ref for each endpoint, but we still
>   have one reference to mappings, so they're not freed. We do need this
>   g_tree_destroy()
> 
> * After detaching all the endpoints, the guest may reuse the domain ID for
>   another domain, but the previous mappings haven't been erased. Not sure
>   how to fix this using the g_tree refs, because dropping all the
>   references will free the internal tree data and it won't be reusable.

You're perfectly right, mappings were not destroyed and I missed that.
So I made 2 modifications:
- do not increment the ref count on the first EP addition
- destroy the domain when its EP list get empty.

Thanks

Eric
> 
> Thanks,
> Jean
> 


