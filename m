Received: from eggs.gnu.org ([2001:4830:134:3::10]:40889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1elovf-0002Uv-IF
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1elovc-00014R-Ac
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:44:23 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:45163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1elovc-00011p-6n
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:44:20 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1E4g7vD050967
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 23:44:14 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 919F86D
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 23:44:15 -0500 (EST)
Received: from sendprodmail04.cc.columbia.edu (sendprodmail04.cc.columbia.edu
	[128.59.72.16]) by hazelnut (Postfix) with ESMTP id 729FF7E
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 23:44:15 -0500 (EST)
Received: from mail-wm0-f69.google.com (mail-wm0-f69.google.com [74.125.82.69])
	by sendprodmail04.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1E4iDfP000401
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 23:44:14 -0500
Received: by mail-wm0-f69.google.com with SMTP id r9so5724546wme.8
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 20:44:14 -0800 (PST)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com.
	[74.125.82.42]) by smtp.gmail.com with ESMTPSA id
	g55sm8729684eda.70.2018.02.13.20.44.10 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Feb 2018 20:44:11 -0800 (PST)
Received: by mail-wm0-f42.google.com with SMTP id a84so8724301wmi.5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 20:44:10 -0800 (PST)
MIME-Version: 1.0
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Tue, 13 Feb 2018 23:44:09 -0500
Message-ID: <CAHyh4xiTDwB2xG_bg00bMA0042yTRq7-dJ-+y3muR+=9N3Vx-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Assigning network devices to nested VMs results in
 driver errors in nested VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>, vfio-users@redhat.com
Cc: Peter Xu <peterx@redhat.com>

Hi,

I'm trying to assign network devices to nested VMs on x86 using KVM,
but I got network device driver errors in the nested VMs. (I've tried
this about an year ago when vIOMMU patches were not upstreamed, and I
got similar errors at that time.)

This could be network driver issues, but I'd like to get some help if
somebody encountered similar issues.

I'm using v4.15.0 kernel and v2.11.0 QEMU, and I followed this [1]
guide. I had no problem with assigning devices to the first level VMs
(L1 VMs). And I also checked that the devices were assigned to nested
VMs with the lspci command in the nested VMs. But network device
drivers failed to initialize the device. I tried two network cards -
Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection and
Mellanox Technologies MT27500 Family.

Intel driver error in the nested VM looks like this.
[    1.939552] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver -
version 5.1.0-k
[    1.949796] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    2.210024] ixgbe 0000:00:04.0: HW Init failed: -12
[    2.218144] ixgbe: probe of 0000:00:04.0 failed with error -12

and I saw lots of these messages in the host (L0) kernel log when
booting the nested VM.

[ 1557.404173] DMAR: DRHD: handling fault status reg 102
[ 1557.409813] DMAR: [DMA Read] Request device [06:00.0] fault addr
90000 [fault reason 06] PTE Read access is not set
[ 1561.383957] DMAR: DRHD: handling fault status reg 202
[ 1561.389598] DMAR: [DMA Read] Request device [06:00.0] fault addr
90000 [fault reason 06] PTE Read access is not set

This is Mellanox driver error in another nested VM.
[    2.481694] mlx4_core: Initializing 0000:00:04.0
[    3.519422] mlx4_core 0000:00:04.0: Installed FW has unsupported
command interface revision 0
[    3.537769] mlx4_core 0000:00:04.0: (Installed FW version is 0.0.000)
[    3.551733] mlx4_core 0000:00:04.0: This driver version supports
only revisions 2 to 3
[    3.568758] mlx4_core 0000:00:04.0: QUERY_FW command failed, aborting
[    3.582789] mlx4_core 0000:00:04.0: Failed to init fw, aborting.

The host showed similar messages as above.

I wonder what could be the cause of these errors. Please let me know
if further information is needed.

[1] https://wiki.qemu.org/Features/VT-d

Thanks,
Jintack
