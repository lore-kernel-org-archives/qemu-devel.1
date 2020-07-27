Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B71AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433C120729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i83aghoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433C120729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k06It-0004bi-Gt
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 12:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k06II-00049W-Ql
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:48:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k06IG-0007Dh-9E
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595868482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x08MIA1yaHbmQEcDw9IXYVv7P49C36YP2b48KFZir18=;
 b=i83aghoQ8hRyyWwYutnLv0GBj19jJHAqYYzmOQP2NN0iOQ/tUFQPS0/RbiC7tgfEyTm8rh
 QsOKQNMM3hP+1qDf77WDkDMTXj9v/C05gTMoJmL9Pd1O2O+FHUd75cw1rCblLfN6wCMcux
 0+X92oWCchg7W+IqfD8JvyRSFOVaGXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-GQfiH3GaPVGjxKoFZn0Q_g-1; Mon, 27 Jul 2020 12:48:00 -0400
X-MC-Unique: GQfiH3GaPVGjxKoFZn0Q_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A6319253CC;
 Mon, 27 Jul 2020 16:47:58 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E58EB10013D7;
 Mon, 27 Jul 2020 16:47:54 +0000 (UTC)
Date: Mon, 27 Jul 2020 10:47:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [RFC PATCH] s390x/pci: vfio-pci breakage with disabled mem
 enforcement
Message-ID: <20200727104754.4337818c@x1.home>
In-Reply-To: <0481c77e-f71f-886b-9b0a-41529eb139ee@linux.ibm.com>
References: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
 <20200723102916.7cf15b43@w520.home>
 <0481c77e-f71f-886b-9b0a-41529eb139ee@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: schnelle@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>,
 david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 17:40:39 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-07-23 18:29, Alex Williamson wrote:
> > On Thu, 23 Jul 2020 11:13:55 -0400
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> >> I noticed that after kernel commit abafbc55 'vfio-pci: Invalidate mmaps
> >> and block MMIO access on disabled memory' vfio-pci via qemu on s390x
> >> fails spectacularly, with errors in qemu like:
> >>
> >> qemu-system-s390x: vfio_region_read(0001:00:00.0:region0+0x0, 4) failed: Input/output error
> >>
> >>  From read to bar 0 originating out of hw/s390x/s390-pci-inst.c:zpci_read_bar().
> >>
> >> So, I'm trying to figure out how to get vfio-pci happy again on s390x.  From
> >> a bit of tracing, we seem to be triggering the new trap in
> >> __vfio_pci_memory_enabled().  Sure enough, if I just force this function to
> >> return 'true' as a test case, things work again.
> >> The included patch attempts to enforce the setting, which restores everything
> >> to working order but also triggers vfio_bar_restore() in the process....  So
> >> this isn't the right answer, more of a proof-of-concept.
> >>
> >> @Alex: Any guidance on what needs to happen to make qemu-s390x happy with this
> >> recent kernel change?  
> > 
> > Bummer!  I won't claim to understand s390 PCI, but if we have a VF
> > exposed to the "host" (ie. the first level where vfio-pci is being
> > used), but we can't tell that it's a VF, how do we know whether the
> > memory bit in the command register is unimplemented because it's a VF
> > or unimplemented because the device doesn't support MMIO?  How are the
> > device ID, vendor ID, and BAR registers virtualized to the host?  Could
> > the memory enable bit also be emulated by that virtualization, much
> > like vfio-pci does for userspace?  If the other registers are
> > virtualized, but these command register bits are left unimplemented, do
> > we need code to deduce that we have a VF based on the existence of MMIO
> > BARs, but lack of memory enable bit?  Thanks,
> > 
> > Alex  
> 
> Alex, Matt,
> 
> in s390 we have the possibility to assign a virtual function to a 
> logical partition as function 0.
> In this case it can not be treated as a virtual function but must be 
> treated as a physical function.
> This is currently working very well.
> However, these functions do not set PCI_COMMAND_MEMORY as we need.

Where is the vendor and device ID virtualization done for these
devices, we can't have a PF with IDs 0000:0000.

> Shouldn't we fix this inside the kernel, to keep older QMEU working?
> 
> Then would it be OK to add a new bit/boolean inside the 
> pci_dev/vfio_pci_device like, is_detached_vfn, that we could set during 
> enumeration and test inside __vfio_pci_memory_enabled() to return true?

Probably each instance of is_virtfn in vfio-pci should be looked at to
see if it applies to s390.  If we're going to recognize this as a VF,
I'd rather we complete the emulation that the lower level hypervisor
has missed.  If we can enable all the is_virtfn code on s390, then we
should probably cache is_virtfn on the vfio_pci_device object and allow
s390 a place to set it once at probe or enable time.

> In the enumeration we have the possibility to know if the function is a 
> HW/Firmware virtual function on devfn 0 or if it is created by SRIOV.
> 
> It seems an easy fix without side effects.
> 
> What do you think?

It sure seems preferable to recognize that it is a VF in the kernel
than to require userspace to have arch specific hacks.  Thanks,

Alex


