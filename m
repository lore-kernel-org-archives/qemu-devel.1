Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0127DC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509F6206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYupoJ/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509F6206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTM16-00069X-5X
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTM00-0004sJ-OH
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTLzy-0004Pw-UE
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602840365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmavPkUAmT0QodVlZRSDJzeufWODv3tA+oJtokGss7I=;
 b=JYupoJ/A8IJRE+hLEyYsu0M9n/c0JOEGfVfUSLZlpHZl1OwBsPOv2vHDxUDgfGPZcu4vWr
 pJCDa6lULjmgDYLygas4r5CDiN1b7k0gQFykjxBxQoybMXFATLQdn+HewoR0jT1h3RJi81
 oGIggTm0b/dEyc2K6H8ShsK83cWqiu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-NEOJ_toaOBOf_nYSH1MbHA-1; Fri, 16 Oct 2020 05:26:03 -0400
X-MC-Unique: NEOJ_toaOBOf_nYSH1MbHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB60D86ABD1;
 Fri, 16 Oct 2020 09:26:02 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D79D16EF54;
 Fri, 16 Oct 2020 09:25:47 +0000 (UTC)
Subject: Re: [PATCH v10 08/10] vfio: Set IOMMU page size as per host supported
 page size
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-9-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d528d8e1-6148-f9ed-47b6-562aac11d10a@redhat.com>
Date: Fri, 16 Oct 2020 11:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-9-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
> From: Bharat Bhushan <bbhushan2@marvell.com>
> 
> Set IOMMU supported page size mask same as host Linux supported page
> size mask.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/vfio/common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 13471ae2943..e66054b02a7 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -636,6 +636,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                              int128_get64(llend),
>                              iommu_idx);
>  
> +        ret = memory_region_iommu_set_page_size_mask(giommu->iommu,
> +                                                     container->pgsizes,
> +                                                     &err);
> +        if (ret) {
> +            g_free(giommu);
> +            goto fail;
> +        }
> +
>          ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
>                                                      &err);
>          if (ret) {
> 


