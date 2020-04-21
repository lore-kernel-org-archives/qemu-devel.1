Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B455FC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839C92084D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTCYtXy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839C92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQoIp-0006gS-O5
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jQoHt-00060U-U1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jQoHr-0004uf-Fh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:29:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jQoHq-0004pw-S1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587457785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRMYN7CIs0pAKBhamwvbihiYtE6DgFdpHTC0hECnLuA=;
 b=MTCYtXy+T1nDvwaAkghBZdD6aFNg3lCTU3Xx+/GYr6f6sYKi6HVIJEPHlgyQwyZmDVq+dK
 L7GVizTC2aHQ1o71jlvZFn1KxshAYyz3KjfoMx2Z9gDy6upM7ge8uxXVFarJMTtWX2uk8l
 FxzKc5+fN5UbHiXpxavnCALuG8UlP+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-AZWfMrv9PFakLUbqsD_uUg-1; Tue, 21 Apr 2020 04:29:43 -0400
X-MC-Unique: AZWfMrv9PFakLUbqsD_uUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 414DB1050908;
 Tue, 21 Apr 2020 08:29:42 +0000 (UTC)
Received: from gondolin (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15E3C60C63;
 Tue, 21 Apr 2020 08:29:40 +0000 (UTC)
Date: Tue, 21 Apr 2020 10:29:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jared Rossi <jrossi@linux.ibm.com>
Subject: Re: [PATCH 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
Message-ID: <20200421102937.511fde3a.cohuck@redhat.com>
In-Reply-To: <2fe2e12dee1799afee088bed88e6c671@linux.vnet.ibm.com>
References: <20200417183838.11796-1-jrossi@linux.ibm.com>
 <20200417183838.11796-2-jrossi@linux.ibm.com>
 <20200420142617.5e255265.cohuck@redhat.com>
 <20200420142917.206d36a5.cohuck@redhat.com>
 <2fe2e12dee1799afee088bed88e6c671@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Apr 2020 18:35:58 -0400
Jared Rossi <jrossi@linux.ibm.com> wrote:

> On 2020-04-20 08:29, Cornelia Huck wrote:
> > On Mon, 20 Apr 2020 14:26:17 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> On Fri, 17 Apr 2020 14:38:38 -0400
> >> Jared Rossi <jrossi@linux.ibm.com> wrote:
> >>   
> >> > Remove the explicit prefetch check when using vfio-ccw devices.
> >> > This check is not needed as all Linux channel programs are intended
> >> > to use prefetch and will be executed in the same way regardless.  
> >> 
> >> As already commented on the Linux patch: Can we log something, so this
> >> is debuggable if this statement does not hold true in the future?
> >>   
> 
> Agreed.  I will work on debugging improvements so that any future issues
> related to unintended prefetching are more clearly logged.

Great.

> 
> >> >
> >> > Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> >> > ---
> >> >  hw/vfio/ccw.c | 13 +++----------
> >> >  1 file changed, 3 insertions(+), 10 deletions(-)
> >> >
> >> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> >> > index 50cc2ec75c..e649377b68 100644
> >> > --- a/hw/vfio/ccw.c
> >> > +++ b/hw/vfio/ccw.c
> >> > @@ -74,16 +74,9 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
> >> >      struct ccw_io_region *region = vcdev->io_region;
> >> >      int ret;
> >> >
> >> > -    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
> >> > -        if (!(vcdev->force_orb_pfch)) {
> >> > -            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
> >> > -            sch_gen_unit_exception(sch);
> >> > -            css_inject_io_interrupt(sch);
> >> > -            return IOINST_CC_EXPECTED;
> >> > -        } else {
> >> > -            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> >> > -            warn_once_pfch(vcdev, sch, "PFCH flag forced");
> >> > -        }
> >> > +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH) && vcdev->force_orb_pfch) {
> >> > +        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> >> > +        warn_once_pfch(vcdev, sch, "PFCH flag forced");
> >> >      }  
> >> 
> >> What happens when you run it with an old kernel? I guess the I/O is
> >> only rejected later (after a trip into the kernel), but has that path
> >> ever been tested?
> >>   
> 
> Yes, this was tested and you are correct that the kernel will reject the 
> I/O unless
> the corresponding patch is also applied there.  I will revisit this path 
> while I'm
> updating the logging to ensure that any potential interactions are 
> appropriately
> considered.

I've looked at the code again and it seems that the kernel will end up
signaling -EOPNOTSUPP to us on that case, which causes the same unit
exception as without this patch, so we should be all good.

> 
> >> >
> >> >      QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));  
> >>   
> > 
> > Oh, and do we want to deprecate the force prefetch interface in the
> > future? We probably need to wait a bit, until the kernel changes have
> > become widely available.  
> 
> Yes, I think we will want to deprecate it at an appropriate time in the 
> future.
> 


