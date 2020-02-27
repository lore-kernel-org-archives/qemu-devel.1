Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6D8C35DF1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6992469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T48HS+gX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6992469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MYl-0000w8-SV
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7MXe-0007wT-4H
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7MXZ-0008I6-37
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:01:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7MXY-0008Hy-Ts
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582822896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTcBXs77dItMi0gGpDFVZ3JqoJwYy1OdCcQ8c+utpZc=;
 b=T48HS+gXq1cOqGtwqUjOHzxfrLvoZY7JxfM7jTlFXkDpniBG1o+XCFQEQRZLhXLRa5TT8x
 J1OzyEK0+saUXWFJ2uaPHtIstb1jXnxw4v4JH1DH+P1LuTyHyeZ4MBD9a/ZhGrJGueAb/L
 xmw1QRoce/DK9XD6GgoWbvVBeWqCme4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-Zzd7rfcANGivsfquT4EGYg-1; Thu, 27 Feb 2020 12:01:33 -0500
X-MC-Unique: Zzd7rfcANGivsfquT4EGYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD49E801E53
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 17:01:32 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F79F60BE2;
 Thu, 27 Feb 2020 17:01:25 +0000 (UTC)
Subject: Re: [PATCH 3/5] KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200226225457.217014-1-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8fd8a9ca-7be0-72f6-04b7-6a92be73f179@redhat.com>
Date: Thu, 27 Feb 2020 18:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200226225457.217014-1-peterx@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/26/20 11:54 PM, Peter Xu wrote:
> So that kvm_irqchip_assign_irqfd() can have access to the
> EventNotifiers, especially the resample event.  It is needed in follow
> up patch to cache and kick resamplefds from QEMU.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  accel/kvm/kvm-all.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
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
> 


