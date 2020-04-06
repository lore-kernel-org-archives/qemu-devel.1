Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588BBC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CD6206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIcGVSsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CD6206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOLJ-0001ct-8w
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jLOGP-0001Pm-B3
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jLOGN-00020y-G9
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jLOGM-0001zm-6r
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586166109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBrAFIa3Ym7Ygcf7VeY5ZqN9lSy1hwAZJqT+m4UuBc8=;
 b=DIcGVSsXcu6ANwPhyVBOCYZb5PAb5BzqysP/Bcy2d99+g3dcgBX+fMibfOi2hHHvkAGYKS
 TexSshnezC/X3vJEGI/BcvZWLBTRwO7WM/8MUJcQeyPXu5rS2zq2d+7MdJcWiwoB8d05HA
 D/fmgVhAoulrJOE8hlisuukZ8WXf05E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-EwosemdQOrKFrIAEiLrkjQ-1; Mon, 06 Apr 2020 05:41:47 -0400
X-MC-Unique: EwosemdQOrKFrIAEiLrkjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7790C8017F4;
 Mon,  6 Apr 2020 09:41:46 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCD05B19CB;
 Mon,  6 Apr 2020 09:41:41 +0000 (UTC)
Date: Mon, 6 Apr 2020 11:41:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] s390x/s390-virtio-ccw: Fix build on systems without
 KVM
Message-ID: <20200406114139.78b60cd5.cohuck@redhat.com>
In-Reply-To: <90760b85-ed98-3106-0cc4-900f55607479@de.ibm.com>
References: <20200406075931.26232-1-borntraeger@de.ibm.com>
 <20200406075931.26232-2-borntraeger@de.ibm.com>
 <20200406110447.5ad97f62.cohuck@redhat.com>
 <90760b85-ed98-3106-0cc4-900f55607479@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Bruce Rogers <brogers@suse.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Apr 2020 11:27:13 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06.04.20 11:04, Cornelia Huck wrote:
> > On Mon,  6 Apr 2020 03:59:31 -0400
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> linux/kvm.h is not available on all platforms. Let us move
> >> s390_machine_inject_pv_error into pv.c as it uses KVM structures.
> >>
> >> Fixes: 49fc3220175e ("s390x: protvirt: Support unpack facility")
> >> Reported-by: Bruce Rogers <brogers@suse.com>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  hw/s390x/ipl.h             |  1 +
> >>  hw/s390x/pv.c              | 11 +++++++++++
> >>  hw/s390x/s390-virtio-ccw.c | 10 ----------
> >>  include/hw/s390x/pv.h      |  3 +++
> >>  4 files changed, 15 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> >> index 89b3044d7a..53cc9eb5ac 100644
> >> --- a/hw/s390x/ipl.h
> >> +++ b/hw/s390x/ipl.h
> >> @@ -14,6 +14,7 @@
> >>  #define HW_S390_IPL_H
> >>  
> >>  #include "cpu.h"
> >> +#include "exec/address-spaces.h"  
> > 
> > Hm, what is now requiring including this? (No objection, but I don't
> > see it.)  
> 
> ipl.h has
> 
> static inline bool ipl_valid_pv_header(IplParameterBlock *iplb)
> {
> [..]
>         if (!address_space_access_valid(&address_space_memory,
> 
> and if included alone this fails to build without the include. 
> 

Ah, makes sense.

> 
> >   
> >>  #include "hw/qdev-core.h"
> >>  
> >>  struct IPLBlockPVComp {  
> > 


