Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F087C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A74E20738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPySPzZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A74E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgt6e-0008M9-JI
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgt5x-0007aK-3P
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:51:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgt5v-0004T6-KN
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591289514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ysu3zAawDea7FzfKbmAnDI1iTckGkkQ0JPoWLyYtwT8=;
 b=VPySPzZqPZT0MMOvf9m/WMYMydTfizqYXyFdapwJw/fXS/gDmK3oLjFzvLTWKFuORUjuzX
 2BY3zlpRZc5vO2GhjvNlYxR7oC2fnGZ9RhT0/OVKtGpRn4Okn7lifuFGfGjd/3SuNoUsjH
 YPwsUyWI0hImAZJyqpwCzGfGnHVH++I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-L7Ca3ZKnPLiSfFuY8txQ4w-1; Thu, 04 Jun 2020 12:51:52 -0400
X-MC-Unique: L7Ca3ZKnPLiSfFuY8txQ4w-1
Received: by mail-wr1-f72.google.com with SMTP id w4so2662250wrl.13
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 09:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=UEwZwmfjqjs4w80kMV6pN2r3pl5nLlWbrk+/wk7Kyug=;
 b=iqbvfZiCC6mrUtfxON7ufU5at7OKGRcV6wQjnw92EcnS244mL1nVJ4S+/qvA2VNywo
 bZodoALfJ4zdjyZXRt4ikuZMwjD7ENWcxRAb2Alhx0w4E2nAlbUfKPp07CzTkq8fXXxf
 6BHv+CjMHVa3d5JPLN7piYSwyk5cg0wufbFZVMjxJ0yNcMYWyOP4O/qHFy40S3Zu3Ygr
 R8iAriOFUClWOdlaYlT8U1kDadQnZSKBWlAMXbQohilF5njFEMoFGtayW5X0UkCB4neS
 YrCnD2VH71GnozG08FAc9Ne3kaa2PQab1aCr9jkmE7aivrBEJQUg6s3w5Bu6cG2RJX7Z
 RnkQ==
X-Gm-Message-State: AOAM533B0xUGg1T3+cD+bt4RaFVg1rkNoCbqfQhih/yM8xMWk0UwVRaG
 pWnizI1g+xX1pWplS5w0TbLCdwSOhEAKJciVklI09dmH2V3gawXMG4ezrs2AcVz4cYppShFj7R+
 HTNJ3nF21C78+H7A=
X-Received: by 2002:adf:a507:: with SMTP id i7mr5862566wrb.0.1591289511432;
 Thu, 04 Jun 2020 09:51:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwOZtv+3IwL2C4iJRXIdCW8ejo8nKuE3fNt6wucHXmSntgwYixqp7CGzQy4+KRK7PZgQPbKw==
X-Received: by 2002:adf:a507:: with SMTP id i7mr5862548wrb.0.1591289511188;
 Thu, 04 Jun 2020 09:51:51 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 1sm7965881wms.25.2020.06.04.09.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 09:51:50 -0700 (PDT)
Date: Thu, 4 Jun 2020 12:51:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
Message-ID: <20200604125041-mutt-send-email-mst@kernel.org>
References: <20200604134022.10564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200604134022.10564-1-alex.bennee@linaro.org>
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

On Thu, Jun 04, 2020 at 02:40:22PM +0100, Alex Bennée wrote:
> The purpose of vhost_section is to identify RAM regions that need to
> be made available to a vhost client. However when running under TCG
> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
> down the line.
> 
> Re-factor the code so:
> 
>   - steps are clearer to follow
>   - reason for rejection is recorded in the trace point
>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
> 
> We expand the comment to explain that kernel based vhost has specific
> support for migration tracking.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> 
> ---
> v2
>   - drop enum, add trace_vhost_reject_section
>   - return false at any fail point
>   - unconditionally add DIRTY_MEMORY_CODE to handled cases
>   - slightly re-word the explanatory comment and commit message
> ---
>  hw/virtio/vhost.c      | 55 ++++++++++++++++++++++++++++++------------
>  hw/virtio/trace-events |  3 ++-
>  2 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index aff98a0ede5..120c0cc747b 100644
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
> @@ -403,26 +404,48 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
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
> +    MemoryRegion *mr = section->mr;
> +
> +    if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> +        uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
> +        uint8_t handled_dirty;
> +
> +        /*
> +         * Kernel based vhost doesn't handle any block which is doing
> +         * dirty-tracking other than migration for which it has
> +         * specific logging support. However for TCG the kernel never
> +         * gets involved anyway so we can also ignore it's
> +         * self-modiying code detection flags.
> +         */
> +        handled_dirty = (1 << DIRTY_MEMORY_MIGRATION);
> +        handled_dirty |= (1 << DIRTY_MEMORY_CODE);

I'd just rewrite it in a single statement:

         handled_dirty = (1 << DIRTY_MEMORY_MIGRATION) |
                         (1 << DIRTY_MEMORY_CODE);


>  
> -    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
> -        result &=
> -            dev->vhost_ops->vhost_backend_mem_section_filter(dev, section);
> -    }
> +        if (dirty_mask & ~handled_dirty) {
> +            trace_vhost_reject_section(mr->name, 1);
> +            return false;
> +        }
> +
> +        if (dev->vhost_ops->vhost_backend_mem_section_filter &&
> +            !dev->vhost_ops->vhost_backend_mem_section_filter(dev, section)) {
> +            trace_vhost_reject_section(mr->name, 2);
> +            return false;
> +        }
>  
> -    trace_vhost_section(section->mr->name, result);
> -    return result;
> +        trace_vhost_section(mr->name);
> +        return true;
> +    } else {
> +        trace_vhost_reject_section(mr->name, 3);
> +        return false;
> +    }
>  }
>  
>  static void vhost_begin(MemoryListener *listener)
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 84ecb85d445..22427126b97 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -5,7 +5,8 @@ vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
>  vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
>  vhost_region_add_section_merge(const char *name, uint64_t new_size, uint64_t gpa, uint64_t owr) "%s: size: 0x%"PRIx64 " gpa: 0x%"PRIx64 " owr: 0x%"PRIx64
>  vhost_region_add_section_aligned(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
> -vhost_section(const char *name, int r) "%s:%d"
> +vhost_section(const char *name) "%s"
> +vhost_reject_section(const char *name, int d) "%s:%d"
>  vhost_iotlb_miss(void *dev, int step) "%p step %d"

Looks good otherwise, thanks!


>  # vhost-user.c
> -- 
> 2.20.1


