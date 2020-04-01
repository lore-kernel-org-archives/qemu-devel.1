Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB32C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681842078B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbcRHObg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681842078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZ8E-0000lx-Gi
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 04:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJZ7W-0008TC-GF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJZ7U-0002A5-2a
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:53:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJZ7T-00029D-UH
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585731186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rhDeyxHNSc/XD3lIIP/apZXwmFE2ubrFR3+ue7DdGA=;
 b=IbcRHObgQbQ8cnySkLKPyq8tl8aEjpTqJQOb6SXYc1aHfgdfLVSlK0Cs4n/GzJv9DTK4FS
 BKI9f1GshrgcACi/S2B96B/KzUXFOA9e7bQuvIE6Z4sEAbH1632+ka6S0fO93WY0MyKxYW
 lh2QGi9y4sMTHNon6odCrLWIcDoCoAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-SsLcu6veNneZen4cdYiFHg-1; Wed, 01 Apr 2020 04:53:05 -0400
X-MC-Unique: SsLcu6veNneZen4cdYiFHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5830D8017CC;
 Wed,  1 Apr 2020 08:53:03 +0000 (UTC)
Received: from gondolin (ovpn-112-252.ams2.redhat.com [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C70BB99DF3;
 Wed,  1 Apr 2020 08:53:01 +0000 (UTC)
Date: Wed, 1 Apr 2020 10:52:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/7] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL
 for EIO
Message-ID: <20200401105258.3e885efb.cohuck@redhat.com>
In-Reply-To: <20200325032428.11dd27a2.pasic@linux.ibm.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
 <20200206214509.16434-2-farman@linux.ibm.com>
 <20200324180430.3597ca94.cohuck@redhat.com>
 <20200325032428.11dd27a2.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 03:24:28 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 24 Mar 2020 18:04:30 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Thu,  6 Feb 2020 22:45:03 +0100
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> > > From: Farhan Ali <alifm@linux.ibm.com>
> > > 
> > > EIO is returned by vfio-ccw mediated device when the backing
> > > host subchannel is not operational anymore. So return cc=3
> > > back to the guest, rather than returning a unit check.
> > > This way the guest can take appropriate action such as
> > > issue an 'stsch'.  
> 
> I believe this is not the only situation when vfio-ccw returns
> EIO, or?
> 
> > > 
> > > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> > > ---
> > > 
> > > Notes:
> > >     v1->v2: [EF]
> > >      - Add s-o-b
> > >      - [Seems the discussion on v1 centered on the return code
> > >        set in the kernel, rather than anything that needs to
> > >        change here, unless I've missed something.]  
> 
> Does this need to change here? If the kernel is supposed to return ENODEV
> then this does not need to change.
> 
> > 
> > I've stared at this and at the kernel code for some time again; and I'm
> > not sure if "return -EIO == not operational" is even true. That said,
> > I'm not sure a unit check is the right response, either. The only thing
> > I'm sure about is that the kernel code needs some review of return
> > codes and some documentation...  
> 
> I could not agree more, this is semantically uapi and needs to be
> properly documented.
> 
> With regards to "linux error codes: vs "ionist cc's" an where
> the mapping is different example:
> 
> """
> /**                                                                             
>  * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt        
>  * and clear ordinally if subchannel is valid.                                  
>  * @sch: subchannel on which to perform the cancel_halt_clear operation         
>  * @iretry: the number of the times remained to retry the next operation        
>  *                                                                              
>  * This should be called repeatedly since halt/clear are asynchronous           
>  * operations. We do one try with cio_cancel, three tries with cio_halt,        
>  * 255 tries with cio_clear. The caller should initialize @iretry with          
>  * the value 255 for its first call to this, and keep using the same            
>  * @iretry in the subsequent calls until it gets a non -EBUSY return.           
>  *                                                                              
>  * Returns 0 if device now idle, -ENODEV for device not operational,            
>  * -EBUSY if an interrupt is expected (either from halt/clear or from a         
>  * status pending), and -EIO if out of retries.                                 
>  */                                                                             
> int cio_cancel_halt_clear(struct subchannel *sch, int *iretry)   
> 
> """
> Here -ENODEV is not operational.

Ok, I went through the kernel code and checked which error may be
returned in which case (hope I caught all of them). Here's what I
currently have:

diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
index fca9c4f5bd9c..43f375a03cce 100644
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -210,7 +210,36 @@ Subchannel.
 
 irb_area stores the I/O result.
 
-ret_code stores a return code for each access of the region.
+ret_code stores a return code for each access of the region. The following
+values may occur:
+
+0
+  The operation was successful.
+
+-EOPNOTSUPP
+  The orb specified transport mode or an unidentified IDAW format, did not
+  specify prefetch mode, or the scsw specified a function other than the
+  start function.
+
+-EIO
+  A request was issued while the device was not in a state ready to accept
+  requests, or an internal error occurred.
+
+-EBUSY
+  The subchannel was status pending or busy, or a request is already active.
+
+-EAGAIN
+  A request was being processed, and the caller should retry.
+
+-EACCES
+  The channel path(s) used for the I/O were found to be not operational.
+
+-ENODEV
+  The device was found to be not operational.
+
+-EINVAL
+  The orb specified a chain longer than 255 ccws, or an internal error
+  occurred.
 
 This region is always available.
 
@@ -231,6 +260,29 @@ This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
 
 Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
 
+command specifies the command to be issued; ret_code stores a return code
+for each access of the region. The following values may occur:
+
+0
+  The operation was successful.
+
+-ENODEV
+  The device was found to be not operational.
+
+-EINVAL
+  A command other than halt or clear was specified.
+
+-EIO
+  A request was issued while the device was not in a state ready to accept
+  requests.
+
+-EAGAIN
+  A request was being processed, and the caller should retry.
+
+-EBUSY
+  The subchannel was status pending or busy while processing a halt request.
+
+
 vfio-ccw operation details
 --------------------------
 
Unless we interpret "device in wrong state" as "not operational",
mapping -EIO to cc 3 is probably not the right thing to do; but
generating a unit exception probably isn't either. Honestly, I'm unsure
what the right thing to do here would be...

Another problem is that -EIO might signal "something went wrong in the
kernel code" - should not happen, but would certainly not be the
caller's fault, and they can't do anything about it. That "internal
error" thing might also be signaled by -EINVAL (which is odd), but
-EINVAL could also mean "the ccw chain is too long", for which
-EOPNOTSUPP would probably be a better return code, as it's a
limitation in the code, not the architecture, IIRC. Not sure if we can
still change that, though (and QEMU handles both in the same way,
anyway.)

The other return codes look sane, and the return codes for the async
region also seem sane (but have the same issue with -EIO == "device in
wrong state").

Looking at the QEMU handling, I think the -EIO handling is a bit
questionable (without an obvious solution), while mapping -EBUSY to cc
2 is the only reasonable thing to do given that the interface does not
differentiate between "busy" and "status pending". The rest seems sane.


