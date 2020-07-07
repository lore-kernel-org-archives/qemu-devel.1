Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E771C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092F82064C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyvmNg1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092F82064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqfx-00034t-AH
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jsqRZ-0007uw-SJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:27:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56639
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jsqRU-0002DN-K5
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594139255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rak1nInpixwt0vVMIfPk/Ds15/HQgJiuh1gi4LKipOQ=;
 b=LyvmNg1FBGuyI1RNNQ8ae2hNNfI3jVfSlL1QBWe22weTnwCdbE7Hc68od0fbeSy7KIqJq6
 AZNbFKPrzHNBAlBs4BPVl6tXGJ9YckQgQa1xnXlYshrfpEnRmEfkIx4kcZjw+wD1XnR7Bz
 QRoVHDU7E51P+HPJGBhuh3NjMi/Guow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-Bg__LXOsOc6E608HNEZCvw-1; Tue, 07 Jul 2020 12:27:31 -0400
X-MC-Unique: Bg__LXOsOc6E608HNEZCvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4431418FE860;
 Tue,  7 Jul 2020 16:27:30 +0000 (UTC)
Received: from starship (unknown [10.35.206.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27B211062246;
 Tue,  7 Jul 2020 16:27:27 +0000 (UTC)
Message-ID: <a483e0a935a9c2d47232a9f7e653e950de525e68.camel@redhat.com>
Subject: Re: [PATCH v4 1/2] nvme: indicate CMB support through controller
 capabilities register
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, kbusch@kernel.org, 
 kwolf@redhat.com, mreitz@redhat.com
Date: Tue, 07 Jul 2020 19:27:26 +0300
In-Reply-To: <20200701214858.28515-2-andrzej.jakowski@linux.intel.com>
References: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
 <20200701214858.28515-2-andrzej.jakowski@linux.intel.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-01 at 14:48 -0700, Andrzej Jakowski wrote:
> This patch sets CMBS bit in controller capabilities register when user
> configures NVMe driver with CMB support, so capabilites are correctly
> reported to guest OS.
> 
> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c      | 2 +-
>  include/block/nvme.h | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 1aee042d4c..9f11f3e9da 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1582,6 +1582,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      NVME_CAP_SET_TO(n->bar.cap, 0xf);
>      NVME_CAP_SET_CSS(n->bar.cap, 1);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
> +    NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
>  
>      n->bar.vs = 0x00010200;
>      n->bar.intmc = n->bar.intms = 0;
> @@ -1591,7 +1592,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      NvmeCtrl *n = NVME(pci_dev);
>      Error *local_err = NULL;
> -
>      int i;
>  
>      nvme_check_constraints(n, &local_err);
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 1720ee1d51..14cf398dfa 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -35,6 +35,7 @@ enum NvmeCapShift {
>      CAP_MPSMIN_SHIFT   = 48,
>      CAP_MPSMAX_SHIFT   = 52,
>      CAP_PMR_SHIFT      = 56,
> +    CAP_CMB_SHIFT      = 57,
>  };
>  
>  enum NvmeCapMask {
> @@ -48,6 +49,7 @@ enum NvmeCapMask {
>      CAP_MPSMIN_MASK    = 0xf,
>      CAP_MPSMAX_MASK    = 0xf,
>      CAP_PMR_MASK       = 0x1,
> +    CAP_CMB_MASK       = 0x1,
>  };
>  
>  #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MASK)
> @@ -78,8 +80,10 @@ enum NvmeCapMask {
>                                                             << CAP_MPSMIN_SHIFT)
>  #define NVME_CAP_SET_MPSMAX(cap, val) (cap |= (uint64_t)(val & CAP_MPSMAX_MASK)\
>                                                              << CAP_MPSMAX_SHIFT)
> -#define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
> +#define NVME_CAP_SET_PMRS(cap, val)   (cap |= (uint64_t)(val & CAP_PMR_MASK)   \
>                                                              << CAP_PMR_SHIFT)
> +#define NVME_CAP_SET_CMBS(cap, val)   (cap |= (uint64_t)(val & CAP_CMB_MASK)   \
> +                                                           << CAP_CMB_SHIFT)
>  
>  enum NvmeCcShift {
>      CC_EN_SHIFT     = 0,


I wonder how this could have beeing forgotten. Hmm.
I see that Linux kernel uses CMBSZ != for that.
I guess this explains it.

Reviewed-by: Maxim Levitsky <mlevitsky@gmail.com>

Best regards,
	Maxim Levitsky



