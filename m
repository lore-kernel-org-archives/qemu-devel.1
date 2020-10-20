Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5052225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD+bkNYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5052225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUkNu-0002Tx-Dp
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 01:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kUkMR-0001hH-Rf
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kUkMP-0006tm-U2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603172340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpI1dhsWpczPWuV3yvdSWxCsTeDsiTNPP6hl0+c3rwE=;
 b=XD+bkNYatRH8uT3Wv6UJXsCnr6G/obSNVk3v2b6m2xTOrrP1QrWnVBJcqMxaR8JD9YQa9y
 mqubJui6Y04AFOAlFLhVjojUq01bp2P8DJ6Z1fJk9I/f/s6r5hiRHKefbN3LfJIzSOq0Pv
 loE8G5geyPoIsjIM97SOmCs49nrNsds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-H9kDbi8kNxeNLM5h0KYxKQ-1; Tue, 20 Oct 2020 01:38:59 -0400
X-MC-Unique: H9kDbi8kNxeNLM5h0KYxKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25E70803F48
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 05:38:58 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C270621E93;
 Tue, 20 Oct 2020 05:38:47 +0000 (UTC)
Subject: Re: [PATCH] intel_iommu: Fix two misuse of "0x%u" prints
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20201019173922.100270-1-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <221c9c8f-4f0f-f253-0214-5924f0cf9761@redhat.com>
Date: Tue, 20 Oct 2020 13:38:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019173922.100270-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/20 上午1:39, Peter Xu wrote:
> Dave magically found this.  Fix them with "0x%x".
>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 749eb6ad63..70ac837733 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2665,7 +2665,7 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>   
>       if (addr + size > DMAR_REG_SIZE) {
>           error_report_once("%s: MMIO over range: addr=0x%" PRIx64
> -                          " size=0x%u", __func__, addr, size);
> +                          " size=0x%x", __func__, addr, size);
>           return (uint64_t)-1;
>       }
>   
> @@ -2716,7 +2716,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>   
>       if (addr + size > DMAR_REG_SIZE) {
>           error_report_once("%s: MMIO over range: addr=0x%" PRIx64
> -                          " size=0x%u", __func__, addr, size);
> +                          " size=0x%x", __func__, addr, size);
>           return;
>       }
>   


Acked-by: Jason Wang <jasowang@redhat.com>



