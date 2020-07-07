Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A8EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3ECC20708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WngB5ucL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3ECC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspxK-0004Lq-3z
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jspwJ-0003PJ-6h
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:55:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jspwG-000431-F4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUEYEo1lKxnaKV+TCXH2VDbm45eSQgEnr7gs2+faMkY=;
 b=WngB5ucL508UKFv72ocJAn+vHKqZUDY1N2hsNpOzLcodPILa66vYcRMGBXqvdEKnHi/xjj
 kTgIyZMIoQjN+PrWxeqXk6mrRu3uwU/PePTEPUwEqcPukOxgqnA21Q9pFXCT+h3nt2tGPy
 JQGKTCu/VVNWyRxNt2c4Ss1/0RGsxTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-4VVrWg_yM9GivJBlb8kCGg-1; Tue, 07 Jul 2020 11:54:59 -0400
X-MC-Unique: 4VVrWg_yM9GivJBlb8kCGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 285A9800403;
 Tue,  7 Jul 2020 15:54:58 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99EAC106222C;
 Tue,  7 Jul 2020 15:54:54 +0000 (UTC)
Date: Tue, 7 Jul 2020 09:54:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: DMA region abruptly removed from PCI device
Message-ID: <20200707095453.5543d9af@x1.home>
In-Reply-To: <9F290836-753A-4ACF-A593-F736C2FA0508@nutanix.com>
References: <MW2PR02MB3723509CC4795066274C9D4C8B690@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200706082004.5c887c67@x1.home>
 <9F290836-753A-4ACF-A593-F736C2FA0508@nutanix.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Liu, 
 Changpeng" <changpeng.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 10:38:01 +0000
Felipe Franciosi <felipe@nutanix.com> wrote:

> > On Jul 6, 2020, at 3:20 PM, Alex Williamson <alex.williamson@redhat.com> wrote:
> > 
> > On Mon, 6 Jul 2020 10:55:00 +0000
> > Thanos Makatos <thanos.makatos@nutanix.com> wrote:
> >   
> >> We have an issue when using the VFIO-over-socket libmuser PoC
> >> (https://www.mail-archive.com/qemu-devel@nongnu.org/msg692251.html) instead of
> >> the VFIO kernel module: we notice that DMA regions used by the emulated device
> >> can be abruptly removed while the device is still using them.
> >> 
> >> The PCI device we've implemented is an NVMe controller using SPDK, so it polls
> >> the submission queues for new requests. We use the latest SeaBIOS where it tries
> >> to boot from the NVMe controller. Several DMA regions are registered
> >> (VFIO_IOMMU_MAP_DMA) and then the admin and a submission queues are created.
> >> From this point SPDK polls both queues. Then, the DMA region where the
> >> submission queue lies is removed (VFIO_IOMMU_UNMAP_DMA) and then re-added at the
> >> same IOVA but at a different offset. SPDK crashes soon after as it accesses
> >> invalid memory. There is no other event (e.g. some PCI config space or NVMe
> >> register write) happening between unmapping and mapping the DMA region. My guess
> >> is that this behavior is legitimate and that this is solved in the VFIO kernel
> >> module by releasing the DMA region only after all references to it have been
> >> released, which is handled by vfio_pin/unpin_pages, correct? If this is the case
> >> then I suppose we need to implement the same logic in libmuser, but I just want
> >> to make sure I'm not missing anything as this is a substantial change.  
> > 
> > The vfio_{pin,unpin}_pages() interface only comes into play for mdev
> > devices and even then it's an announcement that a given mapping is
> > going away and the vendor driver is required to release references.
> > For normal PCI device assignment, vfio-pci is (aside from a few quirks)
> > device agnostic and the IOMMU container mappings are independent of the
> > device.  We do not have any device specific knowledge to know if DMA
> > pages still have device references.  The user's unmap request is
> > absolute, it cannot fail (aside from invalid usage) and upon return
> > there must be no residual mappings or references of the pages.
> > 
> > If you say there's no config space write, ex. clearing bus master from
> > the command register, then something like turning on a vIOMMU might
> > cause a change in the entire address space accessible by the device.
> > This would cause the identity map of IOVA to GPA to be replaced by a
> > new one, perhaps another identity map if iommu=pt or a more restricted
> > mapping if the vIOMMU is used for isolation.
> > 
> > It sounds like you have an incomplete device model, physical devices
> > have their address space adjusted by an IOMMU independent of, but
> > hopefully in collaboration with a device driver.  If a physical device
> > manages to bridge this transition, do what it does.  Thanks,  
> 
> Hi,
> 
> That's what we are trying to work out. IIUC, the problem we are having
> is that a mapping removal was requested but the device was still
> operational. We can surely figure out how to handle that gracefully,
> but I'm trying to get my head around how real hardware handles that.
> Maybe you can add some colour here. :)
> 
> What happens when a device tries to write to a physical address that
> has no memory behind it? Is it an MCE of sorts?

It depends on the system, the write might be silently dropped (a), it
might generate an IOMMU fault (b), or firmware-first platform error
handling might freak out from either (a) or (b) and decide to trigger a
fatal error.  If mappings are getting removed due to bus master enable
getting cleared, I would expect device specific behavior, the device
could either stall or drop transactions.
 
> I haven't really ever looked at memory hot unplug in detail, but
> after reading some QEMU code this is my understanding:
>
> 1) QEMU makes an ACPI request to the guest OS for mem unplug
> 2) Guest OS acks that memory can be pulled out
> 3) QEMU pulls the memory from the guest
> 
> Before step 3, I'm guessing that QEMU tells all device backends that
> this memory is going away. I suppose that in normal operation, the
> Guest OS will have already stopped using the memory (ie. before step
> 2), so there shouldn't be much to it. But I also suppose a malicious
> guest could go "ah, you want to remove this dimm? sure, let me just
> ask all these devices to start using it first... ok, there you go."
> 
> Is this understanding correct?

Memory hot-unplug is cooperative, the guest OS needs to be able to
vacate the necessary range.  If it can't do that or doesn't want to do
that, it just rejects the operation.  The unplugged memory is removed
from the VM address space, so there's no way it can be malicious.
Devices don't own memory, they just use it.  Drivers within the guest
OS having allocations within the requested memory range, especially if
those allocations are for DMA, would be reason for the guest to reject
the unplug operation.  Drivers within QEMU have no business getting a
vote in this matter, if the guest OS has completed the unplug
operation, the memory must be unmapped.  If the guest OS has overlooked
some inflight DMA target, that's on the guest and the above error
handling, or lack thereof comes into play for those transactions.
 
> I don't think that's the case we're running into, though, but I think
> we need to consider it at this time. What's probably happening here is
> that the guest went from SeaBIOS to the kernel, a PCI reset happened
> and we didn't plumb that message through correctly. While we are at
> it, we should review the memory hot unplug business.

Looking at IOVAs mapped to the device from the device perspective,
clearing bus master will remove all the mappings.  That will happen
when the guest OS or SeaBIOS sizes the PCI BARs, but the description
above said that no config space accesses were occurring.  Enabling the
vIOMMU would also change the entire address space of the device.  In
transitioning from SeaBIOS to guest kernel, why is the device still
active?  The normal expectation here would be that SeaBIOS accesses the
device to load the kernel and initrd into memory, the device is
quiesced, the guest OS boots, enumerating the I/O and IOMMU,
potentially involving multiple address space changes, then device
drivers load, which should make sure the device is performing DMA to
valid targets.  I'll be curious to see what's causing this mysterious
remove and shift operation.  Thanks,

Alex


