Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C730EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9051620772
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0hfS5Gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9051620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpuH-0002xd-TU
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgpti-0002Xy-EE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:27:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgpth-0004HZ-Bw
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591277224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uzJu2uEpKt1MtBeOPW/VvzZHQio3U35JVuAKtkhcqw=;
 b=O0hfS5GiRsfB7eZBRggYO+ONw4ISe2XcLEXzZtOzI1V4UogE+/8ygJ94yABNSp1zi/L0uv
 +oHaESlEJSgtF1RCjYsWCWx5HZJ80S72QCij94CCeMsXyYd588izl/ftSTUJSY04aidsmA
 nU4jsLwjQYePL3dGXMczc9aB+6tzwbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-3sca0TvVN_C_LShCxgtalQ-1; Thu, 04 Jun 2020 09:27:02 -0400
X-MC-Unique: 3sca0TvVN_C_LShCxgtalQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D826F102CC43;
 Thu,  4 Jun 2020 13:27:01 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D9FD5FC34;
 Thu,  4 Jun 2020 13:26:38 +0000 (UTC)
Date: Thu, 4 Jun 2020 14:26:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
Message-ID: <20200604132635.GG2851@work-vm>
References: <20200604111323.7458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200604111323.7458-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Bennée (alex.bennee@linaro.org) wrote:
> The purpose of vhost_section is to identify RAM regions that need to
> be made available to a vhost client. However when running under TCG
> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
> down the line. The original comment implies VGA regions are a problem
> but doesn't explain why vhost has a problem with it.
> 
> Re-factor the code so:
> 
>   - steps are clearer to follow
>   - reason for rejection is recorded in the trace point
>   - we allow DIRTY_MEMORY_CODE when TCG is enabled

The problem with VGA is that a VGA page can become mapped and unmapped
under the control of the guest; somewhere in a low address.  This tends
to break hugepage mappings.
For vhost-user, and in particular vhost-user-postcopy this means it
fails the mapping on the vhost-user client.

However the other problem is that with vhost-user, the vhost-user client
is changing memory; and won't mark the pages as dirty - except for
migration (I'm not clear if vhost kernel does this).
So TCG won't notice a page that's been changed by the driver; now in
most cases it's rare for a device to be writing directly into a page
you're going to execute out of, but it's not unknown.

So, as it is, any area that's expecting to get non-migration dirty
notifications is going to be disappointed by a vhost-user backend.

Dave

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/vhost.c | 46 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index aff98a0ede5..f81fc87e74c 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -27,6 +27,7 @@
>  #include "migration/blocker.h"
>  #include "migration/qemu-file-types.h"
>  #include "sysemu/dma.h"
> +#include "sysemu/tcg.h"
>  #include "trace.h"
>  
>  /* enabled until disconnected backend stabilizes */
> @@ -403,26 +404,43 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
>      return r;
>  }
>  
> +/*
> + * vhost_section: identify sections needed for vhost access
> + *
> + * We only care about RAM sections here (where virtqueue can live). If
> + * we find one we still allow the backend to potentially filter it out
> + * of our list.
> + */
>  static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
>  {
> -    bool result;
> -    bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
> -                     ~(1 << DIRTY_MEMORY_MIGRATION);
> -    result = memory_region_is_ram(section->mr) &&
> -        !memory_region_is_rom(section->mr);
> -
> -    /* Vhost doesn't handle any block which is doing dirty-tracking other
> -     * than migration; this typically fires on VGA areas.
> -     */
> -    result &= !log_dirty;
> +    enum { OK = 0, NOT_RAM, DIRTY, FILTERED } result = NOT_RAM;
> +
> +    if (memory_region_is_ram(section->mr) && !memory_region_is_rom(section->mr)) {
> +        uint8_t dirty_mask = memory_region_get_dirty_log_mask(section->mr);
> +        uint8_t handled_dirty;
>  
> -    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
> -        result &=
> -            dev->vhost_ops->vhost_backend_mem_section_filter(dev, section);
> +        /*
> +         * Vhost doesn't handle any block which is doing dirty-tracking other
> +         * than migration; this typically fires on VGA areas. However
> +         * for TCG we also do dirty code page tracking which shouldn't
> +         * get in the way.
> +         */
> +        handled_dirty = (1 << DIRTY_MEMORY_MIGRATION);
> +        if (tcg_enabled()) {
> +            handled_dirty |= (1 << DIRTY_MEMORY_CODE);
> +        }
> +        if (dirty_mask & ~handled_dirty) {
> +            result = DIRTY;
> +        } else if (dev->vhost_ops->vhost_backend_mem_section_filter &&
> +            !dev->vhost_ops->vhost_backend_mem_section_filter(dev, section)) {
> +            result = FILTERED;
> +        } else {
> +            result = OK;
> +        }
>      }
>  
>      trace_vhost_section(section->mr->name, result);
> -    return result;
> +    return result == OK;
>  }
>  
>  static void vhost_begin(MemoryListener *listener)
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


