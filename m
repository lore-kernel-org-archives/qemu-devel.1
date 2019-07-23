Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960C5C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7A0227BF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7A0227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpqm6-0004Vg-35
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hpqlh-0003Bh-2N
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hpqld-00020w-9R
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:07:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hpqlb-0001zZ-Ut
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:07:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 77BCF3082B4B;
 Tue, 23 Jul 2019 09:07:26 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.36.118.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F29165D9CC;
 Tue, 23 Jul 2019 09:07:19 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 11:07:16 +0200
Message-Id: <20190723090718.14590-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 23 Jul 2019 09:07:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] pc: mmap kernel (ELF image) and initrd
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to reduce the memory footprint when PVH kernel and initrd
are used, we map them into memory instead of reading them.
In this way we can share them between multiple instances of QEMU.

These are the results using a PVH kernel and initrd (cpio):
- memory footprint (using smem) [MB]
        QEMU              before                   now
    # instances        USS      PSS            USS      PSS
         1           102.0M   105.8M         102.3M   106.2M
         2            94.6M   101.2M          72.3M    90.1M
         4            94.1M    98.0M          72.0M    81.5M
         8            94.0M    96.2M          71.8M    76.9M
        16            93.9M    95.1M          71.6M    74.3M

    Initrd size: 3.0M
    Kernel
        image size: 28M
        sections size [size -A -d vmlinux]:  18.9M

- boot time [ms]
                          before                   now
 qemu_init_end:           63.85                   55.91
 linux_start_kernel:      82.11 (+18.26)          74.51 (+18.60)
 linux_start_user:       169.94 (+87.83)         159.06 (+84.56)

QEMU command used:
./qemu-system-x86_64 -bios /path/to/seabios/out/bios.bin -no-hpet \
    -machine q35,accel=3Dkvm,kernel_irqchip,nvdimm,sata=3Doff,smbus=3Doff=
,vmport=3Doff \
    -cpu host -m 1G -smp 1 -vga none -display none -no-user-config -nodef=
aults \
    -kernel /path/to/vmlinux -initrd /path/to/rootfs.cpio \
    -append 'root=3D/dev/mem0 ro console=3Dhvc0 pci=3Dlastbus=3D0 nosmap'

Stefano Garzarella (2):
  elf-ops.h: Map into memory the ELF to load
  hw/i386/pc: Map into memory the initrd

 hw/i386/pc.c         | 15 ++++++++---
 include/hw/elf_ops.h | 59 ++++++++++++++++++++++----------------------
 2 files changed, 41 insertions(+), 33 deletions(-)

--=20
2.20.1


