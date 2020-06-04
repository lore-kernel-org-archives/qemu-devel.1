Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB82C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71950206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7o9vKAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71950206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgnzr-0000ni-Mw
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgnzF-0008HK-Lp
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:24:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgnzE-0000Ts-Ak
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591269878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/o631B2lITPt+C5VdirfXThUiTwSIMCPOFIklNwqam8=;
 b=B7o9vKAYEBTkO6Z2N99o95cKRHnFDLFqgtAWFURtGhfpBzOv3J2YVYHRFh70EHGbCyABvH
 6ZAj4/fq6Ouqgt8XvWwOrlW43nuaAWBVvu3djR5LWchlTHZJ8TuwFRavNfQVM3JgRZFf+9
 dsVkRqrMceUqQ++XsAw/ql+SH7dOFww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-T044R9vAMPiGMOZccPxdqw-1; Thu, 04 Jun 2020 07:24:36 -0400
X-MC-Unique: T044R9vAMPiGMOZccPxdqw-1
Received: by mail-wm1-f70.google.com with SMTP id y202so1708071wmd.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5XRlFwJSDT8DLADvgfXs7Un8uF4hShi1/571hutYCxo=;
 b=AVPFrq3lc49YNlRxxcFXnuQygfcW2z0ypG+7aT7qdmUseRG0XyTHYvBlAluzMnckFe
 Q/zHAhvxKLm/9wLdwBMu99IBsItJ6pIPOoWegiGSI88zxLqe8Kmov9rZt/bAaLlv6i5g
 Qtz+sUkGelcpARWyKlDfcS1ZdkP7gU14RNgg7ojS7+NQJKVgBa4166BXapOI/hCYWIsT
 e1AyDyvGhyd2Q6+WX85bpcJIbRLHlC7ClVXKWHzhO7mjctfZ4zpmkL0gc2+fR8hZcDMT
 HICpktRk+0le764gOa2ZvxQwoa7W1kvTeG6+EfZtahQ0A8O3vAE6iYkwy2/+hxuI0SkN
 kuUw==
X-Gm-Message-State: AOAM530xzw6WsNtZtUxRLjf97NvcLMQ90gHx61dBqIlkGtZ/AsTmvbbF
 oz6W8ebueyZSyDS8ndbdexNOSyzP3Jn8VNpTptMpBmp5oHSDV7R28RGv07lbk39r+g8s6wVKUSW
 +mmVrOwPWY8ZcF8c=
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr3913490wru.15.1591269875707;
 Thu, 04 Jun 2020 04:24:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuNYM7aTmU7YsR4ZnOdi32wlVWiZiRrRnfKj8BEX7r+11A58BsUoXrFANWhZ4vHMiJ50ui8g==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr3913471wru.15.1591269875497;
 Thu, 04 Jun 2020 04:24:35 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id h18sm7324314wru.7.2020.06.04.04.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:24:35 -0700 (PDT)
Date: Thu, 4 Jun 2020 07:24:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
Message-ID: <20200604071504-mutt-send-email-mst@kernel.org>
References: <20200604111323.7458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200604111323.7458-1-alex.bennee@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 12:13:23PM +0100, Alex Bennée wrote:
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
> 
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

I'm not sure what does this enum buy us as compared to bool.
Also why force OK to 0?
And I prefer an explicit "else result = NOT_RAM" below
instead of initializing it here.

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

So DIRTY_MEMORY_CODE is only set by TCG right? Thus I'm guessing
we can just allow this unconditionally.


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


