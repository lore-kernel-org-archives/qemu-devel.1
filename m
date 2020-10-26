Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF2C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7423206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um5b2W/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7423206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5vI-0007e4-Ej
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX5uF-0006s8-DD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX5uD-0006Db-Rv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603731817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7sZbkqlV2qLM4L4n5gB6iixRF31pMjYTmnSrlXB7BM=;
 b=Um5b2W/wU0InQpDFIibdAUfWxthOMqAXgrFFXgI68U5jErO3gxsHo1Z/HRsLJtW7z3mMuo
 +taOO2MepfHBlbJuiA+CZMQezPMn5OYQj4EzKtUi276z0M34KMAo3T8PI5X2RGdfnP2m11
 QPDJo4aY3ulTLaDZd9q+YsZxG5xGEkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-zxx_lJ8sPmaTTlQoQskiPA-1; Mon, 26 Oct 2020 13:03:35 -0400
X-MC-Unique: zxx_lJ8sPmaTTlQoQskiPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA2C6A0CC9;
 Mon, 26 Oct 2020 17:03:33 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 511B775141;
 Mon, 26 Oct 2020 17:03:31 +0000 (UTC)
Subject: Re: [PATCH] [RFC] hw/arm/smmuv3: Set the restoration priority of the
 vSMMUv3 explicitly
To: Zenghui Yu <yuzenghui@huawei.com>, peter.maydell@linaro.org
References: <20201019091508.197-1-yuzenghui@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8afdbde3-5b5f-0237-d311-32974cf58a14@redhat.com>
Date: Mon, 26 Oct 2020 18:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201019091508.197-1-yuzenghui@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: wanghaibin.wang@huawei.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zenghui,

On 10/19/20 11:15 AM, Zenghui Yu wrote:
> Ensure the vSMMUv3 will be restored before all PCIe devices so that DMA
> translation can work properly during migration.

Sorry I missed this patch. good catch!

Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> not sure if anything would actually go wrong...
> 
>  hw/arm/smmuv3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0122700e72..2017ba7a5a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1440,6 +1440,7 @@ static const VMStateDescription vmstate_smmuv3 = {
>      .name = "smmuv3",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .priority = MIG_PRI_IOMMU,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(features, SMMUv3State),
>          VMSTATE_UINT8(sid_size, SMMUv3State),
> 


