Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD540C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969A320873
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969A320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeC1-0001ch-JO
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43948)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hoeBm-00010R-07
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hoeBk-0003Wb-VV
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:29:29 -0400
Received: from ozlabs.ru ([107.173.13.209]:59092)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1hoeBk-0003WM-QK; Fri, 19 Jul 2019 21:29:28 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 11998AE8056D;
 Fri, 19 Jul 2019 21:28:50 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 11:28:46 +1000
Message-Id: <20190720012850.14369-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [PATCH qemu RFC 0/4] spapr: Kexec style boot
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an attempts to boot a pseries guest without a firmware.

The idea is to boot a VM with petitboot as a more powerful boot loader
and eliminate scanning phase of the SLOF booting process.

This provides environment without SLOF but with the device tree
and few modifications to already existing H_CAS and H_RTAS hypeprcalls.

This is made on top of these 2 patches:
spapr: Stop providing RTAS blob
spapr_pci: Advertise BAR reallocation capability

This requires a modified pseries kernel, posted separately
as "powerpc/pseries: Kexec style boot".

This also requires patched kexec-lite from the openpower build as
currently it requires linux,rtas-base and rtas-size properties in
the DT which we won't have in such environment.

1/1 is not necessary but having vmlinux at 0 helps debugging via
the qemu gdb stub easier.

The example command line is:
/home/aik/pbuild/qemu-killslof-localhost-ppc64/ppc64-softmmu/qemu-system-ppc64 \
-nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline -nographic -vga none \
-enable-kvm \
-device nec-usb-xhci,id=nec-usb-xhci0 -m 4G \
-kernel /home/aik/pbuild/kernel-guest-nv2-le/vmlinux \
-initrd op-build/output/images/rootfs.cpio \
-machine pseries,bios=no,cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken \
-snapshot \
-netdev "tap,id=TAP0,helper=/home/aik/qemu-bridge-helper --br=br0" \
-device \
"virtio-net-pci,id=vnet0,bus=pci.0,addr=1.0,mac=C0:41:49:4b:00:02,netdev=TAP0" \
-device virtio-scsi-pci,id=vscsi0 \
-drive \
id=DRIVE0,if=none,file=pbuild/__img/u1804-64le-killslof.qcow2,format=qcow2 \
-device scsi-disk,id=scsi-disk0,drive=DRIVE0 \
-smp 8,threads=8 \
-L /home/aik/t/qemu-ppc64-bios/ \
-trace events=qemu_trace_events -d guest_errors \
-chardev socket,id=SOCKET0,server,nowait,path=qemu.mon.mac02 \
-mon chardev=SOCKET0,mode=control



This is based on sha1
216965b20b04 Joel Stanley "ppc/pnv: update skiboot to v6.4".

Please comment. Thanks.



Alexey Kardashevskiy (4):
  spapr: Allow changing kernel loading address
  spapr: Allow bios-less configuration
  spapr: Advertise H_RTAS to the guest
  spapr: Implement SLOF-less client_architecture_support

 include/hw/ppc/spapr.h |   7 +++
 hw/ppc/spapr.c         | 118 ++++++++++++++++++++++++++++++++---------
 hw/ppc/spapr_hcall.c   |  49 +++++++++++++++--
 3 files changed, 146 insertions(+), 28 deletions(-)

-- 
2.17.1


