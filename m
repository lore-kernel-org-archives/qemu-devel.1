Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E793C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DD02072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeoXXNZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DD02072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLhk3-0001Xo-6S
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 02:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jLhjL-000158-5B
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jLhjI-00037l-T7
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:29:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jLhjI-00037T-PK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586240940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WbJK/XYV0ji7AjqpX9r+SriSjaKLc9ONkc4j4QZu4o=;
 b=MeoXXNZuaFZ6hslbj/sSTkpxqcDh2yOcrw0BYwC1/qZyZgir2PkvQGw3cI766ArFr5Ir9S
 9x85fm9KqsXtOL4/ryL0F2FYxgSv5LFBOpsOjHl2l1lEGNemIBLhlo/4OPUt1Hvn80T4Pf
 0kZb9mXVMhYFgoM9UVrgMMQ7zvyiJYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-iAWxVcDMM3aM-qCvlqk9ow-1; Tue, 07 Apr 2020 02:28:57 -0400
X-MC-Unique: iAWxVcDMM3aM-qCvlqk9ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6324FDB61;
 Tue,  7 Apr 2020 06:28:56 +0000 (UTC)
Received: from gondolin (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB46B50C01;
 Tue,  7 Apr 2020 06:28:54 +0000 (UTC)
Date: Tue, 7 Apr 2020 08:28:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/7] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL
 for EIO
Message-ID: <20200407082851.5cc3655a.cohuck@redhat.com>
In-Reply-To: <06a9fc5c-be2d-f152-de61-e815d7454692@linux.ibm.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
 <20200206214509.16434-2-farman@linux.ibm.com>
 <20200324180430.3597ca94.cohuck@redhat.com>
 <20200325032428.11dd27a2.pasic@linux.ibm.com>
 <20200401105258.3e885efb.cohuck@redhat.com>
 <06a9fc5c-be2d-f152-de61-e815d7454692@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Apr 2020 14:21:17 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 4/1/20 4:52 AM, Cornelia Huck wrote:
