Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B66C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73112078C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsrDriHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73112078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdqC7-0006Fv-Se
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 03:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jdqBU-0005pR-Fm
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:09:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jdqBS-0005pS-Ea
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590563340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRZolJFb81RjPv+UoVfVYyduR2SKxLbtN26DcNQnWoQ=;
 b=HsrDriHIvKUwgRQKUAWwX56Q7bYjivAJqg14IO/sofsh9faIPBdeNKalpJnNM0/uuYUD9M
 HuwFJJykNNAZgrNoWolVhiluO6qJ7FjJazy1bzxO+uOJqj04td/b2I5e1TEdgpj+yDctIg
 O1JuSXwF4S3dhPCk3GnxKXVe0Y7Xw3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-V3X6eniLNXWPnM3WGQ97AQ-1; Wed, 27 May 2020 03:08:58 -0400
X-MC-Unique: V3X6eniLNXWPnM3WGQ97AQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80F428018A2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:08:57 +0000 (UTC)
Received: from [10.36.113.56] (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D7F912A4D;
 Wed, 27 May 2020 07:08:50 +0000 (UTC)
Subject: Re: [PATCH] hw/vfio/common: Trace in which mode a IOMMU is opened
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200526173542.28710-1-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6c7c445d-0335-f67d-bb72-5b0c046bb247@redhat.com>
Date: Wed, 27 May 2020 09:08:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200526173542.28710-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 5/26/20 7:35 PM, Philippe Mathieu-Daudé wrote:
> One might want to check which IOMMU version the host kernel
> provide. Add a trace event to see in which mode we opened
> our container.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/vfio/common.c     | 19 ++++++++++++++-----
>  hw/vfio/trace-events |  1 +
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b3593b3c0..6b69a259c1 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1157,15 +1157,24 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>  static int vfio_get_iommu_type(VFIOContainer *container,
>                                 Error **errp)
>  {
> -    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> -                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
> +    static const struct {
> +        int type;
> +        const char *name;
> +    } iommu[] = {
> +        {VFIO_TYPE1v2_IOMMU, "Type1 (v2)"},
> +        {VFIO_TYPE1_IOMMU, "Type1 (v1)"},
> +        {VFIO_SPAPR_TCE_v2_IOMMU, "sPAPR TCE (v2)"},
> +        {VFIO_SPAPR_TCE_IOMMU, "sPAPR TCE (v1)"}
> +    };
>      int i;
>  
> -    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
> -        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
> -            return iommu_types[i];
> +    for (i = 0; i < ARRAY_SIZE(iommu); i++) {
> +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type)) {
> +            trace_vfio_get_iommu_type(iommu[i].type, iommu[i].name);
Just wondering why you want to trace the type as you now have the name
string.
> +            return iommu[i].type;
>          }
>      }
> +    trace_vfio_get_iommu_type(-1, "Not available or not supported");
nit: from a debugging pov, this may be not needed as
vfio_get_group/vfio_connect_container() fails and this leads to an error
output.

Thanks

Eric
>      error_setg(errp, "No available IOMMU models");
>      return -EINVAL;
>  }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index b1ef55a33f..8166c4c50d 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -115,6 +115,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>  vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>  vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
>  vfio_dma_unmap_overflow_workaround(void) ""
> +vfio_get_iommu_type(int iommu_type, const char *iommu_name) "IOMMU type %d (%s)"
>  
>  # platform.c
>  vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
> 


