Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E9CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BFA206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZpYyu+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BFA206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjk7-0001L0-Pc
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jsjjW-0000uk-Bw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:17:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30733
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jsjjU-0000Vk-Qa
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594113464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DO2/ZW51hsPBPfXCwzXeQqYh9wksrh3wP62XzecrJfg=;
 b=TZpYyu+ytXOw6MG+uUwrAepbOY93jsIXMBSCOkhectCs/72sniVNF/ZXu8g3KfvFZ/slDG
 ctCQZQs2xa59QOkFvqeogJFJlOBPMfUf+ZnG8/JMyLHe0qYlu/n//rsL3M8qlplpmwja9K
 yiBOlo/o/5Eh7h7HMdOPetrJaR1Oapo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207--avu6exBOJWYhNX2BH31RA-1; Tue, 07 Jul 2020 05:17:42 -0400
X-MC-Unique: -avu6exBOJWYhNX2BH31RA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A1A6107ACCA;
 Tue,  7 Jul 2020 09:17:41 +0000 (UTC)
Received: from [10.72.13.254] (ovpn-13-254.pek2.redhat.com [10.72.13.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F09045BAC3;
 Tue,  7 Jul 2020 09:17:33 +0000 (UTC)
Subject: Re: [PATCH] intel_iommu: Use correct shift for 256 bits qi descriptor
To: Liu Yi L <yi.l.liu@intel.com>, peterx@redhat.com
References: <1593850035-35483-1-git-send-email-yi.l.liu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <953608d9-16dc-aa2a-4016-a12fdfd9cc66@redhat.com>
Date: Tue, 7 Jul 2020 17:17:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593850035-35483-1-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/4 下午4:07, Liu Yi L wrote:
> In chapter 10.4.23 of VT-d spec 3.0, Descriptor Width bit was introduced
> in VTD_IQA_REG. Sfotware could set this bit to tell VT-d the QI descriptor


Typo.


> from software would be 256 bits. Accordingly, the VTD_IQH_QH_SHIFT should
> be 5 when descriptor size is 256 bits.
>
> This patch adds the DW bit check when deciding the shift used to update
> VTD_IQH_REG.
>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   hw/i386/intel_iommu.c          | 7 ++++++-
>   hw/i386/intel_iommu_internal.h | 3 ++-
>   2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index df7ad25..8703a2d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2549,6 +2549,11 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>   /* Try to fetch and process more Invalidation Descriptors */
>   static void vtd_fetch_inv_desc(IntelIOMMUState *s)
>   {
> +    int qi_shift;
> +
> +    /* Refer to 10.4.23 of VT-d spec 3.0 */
> +    qi_shift = s->iq_dw ? VTD_IQH_QH_SHIFT_5 : VTD_IQH_QH_SHIFT_4;
> +
>       trace_vtd_inv_qi_fetch();
>   
>       if (s->iq_tail >= s->iq_size) {
> @@ -2567,7 +2572,7 @@ static void vtd_fetch_inv_desc(IntelIOMMUState *s)
>           }
>           /* Must update the IQH_REG in time */
>           vtd_set_quad_raw(s, DMAR_IQH_REG,
> -                         (((uint64_t)(s->iq_head)) << VTD_IQH_QH_SHIFT) &
> +                         (((uint64_t)(s->iq_head)) << qi_shift) &
>                            VTD_IQH_QH_MASK);
>       }
>   }
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 862033e..3d5487f 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -230,7 +230,8 @@
>   #define VTD_IQA_DW_MASK             0x800
>   
>   /* IQH_REG */
> -#define VTD_IQH_QH_SHIFT            4
> +#define VTD_IQH_QH_SHIFT_4          4
> +#define VTD_IQH_QH_SHIFT_5          5
>   #define VTD_IQH_QH_MASK             0x7fff0ULL
>   
>   /* ICS_REG */