> > On Wed, 25 Mar 2020 03:24:28 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> >> On Tue, 24 Mar 2020 18:04:30 +0100
> >> Cornelia Huck <cohuck@redhat.com> wrote:
> >>  
> >>> On Thu,  6 Feb 2020 22:45:03 +0100
> >>> Eric Farman <farman@linux.ibm.com> wrote:
> >>>     
> >>>> From: Farhan Ali <alifm@linux.ibm.com>
> >>>>
> >>>> EIO is returned by vfio-ccw mediated device when the backing
> >>>> host subchannel is not operational anymore. So return cc=3
> >>>> back to the guest, rather than returning a unit check.
> >>>> This way the guest can take appropriate action such as
> >>>> issue an 'stsch'.    
> >>
> >> I believe this is not the only situation when vfio-ccw returns
> >> EIO, or?
> >>  
> >>>>
> >>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> >>>> ---
> >>>>
> >>>> Notes:
> >>>>     v1->v2: [EF]
> >>>>      - Add s-o-b
> >>>>      - [Seems the discussion on v1 centered on the return code
> >>>>        set in the kernel, rather than anything that needs to
> >>>>        change here, unless I've missed something.]    
> >>
> >> Does this need to change here? If the kernel is supposed to return ENODEV
> >> then this does not need to change.
> >>  
> >>>
> >>> I've stared at this and at the kernel code for some time again; and I'm
> >>> not sure if "return -EIO == not operational" is even true. That said,
> >>> I'm not sure a unit check is the right response, either. The only thing
> >>> I'm sure about is that the kernel code needs some review of return
> >>> codes and some documentation...    
> >>
> >> I could not agree more, this is semantically uapi and needs to be
> >> properly documented.
> >>
> >> With regards to "linux error codes: vs "ionist cc's" an where
> >> the mapping is different example:
> >>
> >> """
> >> /**                                                                             
> >>  * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt        
> >>  * and clear ordinally if subchannel is valid.                                  
> >>  * @sch: subchannel on which to perform the cancel_halt_clear operation         
> >>  * @iretry: the number of the times remained to retry the next operation        
> >>  *                                                                              
> >>  * This should be called repeatedly since halt/clear are asynchronous           
> >>  * operations. We do one try with cio_cancel, three tries with cio_halt,        
> >>  * 255 tries with cio_clear. The caller should initialize @iretry with          
> >>  * the value 255 for its first call to this, and keep using the same            
> >>  * @iretry in the subsequent calls until it gets a non -EBUSY return.           
> >>  *                                                                              
> >>  * Returns 0 if device now idle, -ENODEV for device not operational,            
> >>  * -EBUSY if an interrupt is expected (either from halt/clear or from a         
> >>  * status pending), and -EIO if out of retries.                                 
> >>  */                                                                             
> >> int cio_cancel_halt_clear(struct subchannel *sch, int *iretry)   
> >>
> >> """
> >> Here -ENODEV is not operational.  
> > 
> > Ok, I went through the kernel code and checked which error may be
> > returned in which case (hope I caught all of them). Here's what I
> > currently have:  
> 
> Thanks for doing all this mapping!
> 
> > 
> > diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
> > index fca9c4f5bd9c..43f375a03cce 100644
> > --- a/Documentation/s390/vfio-ccw.rst
> > +++ b/Documentation/s390/vfio-ccw.rst
> > @@ -210,7 +210,36 @@ Subchannel.
> >  
> >  irb_area stores the I/O result.
> >  
> > -ret_code stores a return code for each access of the region.
> > +ret_code stores a return code for each access of the region. The following
> > +values may occur:
> > +
> > +0
> > +  The operation was successful.
> > +
> > +-EOPNOTSUPP
> > +  The orb specified transport mode or an unidentified IDAW format, did not
> > +  specify prefetch mode, or the scsw specified a function other than the
> > +  start function.
> > +
> > +-EIO
> > +  A request was issued while the device was not in a state ready to accept
> > +  requests, or an internal error occurred.
> > +
> > +-EBUSY
> > +  The subchannel was status pending or busy, or a request is already active.
> > +
> > +-EAGAIN
> > +  A request was being processed, and the caller should retry.
> > +
> > +-EACCES
> > +  The channel path(s) used for the I/O were found to be not operational.
> > +
> > +-ENODEV
> > +  The device was found to be not operational.
> > +
> > +-EINVAL
> > +  The orb specified a chain longer than 255 ccws, or an internal error
> > +  occurred.
> >  
> >  This region is always available.
> >  
> > @@ -231,6 +260,29 @@ This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
> >  
> >  Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
> >  
> > +command specifies the command to be issued; ret_code stores a return code
> > +for each access of the region. The following values may occur:
> > +
> > +0
> > +  The operation was successful.
> > +
> > +-ENODEV
> > +  The device was found to be not operational.
> > +
> > +-EINVAL
> > +  A command other than halt or clear was specified.
> > +
> > +-EIO
> > +  A request was issued while the device was not in a state ready to accept
> > +  requests.
> > +
> > +-EAGAIN
> > +  A request was being processed, and the caller should retry.
> > +
> > +-EBUSY
> > +  The subchannel was status pending or busy while processing a halt request.
> > +
> > +
> >  vfio-ccw operation details
> >  --------------------------
> >  
> > Unless we interpret "device in wrong state" as "not operational",
> > mapping -EIO to cc 3 is probably not the right thing to do; but
> > generating a unit exception probably isn't either. Honestly, I'm unsure
> > what the right thing to do here would be...  
> 
> Me neither. I grepped my qemu logs for the past, ugh, too long for the
> error report that would precede these failures ("vfio-ccw: [wirte/write]
> I/O region failed with errno=%d"). Excluding the ones that were
> obviously the result of half-baked code, all instances were either
> -EBUSY or -ENODEV.  Could I trigger one?  Maybe.  Is it likely?  Doesn't
> seem to be.
> 
> It seems that getting -EIO would indicate we got ourselves out of sync,
> and started buttoning up the device again (or never having opened it in
> the first place), so a unit exception might be valid as a "hey
> something's screwy here" ?

I guess we have to report *some* kind of failure, and an unit exception
is perhaps the least weird way to do so. So probably be best to just
leave it alone, as it seems near impossible to trigger anyway.

> 
> > 
> > Another problem is that -EIO might signal "something went wrong in the
> > kernel code" - should not happen, but would certainly not be the
> > caller's fault, and they can't do anything about it. That "internal
> > error" thing might also be signaled by -EINVAL (which is odd), but
> > -EINVAL could also mean "the ccw chain is too long", for which
> > -EOPNOTSUPP would probably be a better return code, as it's a
> > limitation in the code, not the architecture, IIRC. Not sure if we can
> > still change that, though (and QEMU handles both in the same way,
> > anyway.)
> > 
> > The other return codes look sane, and the return codes for the async
> > region also seem sane (but have the same issue with -EIO == "device in
> > wrong state").
> > 
> > Looking at the QEMU handling, I think the -EIO handling is a bit
> > questionable (without an obvious solution), while mapping -EBUSY to cc
> > 2 is the only reasonable thing to do given that the interface does not
> > differentiate between "busy" and "status pending". The rest seems sane.
> >   
> 
> So maybe with all this data, and absent a better solution, it's best to
> just drop this patch from v3?

Yes, I agree. I'll post the documentation update as a separate patch.


