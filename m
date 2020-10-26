Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0945FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A137221FC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hm/5K3Fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A137221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5h9-0003tW-Tu
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX5fu-00033w-6R
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX5fs-0004BW-54
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603730925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmthL5xFYt5IEmXdKZ0ZLiK5WyjOs8XL/2G3//gLWlc=;
 b=Hm/5K3Fyoo7VdlOh6tQyzyttBWu1+SzBwE1kVO5tiL09Eq91vAjaOlZ5ky3eiCFsCq43cW
 JLhbtZ7rqUYa6Mv7LvX4e/F66znCb42Lyq6ufZVKZPSksGLd0SGTedPNa60aLYcMeig+xH
 4UIMWESUD2j88mL8eZHqCoIUX7gmcdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-tTlntj1mNMeeRhwCAJBBOg-1; Mon, 26 Oct 2020 12:48:38 -0400
X-MC-Unique: tTlntj1mNMeeRhwCAJBBOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEC66AF7B6;
 Mon, 26 Oct 2020 16:48:13 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C1A12C250;
 Mon, 26 Oct 2020 16:47:48 +0000 (UTC)
Date: Mon, 26 Oct 2020 10:47:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>, <pbonzini@redhat.com>
Subject: Re: [PATCH v29 10/17] memory: Set DIRTY_MEMORY_MIGRATION when IOMMU
 is enabled
Message-ID: <20201026104748.589b207d@w520.home>
In-Reply-To: <1603704987-20977-11-git-send-email-kwankhede@nvidia.com>
References: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
 <1603704987-20977-11-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo,

Any objection to this change?  Thanks,

Alex

On Mon, 26 Oct 2020 15:06:20 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> mr->ram_block is NULL when mr->is_iommu is true, then fr.dirty_log_mask
> wasn't set correctly due to which memory listener's log_sync doesn't
> get called.
> This patch returns log_mask with DIRTY_MEMORY_MIGRATION set when
> IOMMU is enabled.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  softmmu/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 403ff3abc99b..94f606e9d9d9 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1792,7 +1792,7 @@ bool memory_region_is_ram_device(MemoryRegion *mr)
>  uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
>  {
>      uint8_t mask = mr->dirty_log_mask;
> -    if (global_dirty_log && mr->ram_block) {
> +    if (global_dirty_log && (mr->ram_block || memory_region_is_iommu(mr))) {
>          mask |= (1 << DIRTY_MEMORY_MIGRATION);
>      }
>      return mask;


