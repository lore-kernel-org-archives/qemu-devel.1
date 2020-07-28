Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819A1C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8F2206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtZO0ZYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8F2206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0P6N-0006VP-In
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k0P5n-0005xA-7T
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:52:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k0P5l-0004ER-L4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595940744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Wc5XXLX9WM6Xzn+Z5ly6Z0lPnl0D7YQsJRKN6FRsBE=;
 b=JtZO0ZYO7vD+47S1v3h1+5Thd4sbV0tjfGN0/QKKpsJTWUr1OSSTz5tZeHYksc4EeYnVwC
 jsyiBUbTvxy5FfIGNYr4dGLnkyLMRuBsr1Jt6kxgi1XdnSFZCh/JGzj4vryAb1A+W3PyEJ
 zrqNXipc4tAUsjIOk14SqzzcbgqGMPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-AkAUxKVPMa6NRPlJ7CzEjQ-1; Tue, 28 Jul 2020 08:52:21 -0400
X-MC-Unique: AkAUxKVPMa6NRPlJ7CzEjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9951880BCAF;
 Tue, 28 Jul 2020 12:52:19 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 158BA1001B2C;
 Tue, 28 Jul 2020 12:52:16 +0000 (UTC)
Date: Tue, 28 Jul 2020 06:52:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [RFC PATCH] s390x/pci: vfio-pci breakage with disabled mem
 enforcement
Message-ID: <20200728065215.21a7f5af@x1.home>
In-Reply-To: <f152965e-ed8c-a34b-e13d-7859c06afd85@linux.ibm.com>
References: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
 <20200723102916.7cf15b43@w520.home>
 <0481c77e-f71f-886b-9b0a-41529eb139ee@linux.ibm.com>
 <20200727104754.4337818c@x1.home>
 <f152965e-ed8c-a34b-e13d-7859c06afd85@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Pierre Morel <pmorel@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 11:33:55 +0200
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> On 7/27/20 6:47 PM, Alex Williamson wrote:
> > On Mon, 27 Jul 2020 17:40:39 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> On 2020-07-23 18:29, Alex Williamson wrote:  
> >>> On Thu, 23 Jul 2020 11:13:55 -0400
> >>> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >>>     
> >>>> I noticed that after kernel commit abafbc55 'vfio-pci: Invalidate mmaps
> >>>> and block MMIO access on disabled memory' vfio-pci via qemu on s390x
> >>>> fails spectacularly, with errors in qemu like:  
> ... snip ...
> >>
> >> Alex, Matt,
> >>
> >> in s390 we have the possibility to assign a virtual function to a 
> >> logical partition as function 0.
> >> In this case it can not be treated as a virtual function but must be 
> >> treated as a physical function.
> >> This is currently working very well.
> >> However, these functions do not set PCI_COMMAND_MEMORY as we need.  
> > 
> > Where is the vendor and device ID virtualization done for these
> > devices, we can't have a PF with IDs 0000:0000.  
> Pierre doesn't mean the Device/Vendor IDs he means it has devfn == 0
> so it is the mandatory function zero on it's PCI bus, where until recently
> we always had only one function per bus but with the recent multi-function
> support it can act more like on other platforms with several PCI functions
> sharing the same Bus e.g. a PF and the VFs created through sriov_numvfs.
> That's why I'm saying that having devfn == 0 should not be very special for a VF
> passed to a VM and I really don't see where it would not act like a VF passed
> from any other Hypervisor.

My question is relative to other registers on VFs that are not
implemented in hardware, not the device address.  In addition to the
memory bit of the command register, SR-IOV VFs do not implement the
vendor and device IDs, these are to be virtualized from the values
provided in the PF SR-IOV capability.  It wouldn't make much sense to
expose a device with no PCI vendor or device ID, so I assume the z/VM
hypervisor is virtualizing these, but not the memory bit.
 
> The only really tricky part in my opinion is where during the "probing"
> we do set is_virtfn so it happens both for VFs passed-through from z/VM
> or LPAR and VFs created through sriov_numvfs which unlike on other platforms
> are also scanned by Firmware (pdev->no_vf_scan disables the Linux side scanning).
> With the fix I'm currently testing I had to do this in pcibios_enable_device()
> because I also create sysfs links between VFs and their parent PFs and those
> need the sysfs entries to be already created, which makes the more apropriately
> sound pcibios_bus_add_device() too early.


I don't think it would be wise to set is_virtfn without a physfn being
present in the OS view.  I believe pci_dev.is_virtfn implies
pci_dev.physfn points to the PF device.  Thanks,

Alex

> >> Shouldn't we fix this inside the kernel, to keep older QMEU working?
> >>
> >> Then would it be OK to add a new bit/boolean inside the 
> >> pci_dev/vfio_pci_device like, is_detached_vfn, that we could set during 
> >> enumeration and test inside __vfio_pci_memory_enabled() to return true?  
> > 
> > Probably each instance of is_virtfn in vfio-pci should be looked at to
> > see if it applies to s390.  If we're going to recognize this as a VF,
> > I'd rather we complete the emulation that the lower level hypervisor
> > has missed.  If we can enable all the is_virtfn code on s390, then we
> > should probably cache is_virtfn on the vfio_pci_device object and allow
> > s390 a place to set it once at probe or enable time.
> >   
> >> In the enumeration we have the possibility to know if the function is a 
> >> HW/Firmware virtual function on devfn 0 or if it is created by SRIOV.
> >>
> >> It seems an easy fix without side effects.
> >>
> >> What do you think?  
> > 
> > It sure seems preferable to recognize that it is a VF in the kernel
> > than to require userspace to have arch specific hacks.  Thanks,
> > 
> > Alex
> >   
> 


