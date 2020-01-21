Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E6A217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fN6KhjbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E6A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwAG-0000lp-TL
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1itw93-0007uZ-0E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1itw8z-0004nL-2j
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:12:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1itw8y-0004nD-Uc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579623164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+cYmXd4h9GDnrgBfM4jOJ8h5CwZIoOqTLGxlCdz9ZOY=;
 b=fN6KhjbX6sZLD0pmWhtQD38bcGq1grSeHQRNgRmwZKGLFwiTJBo8btUDeR5AhR+cF4UTWt
 8Ct2oygwKbkjEr/rvW27uk7DGZtL6w3/Bhr0/GEBBn1fwRXqHiNlczuHjNf9GmY+tjPTP6
 WAeVvS18OwvGPfm28UcVXjD/yG6R1BA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-pm0_cc2cPSKL4jPBa89Ncw-1; Tue, 21 Jan 2020 11:12:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4385914E9;
 Tue, 21 Jan 2020 16:12:34 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6025E10013A7;
 Tue, 21 Jan 2020 16:12:30 +0000 (UTC)
Date: Tue, 21 Jan 2020 17:12:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] target/s390x/kvm: Enable adapter interruption
 suppression again
Message-ID: <20200121171228.3d04cf3c.cohuck@redhat.com>
In-Reply-To: <91bed750-8b12-4f9a-ff57-57fd23fc11ca@linux.ibm.com>
References: <20200120132441.11884-1-thuth@redhat.com>
 <20200120182747.5135fea8.cohuck@redhat.com>
 <95fa3c7d-8879-1401-6847-c5fa82a0cd3c@linux.ibm.com>
 <20200121154608.0b043233.cohuck@redhat.com>
 <6eceafc9-afb5-05a7-0713-2295886f6917@redhat.com>
 <91bed750-8b12-4f9a-ff57-57fd23fc11ca@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: pm0_cc2cPSKL4jPBa89Ncw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 11:05:18 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 1/21/20 10:22 AM, Thomas Huth wrote:
> > On 21/01/2020 15.46, Cornelia Huck wrote:  
> >> On Tue, 21 Jan 2020 09:33:02 -0500
> >> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >>  
> >>> On 1/20/20 12:27 PM, Cornelia Huck wrote:  
> >>>> On Mon, 20 Jan 2020 14:24:41 +0100
> >>>> Thomas Huth <thuth@redhat.com> wrote:
> >>>>      
> >>>>> The AIS feature has been disabled late in the v2.10 development cycle since
> >>>>> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
> >>>>> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
> >>>>> to enable it again for newer machine types, but apparently we forgot to do
> >>>>> this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.
> >>>>>
> >>>>> While at it, also add a more verbose comment why we need the *_allowed()
> >>>>> wrappers in s390-virtio-ccw.c.
> >>>>>
> >>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
> >>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>>>> ---
> >>>>>    v3: Moved "s390mc->kvm_ais_allowed = false" to the end of the function
> >>>>>
> >>>>>    hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
> >>>>>    include/hw/s390x/s390-virtio-ccw.h |  3 +++
> >>>>>    target/s390x/kvm.c                 |  9 ++++++---
> >>>>>    3 files changed, 26 insertions(+), 6 deletions(-)  
> >>>>      
> >>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >>>>> index 15260aeb9a..cf4fb4f2d9 100644
> >>>>> --- a/target/s390x/kvm.c
> >>>>> +++ b/target/s390x/kvm.c
> >>>>> @@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >>>>>        /*
> >>>>>         * The migration interface for ais was introduced with kernel 4.13
> >>>>>         * but the capability itself had been active since 4.12. As migration
> >>>>> -     * support is considered necessary let's disable ais in the 2.10
> >>>>> -     * machine.
> >>>>> +     * support is considered necessary, we only try to enable this for
> >>>>> +     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
> >>>>>         */
> >>>>> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
> >>>>> +    if (kvm_ais_allowed() &&
> >>>>> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {  
> >>>>
> >>>> Hnm, we actually need a kernel irqchip with the kvm flic to get ais to
> >>>> work; else we'll fail with
> >>>>
> >>>> qemu-system-s390x: Failed to inject airq with AIS supported
> >>>>
> >>>> in the kernel_irqchip=off case, as we won't have an I/O adapter
> >>>> registered.
> >>>>
> >>>> Adding 'kvm_kernel_irqchip_required() &&' seems to do the trick;
> >>>> comments?
> >>>>      
> >>>
> >>> In spirit, I agree with this idea.  But, a quick test shows that putting
> >>> this check here results in ais=off for the 'none' machine case (libvirt
> >>> capabilities detection).  I think we have to only look at
> >>> kvm_kernel_irqchip_required() when working with a real machine.  
> >>
> >> Sigh, I think you're right again. We need to check for the 'none'
> >> machine here; but I can't think of a non-ugly way to do so...  
> > 
> > I think it might work when using kvm_kernel_irqchip_allowed() instead of
> > kvm_kernel_irqchip_required() ... Matthew, could you please give it a
> > try with this patch on top of mine:
> >   
> 
> Sure.
> 
> Libvirt detection works with this patch.

Excellent.

> 
> Alternatively, if I run qemu with kernel_irqchip=off and ais=true, I get:
> qemu-system-s390x: Some features requested in the CPU model are not 
> available in the configuration: ais
> 
> Which was the same result as Connie's proposal.

Yep, that's the expected behaviour.

> 
> It reads a bit odd to me at first, but looking at the code quick I think 
> this is the right answer - kvm_kernel_irqchip_allowed() will only return 
> false when kernel_irqchip has been forced off as above, whereas 
> kernel_irqchip_required will also return false in the case where no 
> setting was specified (this is what tripped libvirt up).
> 
> Looks good to me, thanks Thomas.

Thanks for testing!

Thomas, I guess you'll send a v4?


