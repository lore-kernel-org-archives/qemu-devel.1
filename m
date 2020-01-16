Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37E6C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C121C20684
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAykswsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C121C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6Qy-0002s5-VX
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1is6Py-0002BU-HJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1is6Pu-0007qm-M0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:46:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1is6Pu-0007oZ-De
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579185996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wo3X+mwbCldy9TllO7IBoTld/SFShJmHHIv1j9C85R8=;
 b=WAykswsJR6Q4ns3GVvp4DoB2Di7Fee13EYisNDhIcGkJUgDMTNIZ5YmKSochyU358J4zBJ
 NDgsA1Ti999R28KPvr7WDKe/MM4+gT/XR+uf06AEdnoYWEGp4ahaRK0gJ4E2OaqYqFPpjA
 KNQj3ub8gIkVyaSzWRTOD+Sid7dUx0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-UErNve06MHO82WJ3_B2lUA-1; Thu, 16 Jan 2020 09:46:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8112100F7A5;
 Thu, 16 Jan 2020 14:46:31 +0000 (UTC)
Received: from gondolin (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64E4B89D1D;
 Thu, 16 Jan 2020 14:46:27 +0000 (UTC)
Date: Thu, 16 Jan 2020 15:46:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] s390x/flic: adapter routes handling if !kernel_irqchip
Message-ID: <20200116154624.697c2c92.cohuck@redhat.com>
In-Reply-To: <57df7c9b-ddd7-3a7a-1113-91f7c1355d10@redhat.com>
References: <20200116123703.14624-1-cohuck@redhat.com>
 <57df7c9b-ddd7-3a7a-1113-91f7c1355d10@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UErNve06MHO82WJ3_B2lUA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 13:52:21 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 16/01/2020 13.37, Cornelia Huck wrote:
> > If the kernel irqchip has been disabled, we don't want the
> > {add,release}_adapter_routes routines to call any kvm_irqchip_*
> > interfaces, as they may rely on an irqchip actually having been
> > created. Just take a quick exit in that case instead.
> > 
> > Fixes: d426d9fba8ea ("s390x/virtio-ccw: wire up irq routing and irqfds")
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > Without this patch, QEMU with kernel_irqchip=off will crash in
> > kvm_irqchip_release_virq(), so alternatively, we could add a check
> > there. kvm_irqchip_add_adapter_route() is actually fine.
> > 
> > ---
> >  hw/intc/s390_flic_kvm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> > index dddd33ea61c8..44b7960ebcc8 100644
> > --- a/hw/intc/s390_flic_kvm.c
> > +++ b/hw/intc/s390_flic_kvm.c
> > @@ -331,6 +331,10 @@ static int kvm_s390_add_adapter_routes(S390FLICState *fs,
> >      int ret, i;
> >      uint64_t ind_offset = routes->adapter.ind_offset;
> >  
> > +    if (!kvm_gsi_routing_enabled()) {
> > +        return -ENOSYS;
> > +    }  
> 
> As you wrote, this check is not really necessary since it is already
> done in  kvm_irqchip_add_adapter_route() ...

I do think it is cleaner, though.

> 
> >      for (i = 0; i < routes->num_routes; i++) {
> >          ret = kvm_irqchip_add_adapter_route(kvm_state, &routes->adapter);
> >          if (ret < 0) {  
> 
> ... so I wonder if it would be simply best to set
> 
>                routes->gsi[i] = -1;
> 
> before the "goto" instead to make sure that
> kvm_s390_release_adapter_routes() does not try to clean it up? That
> would also fix a potential crash in case kvm_irqchip_add_adapter_route()
> returned an error code in case of a different problem, I think.

I think we should pre-initialize gsi[] to -1 instead, just to be on the
safe side.


