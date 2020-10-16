Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95B0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B58B207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fno5eg+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B58B207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKNm-0007ss-Vd
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 03:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKIq-0004dp-Bq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKIo-0000Mu-Mz
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602833845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWQrIQgHsChHzxx+BbuT3qcWsd4BCKNrezWgbVuuVqQ=;
 b=Fno5eg+4nnNAxZ0wm1oPGXc1AgMeMylLUhxkusoSt6Jae2xsbAYJK9x0CeiD+CUetrt/mZ
 5oJS5UZlc85uhUN4uukGHFcFtMu5u7+eLmHfRRZRQF3nBx9Sf/alkcJPYZhR4gmbZKSag0
 qsGAdxVMqtZPywqzXBPA45lSYrRdL4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-u9sy_VniP2GiEMNg_PN45Q-1; Fri, 16 Oct 2020 03:37:24 -0400
X-MC-Unique: u9sy_VniP2GiEMNg_PN45Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D98E257059;
 Fri, 16 Oct 2020 07:37:22 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D9716EF70;
 Fri, 16 Oct 2020 07:37:11 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v10 02/10] virtio-iommu: Store memory region in endpoint
 struct
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-3-jean-philippe@linaro.org>
Message-ID: <8070dd26-b27a-795c-eb87-beac3353d724@redhat.com>
Date: Fri, 16 Oct 2020 09:37:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-3-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, bbhushan2@marvell.com, qemu-devel@nongnu.org,
 peterx@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 10/8/20 7:15 PM, Jean-Philippe Brucker wrote:
> Store the memory region associated to each endpoint into the endpoint
> structure, to allow efficient memory notification on map/unmap.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Acked-by: Eric Auger <eric.auger@redhat.com>

> ---
> Not super confident about the reconstruct_endpoint() change since I
> haven't tested migration yet. Does it make sense?
It sounds good to me. I tested migration with vhost and this works properly.

Eric
> ---
>  hw/virtio/virtio-iommu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 543fbbb24fb..33115e82186 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -49,6 +49,7 @@ typedef struct VirtIOIOMMUDomain {
>  typedef struct VirtIOIOMMUEndpoint {
>      uint32_t id;
>      VirtIOIOMMUDomain *domain;
> +    IOMMUMemoryRegion *iommu_mr;
>      QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
>  } VirtIOIOMMUEndpoint;
>  
> @@ -137,16 +138,19 @@ static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>                                                        uint32_t ep_id)
>  {
>      VirtIOIOMMUEndpoint *ep;
> +    IOMMUMemoryRegion *mr;
>  
>      ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
>      if (ep) {
>          return ep;
>      }
> -    if (!virtio_iommu_mr(s, ep_id)) {
> +    mr = virtio_iommu_mr(s, ep_id);
> +    if (!mr) {
>          return NULL;
>      }
>      ep = g_malloc0(sizeof(*ep));
>      ep->id = ep_id;
> +    ep->iommu_mr = mr;
>      trace_virtio_iommu_get_endpoint(ep_id);
>      g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
>      return ep;
> @@ -927,9 +931,14 @@ static gboolean reconstruct_endpoints(gpointer key, gpointer value,
>      VirtIOIOMMU *s = (VirtIOIOMMU *)data;
>      VirtIOIOMMUDomain *d = (VirtIOIOMMUDomain *)value;
>      VirtIOIOMMUEndpoint *iter;
> +    IOMMUMemoryRegion *mr;
>  
>      QLIST_FOREACH(iter, &d->endpoint_list, next) {
> +        mr = virtio_iommu_mr(s, iter->id);
> +        assert(mr);
> +
>          iter->domain = d;
> +        iter->iommu_mr = mr;
>          g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
>      }
>      return false; /* continue the domain traversal */
> 


