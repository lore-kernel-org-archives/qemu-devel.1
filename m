Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C171C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534AB20715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534AB20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1B5i-0003lP-9n
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j150s-000793-R8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j150p-0004Jx-HO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:52 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:37980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhabin@linux.alibaba.com>)
 id 1j150p-0004Hm-7W
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:51 -0500
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04428; MF=zhabin@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0Tpb9F9X_1581325530; 
Received: from localhost(mailfrom:zhabin@linux.alibaba.com
 fp:SMTPD_---0Tpb9F9X_1581325530) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Feb 2020 17:05:31 +0800
From: Zha Bin <zhabin@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] virtio mmio specification enhancement
Date: Mon, 10 Feb 2020 17:05:16 +0800
Message-Id: <cover.1581305609.git.zhabin@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
X-Mailman-Approved-At: Mon, 10 Feb 2020 10:31:31 -0500
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
Cc: virtio-dev@lists.oasis-open.org, zhabin@linux.alibaba.com, slp@redhat.com,
 mst@redhat.com, jasowang@redhat.com, jing2.liu@linux.intel.com,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In cloud native environment, we need a lightweight and secure system. It
should benefit from the speed of containers and the security of VM, which
is classified as secure containers. The traditional solution of cloud VM
is Qemu. In fact we don't need to pay for the legacy devices. Currently,
more userspace VMMs, e.g. Qemu, Firecracker, Cloud Hypervisor and Alibaba
Cloud VMM which is called Dragonball, began to pay attention to a
lightweight solution.

The lightweight VMM is suitable to cloud native infrastructure which is
designed for creating secure sandbox to address the requirements of
multi-tenant. Meanwhile, with faster startup time and lower memory
overhead, it makes possible to launch thousands of microVMs on the same
machine. This VMM minimizes the emulation devices and uses virtio-mmio to
get a more lightweight transport layer. The virtio-mmio devices have less
code than virtio-pci, which can decrease boot time and increase deploy
density by customizing kernel such as setting pci=off. From another point
of view, the minimal device can reduce the attack surface.

We have compared the number of files and the lines of code between
virtio-mmio and virio-pci.

				Virtio-PCI	    Virtio-MMIO	
	number of files(Linux)	    161			1
	lines of code(Linux)	    78237		538
	number of files(Qemu)	    24			1
	lines of code(Qemu)	    8952		421

But the current standard virtio-mmio spec has some limitations which is
only support legacy interrupt and will cause performance penalties.

To address such limitation, we proposed to update virtio-mmio spec with
two new feature bits to support MSI interrupt and enhancing notification
mechanism[1], which can achieve the same performance as virtio-pci devices
with only around 600 lines of code.

Here are the performance gain of MSI interrupt in virtio-mmio. Each case is
repeated three times.

        netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024

                Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
        trans/s     9536        6939            9500
        trans/s     9734        7029            9749
        trans/s     9894        7095            9318

With the virtio spec proposal[1], other VMMs (e.g. Qemu) can also make use
of the new features to get a enhancing performance.

[1] https://lkml.org/lkml/2020/1/21/31

Change Log:
v1->v2
* Change version update to feature bit
* Add mask/unmask support
* Add two MSI sharing/non-sharing modes
* Create generic irq domain for all architectures

Liu Jiang (5):
  virtio-mmio: add notify feature for per-queue
  virtio-mmio: refactor common functionality
  virtio-mmio: create a generic MSI irq domain
  virtio-mmio: add MSI interrupt feature support
  x86: virtio-mmio: support virtio-mmio with MSI for x86

 arch/x86/kernel/apic/msi.c          |  11 +-
 drivers/base/platform-msi.c         |   4 +-
 drivers/virtio/Kconfig              |   9 +
 drivers/virtio/virtio_mmio.c        | 351 ++++++++++++++++++++++++++++++++----
 drivers/virtio/virtio_mmio_common.h |  39 ++++
 drivers/virtio/virtio_mmio_msi.h    | 175 ++++++++++++++++++
 include/linux/msi.h                 |   1 +
 include/uapi/linux/virtio_config.h  |  13 +-
 include/uapi/linux/virtio_mmio.h    |  31 ++++
 9 files changed, 596 insertions(+), 38 deletions(-)
 create mode 100644 drivers/virtio/virtio_mmio_common.h
 create mode 100644 drivers/virtio/virtio_mmio_msi.h

-- 
1.8.3.1


