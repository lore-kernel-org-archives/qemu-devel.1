Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C791C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465C32076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBpvQ0N9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465C32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joi4Q-0005Jm-FG
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 02:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1joi3U-0003gt-CM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 02:41:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47760
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1joi3R-0001ZK-HU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 02:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593153700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4ByN3fESxiaH4pbep30Tf1LNBSxt70lTNByVu0U+p48=;
 b=RBpvQ0N9cXXv8DCDIbhRULxc4N2ZlFfVb8TNwEnwW9PJt0zYp8bpZGGysyf+CIIAGvRlDq
 AhCHWPtDtXv3a3V9kLoCjRnyfL/fcNAwWqDHpMqsuviV8zFHhR4VzkgB3RvxGXjHVR3BLq
 udjMNrtQq/FTdCjyxkZUPDunllXVKKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-MyfOUJmmNBWj_3ihAz0ntg-1; Fri, 26 Jun 2020 02:41:36 -0400
X-MC-Unique: MyfOUJmmNBWj_3ihAz0ntg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0970864ACA;
 Fri, 26 Jun 2020 06:41:35 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-112-248.ams2.redhat.com
 [10.36.112.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 555B37FEB2;
 Fri, 26 Jun 2020 06:41:25 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC v2 0/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Date: Fri, 26 Jun 2020 08:41:21 +0200
Message-Id: <20200626064122.9252-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eperezma@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Avi Kivity <avi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I am able to hit this assertion when a Red Hat 7 guest virtio_net device
raises an "Invalidation" of all the TLB entries. This happens in the
guest's startup if 'intel_iommu=on' argument is passed to the guest
kernel and right IOMMU/ATS devices are declared in qemu's command line.

Command line:
/home/qemu/x86_64-softmmu/qemu-system-x86_64 -name \
guest=rhel7-test,debug-threads=on -machine \
pc-q35-5.1,accel=kvm,usb=off,dump-guest-core=off,kernel_irqchip=split \
-cpu \
Broadwell,vme=on,ss=on,vmx=on,f16c=on,rdrand=on,hypervisor=on,arat=on,tsc-adjust=on,umip=on,arch-capabilities=on,xsaveopt=on,pdpe1gb=on,abm=on,skip-l1dfl-vmentry=on,rtm=on,hle=on \
-m 8096 -realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 -uuid \
d022ecbf-679e-4755-87ce-eb87fc5bbc5d -display none -no-user-config \
-nodefaults -rtc base=utc,driftfix=slew -global \
kvm-pit.lost_tick_policy=delay -no-hpet -no-shutdown -global \
ICH9-LPC.disable_s3=1 -global ICH9-LPC.disable_s4=1 -boot strict=on \
-device intel-iommu,intremap=on,device-iotlb=on -device \
pcie-root-port,port=0x8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1 \
-device \
pcie-root-port,port=0x9,chassis=2,id=pci.2,bus=pcie.0,addr=0x1.0x1 \
-device \
pcie-root-port,port=0xa,chassis=3,id=pci.3,bus=pcie.0,addr=0x1.0x2 \
-device \
pcie-root-port,port=0xb,chassis=4,id=pci.4,bus=pcie.0,addr=0x1.0x3 \
-device \
pcie-root-port,port=0xc,chassis=5,id=pci.5,bus=pcie.0,addr=0x1.0x4 \
-device \
pcie-root-port,port=0xd,chassis=6,id=pci.6,bus=pcie.0,addr=0x1.0x5 \
-device \
pcie-root-port,port=0xe,chassis=7,id=pci.7,bus=pcie.0,addr=0x1.0x6 \
-device qemu-xhci,p2=15,p3=15,id=usb,bus=pci.2,addr=0x0 -device \
virtio-serial-pci,id=virtio-serial0,bus=pci.3,addr=0x0 -drive \
file=/home/virtio-test2.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 \
-device \
virtio-blk-pci,scsi=off,bus=pci.4,addr=0x0,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 \
-netdev tap,id=hostnet0,vhost=on,vhostforce=on -device \
virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:0d:1d:f2,bus=pci.1,addr=0x0,iommu_platform=on,ats=on \
-device virtio-balloon-pci,id=balloon0,bus=pci.5,addr=0x0 -object \
rng-random,id=objrng0,filename=/dev/urandom -device \
virtio-rng-pci,rng=objrng0,id=rng0,bus=pci.6,addr=0x0 -s -msg \
timestamp=on

Full backtrace:

    at /home/qemu/hw/i386/intel_iommu.c:2468
    (mr=0x555557609330, addr=136, value=0x7ffde5dfe478, size=4, shift=0, mask=4294967295, attrs=...) at /home/qemu/memory.c:483
    (addr=136, value=0x7ffde5dfe478, size=4, access_size_min=4, access_size_max=8, access_fn=
    0x555555883d38 <memory_region_write_accessor>, mr=0x555557609330, attrs=...) at /home/qemu/memory.c:544
    at /home/qemu/memory.c:1476
    (fv=0x7ffde00935d0, addr=4275634312, attrs=..., ptr=0x7ffff7ff0028, len=4, addr1=136, l=4, mr=0x555557609330) at /home/qemu/exec.c:3146
    at /home/qemu/exec.c:3186
    (as=0x5555567ca640 <address_space_memory>, addr=4275634312, attrs=..., buf=0x7ffff7ff0028, len=4) at /home/qemu/exec.c:3277
    (as=0x5555567ca640 <address_space_memory>, addr=4275634312, attrs=..., buf=0x7ffff7ff0028, len=4, is_write=true)
    at /home/qemu/exec.c:3287

--

If we examinate *entry in frame 4 of backtrace:
*entry = {target_as = 0x555556f6c050, iova = 0x0, translated_addr = 0x0,
addr_mask = 0xffffffffffffffff, perm = 0x0}

Which (I think) tries to invalidate all the TLB registers of the device.

Just deleting that assert is enough for the VM to start and communicate
using IOMMU, but maybe a better alternative is possible. We could move
it to the caller functions in other cases than IOMMU invalidation, or
make it conditional only if not invalidating.

Any comment would be appreciated. Thanks!

Guest kernel version: kernel-3.10.0-1151.el7.x86_64

Bug reference: https://bugs.launchpad.net/qemu/+bug/1885175

v2: Actually delete assertion instead of just commenting out using C99

Eugenio Pérez (1):
  memory: Delete assertion in memory_region_unregister_iommu_notifier

 memory.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.18.1


