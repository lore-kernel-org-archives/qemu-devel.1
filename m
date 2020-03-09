Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9638CC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F6C2464B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGQmdJKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F6C2464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBPaa-0005pd-KX
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 17:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jBPZq-0005NH-Nr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jBPZo-0000Lq-RQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:04:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jBPZo-0000JT-Lb
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583787876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbC3+SCZRcbY25ZcwpCM3r5UPj8OcIpA81tZN1IWAv8=;
 b=dGQmdJKS/WS1UeGSIC7XWjLmDZInkrfUDwwfE3rBlG6TVSrobe5FtZ+WWf9oRR5YwXem9K
 MgelAgQmFPnIsLyavocDEKx3G1HJrYzJDhoFYvMlnO6ECyJVcqw3Wsos8COe2soiZrtJ1h
 Aa22op7VO4tt3h2LS/CvptHgdEO/j/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-4lT2vwygMEGGbOw8952zxA-1; Mon, 09 Mar 2020 17:04:35 -0400
X-MC-Unique: 4lT2vwygMEGGbOw8952zxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9770B1937FC0
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 21:04:34 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B92861000325;
 Mon,  9 Mar 2020 21:04:29 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:04:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200309150428.1eb36e78@w520.home>
In-Reply-To: <20200306004324.GG7146@xz-x1>
References: <20200228161503.382656-1-peterx@redhat.com>
 <20200228161503.382656-5-peterx@redhat.com>
 <20200305165857.6a3ec29f@w520.home> <20200306004324.GG7146@xz-x1>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 19:43:24 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Thu, Mar 05, 2020 at 04:58:57PM -0700, Alex Williamson wrote:
> 
> Hi, Alex,
> 
> [...]
> 
> > > +bool kvm_resample_fd_notify(int gsi)
> > > +{
> > > +    KVMResampleFd *rfd;
> > > +
> > > +    if (!kvm_irqchip_is_split()) {
> > > +        return false;
> > > +    }  
> > 
> > Nit, checking split irqchip here seems unnecessary.  We're only adding
> > and removing list entries based on split irqchip below, so the list
> > would be empty anyway, unless another user comes along that might have
> > a reason for this functionality that isn't as tied to split irqchip.  
> 
> Right, now it's more or less a hint to readers, and we can remove it.
> I'll see whether I'll repost a new version, and I'll drop it if so.
> 
> > 
> > Overall the series looks like a big improvement versus falling back to
> > our crappy generic EOI hackery with split irqchip.  Thanks,  
> 
> Yes I was pretty happy to see the numbers too when I first tested the
> series, after all I was still uncertain about how much overhead the
> userspace EOI would take on the irq return path.  It turns out that
> the injection seems to be more important.
> 
> In all cases, major credits go to Paolo for the idea. :)

Hey Peter, I'm trying to test this myself and my VM just hangs as soon
as I enable split irqchip.  It boots up to discovering the virtio
disks, then nothing more.  My host kernel is 5.3.7-301.fc31.x86_64,
QEMU is 373c7068dd61 + this patch series.  VM script is:

/usr/local/bin/qemu-system-x86_64 \
-S \
-machine pc-q35-5.0,accel=kvm,usb=off,vmport=off,dump-guest-core=off,kernel-irqchip=split \
-cpu host \
-m 2048 \
-smp 2,sockets=2,cores=1,threads=1 \
-no-user-config \
-nodefaults \
-monitor stdio \
-serial none \
-parallel none \
-no-hpet \
-device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x2 \
-device pcie-root-port,port=0x11,chassis=2,id=pci.2,bus=pcie.0,addr=0x2.0x1 \
-device pcie-root-port,port=0x12,chassis=3,id=pci.3,bus=pcie.0,addr=0x2.0x2 \
-device pcie-root-port,port=0x13,chassis=4,id=pci.4,bus=pcie.0,addr=0x2.0x3 \
-device pcie-root-port,port=0x14,chassis=5,id=pci.5,bus=pcie.0,addr=0x2.0x4 \
-device pcie-root-port,port=0x15,chassis=6,id=pci.6,bus=pcie.0,addr=0x2.0x5 \
-drive file=/var/lib/libvirt/images/fedora31-1.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 \
-device virtio-blk-pci,scsi=off,bus=pci.3,addr=0x0,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 \
-vnc :0 \
-device VGA,id=video0,vgamem_mb=16,bus=pcie.0,addr=0x1 \
-device vfio-pci,host=02:00.0,id=e1000e,bus=pci.2,addr=0x0

Guest has pci=nomsi on the kernel command line.  It boots with
irqchip=on, also boots with x-no-kvm-intx=on as an arg to the vfio-pci
device.  I'm afraid there's a regression here unless I'm failing to add
something necessary for split irqchip.  Thanks,

Alex


