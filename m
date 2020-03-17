Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC798C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941C7206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRMpEaPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941C7206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42561 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELBY-00047x-OU
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 18:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jELA7-0001pk-Nc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jELA6-0008J1-If
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:58:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jELA6-0008E3-Du
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584485893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhwQF5g8vG2X3J3654SVthC/nc05aSSF8QisVT3uV0k=;
 b=VRMpEaPrFxLI65XNWGXBixzy87SiOoF8OKx497rHwriRlExeTCbnPCnjfe/6Y9Hgck3/DX
 grPvraUuXrhK4spjwagi7aAsZ4WY+0QTSFr2U6gRS3RjHrQ54dDLt6KONMQ3LnHrPjdYlh
 V2pPH8DyR3uGWatakKFKqr8ecwvSRoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-zDAaM1DuP72MYb8rp4R8fw-1; Tue, 17 Mar 2020 18:58:12 -0400
X-MC-Unique: zDAaM1DuP72MYb8rp4R8fw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D6C18B6381
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 22:58:11 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6ADE473873;
 Tue, 17 Mar 2020 22:58:05 +0000 (UTC)
Date: Tue, 17 Mar 2020 16:58:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 3/5] KVM: Pass EventNotifier into
 kvm_irqchip_assign_irqfd
Message-ID: <20200317165805.28a9bfce@w520.home>
In-Reply-To: <20200317195042.282977-4-peterx@redhat.com>
References: <20200317195042.282977-1-peterx@redhat.com>
 <20200317195042.282977-4-peterx@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 15:50:40 -0400
Peter Xu <peterx@redhat.com> wrote:

> So that kvm_irqchip_assign_irqfd() can have access to the
> EventNotifiers, especially the resample event.  It is needed in follow
> up patch to cache and kick resamplefds from QEMU.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 439a4efe52..d49b74512a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1628,9 +1628,13 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
>      return kvm_update_routing_entry(s, &kroute);
>  }
>  
> -static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int rfd, int virq,
> +static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
> +                                    EventNotifier *resample, int virq,
>                                      bool assign)
>  {
> +    int fd = event_notifier_get_fd(event);
> +    int rfd = resample ? event_notifier_get_fd(resample) : -1;
> +
>      struct kvm_irqfd irqfd = {
>          .fd = fd,
>          .gsi = virq,
> @@ -1735,7 +1739,9 @@ int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32_t vcpu, uint32_t sint)
>      return -ENOSYS;
>  }
>  
> -static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int virq, bool assign)
> +static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
> +                                    EventNotifier *resample, int virq,
> +                                    bool assign)
>  {
>      abort();
>  }
> @@ -1749,15 +1755,13 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg)
>  int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
>                                         EventNotifier *rn, int virq)
>  {
> -    return kvm_irqchip_assign_irqfd(s, event_notifier_get_fd(n),
> -           rn ? event_notifier_get_fd(rn) : -1, virq, true);
> +    return kvm_irqchip_assign_irqfd(s, n, rn, virq, true);
>  }
>  
>  int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
>                                            int virq)
>  {
> -    return kvm_irqchip_assign_irqfd(s, event_notifier_get_fd(n), -1, virq,
> -           false);
> +    return kvm_irqchip_assign_irqfd(s, n, NULL, virq, false);
>  }
>  
>  int kvm_irqchip_add_irqfd_notifier(KVMState *s, EventNotifier *n,


