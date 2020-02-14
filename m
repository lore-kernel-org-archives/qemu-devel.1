Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF89C3B19F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF82217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgW5j/S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF82217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dEj-0002U4-VY
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1j2dE3-0001lv-Em
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1j2dE1-0000Yi-S7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:49:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1j2dE1-0000Xk-Mu
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581695393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pIv0Uk9saondnliaK6YDCVTbITUyxenrJ3jd3o+lFnY=;
 b=VgW5j/S0ntR05aRMdQVDwDBnTIcck7OD0AIWAiSNPsQTHh0lhUf/RvDlPuxTuiPhzVDJBn
 eSo3T+do2QqEzXAciY2xtBmn/14MEIB+aSBXMxy5C2i4gKTsVDM6YCrZthIE78mtHnlBSu
 lhzqdtJiTE9pggQRnwhU7+pqDYPfWEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-9z5m2hGJNYKjQEQd4JHIgQ-1; Fri, 14 Feb 2020 10:49:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40D04DB6D;
 Fri, 14 Feb 2020 15:49:48 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25C4960BF1;
 Fri, 14 Feb 2020 15:49:46 +0000 (UTC)
Date: Fri, 14 Feb 2020 08:49:46 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH] Report stringified errno in VFIO related errors
Message-ID: <20200214084946.5220404b@x1.home>
In-Reply-To: <ef161708-2ecc-8d51-7dae-6a860659a8a9@redhat.com>
References: <2dc5a0962a38b912e4fa4900f9813b7ea1a9273c.1581670009.git.mprivozn@redhat.com>
 <ef161708-2ecc-8d51-7dae-6a860659a8a9@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 9z5m2hGJNYKjQEQd4JHIgQ-1
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 10:19:50 +0100
Michal Privoznik <mprivozn@redhat.com> wrote:

> On 2/14/20 9:47 AM, Michal Privoznik wrote:
> > In a few places we report errno formatted as a negative integer.
> > This is not as user friendly as it can be. Use strerror() and/or
> > error_setg_errno() instead.
> > 
> > Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> > ---
> >   hw/vfio/common.c    | 2 +-
> >   util/vfio-helpers.c | 6 +++---
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >   
> 
> BTW the reason I've noticed these is because I'm seeing some errors when 
> assigning my NVMe disk to qemu. This is the full command line:
> 
> 
> /home/zippy/work/qemu/qemu.git/x86_64-softmmu/qemu-system-x86_64 \
> -name guest=fedora,debug-threads=on \
> -S \
> -object 
> secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-2-fedora/master-key.aes 
> \
> -machine pc-i440fx-4.1,accel=kvm,usb=off,dump-guest-core=off \
> -cpu host \
> -m size=4194304k,slots=16,maxmem=1099511627776k \
> -overcommit mem-lock=off \
> -smp 4,sockets=1,dies=1,cores=2,threads=2 \
> -object iothread,id=iothread1 \
> -object iothread,id=iothread2 \
> -object iothread,id=iothread3 \
> -object iothread,id=iothread4 \
> -mem-prealloc \
> -mem-path /hugepages2M/libvirt/qemu/2-fedora \
> -numa node,nodeid=0,cpus=0,mem=4096 \
> -uuid 63840878-0deb-4095-97e6-fc444d9bc9fa \
> -no-user-config \
> -nodefaults \
> -chardev socket,id=charmonitor,fd=31,server,nowait \
> -mon chardev=charmonitor,id=monitor,mode=control \
> -rtc base=utc \
> -no-shutdown \
> -global PIIX4_PM.disable_s3=0 \
> -global PIIX4_PM.disable_s4=0 \
> -boot menu=on,strict=on \
> -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
> -device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x4 \
> -device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x5 \
> -blockdev 
> '{"driver":"file","filename":"/var/lib/libvirt/images/fedora.qcow2","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"unmap"}' 
> \
> -blockdev 
> '{"node-name":"libvirt-2-format","read-only":false,"discard":"unmap","driver":"qcow2","file":"libvirt-2-storage","backing":null}' 
> \
> -device 
> scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,device_id=drive-scsi0-0-0-0,drive=libvirt-2-format,id=scsi0-0-0-0,bootindex=1 
> \
> -blockdev 
> '{"driver":"nvme","device":"0000:02:00.0","namespace":1,"node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' 
> \
> -blockdev 
> '{"node-name":"libvirt-1-format","read-only":false,"driver":"raw","file":"libvirt-1-storage"}' 
> \
> -device 
> virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=libvirt-1-format,id=virtio-disk0 
> \
> -netdev tap,fd=33,id=hostnet0,vhost=on,vhostfd=34 \
> -device 
> virtio-net-pci,host_mtu=9000,netdev=hostnet0,id=net0,mac=52:54:00:a4:6f:91,bus=pci.0,addr=0x3 
> \
> -chardev pty,id=charserial0 \
> -device isa-serial,chardev=charserial0,id=serial0 \
> -chardev socket,id=charchannel0,fd=35,server,nowait \
> -device 
> virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=org.qemu.guest_agent.0 
> \
> -spice port=5900,addr=0.0.0.0,disable-ticketing,seamless-migration=on \
> -device virtio-vga,id=video0,virgl=on,max_outputs=1,bus=pci.0,addr=0x2 \
> -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x7 \
> -sandbox 
> on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny \
> -msg timestamp=on
> 
> And these are the errors I see:
> 
> 2020-02-14T09:06:18.183167Z qemu-system-x86_64: VFIO_MAP_DMA failed: 
> Invalid argument
> 2020-02-14T09:10:49.753767Z qemu-system-x86_64: VFIO_MAP_DMA failed: 
> Cannot allocate memory
> 2020-02-14T09:11:04.530344Z qemu-system-x86_64: VFIO_MAP_DMA failed: No 
> space left on device
> 2020-02-14T09:11:04.531087Z qemu-system-x86_64: VFIO_MAP_DMA failed: No 
> space left on device
> 2020-02-14T09:11:04.531230Z qemu-system-x86_64: VFIO_MAP_DMA failed: No 
> space left on device

I feel obligated to reply given the VFIO issues, but TBH I've never
used the nvme-vfio driver and don't consider myself the maintainer of
the vfio-helpers.  I'd guess the latter ENOSPC errors indicate we've
exhausted the number of separate DMA mappings that a vfio user is
allowed to create.  We had to put a cap on this to prevent malicious
users and it was set to 64K, which seemed like orders of magnitude more
than we use for device assignment, but perhaps not enough for this
driver.  There's a dma_entry_limit module option on the
vfio_iommu_type1 module that can be bumped up to see if it resolves
this issue.  The initial EINVAL and ENOMEM errors might however
indicate the driver has already gone into the weeds before we get to
the latter problem though.

> I'm doing nothing with the disk inside the guest, but:
> 
>    # dd if=/dev/vda of=/dev/null status=progress
> 
> (the disk appears as /dev/vda in the guest). Surprisingly, I do not see 
> these errors when I use the traditional PCI assignment (-device 
> vfio-pci).

Not really surprising, entirely different models of using the device.
Device assignment should also give better performance, especially if we
really are exhausting the number of mappings a user can have inflight
concurrently.

> My versions of kernel and qemu:
> 
> moe ~ # uname -r
> 5.4.15-gentoo
> moe ~ # /home/zippy/work/qemu/qemu.git/x86_64-softmmu/qemu-system-x86_64 
> --version
> QEMU emulator version 4.2.50 (v4.2.0-1439-g5d6542bea7-dirty)
> Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
> 
> Do you guys want me to file a bug?

Probably a good idea.  Thanks,

Alex


