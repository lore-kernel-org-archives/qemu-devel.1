Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95948C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FC92073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtRbf/+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FC92073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPtX-0007kX-JB
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1isPsh-00078d-HI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1isPsd-0007dT-JW
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:33:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52152
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1isPsd-0007cx-FZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579260814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QuwRKDLp5krrw9QIF7Gb/dDM0E7LLZLPSd/2TUTrTfc=;
 b=GtRbf/+R5L6wkwMPYPlSn7RYyzICDsNBIvlNTNQkfWYFaxgT2iY5Nz5K/KZmOw4G7aCNqP
 DNVnkExyXADhMS2782eBbn6Pra35kk6eTFy+2uN3JaSIRY/tVJkBJ8Ooo5Ms43ExNIP3fD
 htTNVvpZVjny9LCVF6sdrTCg5YAsY2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-D1QB-X9-MQKFXpsZWy6AtQ-1; Fri, 17 Jan 2020 06:33:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31B4D8017CC;
 Fri, 17 Jan 2020 11:33:32 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 251F95D9CD;
 Fri, 17 Jan 2020 11:33:31 +0000 (UTC)
Date: Fri, 17 Jan 2020 12:33:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] s390x: adapter routes error handling
Message-ID: <20200117123328.02498aee.cohuck@redhat.com>
In-Reply-To: <528e1add-6a53-7c55-83a2-f10491be4e4d@de.ibm.com>
References: <20200117111147.5006-1-cohuck@redhat.com>
 <528e1add-6a53-7c55-83a2-f10491be4e4d@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: D1QB-X9-MQKFXpsZWy6AtQ-1
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 12:22:45 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 17.01.20 12:11, Cornelia Huck wrote:
> > If the kernel irqchip has been disabled, we don't want the
> > {add,release}_adapter_routes routines to call any kvm_irqchip_*
> > interfaces, as they may rely on an irqchip actually having been
> > created. Just take a quick exit in that case instead.
> > 
> > Also initialize routes->gsi[] with -1 in the virtio-ccw handling,
> > to make sure we don't trip over other errors, either. (Nobody
> > else uses the gsi array in that structure.)
> > 
> > Fixes: d426d9fba8ea ("s390x/virtio-ccw: wire up irq routing and irqfds")
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> I think it was actually quite good to see an error, because something went wrong
> (kvmirqchip being off). Now the error (crash) was certainly a bad one.
> What happens after this patch?
> To me it _looks_ like every caller of set_guest_notifiers would get the ENOSYS
> and bail out with an error so this should be ok, but it would be good
> to add something to the patch description that says so.
> 
> Something like "instead of crashing we now fail with an error message for vhost
> and friends"
> of course only if this is true.

It should work in the same way as it does for tcg right now (we return
-ENOSYS in the non-kvm flic as well). If you're not using irqfd,
everything will work just fine.

What about the following:

"If you are trying to use irqfd without a kernel irqchip, we will fail
with an error."

?

There probably won't be many people seeing anything like this, as I
guess most people will delegate the irqfd setup to libvirt anyway,
which will not turn off the kernel irqchip.


