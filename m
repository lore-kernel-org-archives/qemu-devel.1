Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C2C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D4A20644
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D4A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqI9-0000gd-Dj
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 08:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36142)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hgq4o-0002YE-74
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hgq4m-0004SZ-Pb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:34:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hgq4k-0004QO-KR
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:34:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 107A6C18B2D3;
 Fri, 28 Jun 2019 11:54:04 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E260D1A927;
 Fri, 28 Jun 2019 11:53:55 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com
Date: Fri, 28 Jun 2019 13:53:45 +0200
Message-Id: <20190628115349.60293-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 28 Jun 2019 11:54:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] Introduce the microvm machine type
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
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Microvm is a machine type inspired by both NEMU and Firecracker, and
constructed after the machine model implemented by the latter.

It's main purpose is providing users a KVM-only machine type with fast
boot times, minimal attack surface (measured as the number of IO ports
and MMIO regions exposed to the Guest) and small footprint (specially
when combined with the ongoing QEMU modularization effort).

Normally, other than the device support provided by KVM itself,
microvm only supports virtio-mmio devices. Microvm also includes a
legacy mode, which adds an ISA bus with a 16550A serial port, useful
for being able to see the early boot kernel messages.

This is the list of the exposed IO ports and MMIO regions when running
in non-legacy mode:

address-space: memory
    00000000d0000000-00000000d00001ff (prio 0, i/o): virtio-mmio
    00000000d0000200-00000000d00003ff (prio 0, i/o): virtio-mmio
    00000000d0000400-00000000d00005ff (prio 0, i/o): virtio-mmio
    00000000d0000600-00000000d00007ff (prio 0, i/o): virtio-mmio
    00000000d0000800-00000000d00009ff (prio 0, i/o): virtio-mmio
    00000000d0000a00-00000000d0000bff (prio 0, i/o): virtio-mmio
    00000000d0000c00-00000000d0000dff (prio 0, i/o): virtio-mmio
    00000000d0000e00-00000000d0000fff (prio 0, i/o): virtio-mmio
    00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi

address-space: I/O
  0000000000000000-000000000000ffff (prio 0, i/o): io
    0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
    0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
    000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
    00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
    00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
    00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr

A QEMU instance with the microvm machine type can be invoked this way:

 - Normal mode:

qemu-system-x86_64 -M microvm -m 512m -smp 2 \
 -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
 -nodefaults -no-user-config \
 -chardev pty,id=3Dvirtiocon0,server \
 -device virtio-serial-device \
 -device virtconsole,chardev=3Dvirtiocon0 \
 -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
 -device virtio-blk-device,drive=3Dtest \
 -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
 -device virtio-net-device,netdev=3Dtap0

 - Legacy mode:

qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
 -kernel vmlinux -append "console=3DttyS0 root=3D/dev/vda" \
 -nodefaults -no-user-config \
 -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
 -device virtio-blk-device,drive=3Dtest \
 -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
 -device virtio-net-device,netdev=3Dtap0 \
 -serial stdio


Sergio Lopez (4):
  hw/i386: Factorize CPU routine
  hw/virtio: Factorize virtio-mmio headers
  hw/i386: Add an Intel MPTable generator
  hw/i386: Introduce the microvm machine type

 default-configs/i386-softmmu.mak            |   1 +
 hw/i386/Kconfig                             |   4 +
 hw/i386/Makefile.objs                       |   2 +
 hw/i386/cpu.c                               | 174 +++++++
 hw/i386/microvm.c                           | 518 ++++++++++++++++++++
 hw/i386/mptable.c                           | 157 ++++++
 hw/i386/pc.c                                | 151 +-----
 hw/i386/pc_piix.c                           |   3 +-
 hw/i386/pc_q35.c                            |   3 +-
 hw/virtio/virtio-mmio.c                     |  35 +-
 hw/virtio/virtio-mmio.h                     |  60 +++
 include/hw/i386/apic.h                      |   1 +
 include/hw/i386/cpu-internal.h              |  32 ++
 include/hw/i386/microvm.h                   |  85 ++++
 include/hw/i386/mptable.h                   |  37 ++
 include/standard-headers/linux/mpspec_def.h | 182 +++++++
 16 files changed, 1264 insertions(+), 181 deletions(-)
 create mode 100644 hw/i386/cpu.c
 create mode 100644 hw/i386/microvm.c
 create mode 100644 hw/i386/mptable.c
 create mode 100644 hw/virtio/virtio-mmio.h
 create mode 100644 include/hw/i386/cpu-internal.h
 create mode 100644 include/hw/i386/microvm.h
 create mode 100644 include/hw/i386/mptable.h
 create mode 100644 include/standard-headers/linux/mpspec_def.h

--
2.21.0

