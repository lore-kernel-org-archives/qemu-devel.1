Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1D5206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DI1b97D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1D5206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYyl-0002JX-K4
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZYy6-0001tW-CB
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:57:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZYy5-0004kS-5l
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589543851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aUH+TtwSJFbCU3USF38P3lC5oZW0dOM6MBq1iuuUyrA=;
 b=DI1b97D1D7lcsF5uulhxYcLZvQHg2Qly6ldZwFHqBUz2S0sN0SwJ620gmHH9E4EJqfQC1S
 pFU1g0UvieI2+yRPPT4oP7L9JzRY4HHXJfSkx28/4s5Fl3eb9ukAuYCWN1F+30oeHw/2UD
 YcyRngQZMWjUp7KTgDJELrvA2Jp7c28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-B_J2d5_RO2ig6l7tRXwB0w-1; Fri, 15 May 2020 07:57:29 -0400
X-MC-Unique: B_J2d5_RO2ig6l7tRXwB0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6BD7107ACCD;
 Fri, 15 May 2020 11:57:28 +0000 (UTC)
Received: from work-vm (ovpn-114-149.ams2.redhat.com [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C97D660F8D;
 Fri, 15 May 2020 11:57:17 +0000 (UTC)
Date: Fri, 15 May 2020 12:57:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 03/17] accel/kvm: Convert to
 ram_block_discard_set_broken()
Message-ID: <20200515115714.GC2954@work-vm>
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506094948.76388-4-david@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> Discarding memory does not work as expected. At the time this is called,
> we cannot have anyone active that relies on discards to work properly.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  accel/kvm/kvm-all.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 439a4efe52..33421184ac 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -40,7 +40,6 @@
>  #include "trace.h"
>  #include "hw/irq.h"
>  #include "sysemu/sev.h"
> -#include "sysemu/balloon.h"
>  #include "qapi/visitor.h"
>  #include "qapi/qapi-types-common.h"
>  #include "qapi/qapi-visit-common.h"
> @@ -2107,7 +2106,7 @@ static int kvm_init(MachineState *ms)
>  
>      s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
>      if (!s->sync_mmu) {
> -        qemu_balloon_inhibit(true);
> +        g_assert(ram_block_discard_set_broken(true));
>      }
>  
>      return 0;
> -- 
> 2.25.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


